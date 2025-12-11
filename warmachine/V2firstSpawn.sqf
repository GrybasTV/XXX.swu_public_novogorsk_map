/*
	Author: IvosH
	
	Description:
		If player (leader) respawn on the BASE at the mission start all AI units are teleported to his position. 
	
	Parameter(s):
		NONE
	
	Returns:
		nothing
		
	Dependencies:
		start.sqf
		
	Execution:
		"warmachine\firstSpawn.sqf" remoteExec ["execVM", 0, false];
*/

if(!hasInterface)exitWith{}; //run on the players only
// TIMEOUT #1: Laukti kol player != null
private _startTime1 = time;
waitUntil {
    sleep 0.5;
    (!isNull player) || (time - _startTime1 > 30)
};

// TIMEOUT #2: Laukti kol player !alive
private _startTime2 = time;
waitUntil {
    sleep 0.5;
    (!alive player) || (time - _startTime2 > 30)
};

// TIMEOUT #3: Laukti kol player alive
private _startTime3 = time;
waitUntil {
    sleep 0.5;
    (alive player) || (time - _startTime3 > 30)
};

sleep 0.5;
fs=1;
if(player != leader player)exitWith{}; //player is not leader > exit

call
{
	if(side player==sideW)exitWith
	{
		if((player distance posBaseW1>100)&&(player distance posBaseW2>100))exitWith{}; //player respawn on the airfield
		{
			if(!isPlayer _x)then{if((player distance _x)>100)then{_x setPos (player getRelPos [4, random 360]);};};
		} forEach units group player;
	};
	if(side player==sideE)exitWith
	{
		if((player distance posBaseE1>100)&&(player distance posBaseE2>100))exitWith{}; //player respawn on the airfield
		{
			if(!isPlayer _x)then{if((player distance _x)>100)then{_x setPos (player getRelPos [4, random 360]);};};
		} forEach units group player;
	};
};
