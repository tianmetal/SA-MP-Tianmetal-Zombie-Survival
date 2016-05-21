public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehid) != 510) SendClientMessage(playerid,-1,"<INFO>: use command '/engine' to turn on/off vehicle engine!");
		else SetVehicleParamsEx(vehid,1,0,0,0,0,0,0);
	}
	return 1;
}