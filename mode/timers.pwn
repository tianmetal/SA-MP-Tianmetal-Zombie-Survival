// Global Timers
task ServerTimer[1000]()
{
	gTimestamp = gettime(Hour,Minute,Second);
	if(Second == 0)
	{
	    if(Minute == 0)
	    {
	        RespawnDrops();
	        if(Hour == 0)
	        {
	            getdate(Year,Month,Day);
	        }
	    }
	}
	return 1;
}

task ClearPlayerDrops[600000]()
{
	foreach(new id : PlayerDrops)
	{
	    if(gTimestamp > (PlayerDropInfo[id][Timestamp]+10800))
	    {
	        defer ClearDrop(id);
	    }
	}
	foreach(new slot : DeadBodies)
	{
		if(gTimestamp > (DeadBodyInfo[slot][Timestamp]+3600))
		{
			defer DeleteDeadBody(slot);
		}
	}
	foreach(new zombie : Zombies)
	{
		if(ZombieInfo[zombie][Dead])
		{
			if(gTimestamp > (ZombieInfo[zombie][DeadTimestamp]+900))
			{
				RespawnZombie(zombie);
			}
		}
	}
	return 1;
}

task ZombieTimer[5000]()
{
	foreach(new zombie : Zombies)
	{
		if(ZombieInfo[zombie][Dead]) continue;
		new Float:cPos[3],
			playerid = ZombieInfo[zombie][Target];
		GetDynamicObjectPos(ZombieInfo[zombie][Head],cPos[0],cPos[1],cPos[2]);
		if((playerid != INVALID_PLAYER_ID) && (PlayerInfo[playerid][Spawned] == true))
		{
			
			if(IsPlayerInRangeOfPoint(playerid,3.0,cPos[0],cPos[1],cPos[2]))
			{
				PlayerInfo[playerid][Blood] -= float(random(2000));
				if(random(2) == random(2))
				{
					PlayerInfo[playerid][Desease][0] = 1;
					TextDrawShowForPlayer(playerid,StatsBleeding);
					SetPlayerAttachedObject(playerid,4,18706,1,0.0,0.0,-1.85,0.0,0.0,0.0,1.0,1.0,1.0,RGBAToInt(255,255,0,0));
				}
				UpdateDebugMonitor(playerid,DEBUG_BLOOD);
				UpdateIndicator(playerid,INDICATOR_BLOOD);
				if(PlayerInfo[playerid][Blood] <= 0.0)
				{
					SetPlayerHealth(playerid,0.0);
				}
			}
		}
		else
		{
			if(ZombieInfo[zombie][Wandering] == false)
			{
				cPos[0] += float(random(60)-random(30));
				cPos[1] += float(random(60)-random(30));
				ZombieInfo[zombie][Wandering] = true;
				CalculateZombieRoute(zombie,cPos[0],cPos[1]);
			}
		}
	}
	return 1;
}

// Player Timers
ptask PlayerTimer[1000](playerid)
{
	if(PlayerInfo[playerid][Spawned])
	{
		if(PlayerInfo[playerid][Hunger] < MAX_MOTIVE)
		{
			PlayerInfo[playerid][Hunger]++;
			switch(PlayerInfo[playerid][Hunger])
			{
				case 200,400,600,800,1000,1200,1400,1600,1800:
				{
					UpdateIndicator(playerid,INDICATOR_HUNGER);
				}
				case 2000:
				{
					SetPlayerHealth(playerid,0.0);
				}
			}
		}
		if(PlayerInfo[playerid][Desease][0])
		{
			PlayerInfo[playerid][Blood] -= float(random(250));
			if(PlayerInfo[playerid][Blood] <= 0.0)
			{
				SetPlayerHealth(playerid,0.0);
			}
			UpdateDebugMonitor(playerid,DEBUG_BLOOD);
			UpdateIndicator(playerid,INDICATOR_BLOOD);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)
		{
			new Float:cPos[3],
				noise = (GetPlayerSpeed(playerid)/4);
			if(noise > 10) noise = 10;
			if(WeaponNoise[playerid] == false)
			{
				if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK) noise = (noise/2);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL,PlayerLabel[playerid],E_STREAMER_DRAW_DISTANCE,5.0+(3.0*noise));
				UpdateIndicator(playerid,INDICATOR_NOISE,noise);
				if(noise > 0)
				{
					new thirst = 1;
					if(noise > 2)
					{
						thirst++;
						if(noise > 6)
						{
							if(PlayerInfo[playerid][Desease][1]) TogglePlayerControllable(playerid,1);
							thirst++;
						}
					}
					if(PlayerInfo[playerid][Thirst] < MAX_MOTIVE)
					{
						PlayerInfo[playerid][Thirst] += thirst;
						if(PlayerInfo[playerid][Thirst] >= MAX_MOTIVE)
						{
							SetPlayerHealth(playerid,0.0);
						}
					}
					UpdateIndicator(playerid,INDICATOR_THIRST);
					new Float:dist = (float(noise)*5.0);
					foreach(new zombie : StreamedZombies[playerid])
					{
						if(ZombieInfo[zombie][Dead]) continue;
						if(ZombieInfo[zombie][Target] != INVALID_PLAYER_ID) continue;
						GetDynamicObjectPos(ZombieInfo[zombie][Head],cPos[0],cPos[1],cPos[2]);
						if(IsPlayerInRangeOfPoint(playerid,dist,cPos[0],cPos[1],cPos[2]))
						{
							ZombieInfo[zombie][Target] = playerid;
							MoveZombieToPlayer(zombie,playerid);
						}
					}
				}
			}
			else
			{
				WeaponNoise[playerid] = false;
			}
		}
	}
	return 1;
}

// Delayed Timers
timer ClearDrop[1000](id)
{
	DeletePlayerDrop(id);
	return 1;
}
timer DeleteDeadBody[1000](id)
{
	Iter_Remove(DeadBodies,id);
	DeleteGVar("AreaType",DeadBodyInfo[id][Area]);
	DeleteGVar("AreaData",DeadBodyInfo[id][Area]);
	DestroyDynamicArea(DeadBodyInfo[id][Area]);
	DestroyDynamic3DTextLabel(DeadBodyInfo[id][Label]);
	DestroyDynamicObject(DeadBodyInfo[id][Object]);
}