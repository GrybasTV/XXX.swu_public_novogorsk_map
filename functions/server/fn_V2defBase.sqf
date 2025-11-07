/*
	Author: IvosH
	
	Description:
		Tell defense group return to their position
		
	Parameter(s):
		0: ARRAY Base position
		1: VARIABLE Group
		
	Returns:
		nothing
		
	Dependencies:
		baseDefense.sqf
		
	Execution:
		[_sec,_grp] spawn wrm_fnc_V2defBase;
*/
//SVARBU: patikrinti, ar parametrai yra teisingi
if (count _this < 2) exitWith {
	if (DBG) then {
		["[fn_V2defBase] Klaida: nepakanka parametrų"] remoteExec ["systemChat", 0, false];
	};
};

private _base = _this select 0;
private _grp = _this select 1;

//Patikrinti, ar grupė egzistuoja ir yra valid
if (isNil "_grp" || isNull _grp) exitWith {
	if (DBG) then {
		["[fn_V2defBase] Klaida: grupė neapibrėžta arba null"] remoteExec ["systemChat", 0, false];
	};
};

//Patikrinti, ar base pozicija yra valid masyvas
if (isNil "_base" || count _base < 2) exitWith {
	if (DBG) then {
		["[fn_V2defBase] Klaida: base pozicija neapibrėžta arba neteisinga"] remoteExec ["systemChat", 0, false];
	};
};

while {({alive _x} count (units _grp)) > 0} do 
{
	//Papildomas patikrinimas, kad grupė vis dar egzistuoja
	if (isNull _grp) exitWith {};
	
	[_grp,[((_base select 0)+(round((random 10)*(selectRandom[-1,1])))),((_base select 1)+(round((random 10)*(selectRandom[-1,1]))))]] remoteExec ["move", (groupOwner _grp), false];
	sleep 181;
};