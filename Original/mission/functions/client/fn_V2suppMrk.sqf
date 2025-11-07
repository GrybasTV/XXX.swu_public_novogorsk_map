/*
	Author: IvosH
	
	Description:
		Create local marker for the supply box
	
	Parameter(s):
		0: ARRAY, _box
		1: STRING, name of the marker
		2: SIDE, players side
		
	Returns:
		nothing
		
	Dependencies:
		fn_airDrop.sqf
		fn_V2coolDown
		
	Execution:
		[_box,(str profileName),(side player)] remoteExec ["wrm_fnc_V2suppMrk", 0, true];
*/
if (!hasInterface) exitWith {}; //run on the players only

_box = _this select 0;
_nme = (_this select 1) + (str round time);
_sde = _this select 2;
_icn = "";

if (side player != _sde) exitWith {}; //run on the players of the same side

call
{
	if (side player == west) exitWith {_icn = "b_support";};
	if (side player == east) exitWith {_icn = "o_support";};
	if (side player == independent) exitWith {_icn = "n_support";};
};

_mrk = createMarkerLocal [_nme, (getPos _box)];
_mrk setMarkerShapeLocal "ICON";
_mrk setMarkerTypeLocal _icn;
_mrk setMarkerTextLocal "Ammo";