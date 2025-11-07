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
//Patikrinti, ar žaidėjas jau gyvas - jei taip, nereikia laukti
if (!alive player) then {
	//Jei žaidėjas nėra gyvas, laukti su timeout'u
	private _timeout = time + 30; //30 sekundžių timeout
	waitUntil {alive player || time > _timeout}; //player has respawned
	if (time > _timeout) exitWith {}; //Jei timeout'as pasiektas, išeiti
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
