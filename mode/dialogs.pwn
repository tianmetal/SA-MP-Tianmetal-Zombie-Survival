public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
    switch(dialogid)
    {
        case 0: return 1;
		case DIALOG_REGISTER:
		{
			if(response)
			{
				if(IsNull(inputtext)) return ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_PASSWORD,"Unregistered!","{ffff00}You are not registered!\n{ffffff}please input a password in the box below to register!","Register","Quit");
				new string[384],playername[24],password[130];
				GetPlayerName(playerid,playername,sizeof(playername));
				strToLower(playername);
				WP_Hash(password,129,inputtext);
				format(string,sizeof(string),"INSERT INTO `users`(`user`,`password`) VALUES('%s','%s')",playername,password);
				mysql_function_query(Database,string,false,"User_Register","d",playerid);
			}
			else Kick(playerid);
		}
		case DIALOG_LOGIN:
		{
			if(response)
			{
				if(IsNull(inputtext)) return ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login to Server","Please input your password below to login into the server!","Login","Quit");
				new string[130],password[130];
				GetPVarString(playerid,"TempPass",password,sizeof(password));
				WP_Hash(string,129,inputtext);
				if(!strcmp(string,password,true))
				{
					new charid = GetPVarInt(playerid,"TempID");
					DeletePVar(playerid,"TempPass");
					DeletePVar(playerid,"TempID");
					format(string,sizeof(string),"SELECT * FROM `users` WHERE `id`='%d'",charid);
					mysql_function_query(Database,string,true,"User_Login","dd",playerid,charid);
				}
				else
				{
					new tries = GetPVarInt(playerid,"LoginTries");
					tries++;
					if(tries == 5) Kick(playerid);
					else
					{
						SetPVarInt(playerid,"LoginTries",tries);
						ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login to Server","Please input your password below to login into the server!","Login","Quit");
					}
				}
			}
			else Kick(playerid);
		}
        case DIALOG_INVENTORY_SHOW:
        {
			if(response)
			{
			    SetPVarInt(playerid,"SelectItem",listitem);
			    ShowPlayerDialog(playerid,DIALOG_INVENTORY_ACTION,DIALOG_STYLE_LIST,"Item Action","Use/Equip/Consume\nDrop","Select","Back");
			}
        }
        case DIALOG_INVENTORY_ACTION:
        {
            new itemslot = GetPVarInt(playerid,"SelectItem");
            DeletePVar(playerid,"SelectItem");
            if(response)
            {
                if(listitem == 0)
                {
                    if(PlayerUseItem(playerid,PlayerInfo[playerid][Item][itemslot],itemslot))
                    {
                        PlayerInfo[playerid][Item][itemslot] = 0;
                        RearrangeInventory(playerid);
                    }
                }
				else
				{
				    new Float:cPos[3];
				    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
				    CreatePlayerDrop(PlayerInfo[playerid][Item][itemslot],cPos[0],cPos[1],cPos[2]);
				    PlayerInfo[playerid][Item][itemslot] = 0;
                    RearrangeInventory(playerid);
                    Streamer_Update(playerid);
				}
            }
            else
            {
                ShowPlayerInventory(playerid);
            }
        }
        case DIALOG_DROP_FOUND:
        {
            if(response)
            {
				new id = GetPVarInt(playerid,"NearDrop");
				new slot = FindItemFreeSlot(playerid);
				if(slot == -1) return SEM(playerid,"<ERROR>: Backpack full!");
				if(Iter_Contains(Drops,id))
				{
				    DeletePVar(playerid,"NearDrop");
				    PlayerInfo[playerid][Item][slot] = DropInfo[id][Item];
					DeleteDrop(id);
				}
            }
        }
        case DIALOG_PLAYER_DROP_FOUND:
        {
            if(response)
            {
				new id = GetPVarInt(playerid,"NearPlayerDrop");
				new slot = FindItemFreeSlot(playerid);
				if(slot == -1) return SEM(playerid,"<ERROR>: Backpack full!");
				if(Iter_Contains(PlayerDrops,id))
				{
				    DeletePVar(playerid,"NearPlayerDrop");
				    PlayerInfo[playerid][Item][slot] = PlayerDropInfo[id][Item];
					DeletePlayerDrop(id);
				}
            }
        }
		case DIALOG_VEHICLE_MAIN:
		{
			if(response)
			{
				if(GetPVarType(playerid,"NearVehicle") > 0)
				{
					new vehid = GetPVarInt(playerid,"NearVehicle");
					switch(GetVehicleModel(vehid))
					{
						case 510: ShowPlayerDialog(playerid,DIALOG_VEHICLE_ACTION,DIALOG_STYLE_LIST,"Vehicle Action","Items","Select","Exit");
						default:
						{
							if(PlayerInfo[playerid][Toolbox] == 0) ShowPlayerDialog(playerid,DIALOG_VEHICLE_ACTION,DIALOG_STYLE_LIST,"Vehicle Action","Items\nRefill fuel\nAdd Engine\nAdd Tire","Select","Exit");
							else ShowPlayerDialog(playerid,DIALOG_VEHICLE_ACTION,DIALOG_STYLE_LIST,"Vehicle Action","Items\nRefill fuel\nAdd Engine\nAdd Tire\nRepair Vehicle","Select","Exit");
						}
					}
				}
			}
		}
		case DIALOG_VEHICLE_ACTION:
		{
			if(response)
			{
				if(GetPVarType(playerid,"NearVehicle") > 0)
				{
					new vehid = GetPVarInt(playerid,"NearVehicle");
					if(listitem == 0)
					{
						ShowPlayerDialog(playerid,DIALOG_VEHICLE_STORAGE_MENU,DIALOG_STYLE_LIST,"Vehicle Inventory","Store Item\nTake Item","Select","Exit");
					}
					else if(listitem == 1)
					{
						if(VehicleInfo[vehid][Fuel] < 100)
						{
							new slot = FindPlayerItem(playerid,ITEM_GASCAN_FULL);
							if(slot != -1)
							{
								VehicleInfo[vehid][Fuel] += 25;
								if(VehicleInfo[vehid][Fuel] > 100) VehicleInfo[vehid][Fuel] = 100;
								PlayerInfo[playerid][Item][slot] = ITEM_GASCAN_EMPTY;
								SendClientMessage(playerid,-1,"<ITEM>: You've used all the fuel from the gascan!");
							}
							else SEM(playerid,"<ERROR>: You don't have any full gascan!");
						}
						else SEM(playerid,"<ERROR>: This vehicle don't need anymore fuel!");
					}
					else if(listitem == 2)
					{
						if(VehicleInfo[vehid][Engine] == 0)
						{
							new slot = FindPlayerItem(playerid,ITEM_ENGINE);
							if(slot != -1)
							{
								VehicleInfo[vehid][Engine] = 1;
								PlayerInfo[playerid][Item][slot] = ITEM_NONE;
								RearrangeInventory(playerid);
								SendClientMessage(playerid,-1,"<ITEM>: You've installed an engine on the vehicle");
							}
							else SEM(playerid,"<ERROR>: You don't have any engine!");
						}
						else SEM(playerid,"<ERROR>: This vehicle already has an engine!");
					}
					else if(listitem == 3)
					{
						new need = 4;
						if(GetVehicleModel(vehid) == 468) need = 2;
						if(VehicleInfo[vehid][Tires] < need)
						{
							new slot = FindPlayerItem(playerid,ITEM_TIRE);
							if(slot != -1)
							{
								VehicleInfo[vehid][Tires]++;
								PlayerInfo[playerid][Item][slot] = ITEM_NONE;
								RearrangeInventory(playerid);
								SendClientMessage(playerid,-1,"<ITEM>: You've installed a tire on the vehicle");
							}
							else SEM(playerid,"<ERROR>: You don't have any tire!");
						}
						else SEM(playerid,"<ERROR>: This vehicle has enough tires!");
					}
					else if(listitem == 4)
					{
						if(VehicleInfo[vehid][Engine] == 1)
						{
							SetVehicleHealth(vehid,1000.0);
						}
						else SEM(playerid,"<ERROR>: This vehicle does not have any engine!");
					}
				}
			}
		}
		case DIALOG_VEHICLE_STORAGE_MENU:
		{
			if(response)
			{
				if(GetPVarType(playerid,"NearVehicle") > 0)
				{
					new vehid = GetPVarInt(playerid,"NearVehicle");
					if(listitem == 0)
					{
						ShowPlayerInventory(playerid,DIALOG_VEHICLE_STORAGE_GIVE);
					}
					else
					{
						new string[128];
						forex(i,5)
						{
							new item = VehicleInfo[vehid][Item][i];
							strcat(string,ItemNames[item],sizeof(string));
							strcat(string,"\n",sizeof(string));
						}
						ShowPlayerDialog(playerid,DIALOG_VEHICLE_STORAGE_TAKE,DIALOG_STYLE_LIST,"Vehicle Inventory",string,"Take","Exit");
					}
				}
			}
		}
		case DIALOG_VEHICLE_STORAGE_GIVE:
		{
			if(response)
			{
				if(GetPVarType(playerid,"NearVehicle") > 0)
				{
					new vehid = GetPVarInt(playerid,"NearVehicle");
					new slot = -1;
					forex(i,5)
					{
						if(VehicleInfo[vehid][Item][i] == ITEM_NONE)
						{
							slot = i;
							break;
						}
					}
					if(slot == -1) return SEM(playerid,"<ERROR>: Vehicle inventory is full!");
					else
					{
						VehicleInfo[vehid][Item][slot] = PlayerInfo[playerid][Item][listitem];
						PlayerInfo[playerid][Item][listitem] = ITEM_NONE;
						RearrangeInventory(playerid);
					}
				}
			}
		}
		case DIALOG_VEHICLE_STORAGE_TAKE:
		{
			if(response)
			{
				if(GetPVarType(playerid,"NearVehicle") > 0)
				{
					new vehid = GetPVarInt(playerid,"NearVehicle");
					new slot = FindItemFreeSlot(playerid);
					if(slot == -1) return SEM(playerid,"<ERROR>: Your inventory is full!");
					if(VehicleInfo[vehid][Item][listitem] != ITEM_NONE)
					{
						new string[128];
						PlayerInfo[playerid][Item][slot] = VehicleInfo[vehid][Item][listitem];
						VehicleInfo[vehid][Item][listitem] = ITEM_NONE;
						forex(i,5)
						{
							new item = VehicleInfo[vehid][Item][i];
							strcat(string,ItemNames[item],sizeof(string));
							strcat(string,"\n",sizeof(string));
						}
						ShowPlayerDialog(playerid,DIALOG_VEHICLE_STORAGE_TAKE,DIALOG_STYLE_LIST,"Vehicle Inventory",string,"Take","Exit");
					}
					else SEM(playerid,"<ERROR>: Invalid item!");
				}
			}
		}
		case DIALOG_BODY_MENU:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(GetPVarType(playerid,"NearBody") > 0)
					{
						new id = GetPVarInt(playerid,"NearBody"),
							string[256];
						forex(i,MAX_INVENTORY_SLOT)
						{
							new item = DeadBodyInfo[id][Item][i];
							if(item == 0) break;
							strcat(string,ItemNames[item],sizeof(string));
							strcat(string,"\n",sizeof(string));
						}
						if(!IsNull(string)) ShowPlayerDialog(playerid,DIALOG_BODY_LOOT,DIALOG_STYLE_LIST,"Loot dead body",string,"Take","Exit");
						else SEM(playerid,"<ERROR>: You found nothing!");
					}
				}
			}
		}
		case DIALOG_BODY_LOOT:
		{
			if(response)
			{
				if(GetPVarType(playerid,"NearBody") > 0)
				{
					new id = GetPVarInt(playerid,"NearBody"),
						slot = FindItemFreeSlot(playerid),
						string[256];
					if(slot == -1) return SEM(playerid,"<ERROR>: Your inventory is full!");
					PlayerInfo[playerid][Item][slot] = DeadBodyInfo[id][Item][listitem];
					DeadBodyInfo[id][Item][listitem] = ITEM_NONE;
					RearrangeInventory(id,1);
					forex(i,MAX_INVENTORY_SLOT)
					{
						new item = DeadBodyInfo[id][Item][i];
						if(item == 0) break;
						strcat(string,ItemNames[item],sizeof(string));
						strcat(string,"\n",sizeof(string));
					}
					if(!IsNull(string)) ShowPlayerDialog(playerid,DIALOG_BODY_LOOT,DIALOG_STYLE_LIST,"Loot dead body",string,"Take","Exit");
					else SEM(playerid,"<ERROR>: You found nothing more!");
				}
			}
		}
		case DIALOG_ZOMBIE_LOOT:
		{
			if(response)
			{
				if(GetPVarType(playerid,"NearZombie") > 0)
				{
					new zombie = GetPVarInt(playerid,"NearZombie"),
						slot = FindItemFreeSlot(playerid);
					if(slot == -1) return SEM(playerid,"<ERROR>: Your inventory is full!");
					PlayerInfo[playerid][Item][slot] = ZombieInfo[zombie][Item];
					ZombieInfo[zombie][Item] = ITEM_NONE;
				}
			}
		}
		case DIALOG_UNEQUIP_WARN:
		{
			if(response)
			{
				ShowPlayerDialog(playerid,DIALOG_UNEQUIP_OPTION,DIALOG_STYLE_MSGBOX,"Unequip Option","Where do you want to put this weapon?","Inventory","Drop");
			}
		}
		case DIALOG_UNEQUIP_OPTION:
		{
			new weapon = GetPlayerWeapon(playerid);
			if(weapon == 0) return SEM(playerid,"<ERROR>: You are not holding any weapon!");
			new slot = GetWeaponType(weapon);
			if(slot == 2) return SEM(playerid,"<ERROR>: Melee weapon cannot be unequipped yet!");
			if(PlayerInfo[playerid][Weapon][slot] != weapon) return SEM(playerid,"<ERROR>: Invalid weapon!");
			if(response)
			{
				new itemslot = FindItemFreeSlot(playerid);
				if(itemslot != -1)
				{
					PlayerInfo[playerid][Item][itemslot] = GetWeaponItemID(weapon);
					PlayerInfo[playerid][Weapon][slot] = 0;
					PlayerInfo[playerid][Ammo][slot] = 0;
					SetPlayerAmmo(playerid,weapon,0);
					return 1;
				}
				else SEM(playerid,"<WARNING>: Your inventory is full, weapon has been dropped!");
			}
			new Float:cPos[3];
			GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
			CreatePlayerDrop(GetWeaponItemID(weapon),cPos[0],cPos[1],cPos[2]);
			PlayerInfo[playerid][Weapon][slot] = 0;
			PlayerInfo[playerid][Ammo][slot] = 0;
			SetPlayerAmmo(playerid,weapon,0);
			Streamer_Update(playerid);
		}
    }
    return 1;
}