public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new string[256];
	if(Pressed(KEY_CTRL_BACK))
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ShowPlayerInventory(playerid);
	}
	else if(Pressed(KEY_WALK))
	{
	    if(GetPVarType(playerid,"NearDrop") > 0)
	    {
			new id = GetPVarInt(playerid,"NearDrop");
			if(IsPlayerInDynamicArea(playerid,DropInfo[id][Area]))
			{
			    new item = DropInfo[id][Item];
				format(string,sizeof(string),"{ffffff}You've found item '{00ffff}%s{ffffff}'.\nwhat would you like to do with it?",ItemNames[item]);
				ShowPlayerDialog(playerid,DIALOG_DROP_FOUND,DIALOG_STYLE_MSGBOX,"Found item",string,"Take","Leave");
			}
	    }
		else if(GetPVarType(playerid,"NearPlayerDrop") > 0)
		{
		    new id = GetPVarInt(playerid,"NearPlayerDrop");
		    if(IsPlayerInDynamicArea(playerid,PlayerDropInfo[id][Area]))
		    {
		        new item = PlayerDropInfo[id][Item];
		        format(string,sizeof(string),"{ffff00}Someone dropped this item!\n{ffffff}You've found item '{00ffff}%s{ffffff}'.\nwhat would you like to do with it?",ItemNames[item]);
				ShowPlayerDialog(playerid,DIALOG_PLAYER_DROP_FOUND,DIALOG_STYLE_MSGBOX,"Found item",string,"Take","Leave");
		    }
		}
	}
	else if(Pressed(KEY_NO))
	{
		if(GetPVarType(playerid,"NearVehicle") > 0)
	    {
			new vehid = GetPVarInt(playerid,"NearVehicle");
			if(IsPlayerInDynamicArea(playerid,VehicleInfo[vehid][Area]))
			{
				ShowPlayerDialog(playerid,DIALOG_VEHICLE_MAIN,DIALOG_STYLE_MSGBOX,"Vehicle Menu","Please select action:","Actions","Leave");
			}
		}
		else if(GetPVarType(playerid,"NearBody") > 0)
		{
			new slot = GetPVarInt(playerid,"NearBody");
			if(IsPlayerInDynamicArea(playerid,DeadBodyInfo[slot][Area]))
			{
				ShowPlayerDialog(playerid,DIALOG_BODY_MENU,DIALOG_STYLE_LIST,"Body Found","Loot","Select","Exit");
			}
		}
		else if(GetPVarType(playerid,"NearZombie") > 0)
		{
			new zombie = GetPVarInt(playerid,"NearZombie");
			new item = ZombieInfo[zombie][Item];
			if(item != ITEM_NONE)
			{
				format(string,sizeof(string),"{ffffff}You've found item '{00ffff}%s{ffffff}' from the zombie.\nwhat would you like to do with it?",ItemNames[item]);
				ShowPlayerDialog(playerid,DIALOG_ZOMBIE_LOOT,DIALOG_STYLE_MSGBOX,"Looting zombie",string,"Take","Leave");
			}
			else SEM(playerid,"<ERROR>: You found nothing!");
		}
	}
	else if(Pressed(KEY_JUMP) || Pressed(KEY_SPRINT))
	{
		if((PlayerInfo[playerid][Desease][1]) && (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT))
		{
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid,1);
		}
	}
	return 1;
}