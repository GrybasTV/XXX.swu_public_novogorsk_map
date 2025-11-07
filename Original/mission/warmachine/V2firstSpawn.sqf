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
waitUntil {!isNull player}; //JIP
waitUntil {!alive player}; //player has respawned
waitUntil {alive player}; //player has respawned
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
