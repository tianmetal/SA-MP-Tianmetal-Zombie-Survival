function User_Register(playerid)
{
	if(mysql_affected_rows(Database) > 0)
	{	
		IsPlayerLogged[playerid] = true;
		PlayerInfo[playerid][ID] = mysql_insert_id(Database);
		ForceClassSelection(playerid);
		TogglePlayerSpectating(playerid,0);
	}
	else Kick(playerid);
	return 1;
}
function User_GetPassword(playerid)
{
	new rows,fields;
	cache_get_data(rows,fields,Database);
	if(rows == 1)
	{
		new string[130];
		SetPVarInt(playerid,"TempID",cache_get_row_int(0,0,Database));
		cache_get_row(0,1,string,Database,sizeof(string));
		SetPVarString(playerid,"TempPass",string);
		ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login to Server","Please input your password below to login into the server!","Login","Quit");
	}
	else
	{
		ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_PASSWORD,"Unregistered!","{ffff00}You are not registered!\n{ffffff}please input a password in the box below to register!","Register","Quit");
	}
	return 1;
}
function User_Login(playerid,charid)
{
	new rows,fields;
	cache_get_data(rows,fields,Database);
	if(rows == 1)
	{
		IsPlayerLogged[playerid] = true;
		PlayerInfo[playerid][ID] = charid;
		PlayerInfo[playerid][Spawned] = bool:cache_get_row_int(0,3,Database);
		PlayerInfo[playerid][Deaths] = cache_get_row_int(0,7,Database);
		if(PlayerInfo[playerid][Spawned])
		{
			new Float:cPos[3];
			cPos[0] = cache_get_row_float(0,4,Database);
			cPos[1] = cache_get_row_float(0,5,Database);
			cPos[2] = cache_get_row_float(0,6,Database);
			PlayerInfo[playerid][Skin] = cache_get_row_int(0,8,Database);
			PlayerInfo[playerid][Kills] = cache_get_row_int(0,9,Database);
			PlayerInfo[playerid][Murders] = cache_get_row_int(0,10,Database);
			PlayerInfo[playerid][Blood] = cache_get_row_float(0,11,Database);
			PlayerInfo[playerid][Temperature] = cache_get_row_int(0,12,Database);
			PlayerInfo[playerid][Hunger] = cache_get_row_int(0,13,Database);
			PlayerInfo[playerid][Thirst] = cache_get_row_int(0,14,Database);
			PlayerInfo[playerid][Desease][0] = cache_get_row_int(0,15,Database);
			PlayerInfo[playerid][Desease][1] = cache_get_row_int(0,16,Database);
			PlayerInfo[playerid][Bag] = cache_get_row_int(0,17,Database);
			PlayerInfo[playerid][Map] = cache_get_row_int(0,18,Database);
			PlayerInfo[playerid][GPS] = cache_get_row_int(0,19,Database);
			PlayerInfo[playerid][Toolbox] = cache_get_row_int(0,20,Database);
			forex(i,MAX_INVENTORY_SLOT)
			{
				PlayerInfo[playerid][Item][i] = cache_get_row_int(0,(21+i),Database);
			}
			PlayerInfo[playerid][Weapon][0] = cache_get_row_int(0,57,Database);
			PlayerInfo[playerid][Weapon][1] = cache_get_row_int(0,58,Database);
			PlayerInfo[playerid][Weapon][2] = cache_get_row_int(0,59,Database);
			PlayerInfo[playerid][Ammo][0] = cache_get_row_int(0,60,Database);
			PlayerInfo[playerid][Ammo][1] = cache_get_row_int(0,61,Database);
			PlayerInfo[playerid][Radio] = cache_get_row_int(0,62,Database);
			if(PlayerInfo[playerid][Ammo][0] == 0) PlayerInfo[playerid][Weapon][0] = 0;
			if(PlayerInfo[playerid][Ammo][1] == 0) PlayerInfo[playerid][Weapon][1] = 0;
			SetSpawnInfo(playerid,NO_TEAM,PlayerInfo[playerid][Skin],cPos[0],cPos[1],cPos[2],0.0,0,0,0,0,0,1);
			TogglePlayerSpectating(playerid,0);
		}
		else
		{
			ForceClassSelection(playerid);
			TogglePlayerSpectating(playerid,0);
		}
	}
	else Kick(playerid);
	return 1;
}
function User_Save(playerid)
{
	ClearPlayerData(playerid,true);
	return 1;
}