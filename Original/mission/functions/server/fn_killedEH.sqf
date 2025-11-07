/*
	Author: IvosH
	
	Description:
		Event handler for MPkilled. reduce respawn tickets when AI is killed
		
	Parameter(s):
		0: VARIABLE killed unit
		1: SIDE
		
	Returns:
		BOOL
		
	Dependencies:
		fn_resGrpsUpdate.sqf
		fn_aiMove.sqf

	Execution:
		[_unit,side] spawn wrm_fnc_killedEH;
*/

if(progress<2)exitWith{};
_unit = _this select 0; //_this = killed unit 
_side = _this select 1;
if(!local _unit)exitWith{};
if (isPlayer _unit) exitWith {}; //unit is player script stops here
[(_side), -1] remoteExec ["BIS_fnc_respawnTickets", 2, false]; // reduce side respawn tickets by 1
if(vehicle _unit!=_unit)then{sleep 1; moveOut _unit;};