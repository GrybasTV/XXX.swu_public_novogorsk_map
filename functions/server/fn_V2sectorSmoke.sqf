/*
	Author: IvosH
	
	Description:
		Create smoke when player is close to the AA / artillery sector & vehicles are not spawned
		smoke 1min
		chem light 15min
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf

	Execution:
		[] spawn wrm_fnc_V2sectorSmoke;
*/

for "_i" from 0 to 1 step 0 do 
{
	_a=true; _b=true;
	{
		if(!alive _x)exitWith{};
		if(_a)then{if((_x distance posAA < 300)&&(!alive objAAW)&&(!alive objAAE))then{"SmokeShellBlue" createVehicle posAA; _a=false;};};
		if(_b)then{if((_x distance posArti < 300)&&(!alive objArtiW)&&(!alive objArtiE))then{"SmokeShellYellow" createVehicle posArti; _b=false;};};
	} forEach allPlayers;
	sleep 180;
};
