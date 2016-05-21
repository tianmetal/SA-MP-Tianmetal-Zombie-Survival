CMD:gmx(playerid,params[])
{
	if(IsPlayerAdmin(playerid))
	{
		GameModeExit();
	}
	return 1;
}
CMD:unequip(playerid,params[])
{
	new weapon = GetPlayerWeapon(playerid);
	if(weapon == 0)
	{
		SEM(playerid,"ERROR: You don't have any weapon equipped!");
		return 1;
	}
	new slot = GetWeaponType(weapon);
	if(slot == 2)
	{
		SEM(playerid,"ERROR: Melee weapons cannot be unequiped!");
		return 1;
	}
	if(PlayerInfo[playerid][Weapon][slot] == weapon)
	{
		ShowPlayerDialog(playerid,DIALOG_UNEQUIP_WARN,DIALOG_STYLE_MSGBOX,"Unequip Warning","{ffff00}WARNING: {ffffff}You will lose all your ammo upon unequipping!","Continue","Cancel");
	}
	else SEM(playerid,"<ERROR>: Invalid weapon!");
	return 1;
}
CMD:me(playerid,params[])
{
	if(!IsNull(params))
	{
		new string[128];
		GetPlayerName(playerid,string,MAX_PLAYER_NAME);
		format(string,sizeof(string),"* %s %s",string,params);
		SendRangedClientMessage(playerid,30.0,string,false,COLOR_PURPLE);
	}
	else SEM(playerid,"<USAGE>: /me [action]");
	return 1;
}
CMD:do(playerid,params[])
{
	if(!IsNull(params))
	{
		new playername[MAX_PLAYER_NAME],string[128];
		GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
		strcat(string,params,100);
		format(string,sizeof(string),"* %s (( %s ))",string,playername);
		SendRangedClientMessage(playerid,30.0,string,false,COLOR_PURPLE);
	}
	else SEM(playerid,"<USAGE>: /do [text]");
	return 1;
}
CMD:s(playerid,params[])
{
	if(!IsNull(params))
	{
		new string[128];
		GetPlayerName(playerid,string,MAX_PLAYER_NAME);
		format(string,sizeof(string),"%s shouts: %s",string,params);
		SendRangedClientMessage(playerid,40.0,string,true);
	}
	else SEM(playerid,"<USAGE>: /s [text]");
	return 1;
}
CMD:low(playerid,params[])
{
	if(!IsNull(params))
	{
		new string[128];
		GetPlayerName(playerid,string,MAX_PLAYER_NAME);
		format(string,sizeof(string),"%s whispers: %s",string,params);
		SendRangedClientMessage(playerid,5.0,string,true);
	}
	else SEM(playerid,"<USAGE>: /low [text]");
	return 1;
}
CMD:o(playerid,params[])
{
	if(!IsNull(params))
	{
		new string[128];
		GetPlayerName(playerid,string,MAX_PLAYER_NAME);
		format(string,sizeof(string),"(( %s: %s ))",string,params);
		SendClientMessageToAll(-1,string);
	}
	else SEM(playerid,"<USAGE>: /o [text]");
	return 1;
}
CMD:engine(playerid,params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehid = GetPlayerVehicleID(playerid);
		new paramex[7];
		GetVehicleParamsEx(vehid,paramex[0],paramex[1],paramex[2],paramex[3],paramex[4],paramex[5],paramex[6]);
		if(paramex[0] != 1)
		{
			new needtire = 4;
			if(GetVehicleModel(vehid) == 468) needtire = 2;
			new engine = VehicleInfo[vehid][Engine];
			new wheels = VehicleInfo[vehid][Tires];
			if(engine != 1) return SEM(playerid,"<ERROR>: This vehicle don't have any engine installed!");
			if(wheels != needtire)
			{
				new string[128];
				format(string,sizeof(string),"<ERROR>: This vehicle needs %d more tire!",(needtire-wheels));
				SEM(playerid,string);
				return 1;
			}
			SetVehicleParamsEx(vehid,1,paramex[1],paramex[2],paramex[3],paramex[4],paramex[5],paramex[6]);
		}
		else
		{
			SetVehicleParamsEx(vehid,0,paramex[1],paramex[2],paramex[3],paramex[4],paramex[5],paramex[6]);
		}
	}
	return 1;
}
CMD:r(playerid,params[])
{
	if(PlayerInfo[playerid][Radio] != 0)
	{
		new playername[24],string[128];
		if(IsNull(params)) return SEM(playerid,"<USAGE>: /r [text]");
		GetPlayerName(playerid,playername,sizeof(playername));
		format(string,sizeof(string),"[WT:%d] %s: %s",PlayerInfo[playerid][Radio],playername,params);
		foreach(new i : Player)
		{
			if(PlayerInfo[i][Radio] == PlayerInfo[playerid][Radio])
			{
				SendClientMessage(i,COLOR_WT,string);
			}
		}
	}
	else SEM(playerid,"<ERROR>: You don't have any radio equipped!");
	return 1;
}
CMD:setfq(playerid,params[])
{
	if(PlayerInfo[playerid][Radio] != 0)
	{
		if(IsNull(params)) return SEM(playerid,"<USAGE>: /setfq [channel]");
		new channel = strval(params);
		if(1000 > channel > 0)
		{
			new string[128];
			PlayerInfo[playerid][Radio] = channel;
			format(string,sizeof(string),"<RADIO>: {ffffff}Radio channel changed to {ffff00}%d",channel);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		}
		else SEM(playerid,"<ERROR>: Channel cannot go below 1 or above 999!");
	}
	else SEM(playerid,"<ERROR>: You don't have any radio equipped!");
	return 1;
}
CMD:help(playerid,params[])
{
	new string[2048];
	strcat(string,"{00ffff}KEYS: {ff0000}H {ffffff}to open inventory, {ff0000}Left Alt {ffffff}or {ff0000}N {ffffff}to pickup items or other actions\n",sizeof(string));
	strcat(string,"{00ffff}COMMANDS: {ffff00}/help /unequip /engine /faq /credits /me /do /setfq\n",sizeof(string));
	strcat(string,"{00ffff}CHATS: {ffff00}/r /s /low /o\n",sizeof(string));
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"Help",string,"Close","");
	return 1;
}
CMD:faq(playerid,params[])
{
	new string[2048];
	strcat(string,"{ff0000}Q: {ffff00}What gamemode is this?\n{00ffff}A: {ffffff}Zombie survival, duh!\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}Is is allowed to kill other player?\n{00ffff}A: {ffffff}For the sake of survival, yes\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}Can I team up with other players?\n{00ffff}A: {ffffff}Yes!\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}Can I kill a zombie using a melee weapon?\n{00ffff}A: {ffffff}Not yet, use a gun\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}How many shot to kill a zombie?\n{00ffff}A: {ffffff}1-4 shots, or even more!, later there will be health bar!\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}How can I give a gun to other player?\n{00ffff}A: {ffffff}If the weapon is already equiped, can not, yet\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}How to use a map, battery, gascan, or heatpack?\n{00ffff}A: {ffffff}Those items are not usable yet, better throw it away!\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}I found a bug!\n{00ffff}A: {ffffff}Since it's still in Beta Stage, please report it when the developer is online!\n\n",sizeof(string));
	strcat(string,"{ff0000}Q: {ffff00}I have a good suggestion!\n{00ffff}A: {ffffff}We don't accept suggestions, yet\n\n",sizeof(string));
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"F.A.Q",string,"Close","");
	return 1;
}
CMD:credits(playerid,params[])
{
	new string[2048];
	strcat(string,"Special Thanks to:\n",sizeof(string));
	strcat(string,"{00ffff}DayZ Team{FFFFFF} for inspiration\n",sizeof(string));
	strcat(string,"{00ffff}SA:MP Team{FFFFFF}, {00ffff}SA:MP Forum{FFFFFF}, dan {00ffff}SA:MP Wiki{FFFFFF} for guidance.\n",sizeof(string));
	strcat(string,"{00ffff}Kalcor and Mauzen{FFFFFF} for MapAndreas plugin\n",sizeof(string));
    strcat(string,"{00ffff}Y_Less{FFFFFF} for YSI, foreach include, sscanf2 Plugin, and Whirlpool Plugin.\n",sizeof(string));
    strcat(string,"{00ffff}Incognito{FFFFFF} for Streamer Plugin and GVar plugin.\n",sizeof(string));
    strcat(string,"{00ffff}BlueG{FFFFFF} for MySQL Plugin.\n",sizeof(string));
    strcat(string,"{00ffff}Tianmetal{FFFFFF} for creating this awesome script",sizeof(string));
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"Credits",string,"Close","");
	return 1;
}