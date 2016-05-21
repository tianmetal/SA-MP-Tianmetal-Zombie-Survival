#pragma dynamic 16777216

#define MAX_PLAYERS     50
#define MAX_VEHICLES    50

#include <a_samp>
#include <a_mysql>
#include <whirlpool>
#include <sscanf2>
#include <streamer>
#include <gvar>
#include <mapandreas>
#include <PathFinder>
#include <YSI\y_iterate>
#include <YSI\y_colours>
#include <YSI\y_timers>
#include <YSI\y_commands>

#include "../gamemodes/randitem.inc"

#include "../gamemodes/mode/defines.pwn"
#include "../gamemodes/mode/variables.pwn"
#include "../gamemodes/mode/sscanf.pwn"

main() { }

stock CreateGlobalTextdraw()
{
    DebugBackground = TextDrawCreate(555.000000, 10.000000, "Debug Monitor~n~~n~~n~~n~~n~~n~~n~");
	TextDrawAlignment(DebugBackground, 2);
	TextDrawBackgroundColor(DebugBackground, 255);
	TextDrawFont(DebugBackground, 0);
	TextDrawLetterSize(DebugBackground, 0.579999, 1.899999);
	TextDrawColor(DebugBackground, -1);
	TextDrawSetOutline(DebugBackground, 0);
	TextDrawSetProportional(DebugBackground, 1);
	TextDrawSetShadow(DebugBackground, 1);
	TextDrawUseBox(DebugBackground, 1);
	TextDrawBoxColor(DebugBackground, 1127557631);
	TextDrawTextSize(DebugBackground, 0.000000, 150.000000);

    DebugTotalZombies = TextDrawCreate(483.000000, 68.000000, "Zombies (A/S): 0/0");
	TextDrawBackgroundColor(DebugTotalZombies, 255);
	TextDrawFont(DebugTotalZombies, 1);
	TextDrawLetterSize(DebugTotalZombies, 0.259999, 1.299999);
	TextDrawColor(DebugTotalZombies, -1);
	TextDrawSetOutline(DebugTotalZombies, 1);
	TextDrawSetProportional(DebugTotalZombies, 1);
	
	StatsHunger = TextDrawCreate(560.000000, 382.000000, "hud:radar_burgershot");
	TextDrawBackgroundColor(StatsHunger, 255);
	TextDrawFont(StatsHunger, 4);
	TextDrawLetterSize(StatsHunger, 0.500000, 1.000000);
	TextDrawColor(StatsHunger, -1);
	TextDrawSetOutline(StatsHunger, 0);
	TextDrawSetProportional(StatsHunger, 1);
	TextDrawSetShadow(StatsHunger, 1);
	TextDrawUseBox(StatsHunger, 1);
	TextDrawBoxColor(StatsHunger, 255);
	TextDrawTextSize(StatsHunger, 20.000000, 20.000000);

	StatsThirst = TextDrawCreate(561.000000, 357.000000, "hud:radar_diner");
	TextDrawBackgroundColor(StatsThirst, 255);
	TextDrawFont(StatsThirst, 4);
	TextDrawLetterSize(StatsThirst, 0.500000, 1.000000);
	TextDrawColor(StatsThirst, -1);
	TextDrawSetOutline(StatsThirst, 0);
	TextDrawSetProportional(StatsThirst, 1);
	TextDrawSetShadow(StatsThirst, 1);
	TextDrawUseBox(StatsThirst, 1);
	TextDrawBoxColor(StatsThirst, 255);
	TextDrawTextSize(StatsThirst, 20.000000, 20.000000);

	StatsBlood = TextDrawCreate(561.000000, 332.000000, "hud:radar_girlfriend");
	TextDrawBackgroundColor(StatsBlood, 255);
	TextDrawFont(StatsBlood, 4);
	TextDrawLetterSize(StatsBlood, 0.500000, 1.000000);
	TextDrawColor(StatsBlood, -1);
	TextDrawSetOutline(StatsBlood, 0);
	TextDrawSetProportional(StatsBlood, 1);
	TextDrawSetShadow(StatsBlood, 1);
	TextDrawUseBox(StatsBlood, 1);
	TextDrawBoxColor(StatsBlood, 255);
	TextDrawTextSize(StatsBlood, 20.000000, 20.000000);

    StatsNoise = TextDrawCreate(560.000000, 407.000000, "hud:radar_spray");
	TextDrawBackgroundColor(StatsNoise, 255);
	TextDrawFont(StatsNoise, 4);
	TextDrawLetterSize(StatsNoise, 0.500000, 1.000000);
	TextDrawColor(StatsNoise, -1);
	TextDrawSetOutline(StatsNoise, 0);
	TextDrawSetProportional(StatsNoise, 1);
	TextDrawSetShadow(StatsNoise, 1);
	TextDrawUseBox(StatsNoise, 1);
	TextDrawBoxColor(StatsNoise, 255);
	TextDrawTextSize(StatsNoise, 20.000000, 20.000000);

	StatsBlockGPS = TextDrawCreate(89.000000, 340.000000, "_~n~~n~~n~~n~No GPS~n~~n~~n~~n~~n~~n~");
	TextDrawAlignment(StatsBlockGPS, 2);
	TextDrawBackgroundColor(StatsBlockGPS, 255);
	TextDrawFont(StatsBlockGPS, 1);
	TextDrawLetterSize(StatsBlockGPS, 0.500000, 1.000000);
	TextDrawColor(StatsBlockGPS, -1);
	TextDrawSetOutline(StatsBlockGPS, 0);
	TextDrawSetProportional(StatsBlockGPS, 1);
	TextDrawSetShadow(StatsBlockGPS, 1);
	TextDrawUseBox(StatsBlockGPS, 1);
	TextDrawBoxColor(StatsBlockGPS, 255);
	TextDrawTextSize(StatsBlockGPS, 0.000000, 118.000000);

	StatsBleeding = TextDrawCreate(560.000000, 308.000000, "hud:radar_hostpital");
	TextDrawBackgroundColor(StatsBleeding, 255);
	TextDrawFont(StatsBleeding, 4);
	TextDrawLetterSize(StatsBleeding, 0.500000, 1.000000);
	TextDrawColor(StatsBleeding, -1);
	TextDrawSetOutline(StatsBleeding, 0);
	TextDrawSetProportional(StatsBleeding, 1);
	TextDrawSetShadow(StatsBleeding, 1);
	TextDrawUseBox(StatsBleeding, 1);
	TextDrawBoxColor(StatsBleeding, 255);
	TextDrawTextSize(StatsBleeding, 20.000000, 20.000000);

	StatsBrokenLeg = TextDrawCreate(592.000000, 308.000000, "hud:radar_gym");
	TextDrawBackgroundColor(StatsBrokenLeg, 255);
	TextDrawFont(StatsBrokenLeg, 4);
	TextDrawLetterSize(StatsBrokenLeg, 0.500000, 1.000000);
	TextDrawColor(StatsBrokenLeg, -65281);
	TextDrawSetOutline(StatsBrokenLeg, 0);
	TextDrawSetProportional(StatsBrokenLeg, 1);
	TextDrawSetShadow(StatsBrokenLeg, 1);
	TextDrawUseBox(StatsBrokenLeg, 1);
	TextDrawBoxColor(StatsBrokenLeg, 255);
	TextDrawTextSize(StatsBrokenLeg, 20.000000, 20.000000);
	return 1;
}
stock CreatePlayerTextdraws(playerid)
{
    DebugKills[playerid] = CreatePlayerTextDraw(playerid,481.000000, 32.000000, "Zombies killed: 0");
	PlayerTextDrawBackgroundColor(playerid,DebugKills[playerid], 255);
	PlayerTextDrawFont(playerid,DebugKills[playerid], 1);
	PlayerTextDrawLetterSize(playerid,DebugKills[playerid], 0.259999, 1.299999);
	PlayerTextDrawColor(playerid,DebugKills[playerid], -1);
	PlayerTextDrawSetOutline(playerid,DebugKills[playerid], 1);
	PlayerTextDrawSetProportional(playerid,DebugKills[playerid], 1);

	DebugMurders[playerid] = CreatePlayerTextDraw(playerid,510.000000, 44.000000, "Murders: 0");
	PlayerTextDrawBackgroundColor(playerid,DebugMurders[playerid], 255);
	PlayerTextDrawFont(playerid,DebugMurders[playerid], 1);
	PlayerTextDrawLetterSize(playerid,DebugMurders[playerid], 0.259999, 1.299999);
	PlayerTextDrawColor(playerid,DebugMurders[playerid], -1);
	PlayerTextDrawSetOutline(playerid,DebugMurders[playerid], 1);
	PlayerTextDrawSetProportional(playerid,DebugMurders[playerid], 1);

	DebugBlood[playerid] = CreatePlayerTextDraw(playerid,521.000000, 56.000000, "Blood: 12000.0");
	PlayerTextDrawBackgroundColor(playerid,DebugBlood[playerid], 255);
	PlayerTextDrawFont(playerid,DebugBlood[playerid], 1);
	PlayerTextDrawLetterSize(playerid,DebugBlood[playerid], 0.259999, 1.299999);
	PlayerTextDrawColor(playerid,DebugBlood[playerid], -1);
	PlayerTextDrawSetOutline(playerid,DebugBlood[playerid], 1);
	PlayerTextDrawSetProportional(playerid,DebugBlood[playerid], 1);

	DebugTemperature[playerid] = CreatePlayerTextDraw(playerid,490.000000, 80.000000, "Temperature: 42 C");
	PlayerTextDrawBackgroundColor(playerid,DebugTemperature[playerid], 255);
	PlayerTextDrawFont(playerid,DebugTemperature[playerid], 1);
	PlayerTextDrawLetterSize(playerid,DebugTemperature[playerid], 0.259999, 1.299999);
	PlayerTextDrawColor(playerid,DebugTemperature[playerid], -1);
	PlayerTextDrawSetOutline(playerid,DebugTemperature[playerid], 1);
	PlayerTextDrawSetProportional(playerid,DebugTemperature[playerid], 1);

	DebugName[playerid] = CreatePlayerTextDraw(playerid,521.000000, 92.000000, "Name: Tianmetal");
	PlayerTextDrawBackgroundColor(playerid,DebugName[playerid], 255);
	PlayerTextDrawFont(playerid,DebugName[playerid], 1);
	PlayerTextDrawLetterSize(playerid,DebugName[playerid], 0.259999, 1.299999);
	PlayerTextDrawColor(playerid,DebugName[playerid], -1);
	PlayerTextDrawSetOutline(playerid,DebugName[playerid], 1);
	PlayerTextDrawSetProportional(playerid,DebugName[playerid], 1);

	DebugWeapon[playerid] = CreatePlayerTextDraw(playerid,511.000000, 104.000000, "Weapon: None");
	PlayerTextDrawBackgroundColor(playerid,DebugWeapon[playerid], 255);
	PlayerTextDrawFont(playerid,DebugWeapon[playerid], 1);
	PlayerTextDrawLetterSize(playerid,DebugWeapon[playerid], 0.259999, 1.299999);
	PlayerTextDrawColor(playerid,DebugWeapon[playerid], -1);
	PlayerTextDrawSetOutline(playerid,DebugWeapon[playerid], 1);
	PlayerTextDrawSetProportional(playerid,DebugWeapon[playerid], 1);

	DebugAmmo[playerid] = CreatePlayerTextDraw(playerid,519.000000, 116.000000, "Ammo: 0");
	PlayerTextDrawBackgroundColor(playerid,DebugAmmo[playerid], 255);
	PlayerTextDrawFont(playerid,DebugAmmo[playerid], 1);
	PlayerTextDrawLetterSize(playerid,DebugAmmo[playerid], 0.259999, 1.299999);
	PlayerTextDrawColor(playerid,DebugAmmo[playerid], -1);
	PlayerTextDrawSetOutline(playerid,DebugAmmo[playerid], 1);
	PlayerTextDrawSetProportional(playerid,DebugAmmo[playerid], 1);
	
	StatsHungerBar[playerid] = CreatePlayerTextDraw(playerid,583.000000, 384.000000, "IIIIIIIIII");
	PlayerTextDrawBackgroundColor(playerid,StatsHungerBar[playerid], 255);
	PlayerTextDrawFont(playerid,StatsHungerBar[playerid], 1);
	PlayerTextDrawLetterSize(playerid,StatsHungerBar[playerid], 0.460000, 1.899999);
	PlayerTextDrawColor(playerid,StatsHungerBar[playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,StatsHungerBar[playerid], 1);
	PlayerTextDrawSetProportional(playerid,StatsHungerBar[playerid], 1);

	StatsThirstBar[playerid] = CreatePlayerTextDraw(playerid,583.000000, 359.000000, "IIIIIIIIII");
	PlayerTextDrawBackgroundColor(playerid,StatsThirstBar[playerid], 255);
	PlayerTextDrawFont(playerid,StatsThirstBar[playerid], 1);
	PlayerTextDrawLetterSize(playerid,StatsThirstBar[playerid], 0.460000, 1.899999);
	PlayerTextDrawColor(playerid,StatsThirstBar[playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,StatsThirstBar[playerid], 1);
	PlayerTextDrawSetProportional(playerid,StatsThirstBar[playerid], 1);

	StatsBloodBar[playerid] = CreatePlayerTextDraw(playerid,583.000000, 334.000000, "IIIIIIIIII");
	PlayerTextDrawBackgroundColor(playerid,StatsBloodBar[playerid], 255);
	PlayerTextDrawFont(playerid,StatsBloodBar[playerid], 1);
	PlayerTextDrawLetterSize(playerid,StatsBloodBar[playerid], 0.460000, 1.899999);
	PlayerTextDrawColor(playerid,StatsBloodBar[playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,StatsBloodBar[playerid], 1);
	PlayerTextDrawSetProportional(playerid,StatsBloodBar[playerid], 1);
	
	StatsNoiseBar[playerid] = CreatePlayerTextDraw(playerid,583.000000, 408.000000, "IIIIIIIIII");
	PlayerTextDrawBackgroundColor(playerid,StatsNoiseBar[playerid], 255);
	PlayerTextDrawFont(playerid,StatsNoiseBar[playerid], 1);
	PlayerTextDrawLetterSize(playerid,StatsNoiseBar[playerid], 0.460000, 1.899999);
	PlayerTextDrawColor(playerid,StatsNoiseBar[playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,StatsNoiseBar[playerid], 1);
	PlayerTextDrawSetProportional(playerid,StatsNoiseBar[playerid], 1);
	return 1;
}
stock ShowDebugMonitor(playerid)
{
	new string[32],weaponid,playername[MAX_PLAYER_NAME];
	weaponid = GetPlayerWeapon(playerid);
	GetPlayerName(playerid,playername,sizeof(playername));
	TextDrawShowForPlayer(playerid,DebugBackground);
	TextDrawShowForPlayer(playerid,DebugTotalZombies);
	PlayerTextDrawShow(playerid,DebugKills[playerid]);
	PlayerTextDrawShow(playerid,DebugMurders[playerid]);
	PlayerTextDrawShow(playerid,DebugBlood[playerid]);
	PlayerTextDrawShow(playerid,DebugTemperature[playerid]);
	PlayerTextDrawShow(playerid,DebugName[playerid]);
	PlayerTextDrawShow(playerid,DebugWeapon[playerid]);
	PlayerTextDrawShow(playerid,DebugAmmo[playerid]);
	format(string,sizeof(string),"Zombies killed: %d",PlayerInfo[playerid][Kills]);
	PlayerTextDrawSetString(playerid,DebugKills[playerid],string);
	format(string,sizeof(string),"Murders: %d",PlayerInfo[playerid][Murders]);
	PlayerTextDrawSetString(playerid,DebugMurders[playerid],string);
	format(string,sizeof(string),"Blood: %.1f",PlayerInfo[playerid][Blood]);
	PlayerTextDrawSetString(playerid,DebugBlood[playerid],string);
	format(string,sizeof(string),"Temperature: %d C",PlayerInfo[playerid][Temperature]);
	PlayerTextDrawSetString(playerid,DebugTemperature[playerid],string);
	format(string,sizeof(string),"Name: %s",playername);
	PlayerTextDrawSetString(playerid,DebugName[playerid],string);
	format(string,sizeof(string),"Weapon: %s",GunNames[weaponid]);
	PlayerTextDrawSetString(playerid,DebugWeapon[playerid],string);
	format(string,sizeof(string),"Ammo: %d",0);
	PlayerTextDrawSetString(playerid,DebugAmmo[playerid],string);
	return 1;
}
stock HideDebugMonitor(playerid)
{
    TextDrawHideForPlayer(playerid,DebugBackground);
	TextDrawHideForPlayer(playerid,DebugTotalZombies);
	PlayerTextDrawHide(playerid,DebugKills[playerid]);
	PlayerTextDrawHide(playerid,DebugMurders[playerid]);
	PlayerTextDrawHide(playerid,DebugBlood[playerid]);
	PlayerTextDrawHide(playerid,DebugTemperature[playerid]);
	PlayerTextDrawHide(playerid,DebugName[playerid]);
	PlayerTextDrawHide(playerid,DebugWeapon[playerid]);
	PlayerTextDrawHide(playerid,DebugAmmo[playerid]);
	return 1;
}
stock UpdateDebugMonitor(playerid,type,value=0)
{
	new string[32];
	switch(type)
	{
	    case DEBUG_KILLS:
	    {
	        format(string,sizeof(string),"Zombies killed: %d",PlayerInfo[playerid][Kills]);
			PlayerTextDrawSetString(playerid,DebugKills[playerid],string);
	    }
	    case DEBUG_MURDERS:
	    {
	        format(string,sizeof(string),"Murders: %d",PlayerInfo[playerid][Murders]);
			PlayerTextDrawSetString(playerid,DebugMurders[playerid],string);
	    }
	    case DEBUG_BLOOD:
	    {
	        format(string,sizeof(string),"Blood: %.1f",PlayerInfo[playerid][Blood]);
			PlayerTextDrawSetString(playerid,DebugBlood[playerid],string);
	    }
	    case DEBUG_TEMPERATURE:
	    {
	        format(string,sizeof(string),"Temperature: %d C",PlayerInfo[playerid][Temperature]);
			PlayerTextDrawSetString(playerid,DebugTemperature[playerid],string);
	    }
	    case DEBUG_WEAPON:
	    {
	        new weaponid = GetPlayerWeapon(playerid);
	        format(string,sizeof(string),"Weapon: %s",GunNames[weaponid]);
			PlayerTextDrawSetString(playerid,DebugWeapon[playerid],string);
	    }
	    case DEBUG_AMMO:
	    {
	        format(string,sizeof(string),"Ammo: %d",value);
			PlayerTextDrawSetString(playerid,DebugAmmo[playerid],string);
	    }
	}
	return 1;
}
stock SendRangedClientMessage(senderid,Float:range,string[],bool:fading,color=0)
{
    new Float:pPos[3],pRange,MaxRange,interior,world;
    MaxRange = floatround(range);
    interior = GetPlayerInterior(senderid);
    world = GetPlayerVirtualWorld(senderid);
    GetPlayerPos(senderid,pPos[0],pPos[1],pPos[2]);
    if(fading) SendClientMessage(senderid,COLOR_WHITE,string);
    else SendClientMessage(senderid,color,string);
	foreach(new i : Player)
	{
	    if(i == senderid) continue;
        if(GetPlayerVirtualWorld(i) == world && GetPlayerInterior(i) == interior)
        {
			pRange = floatround(GetPlayerDistanceFromPoint(i,pPos[0],pPos[1],pPos[2]));
			if(pRange < MaxRange)
			{
			    if(fading)
			    {
			        new fadeRGB = (255-((pRange*255)/MaxRange));
			    	SendClientMessage(i,RGBAToInt(fadeRGB,fadeRGB,fadeRGB,255),string);
				}
				else
				{
				    SendClientMessage(i,color,string);
				}
			}
		}
	}
	return 1;
}
stock ShowIndicators(playerid)
{
    TextDrawShowForPlayer(playerid,StatsHunger);
	TextDrawShowForPlayer(playerid,StatsThirst);
	TextDrawShowForPlayer(playerid,StatsBlood);
	TextDrawShowForPlayer(playerid,StatsNoise);
	if(PlayerInfo[playerid][GPS] == 0)
	{
		TextDrawShowForPlayer(playerid,StatsBlockGPS);
		GangZoneShowForPlayer(playerid,MapBlock,255);
	}
	if(PlayerInfo[playerid][Desease][0] == 1)
	{
		TextDrawShowForPlayer(playerid,StatsBleeding);
		SetPlayerAttachedObject(playerid,4,18706,1,0.0,0.0,-1.85,0.0,0.0,0.0,1.0,1.0,1.0,RGBAToInt(255,255,0,0));
	}
	if(PlayerInfo[playerid][Desease][1] == 1) TextDrawShowForPlayer(playerid,StatsBrokenLeg);
	new barsize[16],barcolor;
	new totalbar = ((MAX_MOTIVE-PlayerInfo[playerid][Hunger])/(MAX_MOTIVE/10));
	barcolor = (totalbar*25);
	if(totalbar == 0) totalbar = 1;
	forex(i,totalbar)
	{
		barsize[i] = 'I';
	}
	barsize[totalbar] = EOS;
	PlayerTextDrawColor(playerid,StatsHungerBar[playerid],RGBAToInt((255-barcolor),barcolor,0,255));
	PlayerTextDrawSetString(playerid,StatsHungerBar[playerid],barsize);
	totalbar = ((MAX_MOTIVE-PlayerInfo[playerid][Thirst])/(MAX_MOTIVE/10));
	barcolor = (totalbar*25);
	if(totalbar == 0) totalbar = 1;
	forex(i,totalbar)
	{
		barsize[i] = 'I';
	}
	barsize[totalbar] = EOS;
	PlayerTextDrawColor(playerid,StatsThirstBar[playerid],RGBAToInt((255-barcolor),barcolor,0,255));
	PlayerTextDrawSetString(playerid,StatsThirstBar[playerid],barsize);
	totalbar = floatround((PlayerInfo[playerid][Blood]/1200));
	barcolor = (totalbar*25);
	if(totalbar == 0) totalbar = 1;
	forex(i,totalbar)
	{
		barsize[i] = 'I';
	}
	barsize[totalbar] = EOS;
	PlayerTextDrawColor(playerid,StatsBloodBar[playerid],RGBAToInt((255-barcolor),barcolor,0,255));
	PlayerTextDrawSetString(playerid,StatsBloodBar[playerid],barsize);
	PlayerTextDrawShow(playerid,StatsHungerBar[playerid]);
	PlayerTextDrawShow(playerid,StatsThirstBar[playerid]);
	PlayerTextDrawShow(playerid,StatsBloodBar[playerid]);
	PlayerTextDrawShow(playerid,StatsNoiseBar[playerid]);
	return 1;
}
stock HideIndicators(playerid)
{
    TextDrawHideForPlayer(playerid,StatsHunger);
	TextDrawHideForPlayer(playerid,StatsThirst);
	TextDrawHideForPlayer(playerid,StatsBlood);
	TextDrawHideForPlayer(playerid,StatsNoise);
	TextDrawHideForPlayer(playerid,StatsBlockGPS);
	TextDrawHideForPlayer(playerid,StatsBleeding);
	TextDrawHideForPlayer(playerid,StatsBrokenLeg);
	PlayerTextDrawHide(playerid,StatsHungerBar[playerid]);
	PlayerTextDrawHide(playerid,StatsThirstBar[playerid]);
	PlayerTextDrawHide(playerid,StatsBloodBar[playerid]);
	PlayerTextDrawHide(playerid,StatsNoiseBar[playerid]);
	return 1;
}
stock UpdateIndicator(playerid,type,extradata=0)
{
	new barsize[16],totalbar,barcolor;
	switch(type)
	{
	    case INDICATOR_HUNGER:
	    {
	        totalbar = ((MAX_MOTIVE-PlayerInfo[playerid][Hunger])/(MAX_MOTIVE/10));
	        barcolor = (totalbar*25);
			if(totalbar == 0) totalbar = 1;
			forex(i,totalbar)
			{
				barsize[i] = 'I';
			}
			barsize[totalbar] = EOS;
			PlayerTextDrawSetString(playerid,StatsHungerBar[playerid],barsize);
			PlayerTextDrawColor(playerid,StatsHungerBar[playerid],RGBAToInt((255-barcolor),barcolor,0,255));
			PlayerTextDrawHide(playerid,StatsHungerBar[playerid]);
			PlayerTextDrawShow(playerid,StatsHungerBar[playerid]);
	    }
	    case INDICATOR_THIRST:
	    {
	        totalbar = ((MAX_MOTIVE-PlayerInfo[playerid][Thirst])/(MAX_MOTIVE/10));
	        barcolor = (totalbar*25);
			if(totalbar == 0) totalbar = 1;
			forex(i,totalbar)
			{
				barsize[i] = 'I';
			}
			barsize[totalbar] = EOS;
			PlayerTextDrawSetString(playerid,StatsThirstBar[playerid],barsize);
			PlayerTextDrawColor(playerid,StatsThirstBar[playerid],RGBAToInt((255-barcolor),barcolor,0,255));
			PlayerTextDrawHide(playerid,StatsThirstBar[playerid]);
			PlayerTextDrawShow(playerid,StatsThirstBar[playerid]);
	    }
	    case INDICATOR_BLOOD:
	    {
	        totalbar = floatround((PlayerInfo[playerid][Blood]/1200));
	        barcolor = (totalbar*25);
			if(totalbar == 0) totalbar = 1;
			forex(i,totalbar)
			{
				barsize[i] = 'I';
			}
			barsize[totalbar] = EOS;
			PlayerTextDrawSetString(playerid,StatsBloodBar[playerid],barsize);
			PlayerTextDrawColor(playerid,StatsBloodBar[playerid],RGBAToInt((255-barcolor),barcolor,0,255));
			PlayerTextDrawHide(playerid,StatsBloodBar[playerid]);
			PlayerTextDrawShow(playerid,StatsBloodBar[playerid]);
	    }
	    case INDICATOR_NOISE:
	    {
	        if(extradata == 0)
	        {
	            PlayerTextDrawSetString(playerid,StatsNoiseBar[playerid],"_");
	        }
	        else
	        {
		        forex(i,extradata)
		        {
		            barsize[i] = 'I';
		        }
		        barsize[extradata] = EOS;
		        barcolor = (extradata*25);
		        PlayerTextDrawSetString(playerid,StatsNoiseBar[playerid],barsize);
				PlayerTextDrawColor(playerid,StatsNoiseBar[playerid],RGBAToInt(barcolor,(255-barcolor),0,255));
			}
			PlayerTextDrawHide(playerid,StatsNoiseBar[playerid]);
			PlayerTextDrawShow(playerid,StatsNoiseBar[playerid]);
	    }
	}
	return 1;
}
stock SavePlayer(playerid)
{
	new string[2048];
	if(PlayerInfo[playerid][Spawned])
	{
	    new Float:cPos[3],substr[32];
	    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);

	    format(string,sizeof(string),"UPDATE `users` SET `spawned`='1',`pos_x`='%.2f',`pos_y`='%.2f',`pos_z`='%.2f',`deaths`='%d',`skin`='%d',`kills`='%d',`murders`='%d'",
		cPos[0],cPos[1],cPos[2],PlayerInfo[playerid][Deaths],PlayerInfo[playerid][Skin],PlayerInfo[playerid][Kills],PlayerInfo[playerid][Murders]);
	    format(string,sizeof(string),"%s,`blood`='%.1f',`temperature`='%d',`hunger`='%d',`thirst`='%d',`desease1`='%d',`desease2`='%d',`bag`='%d',`map`='%d',`gps`='%d',`toolbox`='%d'",string,
	    PlayerInfo[playerid][Blood],PlayerInfo[playerid][Temperature],PlayerInfo[playerid][Hunger],PlayerInfo[playerid][Thirst],PlayerInfo[playerid][Desease][0],PlayerInfo[playerid][Desease][1],
	    PlayerInfo[playerid][Bag],PlayerInfo[playerid][Map],PlayerInfo[playerid][GPS],PlayerInfo[playerid][Toolbox]);
	    forex(i,MAX_INVENTORY_SLOT)
	    {
	        format(substr,sizeof(substr),",`item%d`='%d'",(i+1),PlayerInfo[playerid][Item][i]);
	        strcat(string,substr,sizeof(string));
	    }
        format(string,sizeof(string),"%s,`gun1`='%d',`gun2`='%d',`gun3`='%d',`ammo1`='%d',`ammo2`='%d',`radio`='%d' WHERE `id`='%d'",string,
        PlayerInfo[playerid][Weapon][0],PlayerInfo[playerid][Weapon][1],PlayerInfo[playerid][Weapon][2],PlayerInfo[playerid][Ammo][0],PlayerInfo[playerid][Ammo][1],PlayerInfo[playerid][Radio],PlayerInfo[playerid][ID]);
	}
	else
	{
		format(string,sizeof(string),"UPDATE `users` SET `spawned`='0',`deaths`='%d' WHERE `id`='%d'",PlayerInfo[playerid][Deaths],PlayerInfo[playerid][ID]);
	}
	mysql_function_query(Database,string,false,"User_Save","d",playerid);
	return 1;
}
stock ClearPlayerData(playerid,bool:full)
{
	if(full)
	{
	    PlayerInfo[playerid][ID] = 0;
		PlayerInfo[playerid][Deaths] = 0;
		IsPlayerLogged[playerid] = false;
	}
	ResetPlayerWeapons(playerid);
	PlayerInfo[playerid][Spawned] = false;
	PlayerInfo[playerid][Skin] = MaleSkins[random(sizeof(MaleSkins))];
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][Murders] = 0;
	PlayerInfo[playerid][Blood] = 12000.0;
	PlayerInfo[playerid][Temperature] = 37;
	PlayerInfo[playerid][Hunger] = 0;
	PlayerInfo[playerid][Thirst] = 0;
	forex(i,2)
	{
		PlayerInfo[playerid][Desease][i] = 0;
	}
	PlayerInfo[playerid][Bag] = 0;
	PlayerInfo[playerid][Map] = 0;
	PlayerInfo[playerid][GPS] = 0;
	PlayerInfo[playerid][Toolbox] = 0;
	forex(i,MAX_INVENTORY_SLOT)
	{
		PlayerInfo[playerid][Item][i] = 0;
	}
	forex(i,3)
	{
		PlayerInfo[playerid][Weapon][i] = 0;
	}
	forex(i,2)
	{
	    PlayerInfo[playerid][Ammo][i] = 0;
	}
	PlayerInfo[playerid][Radio] = 0;
	CurrentWeapon[playerid] = 0;
	Crouching[playerid] = false;
	WeaponNoise[playerid] = false;
	Iter_Clear(StreamedZombies[playerid]);
	return 1;
}
stock CreateDrop(item,Float:pos_x,Float:pos_y,Float:pos_z)
{
	if(item == -1)
	{
	    item = ITEM_NONE;
		if(random(2) == random(2))
		{
		    item = random(TOTAL_ITEMS);
		}
	}
	if(item == ITEM_NONE) return 0;
	new slot = Iter_Free(Drops);
	if(slot == -1) return 0;
	new Float:rotation = float(random(360));
	DropInfo[slot][Object] = CreateDynamicObject(ItemData[item][Model],pos_x,pos_y,pos_z+ItemData[item][OffsetZ],ItemData[item][RotationX],ItemData[item][RotationY],rotation);
	Iter_Add(Drops,slot);
	DropInfo[slot][Item] = item;
	DropInfo[slot][Area] = CreateDynamicSphere(pos_x,pos_y,pos_z,2.0);
	DropInfo[slot][Label] = CreateDynamic3DTextLabel("Press {00ffff}Left ALT {ffffff}to pickup the drop",-1,pos_x,pos_y,pos_z-1.0,5.0);
	SetGVarInt("AreaType",AREA_TYPE_DROP,DropInfo[slot][Area]);
	SetGVarInt("AreaData",slot,DropInfo[slot][Area]);
	return 1;
}
stock DeleteDrop(slot)
{
	Iter_Remove(Drops,slot);
	DestroyDynamicObject(DropInfo[slot][Object]);
	DestroyDynamic3DTextLabel(DropInfo[slot][Label]);
	DeleteGVar("AreaType",DropInfo[slot][Area]);
	DeleteGVar("AreaData",DropInfo[slot][Area]);
	DestroyDynamicArea(DropInfo[slot][Area]);
	return 1;
}
stock CreatePlayerDrop(item,Float:pos_x,Float:pos_y,Float:pos_z)
{
	if(item == ITEM_NONE) return 0;
	new slot = Iter_Free(PlayerDrops);
	if(slot == -1) return 0;
	new Float:rotation = float(random(360));
	PlayerDropInfo[slot][Object] = CreateDynamicObject(ItemData[item][Model],pos_x,pos_y,(pos_z+ItemData[item][OffsetZ]),ItemData[item][RotationX],ItemData[item][RotationY],rotation);
	Iter_Add(PlayerDrops,slot);
	PlayerDropInfo[slot][Timestamp] = gTimestamp;
	PlayerDropInfo[slot][Item] = item;
	PlayerDropInfo[slot][Area] = CreateDynamicSphere(pos_x,pos_y,pos_z,2.0);
	PlayerDropInfo[slot][Label] = CreateDynamic3DTextLabel("{ffff00}Someone dropped this item!\n{ffffff}Press {00ffff}Left ALT {ffffff}to pickup the drop",-1,pos_x,pos_y,pos_z-1.0,5.0);
	SetGVarInt("AreaType",AREA_TYPE_PLAYER_DROP,PlayerDropInfo[slot][Area]);
	SetGVarInt("AreaData",slot,PlayerDropInfo[slot][Area]);
	return 1;
}
stock DeletePlayerDrop(slot)
{
    Iter_Remove(PlayerDrops,slot);
	DestroyDynamicObject(PlayerDropInfo[slot][Object]);
	DestroyDynamic3DTextLabel(PlayerDropInfo[slot][Label]);
	DeleteGVar("AreaType",PlayerDropInfo[slot][Area]);
	DeleteGVar("AreaData",PlayerDropInfo[slot][Area]);
	DestroyDynamicArea(PlayerDropInfo[slot][Area]);
	return 1;
}
stock AttachBag(playerid)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
	switch(PlayerInfo[playerid][Bag])
	{
	    case BAG_SMALL: SetPlayerAttachedObject(playerid,3,363,1,0.317999,-0.153000,0.185000,0.000000,86.200012,-1.499999,1.0,1.0,1.0);
	    case BAG_MEDIUM: SetPlayerAttachedObject(playerid,3,371,1,0.097999,-0.135000,-0.011000,1.100000,87.699958,3.199999,1.0,1.0,1.0);
	    case BAG_LARGE: SetPlayerAttachedObject(playerid,3,3026,1,-0.130000,-0.079999,0.000000,0.000000,0.000000,0.000000,1.0,1.319000,1.432000);
	    case BAG_HUGE: SetPlayerAttachedObject(playerid,3,1310,1,-0.085999,-0.193999,0.000000,0.000000,88.499969,0.000000,1.0,1.0,1.0);
	}
	return 1;
}
stock DetachBag(playerid)
{
    if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
	return 1;
}
stock CreateVehicles()
{
	forex(i,sizeof(VehSpawn))
	{
		if(random(35) == random(35))
		{
		    new vehid = CreateVehicle(VehData[random(sizeof(VehData))][Model],VehSpawn[i][0],VehSpawn[i][1],VehSpawn[i][2],VehSpawn[i][3],random(255),random(255),6000000);
		    VehicleInfo[vehid][Area] = CreateDynamicSphere(0.0,0.0,0.0,5.0);
		    AttachDynamicAreaToVehicle(VehicleInfo[vehid][Area],vehid);
		    SetGVarInt("AreaType",AREA_TYPE_VEHICLE,VehicleInfo[vehid][Area]);
		    SetGVarInt("AreaData",vehid,VehicleInfo[vehid][Area]);
		    VehicleInfo[vehid][Label] = CreateDynamic3DTextLabel("Press {ff0000}N {ffffff}to view vehicle stats",-1,0.0,0.0,0.0,5.0,.attachedvehicle=vehid,.testlos=1);
		    VehicleInfo[vehid][Fuel] = random(25);
		    VehicleInfo[vehid][Engine] = 0;
		    VehicleInfo[vehid][Tires] = 0;
		    forex(slot,5)
		    {
		        VehicleInfo[vehid][Item][slot] = 0;
		        if(random(10) == random(10))
		        {
		            VehicleInfo[vehid][Item][slot] = random(TOTAL_ITEMS);
		        }
		    }
            Iter_Add(Vehicles,vehid);
		    if(Iter_Count(Vehicles) == 50) break;
		}
	}
	return Iter_Count(Vehicles);
}
public OnVehicleSpawn(vehicleid)
{
	if(Iter_Contains(Vehicles,vehicleid))
	{
	    DestroyVehicle(vehicleid);
	    Iter_Remove(Vehicles,vehicleid);
		DeleteGVar("AreaType",VehicleInfo[vehicleid][Area]);
		DeleteGVar("AreaData",VehicleInfo[vehicleid][Area]);
		DestroyDynamicArea(VehicleInfo[vehicleid][Area]);
		DestroyDynamic3DTextLabel(VehicleInfo[vehicleid][Label]);
		if(Iter_Count(Vehicles) < 10) CreateVehicles();
	}
	return 1;
}
stock CreateZombie(Float:pX,Float:pY,Float:pZ,Float:angle)
{
	new zombie = Iter_Free(Zombies);
	if(zombie == -1) return -1;
	Iter_Add(Zombies,zombie);
	new Float:PEPE = floatsin((angle*3.14159/180.0));
	new Float:PIPO = floatcos((angle*3.14159/180.0));
	new string[32];
	ZombieInfo[zombie][Head] = CreateDynamicObject(z1[headZ][partModel],pX,pY,pZ,z1[headZ][RelrX],z1[headZ][RelrY],angle);
	ZombieInfo[zombie][Torso] = CreateDynamicObject(z1[torsoZ][partModel],pX+z1[torsoZ][RelX]*PIPO+PEPE*z2[torsoZ][RelX],pY+z1[torsoZ][RelY]*PIPO+PEPE*z2[torsoZ][RelY],pZ+z1[torsoZ][RelZ],z1[torsoZ][RelrX],z1[torsoZ][RelrY],angle);
	ZombieInfo[zombie][LeftArm] = CreateDynamicObject(z1[lArmZ][partModel],pX+z1[lArmZ][RelX]*PIPO+PEPE*z2[lArmZ][RelX],pY+z1[lArmZ][RelY]*PIPO+PEPE*z2[lArmZ][RelY],pZ+z1[lArmZ][RelZ],z1[lArmZ][RelrX],z1[lArmZ][RelrY],angle);
	ZombieInfo[zombie][RightArm] = CreateDynamicObject(z1[rArmZ][partModel],pX+z1[rArmZ][RelX]*PIPO+PEPE*z2[rArmZ][RelX],pY+z1[rArmZ][RelY]*PIPO+PEPE*z2[rArmZ][RelY],pZ+z1[rArmZ][RelZ],z1[rArmZ][RelrX],z1[rArmZ][RelrY],angle);
	ZombieInfo[zombie][LeftLeg] = CreateDynamicObject(z1[lLegZ][partModel],pX+z1[lLegZ][RelX]*PIPO+PEPE*z2[lLegZ][RelX],pY+z1[lLegZ][RelY]*PIPO+PEPE*z2[lLegZ][RelY],pZ+z1[lLegZ][RelZ],z1[lLegZ][RelrX],z1[lLegZ][RelrY],angle);
	ZombieInfo[zombie][RightLeg] = CreateDynamicObject(z1[rLegZ][partModel],pX+z1[rLegZ][RelX]*PIPO+PEPE*z2[rLegZ][RelX],pY+z1[rLegZ][RelY]*PIPO+PEPE*z2[rLegZ][RelY],pZ+z1[rLegZ][RelZ],z1[rLegZ][RelrX],z1[rLegZ][RelrY],angle);

	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][Head]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][Torso]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][LeftArm]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][RightArm]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][LeftLeg]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][RightLeg]);

	ZombieInfo[zombie][Dead] = false;
	ZombieInfo[zombie][Target] = INVALID_PLAYER_ID;
	ZombieInfo[zombie][Item] = random(TOTAL_ITEMS);
	ZombieInfo[zombie][AreaFar] = CreateDynamicCircle(0.0,0.0,250.0);
 	ZombieInfo[zombie][Area] = CreateDynamicSphere(0.0,0.0,0.0,5.0);
	AttachDynamicAreaToObject(ZombieInfo[zombie][AreaFar],ZombieInfo[zombie][Torso]);
	AttachDynamicAreaToObject(ZombieInfo[zombie][Area],ZombieInfo[zombie][Torso]);
	SetGVarInt("AreaType",AREA_TYPE_ZOMBIE_FAR,ZombieInfo[zombie][AreaFar]);
	SetGVarInt("AreaData",zombie,ZombieInfo[zombie][AreaFar]);
	SetGVarInt("AreaType",AREA_TYPE_ZOMBIE_NEAR,ZombieInfo[zombie][Area]);
	SetGVarInt("AreaData",zombie,ZombieInfo[zombie][Area]);
	SetGVarInt("ZombieID",zombie,ZombieInfo[zombie][Torso]);
	format(string,sizeof(string),"Zombies (A/S): %d/%d",Iter_Count(Zombies),Iter_Count(Zombies));
	TextDrawSetString(DebugTotalZombies,string);
	return zombie;
}
stock KillZombie(zombie)
{
	if(ZombieInfo[zombie][Dead]) return 0;
	new string[32],Float:cPos[3];
	GetDynamicObjectPos(ZombieInfo[zombie][Head],cPos[0],cPos[1],cPos[2]);
	ZombieInfo[zombie][Dead] = true;
	ZombieInfo[zombie][DeadTimestamp] = gTimestamp;
	
	DeleteGVar("ZObject",ZombieInfo[zombie][Head]);
	DeleteGVar("ZObject",ZombieInfo[zombie][LeftArm]);
	DeleteGVar("ZObject",ZombieInfo[zombie][RightArm]);
	DeleteGVar("ZObject",ZombieInfo[zombie][LeftLeg]);
	DeleteGVar("ZObject",ZombieInfo[zombie][RightLeg]);
	
	DestroyDynamicObject(ZombieInfo[zombie][Head]);
	DestroyDynamicObject(ZombieInfo[zombie][LeftArm]);
	DestroyDynamicObject(ZombieInfo[zombie][RightArm]);
	DestroyDynamicObject(ZombieInfo[zombie][LeftLeg]);
	DestroyDynamicObject(ZombieInfo[zombie][RightLeg]);
	ZombieInfo[zombie][Target] = INVALID_PLAYER_ID;
	StopDynamicObject(ZombieInfo[zombie][Torso]);
    MapAndreas_FindZ_For2DCoord(cPos[0],cPos[1],cPos[2]);
    SetDynamicObjectPos(ZombieInfo[zombie][Torso],cPos[0],cPos[1],cPos[2]+0.3);
    SetDynamicObjectRot(ZombieInfo[zombie][Torso],0.0,0.0,float(random(360)));
    ZombieInfo[zombie][Label] = CreateDynamic3DTextLabel("{ffff00}Dead Zombie\n{ffffff}Press {ff0000}N {ffffff}to loot dead zombie",-1,cPos[0],cPos[1],cPos[2],5.0);
    new zombies = Iter_Count(Zombies);
    DeadZombie++;
    format(string,sizeof(string),"Zombies (A/S): %d/%d",(zombies-DeadZombie),zombies);
	TextDrawSetString(DebugTotalZombies,string);
	return 1;
}
stock RespawnZombie(zombie)
{
	new spawn = random(sizeof(ZombieSpawns)),
		Float:Offset[2],Float:PosZ,Float:pX,Float:pY,Float:pZ,Float:angle;
	ResearchSpawn:
    Offset[0] = float((ZombieSpawns[spawn][Diameter]/2)-(random(ZombieSpawns[spawn][Diameter])));
    Offset[1] = float((ZombieSpawns[spawn][Diameter]/2)-(random(ZombieSpawns[spawn][Diameter])));
	MapAndreas_FindZ_For2DCoord(ZombieSpawns[spawn][SpawnX]+Offset[0],ZombieSpawns[spawn][SpawnY]+Offset[1],PosZ);
	if(PosZ == 0.0 || PosZ > 100.0) goto ResearchSpawn;
	pX = ZombieSpawns[spawn][SpawnX]+Offset[0];
	pY = ZombieSpawns[spawn][SpawnY]+Offset[1];
	pZ = (PosZ+1.7);
	angle = float(random(360));
	new Float:PEPE = floatsin((angle*3.14159/180.0));
	new Float:PIPO = floatcos((angle*3.14159/180.0));
	new string[32];
	ZombieInfo[zombie][Dead] = false;
	ZombieInfo[zombie][Head] = CreateDynamicObject(z1[headZ][partModel],pX,pY,pZ,z1[headZ][RelrX],z1[headZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][Torso],pX+z1[torsoZ][RelX]*PIPO+PEPE*z2[torsoZ][RelX],pY+z1[torsoZ][RelY]*PIPO+PEPE*z2[torsoZ][RelY],pZ+z1[torsoZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][Torso],z1[torsoZ][RelrX],z1[torsoZ][RelrY],angle);
	ZombieInfo[zombie][LeftArm] = CreateDynamicObject(z1[lArmZ][partModel],pX+z1[lArmZ][RelX]*PIPO+PEPE*z2[lArmZ][RelX],pY+z1[lArmZ][RelY]*PIPO+PEPE*z2[lArmZ][RelY],pZ+z1[lArmZ][RelZ],z1[lArmZ][RelrX],z1[lArmZ][RelrY],angle);
	ZombieInfo[zombie][RightArm] = CreateDynamicObject(z1[rArmZ][partModel],pX+z1[rArmZ][RelX]*PIPO+PEPE*z2[rArmZ][RelX],pY+z1[rArmZ][RelY]*PIPO+PEPE*z2[rArmZ][RelY],pZ+z1[rArmZ][RelZ],z1[rArmZ][RelrX],z1[rArmZ][RelrY],angle);
	ZombieInfo[zombie][LeftLeg] = CreateDynamicObject(z1[lLegZ][partModel],pX+z1[lLegZ][RelX]*PIPO+PEPE*z2[lLegZ][RelX],pY+z1[lLegZ][RelY]*PIPO+PEPE*z2[lLegZ][RelY],pZ+z1[lLegZ][RelZ],z1[lLegZ][RelrX],z1[lLegZ][RelrY],angle);
	ZombieInfo[zombie][RightLeg] = CreateDynamicObject(z1[rLegZ][partModel],pX+z1[rLegZ][RelX]*PIPO+PEPE*z2[rLegZ][RelX],pY+z1[rLegZ][RelY]*PIPO+PEPE*z2[rLegZ][RelY],pZ+z1[rLegZ][RelZ],z1[rLegZ][RelrX],z1[rLegZ][RelrY],angle);

    SetGVarInt("ZObject",zombie,ZombieInfo[zombie][Head]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][LeftArm]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][RightArm]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][LeftLeg]);
	SetGVarInt("ZObject",zombie,ZombieInfo[zombie][RightLeg]);

	ZombieInfo[zombie][Target] = INVALID_PLAYER_ID;
	ZombieInfo[zombie][Item] = random(TOTAL_ITEMS);
	DestroyDynamic3DTextLabel(ZombieInfo[zombie][Label]);
	new zombies = Iter_Count(Zombies);
	DeadZombie--;
	format(string,sizeof(string),"Zombies (A/S): %d/%d",(zombies-DeadZombie),zombies);
	TextDrawSetString(DebugTotalZombies,string);
	return 1;
}
stock MoveZombieToPlayer(zombie,playerid)
{
    new Float:cPos[3];
    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
    CalculateZombieRoute(zombie,cPos[0],cPos[1]);
	/*if(ZombieInfo[zombie][Dead] == true) return 1;
	new Float:cPos[3],Float:zPos[3],Float:angle;
	GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
	StopDynamicObject(ZombieInfo[zombie][Head]);
    StopDynamicObject(ZombieInfo[zombie][Torso]);
    StopDynamicObject(ZombieInfo[zombie][LeftArm]);
    StopDynamicObject(ZombieInfo[zombie][RightArm]);
    StopDynamicObject(ZombieInfo[zombie][LeftLeg]);
    StopDynamicObject(ZombieInfo[zombie][RightLeg]);
	GetDynamicObjectPos(ZombieInfo[zombie][Head],zPos[0],zPos[1],zPos[2]);
	angle = (180.0-atan2(zPos[0]-cPos[0],zPos[1]-cPos[1]));
	new Float:PEPE = floatsin((angle*3.14159/180.0));
	new Float:PIPO = floatcos((angle*3.14159/180.0));
	SetDynamicObjectRot(ZombieInfo[zombie][Head],z1[headZ][RelrX],z1[headZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][Torso],zPos[0]+z1[torsoZ][RelX]*PIPO+PEPE*z2[torsoZ][RelX],zPos[1]+z1[torsoZ][RelY]*PIPO+PEPE*z2[torsoZ][RelY],zPos[2]+z1[torsoZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][Torso],z1[torsoZ][RelrX],z1[torsoZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][LeftArm],zPos[0]+z1[lArmZ][RelX]*PIPO+PEPE*z2[lArmZ][RelX],zPos[1]+z1[lArmZ][RelY]*PIPO+PEPE*z2[lArmZ][RelY],zPos[2]+z1[lArmZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][LeftArm],z1[lArmZ][RelrX],z1[lArmZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][RightArm],zPos[0]+z1[rArmZ][RelX]*PIPO+PEPE*z2[rArmZ][RelX],zPos[1]+z1[rArmZ][RelY]*PIPO+PEPE*z2[rArmZ][RelY],zPos[2]+z1[rArmZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][RightArm],z1[rArmZ][RelrX],z1[rArmZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][LeftLeg],zPos[0]+z1[lLegZ][RelX]*PIPO+PEPE*z2[lLegZ][RelX],zPos[1]+z1[lLegZ][RelY]*PIPO+PEPE*z2[lLegZ][RelY],zPos[2]+z1[lLegZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][LeftLeg],z1[lLegZ][RelrX],z1[lLegZ][RelrY],angle);
    SetDynamicObjectPos(ZombieInfo[zombie][RightLeg],zPos[0]+z1[rLegZ][RelX]*PIPO+PEPE*z2[rLegZ][RelX],zPos[1]+z1[rLegZ][RelY]*PIPO+PEPE*z2[rLegZ][RelY],zPos[2]+z1[rLegZ][RelZ]);
    SetDynamicObjectRot(ZombieInfo[zombie][RightLeg],z1[rLegZ][RelrX],z1[rLegZ][RelrY],angle);
    cPos[2] += 0.7;
	MoveDynamicObject(ZombieInfo[zombie][Head],cPos[0],cPos[1],cPos[2],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][Torso],cPos[0]+z1[torsoZ][RelX]*PIPO+PEPE*z2[torsoZ][RelX],cPos[1]+z1[torsoZ][RelY]*PIPO+PEPE*z2[torsoZ][RelY],cPos[2]+z1[torsoZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][LeftArm],cPos[0]+z1[lArmZ][RelX]*PIPO+PEPE*z2[lArmZ][RelX],cPos[1]+z1[lArmZ][RelY]*PIPO+PEPE*z2[lArmZ][RelY],cPos[2]+z1[lArmZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][RightArm],cPos[0]+z1[rArmZ][RelX]*PIPO+PEPE*z2[rArmZ][RelX],cPos[1]+z1[rArmZ][RelY]*PIPO+PEPE*z2[rArmZ][RelY],cPos[2]+z1[rArmZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][LeftLeg],cPos[0]+z1[lLegZ][RelX]*PIPO+PEPE*z2[lLegZ][RelX],cPos[1]+z1[lLegZ][RelY]*PIPO+PEPE*z2[lLegZ][RelY],cPos[2]+z1[lLegZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][RightLeg],cPos[0]+z1[rLegZ][RelX]*PIPO+PEPE*z2[rLegZ][RelX],cPos[1]+z1[rLegZ][RelY]*PIPO+PEPE*z2[rLegZ][RelY],cPos[2]+z1[rLegZ][RelZ],ZOMBIE_SPEED);*/
	return 1;
}
stock MoveZombieTo(zombie,Float:MoveX,Float:MoveY,Float:MoveZ)
{
	if(ZombieInfo[zombie][Dead] == true) return 1;
	new Float:cPos[3],Float:zPos[3],Float:angle;
	cPos[0] = MoveX;
	cPos[1] = MoveY;
	cPos[2] = MoveZ;
	StopDynamicObject(ZombieInfo[zombie][Head]);
    StopDynamicObject(ZombieInfo[zombie][Torso]);
    StopDynamicObject(ZombieInfo[zombie][LeftArm]);
    StopDynamicObject(ZombieInfo[zombie][RightArm]);
    StopDynamicObject(ZombieInfo[zombie][LeftLeg]);
    StopDynamicObject(ZombieInfo[zombie][RightLeg]);
	GetDynamicObjectPos(ZombieInfo[zombie][Head],zPos[0],zPos[1],zPos[2]);
	angle = (180.0-atan2(zPos[0]-cPos[0],zPos[1]-cPos[1]));
	new Float:PEPE = floatsin((angle*3.14159/180.0));
	new Float:PIPO = floatcos((angle*3.14159/180.0));
	SetDynamicObjectRot(ZombieInfo[zombie][Head],z1[headZ][RelrX],z1[headZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][Torso],zPos[0]+z1[torsoZ][RelX]*PIPO+PEPE*z2[torsoZ][RelX],zPos[1]+z1[torsoZ][RelY]*PIPO+PEPE*z2[torsoZ][RelY],zPos[2]+z1[torsoZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][Torso],z1[torsoZ][RelrX],z1[torsoZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][LeftArm],zPos[0]+z1[lArmZ][RelX]*PIPO+PEPE*z2[lArmZ][RelX],zPos[1]+z1[lArmZ][RelY]*PIPO+PEPE*z2[lArmZ][RelY],zPos[2]+z1[lArmZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][LeftArm],z1[lArmZ][RelrX],z1[lArmZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][RightArm],zPos[0]+z1[rArmZ][RelX]*PIPO+PEPE*z2[rArmZ][RelX],zPos[1]+z1[rArmZ][RelY]*PIPO+PEPE*z2[rArmZ][RelY],zPos[2]+z1[rArmZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][RightArm],z1[rArmZ][RelrX],z1[rArmZ][RelrY],angle);
	SetDynamicObjectPos(ZombieInfo[zombie][LeftLeg],zPos[0]+z1[lLegZ][RelX]*PIPO+PEPE*z2[lLegZ][RelX],zPos[1]+z1[lLegZ][RelY]*PIPO+PEPE*z2[lLegZ][RelY],zPos[2]+z1[lLegZ][RelZ]);
	SetDynamicObjectRot(ZombieInfo[zombie][LeftLeg],z1[lLegZ][RelrX],z1[lLegZ][RelrY],angle);
    SetDynamicObjectPos(ZombieInfo[zombie][RightLeg],zPos[0]+z1[rLegZ][RelX]*PIPO+PEPE*z2[rLegZ][RelX],zPos[1]+z1[rLegZ][RelY]*PIPO+PEPE*z2[rLegZ][RelY],zPos[2]+z1[rLegZ][RelZ]);
    SetDynamicObjectRot(ZombieInfo[zombie][RightLeg],z1[rLegZ][RelrX],z1[rLegZ][RelrY],angle);
    cPos[2] += 0.7;
	MoveDynamicObject(ZombieInfo[zombie][Head],cPos[0],cPos[1],cPos[2],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][Torso],cPos[0]+z1[torsoZ][RelX]*PIPO+PEPE*z2[torsoZ][RelX],cPos[1]+z1[torsoZ][RelY]*PIPO+PEPE*z2[torsoZ][RelY],cPos[2]+z1[torsoZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][LeftArm],cPos[0]+z1[lArmZ][RelX]*PIPO+PEPE*z2[lArmZ][RelX],cPos[1]+z1[lArmZ][RelY]*PIPO+PEPE*z2[lArmZ][RelY],cPos[2]+z1[lArmZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][RightArm],cPos[0]+z1[rArmZ][RelX]*PIPO+PEPE*z2[rArmZ][RelX],cPos[1]+z1[rArmZ][RelY]*PIPO+PEPE*z2[rArmZ][RelY],cPos[2]+z1[rArmZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][LeftLeg],cPos[0]+z1[lLegZ][RelX]*PIPO+PEPE*z2[lLegZ][RelX],cPos[1]+z1[lLegZ][RelY]*PIPO+PEPE*z2[lLegZ][RelY],cPos[2]+z1[lLegZ][RelZ],ZOMBIE_SPEED);
	MoveDynamicObject(ZombieInfo[zombie][RightLeg],cPos[0]+z1[rLegZ][RelX]*PIPO+PEPE*z2[rLegZ][RelX],cPos[1]+z1[rLegZ][RelY]*PIPO+PEPE*z2[rLegZ][RelY],cPos[2]+z1[rLegZ][RelZ],ZOMBIE_SPEED);
	return 1;
}
stock SpawnZombies()
{
	new Created,Float:Offset[2],Float:sPos[3];
	forex(spawn,sizeof(ZombieSpawns))
	{
	    forex(i,ZombieSpawns[spawn][Amount])
	    {
	        Research:
	        Offset[0] = float((ZombieSpawns[spawn][Diameter]/2)-(random(ZombieSpawns[spawn][Diameter])));
	        Offset[1] = float((ZombieSpawns[spawn][Diameter]/2)-(random(ZombieSpawns[spawn][Diameter])));
	        sPos[0] = (ZombieSpawns[spawn][SpawnX]+Offset[0]);
	        sPos[1] = (ZombieSpawns[spawn][SpawnY]+Offset[1]);
	        MapAndreas_FindZ_For2DCoord(sPos[0],sPos[1],sPos[2]);
	        if(floatround(sPos[2]) == 0) goto Research;
		    CreateZombie(sPos[0],sPos[1],(sPos[2]+1.7),float(random(360)));
		    Created++;
	    }
	}
	return Created;
}
stock GetPlayerSpeed(playerid)
{
  	new Float:X,Float:Y,Float:Z;
  	GetPlayerVelocity(playerid, X, Y, Z);
  	return floatround(floatsqroot(X*X + Y*Y + Z*Z)*200.0);
}
stock CalculateZombieRoute(zombie,Float:pos_X,Float:pos_Y)
{
    if(ZombieInfo[zombie][Dead] == true) return 1;
	new Float:zPos[3];
	GetDynamicObjectPos(ZombieInfo[zombie][Head],zPos[0],zPos[1],zPos[2]);
	PathFinder_FindWay(zombie,zPos[0],zPos[1],pos_X,pos_Y);
	return 1;
}
public OnPathCalculated(routeid,success,nodes[],nodes_size)
{
	if(success && (nodes_size > 1))
	{
	    new node = 0;
	    new Float:nPos[3];
		for(new i = 0; i < nodes_size; i++)
		{
			PathFinder_GetNodePos(nodes[i],nPos[0],nPos[1],nPos[2]);
		    if(i == 0)
			{
				ZombiePath[routeid][node][Pos_X] = nPos[0];
				ZombiePath[routeid][node][Pos_Y] = nPos[1];
				ZombiePath[routeid][node][Pos_Z] = nPos[2];
		    	ZombiePath[routeid][node][Final] = false;
			}
			else
			{
				if(ZombiePath[routeid][node][Pos_Z] != nPos[2])
				{
				    node++;
				    if(node == MAX_ZOMBIE_NODE) break;
				    ZombiePath[routeid][node][Pos_X] = nPos[0];
					ZombiePath[routeid][node][Pos_Y] = nPos[1];
					ZombiePath[routeid][node][Pos_Z] = nPos[2];
					ZombiePath[routeid][node][Final] = false;
				}
			}
		}
		ZombiePath[routeid][(node-1)][Final] = true;
		ZombieCurrentNode[routeid] = 0;
		MoveZombieTo(routeid,ZombiePath[routeid][0][Pos_X],ZombiePath[routeid][0][Pos_Y],(ZombiePath[routeid][0][Pos_Z]+1.0));
	}
	else
	{
	    printf("Zombie %d: failed to calculate path!");
	}
	return 1;
}
forward OnZombieStopMoving(zombie);
public OnDynamicObjectMoved(objectid)
{
	if(GetGVarType("ZombieID",objectid) > 0)
	{
	    new zombie = GetGVarInt("ZombieID",objectid);
	    new node = ZombieCurrentNode[zombie];
	    if(ZombiePath[zombie][node][Final] == false)
	    {
	        node++;
	        MoveZombieTo(zombie,ZombiePath[zombie][node][Pos_X],ZombiePath[zombie][node][Pos_Y],(ZombiePath[zombie][node][Pos_Z]+1.0));
	        ZombieCurrentNode[zombie] = node;
	    }
	    else
	    {
	        CallLocalFunction("OnZombieStopMoving","d",zombie);
	    }
	}
	return 1;
}
public OnZombieStopMoving(zombie)
{
	if(ZombieInfo[zombie][Wandering])
	{
	    ZombieInfo[zombie][Wandering] = false;
	}
	else
	{
		new Float:cPos[3];
		GetDynamicObjectPos(ZombieInfo[zombie][Head],cPos[0],cPos[1],cPos[2]);
		if(IsPlayerInRangeOfPoint(ZombieInfo[zombie][Target],((ZOMBIE_DETECTION*3)/2),cPos[0],cPos[1],cPos[2]))
		{
		    MoveZombieToPlayer(zombie,ZombieInfo[zombie][Target]);
		}
		else
		{
		    ZombieInfo[zombie][Target] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}
public OnGameModeInit()
{
	SetGameModeText("IanZ Beta 1.0d");
	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	ShowNameTags(0);
	MapBlock = GangZoneCreate(-3000.0,-3000.0,3000.0,3000.0);
	CreateGlobalTextdraw();
	ManualVehicleEngineAndLights();
	Streamer_TickRate(100);
	
	PathFinder_Init(2.0,10000);

	Database = mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_DATABASE,MYSQL_PASSWORD);
	printf("MYSQL: Successfully connected to database on handle %d!",Database);

	printf("%d Random vehicles created!",CreateVehicles());
	printf("%d Zombies created!",SpawnZombies());
	Iter_Init(StreamedZombies);
	forex(i,MAX_PLAYERS)
	{
	    ClearPlayerData(i,true);
	}
	forex(i,sizeof(randomItems))
	{
	    CreateDrop(-1,randomItems[i][0],randomItems[i][1],randomItems[i][2]);
	}
	return 1;
}
public OnGameModeExit()
{
	MapAndreas_Unload();
	return 1;
}
public OnPlayerConnect(playerid)
{
	new string[64],playername[24];
	GetPlayerName(playerid,playername,sizeof(playername));
	format(string,sizeof(string),"(id:%d)\n{00ffff}%s",playerid,playername);
 	PlayerLabel[playerid] =	CreateDynamic3DTextLabel(string,-1,0.0,0.0,0.2,10.0,playerid,.testlos=1);
    CreatePlayerTextdraws(playerid);
	return 1;
}
public OnPlayerDisconnect(playerid,reason)
{
    if(PlayerLabel[playerid] != INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel(PlayerLabel[playerid]);
		PlayerLabel[playerid] = INVALID_3DTEXT_ID;
	}
	if(IsPlayerLogged[playerid])
	{
	    SavePlayer(playerid);
	}
	else
	{
    	ClearPlayerData(playerid,true);
	}
	return 1;
}
public OnPlayerRequestClass(playerid)
{
	if(IsPlayerLogged[playerid])
	{
		new tries = 0;
		search_spawn:
		new rand = random(sizeof(RandomSpawns));
		foreach(new i : Player)
		{
		    if(i == playerid) continue;
		    if(IsPlayerInRangeOfPoint(i,50.0,RandomSpawns[rand][0],RandomSpawns[rand][1],RandomSpawns[rand][2]))
		    {
		        tries++;
		        if(tries < 5) goto search_spawn;
		    }
		}
		SetSpawnInfo(playerid,NO_TEAM,PlayerInfo[playerid][Skin],RandomSpawns[rand][0],RandomSpawns[rand][1],RandomSpawns[rand][2],RandomSpawns[rand][3],0,0,0,0,0,0);
		SpawnPlayer(playerid);
	}
	else
	{
	    SetSpawnInfo(playerid,NO_TEAM,299,0.0,0.0,1000.0,0.0,0,0,0,0,0,0);
	    SpawnPlayer(playerid);
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
	if(IsPlayerLogged[playerid])
	{
		SetPlayerHealth(playerid,999999);
		if(PlayerInfo[playerid][Spawned] == false)
		{
			PlayerInfo[playerid][Spawned] = true;
			if(PlayerInfo[playerid][Bag] == 0)
			{
				PlayerInfo[playerid][Bag] = BAG_SMALL;
				PlayerInfo[playerid][Item][0] = ITEM_BOTTLE_FULL;
				PlayerInfo[playerid][Item][1] = ITEM_BANDAGE;
				PlayerInfo[playerid][Item][2] = ITEM_BASEBALL;
			}
		}
		forex(i,3)
		{
			GivePlayerWeapon(playerid,PlayerInfo[playerid][Weapon][i],20000);
		}
		SetPlayerColor(playerid,0xFFFFFF00);
		AttachBag(playerid);
	    ShowDebugMonitor(playerid);
	    ShowIndicators(playerid);
	}
	else
	{
	    new string[128],playername[24];
	    GetPlayerName(playerid,playername,sizeof(playername));
	    strToLower(playername);
	    format(string,sizeof(string),"SELECT `id`,`password` FROM `users` WHERE `user`='%s'",playername);
	    TogglePlayerSpectating(playerid,1);
	    mysql_function_query(Database,string,true,"User_GetPassword","d",playerid);
	}
	return 1;
}
public OnPlayerText(playerid,text[])
{
    if(IsPlayerLogged[playerid])
	{
	    new string[128];
	    GetPlayerName(playerid,string,MAX_PLAYER_NAME);
		format(string,sizeof(string),"%s says: %s",string,text);
		SendRangedClientMessage(playerid,20.0,string,true);
	}
	return 0;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
	    PlayerInfo[playerid][Blood] -= (amount*150.0);
	    if(PlayerInfo[playerid][Blood] <= 0.0)
	    {
	        SetPVarInt(playerid,"KilledBy",issuerid);
	        SetPlayerHealth(playerid,0.0);
	        return 1;
	    }
	    else
	    {
	        if(random(2) == random(2))
	        {
	            PlayerInfo[playerid][Desease][0] = 1;
	            TextDrawShowForPlayer(playerid,StatsBleeding);
	            SetPlayerAttachedObject(playerid,4,18706,1,0.0,0.0,-1.85,0.0,0.0,0.0,1.0,1.0,1.0,RGBAToInt(255,255,0,0));
	        }
	    }
	}
	else
	{
	    
	    if(weaponid == 54)
	    {
			new Float:damage = (amount*250.0);
			PlayerInfo[playerid][Blood] -= damage;
			if(damage > 1000.0)
			{
				if(random(4) == random(4))
				{
				    PlayerInfo[playerid][Desease][1] = 1;
				    TextDrawShowForPlayer(playerid,StatsBrokenLeg);
				}
			}
	    }
	    else
	    {
	        PlayerInfo[playerid][Blood] -= (amount*250.0);
	    }
	    if(PlayerInfo[playerid][Blood] <= 0.0)
	    {
	        SetPlayerHealth(playerid,0.0);
	    }
	}
	UpdateDebugMonitor(playerid,DEBUG_BLOOD);
	UpdateIndicator(playerid,INDICATOR_BLOOD);
	SetPlayerHealth(playerid,999999);
	return 1;
}
public OnPlayerDeath(playerid,killerid,reason)
{
    DetachBag(playerid);
    HideDebugMonitor(playerid);
    HideIndicators(playerid);
    CreateDeadPlayer(playerid);
    ClearPlayerData(playerid,false);
	PlayerInfo[playerid][Deaths]++;
	if(GetPVarType(playerid,"KilledBy") > 0)
	{
	    new killer = GetPVarInt(playerid,"KilledBy");
	    DeletePVar(playerid,"KilledBy");
	    PlayerInfo[killer][Murders]++;
	    UpdateDebugMonitor(killer,DEBUG_MURDERS);
	}
	ForceClassSelection(playerid);
	return 1;
}
public OnPlayerEnterDynamicArea(playerid,areaid)
{
	if(PlayerInfo[playerid][Spawned] == false) return 1;
	new id = GetGVarInt("AreaData",areaid);
	switch(GetGVarInt("AreaType",areaid))
	{
	    case AREA_TYPE_DROP:
	    {
	        SetPVarInt(playerid,"NearDrop",id);
	    }
	    case AREA_TYPE_PLAYER_DROP:
	    {
	        SetPVarInt(playerid,"NearPlayerDrop",id);
	    }
	    case AREA_TYPE_VEHICLE:
	    {
			SetPVarInt(playerid,"NearVehicle",id);
	    }
	    case AREA_TYPE_BODY:
	    {
	        SetPVarInt(playerid,"NearBody",id);
	    }
	    case AREA_TYPE_ZOMBIE_FAR:
	    {
			if(Iter_Count(StreamedZombies[playerid]) != (MAX_ZOMBIES/2))
			{
			    Iter_Add(StreamedZombies[playerid],id);
			}
			else
			{
			    SEM(playerid,"WARNING: Zombie overload!");
			}
	    }
	    case AREA_TYPE_ZOMBIE_NEAR:
	    {
	        if(ZombieInfo[id][Dead] == true) SetPVarInt(playerid,"NearZombie",id);
	    }
	}
	return 1;
}
public OnPlayerLeaveDynamicArea(playerid,areaid)
{
    if(PlayerInfo[playerid][Spawned] == false) return 1;
	new id = GetGVarInt("AreaData",areaid);
	switch(GetGVarInt("AreaType",areaid))
	{
	    case AREA_TYPE_DROP:
	    {
	        DeletePVar(playerid,"NearDrop");
	    }
	    case AREA_TYPE_PLAYER_DROP:
	    {
	        DeletePVar(playerid,"NearPlayerDrop");
	    }
	    case AREA_TYPE_VEHICLE:
	    {
	        DeletePVar(playerid,"NearVehicle");
	    }
	    case AREA_TYPE_BODY:
	    {
	        DeletePVar(playerid,"NearBody");
	    }
	    case AREA_TYPE_ZOMBIE_FAR:
	    {
	        Iter_Remove(StreamedZombies[playerid],id);
	    }
     	case AREA_TYPE_ZOMBIE_NEAR:
	    {
	        DeletePVar(playerid,"NearZombie");
	    }
	}
	return 1;
}
stock ShowPlayerInventory(playerid,dialog=DIALOG_INVENTORY_SHOW)
{
    new string[512],item;
	forex(i,MAX_INVENTORY_SLOT)
	{
	    if(PlayerInfo[playerid][Item][i] == 0) break;
	    item = PlayerInfo[playerid][Item][i];
	    strcat(string,ItemNames[item],sizeof(string));
	    strcat(string,"\n",sizeof(string));
	}
	if(!IsNull(string)) ShowPlayerDialog(playerid,dialog,DIALOG_STYLE_LIST,"Inventory",string,"Select","Close");
	else
	{
		SEM(playerid,"WARNING: Inventory empty");
	}
	return 1;
}
stock RearrangeInventory(playerid,type=0)
{
	if(type == 0)
	{
		new idx,
			bagsize = BagSize[PlayerInfo[playerid][Bag]];
		forex(i,bagsize)
		{
		    if(PlayerInfo[playerid][Item][i] == 0) continue;
		    new item = PlayerInfo[playerid][Item][i];
		    PlayerInfo[playerid][Item][i] = 0;
		    PlayerInfo[playerid][Item][idx] = item;
			idx++;
		}
	}
	else if(type == 1)
	{
	    new idx;
	    forex(i,MAX_INVENTORY_SLOT)
	    {
	        if(DeadBodyInfo[playerid][Item][i] == 0) continue;
	        new item = DeadBodyInfo[playerid][Item][i];
	        DeadBodyInfo[playerid][Item][i] = 0;
	        DeadBodyInfo[playerid][Item][idx] = item;
	        idx++;
	    }
	}
	return 1;
}
stock IsPlayerSwimming(playerid)
{
    switch(GetPlayerAnimationIndex(playerid))
    {
        case 1544,1540,1541,1538,1539: return 1;
        case 1197,1195,1198,1064,1062,1542: return 2;
    }
    return 0;
}
stock FindItemFreeSlot(playerid)
{
    new bagsize = BagSize[PlayerInfo[playerid][Bag]];
	forex(i,bagsize)
	{
	    if(PlayerInfo[playerid][Item][i] == 0) return i;
	}
	return -1;
}
stock FindPlayerItem(playerid,item)
{
    new bagsize = BagSize[PlayerInfo[playerid][Bag]];
	forex(i,bagsize)
	{
	    if(PlayerInfo[playerid][Item][i] == item) return i;
	}
	return -1;
}
stock CreateDeadPlayer(playerid)
{
	if(PlayerInfo[playerid][Spawned] == true)
	{
	    new Float:cPos[4];
	    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
	    GetPlayerFacingAngle(playerid,cPos[3]);
	    new slot = Iter_Free(DeadBodies);
	    if(slot != -1)
	    {
	        Iter_Add(DeadBodies,slot);
	        forex(i,MAX_INVENTORY_SLOT)
	        {
				if(PlayerInfo[playerid][Item][i] == 0) break;
				DeadBodyInfo[slot][Item][i] = PlayerInfo[playerid][Item][i];
	        }
	        DeadBodyInfo[slot][Timestamp] = gTimestamp;
	        DeadBodyInfo[slot][Object] = CreateDynamicObject(2907,cPos[0],cPos[1],cPos[2]-1.0,0.0,0.0,cPos[3]);
	        DeadBodyInfo[slot][Label] = CreateDynamic3DTextLabel("{00ffff}Dead body\n{ffffff}Press {ff0000}N {ffffff}to investigate body",-1,cPos[0],cPos[1],cPos[2]-0.9,3.0);
	        DeadBodyInfo[slot][Area] = CreateDynamicSphere(cPos[0],cPos[1],cPos[2]-1.0,3.0);
	        SetGVarInt("AreaType",AREA_TYPE_BODY,DeadBodyInfo[slot][Area]);
	        SetGVarInt("AreaData",slot,DeadBodyInfo[slot][Area]);
	    }
	}
	return 1;
}
stock PlayerUseItem(playerid,item,slot)
{
    switch(item)
	{
	    case ITEM_BEANS,ITEM_PIZZA,ITEM_HOTDOG:
	    {
            if(PlayerInfo[playerid][Hunger] > 100)
            {
                PlayerInfo[playerid][Hunger] -= 500;
                if(PlayerInfo[playerid][Hunger] < 0) PlayerInfo[playerid][Hunger] = 0;
                PlayerInfo[playerid][Blood] += 200.0;
				if(PlayerInfo[playerid][Blood] > 12000.0) PlayerInfo[playerid][Blood] = 12000.0;
				UpdateDebugMonitor(playerid,DEBUG_BLOOD);
				UpdateIndicator(playerid,INDICATOR_BLOOD);
				UpdateIndicator(playerid,INDICATOR_HUNGER);
            }
            else
            {
                SEM(playerid,"ERROR: Your hunger level is full!");
                return 0;
            }
	    }
	    case ITEM_BOTTLE_EMPTY:
	    {
	        if(IsPlayerSwimming(playerid))
	        {
	            PlayerInfo[playerid][Item][slot] = ITEM_BOTTLE_FULL;
	            SendClientMessage(playerid,-1,"INFO: Bottle filled with water!");
	        }
	        else
			{
			    SEM(playerid,"ERROR: You need to be in the water to use this command!");
			}
	        return 0;
	    }
	    case ITEM_BOTTLE_FULL:
	    {
			if(PlayerInfo[playerid][Thirst] > 250)
			{
			    PlayerInfo[playerid][Item][slot] = ITEM_BOTTLE_EMPTY;
			    PlayerInfo[playerid][Thirst] -= 500;
			    if(PlayerInfo[playerid][Thirst] < 0) PlayerInfo[playerid][Thirst] = 0;
			    UpdateIndicator(playerid,INDICATOR_THIRST);
			}
			else
			{
				SEM(playerid,"ERROR: Your thirst level is full!");
			}
			return 0;
	    }
	    case ITEM_SODA,ITEM_BEER:
	    {
	        if(PlayerInfo[playerid][Thirst] > 250)
			{
			    PlayerInfo[playerid][Thirst] -= 500;
			    if(PlayerInfo[playerid][Thirst] < 0) PlayerInfo[playerid][Thirst] = 0;
			    UpdateIndicator(playerid,INDICATOR_THIRST);
			}
			else
			{
				SEM(playerid,"ERROR: Your thirst level is full!");
				return 0;
			}
	    }
	    case ITEM_BANDAGE:
	    {
	        if(PlayerInfo[playerid][Desease][0] == 1)
	        {
	            PlayerInfo[playerid][Desease][0] = 0;
	            TextDrawHideForPlayer(playerid,StatsBleeding);
	            RemovePlayerAttachedObject(playerid,4);
	        }
	        else
	        {
	            SEM(playerid,"ERROR: You are not bleeding!");
	            return 0;
	        }
	    }
	    case ITEM_MORPHINE:
	    {
	        if(PlayerInfo[playerid][Desease][1] == 1)
	        {
	            PlayerInfo[playerid][Desease][1] = 0;
	            TextDrawHideForPlayer(playerid,StatsBrokenLeg);
	        }
	        else
	        {
	            SEM(playerid,"ERROR: You have no broken limbs!");
	            return 0;
	        }
	    }
	    case ITEM_BLOOD_BAG:
	    {
	        PlayerInfo[playerid][Blood] = 12000.0;
			if(PlayerInfo[playerid][Blood] > 12000.0) PlayerInfo[playerid][Blood] = 12000.0;
			UpdateDebugMonitor(playerid,DEBUG_BLOOD);
			UpdateIndicator(playerid,INDICATOR_BLOOD);
	    }
	    case ITEM_HEATPACK:
	    {
	        return 0;
	    }
	    case ITEM_ENGINE,ITEM_TIRE,ITEM_GASCAN_FULL:
	    {
	        SEM(playerid,"ERROR: You can only use this on a vehicle!");
	        return 0;
	    }
	    case ITEM_TOOLBOX:
	    {
	        if(PlayerInfo[playerid][Toolbox] == 0)
	        {
	            PlayerInfo[playerid][Toolbox] = 1;
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a toolbox equiped!");
	            return 0;
	        }
	    }
	    case ITEM_MAP:
	    {
	        if(PlayerInfo[playerid][Map] == 0)
	        {
	            PlayerInfo[playerid][Map] = 1;
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a map equiped!");
	            return 0;
	        }
	    }
	    case ITEM_GPS:
	    {
	        if(PlayerInfo[playerid][GPS] == 0)
	        {
	            PlayerInfo[playerid][GPS] = 1;
	            TextDrawHideForPlayer(playerid,StatsBlockGPS);
	            GangZoneHideForPlayer(playerid,MapBlock);
	            
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a GPS equiped!");
	            return 0;
	        }
	    }
	    case ITEM_RADIO:
	    {
	        if(PlayerInfo[playerid][Radio] == 0)
	        {
	            PlayerInfo[playerid][Radio] = 1;
	        }
	        else
			{
			    SEM(playerid,"<ERROR>: You already have a Radio equiped!");
				return 0;
			}
	    }
	    case ITEM_BATTERY:
	    {
	        return 0;
	    }
	    case ITEM_BASEBALL:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_MELEE] == 0)
	        {
	            PlayerInfo[playerid][Weapon][WEAPON_MELEE] = 5;
	            GivePlayerWeapon(playerid,5,20000);
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a melee weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_KATANA:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_MELEE] == 0)
	        {
	            PlayerInfo[playerid][Weapon][WEAPON_MELEE] = 8;
	            GivePlayerWeapon(playerid,8,20000);
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a melee weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_PISTOL:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_SECONDARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_PISTOL_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_SECONDARY] = 22;
	                PlayerInfo[playerid][Ammo][WEAPON_SECONDARY] = (ammocount*25);
	            	GivePlayerWeapon(playerid,22,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any pistol ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a secondary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_SILENT_PISTOL:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_SECONDARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_PISTOL_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_SECONDARY] = 23;
	                PlayerInfo[playerid][Ammo][WEAPON_SECONDARY] = (ammocount*25);
	            	GivePlayerWeapon(playerid,23,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any pistol ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a secondary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_SMG:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_SECONDARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_SMG_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_SECONDARY] = 29;
	                PlayerInfo[playerid][Ammo][WEAPON_SECONDARY] = (ammocount*30);
	            	GivePlayerWeapon(playerid,29,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any SMG ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a secondary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_SHOTGUN:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_SHOTGUN_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] = 25;
	                PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] = (ammocount*15);
	            	GivePlayerWeapon(playerid,25,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any shotgun ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a primary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_SPAS:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_SHOTGUN_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] = 27;
	                PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] = (ammocount*15);
	            	GivePlayerWeapon(playerid,27,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any shotgun ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a primary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_RIFLE:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_RIFLE_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] = 33;
	                PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] = (ammocount*10);
	            	GivePlayerWeapon(playerid,33,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any rifle ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a primary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_SNIPER:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_RIFLE_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] = 34;
	                PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] = (ammocount*10);
	            	GivePlayerWeapon(playerid,34,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any rifle ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a primary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_AK47:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_ASSAULT_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] = 30;
	                PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] = (ammocount*50);
	            	GivePlayerWeapon(playerid,30,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any asault ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a primary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_M4:
	    {
	        if(PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] == 0)
	        {
	            new ammocount;
	            forex(i,MAX_INVENTORY_SLOT)
	            {
	                if(PlayerInfo[playerid][Item][i] == ITEM_ASSAULT_AMMO)
	                {
	                    PlayerInfo[playerid][Item][i] = 0;
	                    ammocount++;
	                }
	            }
	            if(ammocount > 0)
	            {
	                PlayerInfo[playerid][Weapon][WEAPON_PRIMARY] = 31;
	                PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] = (ammocount*50);
	            	GivePlayerWeapon(playerid,31,20000);
	            }
	            else
	            {
	                SEM(playerid,"<ERROR>: You don't have any asault ammo!");
	                return 0;
	            }
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have a primary weapon equiped!");
				return 0;
	        }
	    }
	    case ITEM_PISTOL_AMMO:
	    {
	        new weapon = GetPlayerWeapon(playerid);
	        if(weapon == 22 || weapon == 23)
	        {
	            PlayerInfo[playerid][Ammo][WEAPON_SECONDARY] += 25;
				UpdateDebugMonitor(playerid,DEBUG_AMMO,PlayerInfo[playerid][Ammo][WEAPON_SECONDARY]);
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You don't have the correct weapon equiped!");
	            return 0;
	        }
	    }
	    case ITEM_SHOTGUN_AMMO:
	    {
	        new weapon = GetPlayerWeapon(playerid);
	        if(weapon == 25 || weapon == 27)
	        {
	            PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] += 15;
				UpdateDebugMonitor(playerid,DEBUG_AMMO,PlayerInfo[playerid][Ammo][WEAPON_PRIMARY]);
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You don't have the correct weapon equiped!");
	            return 0;
	        }
	    }
	    case ITEM_RIFLE_AMMO:
	    {
	        new weapon = GetPlayerWeapon(playerid);
	        if(weapon == 33 || weapon == 34)
	        {
	            PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] += 10;
				UpdateDebugMonitor(playerid,DEBUG_AMMO,PlayerInfo[playerid][Ammo][WEAPON_PRIMARY]);
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You don't have the correct weapon equiped!");
	            return 0;
	        }
	    }
	    case ITEM_ASSAULT_AMMO:
	    {
	        new weapon = GetPlayerWeapon(playerid);
	        if(weapon == 30 || weapon == 31)
	        {
	            PlayerInfo[playerid][Ammo][WEAPON_PRIMARY] += 50;
				UpdateDebugMonitor(playerid,DEBUG_AMMO,PlayerInfo[playerid][Ammo][WEAPON_PRIMARY]);
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You don't have the correct weapon equiped!");
	            return 0;
	        }
	    }
	    case ITEM_BAG_SMALL,ITEM_BAG_MEDIUM,ITEM_BAG_LARGE,ITEM_BAG_HUGE:
	    {
	        if(PlayerInfo[playerid][Bag] < (item-34))
	        {
	            PlayerInfo[playerid][Bag] = (item-34);
	            AttachBag(playerid);
	        }
	        else
	        {
	            SEM(playerid,"<ERROR>: You already have the same or the better bag equiped!");
	            return 0;
	        }
	    }
		/*
	    case ITEM_GASCAN_EMPTY:
	    {
	        DropInfo[slot][Object] = CreateDynamicObject(1650,pos_x,pos_y,pos_z-0.95,90.0,0.0,rotation);
	    }
	    */
	    default: return 0;
	}
	return 1;
}
stock GetWeaponType(weaponid)
{
	switch(weaponid)
	{
		case 0,5,8: return 2;
		case 22,23,29: return 1;
		case 25,26,30,31,33,34: return 0;
	}
	return -1;
}
stock GetWeaponItemID(weaponid)
{
	switch(weaponid)
	{
		case 5: return ITEM_BASEBALL;
		case 8:	return ITEM_KATANA;
		case 22: return ITEM_PISTOL;
		case 23: return ITEM_SILENT_PISTOL;
		case 25: return ITEM_SHOTGUN;
		case 27: return ITEM_SPAS;
		case 29: return ITEM_SMG;
		case 30: return ITEM_AK47;
		case 31: return ITEM_M4;
		case 33: return ITEM_RIFLE;
		case 34: return ITEM_SNIPER;
	}
	return ITEM_NONE;
}
stock GetWeaponModel(weaponid)
{
	switch(weaponid)
	{
		case 1: return 331;
		case 2: return 333;
		case 3: return 334;
		case 4: return 335;
		case 5: return 336;
		case 6: return 337;
		case 7: return 338;
		case 8: return 339;
		case 9: return 341;
		case 10: return 321;
		case 11: return 322;
		case 12: return 323;
		case 13: return 324;
		case 14: return 325;
		case 15: return 326;
		case 16: return 342;
		case 17: return 343;
		case 18: return 344;
		case 22: return 346;
		case 23: return 347;
		case 24: return 348;
		case 25: return 349;
		case 26: return 350;
		case 27: return 351;
		case 28: return 352;
		case 29: return 353;
		case 30: return 355;
		case 31: return 356;
		case 32: return 372;
		case 33: return 357;
		case 34: return 358;
		case 35: return 359;
		case 36: return 360;
		case 37: return 361;
		case 38: return 362;
		case 39: return 363;
		case 40: return 364;
		case 41: return 365;
		case 42: return 366;
		case 43: return 367;
		case 44: return 368;
		case 45: return 369;
		case 46: return 371;
		default: return 0;
	}
	return 1;
}
forward OnPlayerSwitchWeapon(playerid,newweapon,oldweapon);
public OnPlayerSwitchWeapon(playerid,newweapon,oldweapon)
{
	new type = GetWeaponType(newweapon);
	if((PlayerInfo[playerid][Weapon][type] == newweapon) || (newweapon == 0))
	{
	    new weapon;
	    UpdateDebugMonitor(playerid,DEBUG_WEAPON);
		if(newweapon != 0) UpdateDebugMonitor(playerid,DEBUG_AMMO,PlayerInfo[playerid][Ammo][type]);
		else UpdateDebugMonitor(playerid,DEBUG_AMMO,0);
	    forex(i,3)
	    {
	        weapon = PlayerInfo[playerid][Weapon][i];
	        if(weapon != 0)
	        {
				if(weapon == newweapon)
				{
				    RemovePlayerAttachedObject(playerid,i);
				}
				else if(weapon == oldweapon)
				{
				    SetPlayerAttachedObject(playerid,i,GetWeaponModel(weapon),AttachmentBone[i],AttachmentOffset[i][0],AttachmentOffset[i][1],AttachmentOffset[i][2],AttachmentOffset[i][3],AttachmentOffset[i][4],AttachmentOffset[i][5],1.0,1.0,1.0);
				}
	        }
	    }
	}
	else
	{
	    new string[64];
	    format(string,sizeof(string),"Weapon Cheat (%s)",GunNames[newweapon]);
	    BanEx(playerid,string);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	new type = GetWeaponType(weaponid);
	PlayerInfo[playerid][Ammo][type]--;
    UpdateDebugMonitor(playerid,DEBUG_AMMO,PlayerInfo[playerid][Ammo][type]);
    if((PlayerInfo[playerid][Ammo][type] == 0) && (PlayerInfo[playerid][Weapon][type] == weaponid))
    {
        new Float:cPos[3];
	    GetPlayerPos(playerid,cPos[0],cPos[1],cPos[2]);
		new item = GetWeaponItemID(weaponid);
	    CreatePlayerDrop(item,cPos[0],cPos[1],cPos[2]);
	    PlayerInfo[playerid][Weapon][type] = 0;
	    PlayerInfo[playerid][Ammo][type] = 0;
	    SetPlayerAmmo(playerid,weaponid,0);
	    Streamer_Update(playerid);
    }
    else SetPlayerAmmo(playerid,weaponid,20000);
    if((weaponid != 23) && (WeaponNoise[playerid] == false))
	{
		new Float:cPos[3];
	    WeaponNoise[playerid] = true;
	    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL,PlayerLabel[playerid],E_STREAMER_DRAW_DISTANCE,35.0);
		UpdateIndicator(playerid,INDICATOR_NOISE,10);
	    foreach(new zombie : StreamedZombies[playerid])
		{
		    if(ZombieInfo[zombie][Dead]) continue;
			if(ZombieInfo[zombie][Target] != INVALID_PLAYER_ID) continue;
			GetDynamicObjectPos(ZombieInfo[zombie][Head],cPos[0],cPos[1],cPos[2]);
			if(IsPlayerInRangeOfPoint(playerid,50.0,cPos[0],cPos[1],cPos[2]))
			{
				ZombieInfo[zombie][Target] = playerid;
				MoveZombieToPlayer(zombie,playerid);
			}
		}
	}
	return 1;
}
public OnShootDynamicObject(playerid, weaponid, objectid, Float:fX, Float:fY, Float:fZ)
{
	if(GetGVarType("ZObject",objectid) != 0)
	{
	    new zombie = GetGVarInt("ZObject",objectid);
	    if(ZombieInfo[zombie][Dead]) return 1;
	    if(ZombieInfo[zombie][Head] == objectid)
	    {
	        PlayerInfo[playerid][Kills]++;
			KillZombie(zombie);
			UpdateDebugMonitor(playerid,DEBUG_KILLS);
	    }
	    else if(random(3) == random(3))
		{
		    PlayerInfo[playerid][Kills]++;
			KillZombie(zombie);
			UpdateDebugMonitor(playerid,DEBUG_KILLS);
		}
		else
		{
		    if(ZombieInfo[zombie][Target] == INVALID_PLAYER_ID)
		    {
			    ZombieInfo[zombie][Target] = playerid;
				MoveZombieToPlayer(zombie,playerid);
			}
		}
	}
	return 1;
}
public OnPlayerUpdate(playerid)
{
	if(PlayerInfo[playerid][Spawned])
	{
	    new weapon = GetPlayerWeapon(playerid);
	    if(CurrentWeapon[playerid] != weapon)
	    {
	        CallLocalFunction("OnPlayerSwitchWeapon","ddd",playerid,weapon,CurrentWeapon[playerid]);
            CurrentWeapon[playerid] = weapon;
	    }
	}
	return 1;
}
stock RespawnDrops()
{
	foreach(new id : Drops)
	{
	    DestroyDynamicObject(DropInfo[id][Object]);
		DestroyDynamic3DTextLabel(DropInfo[id][Label]);
		DeleteGVar("AreaType",DropInfo[id][Area]);
		DeleteGVar("AreaData",DropInfo[id][Area]);
		DestroyDynamicArea(DropInfo[id][Area]);
	}
	Iter_Clear(Drops);
	forex(i,sizeof(randomItems))
	{
	    CreateDrop(-1,randomItems[i][0],randomItems[i][1],randomItems[i][2]);
	}
	return 1;
}

stock crossp(Float:v1x, Float:v1y, Float:v1z, Float:v2x, Float:v2y, Float:v2z, &Float:output)
{
	new
	Float:c1 = (v1y * v2z) - (v1z * v2y),
	Float:c2 = (v1z * v2x) - (v1x * v2z),
	Float:c3 = (v1x * v2y) - (v1y * v2x);
	output = floatsqroot ((c1 * c1) + (c2 * c2) + (c3 * c3));
	return 0;
}
stock GetDistanceFromPointToLine(&Float:distance, Float:line_vector_x, Float:line_vector_y, Float:line_vector_z, Float:line_x, Float:line_y, Float:line_z, Float:point_x, Float:point_y, Float:point_z)
{
	static Float:output;
	crossp(line_vector_x, line_vector_y, line_vector_z, point_x - line_x, point_y - line_y, point_z - line_z, output);
	distance = output / floatsqroot ((line_vector_x * line_vector_x) + (line_vector_y * line_vector_y) + (line_vector_z * line_vector_z));
	return 0;
}


#include "../gamemodes/mode/query.pwn"
#include "../gamemodes/mode/timers.pwn"
#include "../gamemodes/mode/playerstate.pwn"
#include "../gamemodes/mode/keystate.pwn"
#include "../gamemodes/mode/dialogs.pwn"
#include "../gamemodes/mode/commands.pwn"
