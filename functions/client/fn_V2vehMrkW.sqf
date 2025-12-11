/*
	Author: IvosH
	
	Description:
		Create local marker for the vehicle at the respawn position
	
	Parameter(s):
		0: STRING, marker name
		1: STRING, marker type
		2: ARRAY, position
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		
	Execution:
		[_nme,_mrk,_res] remoteExec ["wrm_fnc_V2vehMrkW", 0, true];
*/
if (!hasInterface) exitWith {}; //run on the players only
// Patikriname, ar sideW yra apibrėžtas
if (isNil "sideW") exitWith {};
if (side player != sideW) exitWith {}; //run on the players of sideW

_nme = _this select 0;
_mrk = _this select 1;
_res = _this select 2;

_mSd = "";
call
{
	if (side player == west) exitWith {_mSd = "b_";};
	if (side player == east) exitWith {_mSd = "o_";};
	if (side player == independent) exitWith {_mSd = "n_";};
};

_mType = [_mSd,_mrk] joinString "";

// Patikriname, ar _res yra teisingas masyvas su 3 elementais (x, y, z koordinatės)
if (isNil "_res" || count _res < 2) then 
{
	// Jei _res nėra teisingas, naudojame [0,0,0] kaip numatytąją poziciją
	_res = [0,0,0];
	["wrm_fnc_V2vehMrkW: Klaida - _res nėra teisingas masyvas"] call BIS_fnc_error;
};

_mrkVeh = createMarkerLocal [_nme, _res];
_mrkVeh setMarkerShapeLocal "ICON";
_mrkVeh setMarkerTypeLocal _mType;
