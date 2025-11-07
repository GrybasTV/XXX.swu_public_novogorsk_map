/*
	Author: IvosH
	
	Description:
		Protect vehicle to be destroied when in base
		
	Parameter(s):
		0: VARIABLE vehicle
		1: SIDE
		
	Returns:
		nothing
		
	Dependencies:
		start.sqf (event handler)
		
	Execution:
		[_veh,_side] spawn wrm_fnc_safeZoneVeh;
*/

params ["_veh","_base"];
if(progress<2)exitWith{};
if((_veh distance _base) > 100)exitWith{_veh allowDammage true;};
while {(_veh distance _base) < 100} do {sleep 7;};
_veh allowDammage true;