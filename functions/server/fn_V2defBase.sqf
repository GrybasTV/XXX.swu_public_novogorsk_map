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
// Užtikrinti, kad DBG yra apibrėžtas (apsauga nuo undefined variable klaidos)
if (isNil "DBG") then {
	DBG = false;
};

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
	
	//AI DEFENSE FIX: Taikyti tą pačią apsaugą kaip ir pagrindinėje aiMove funkcijoje

	//1. DS FIX: Išjungti DS prieš siunčiant move komandą (jei įjungta)
	private _hadDS = false;
	if(!isNil "enableDynamicSimulationSystem" && {dynamicSimulationEnabled _grp})then{
		_hadDS = true;
		_grp enableDynamicSimulation false;
	};

	//2. AI BEHAVIOUR FIX: Užtikrinti, kad gynybos grupė gali judėti
	private _leader = leader _grp;
	if(!isNull _leader && {alive _leader})then{
		//Patikrinti ar leader gali judėti (ne disabled AI)
		if(!(_leader checkAIFeature "PATH"))then{
			_leader enableAI "PATH";
		};
		if(!(_leader checkAIFeature "MOVE"))then{
			_leader enableAI "MOVE";
		};
		//Užtikrinti tinkamą behaviour
		if(behaviour _leader == "CARELESS")then{
			_grp setBehaviour "AWARE";
		};
	};

	//3. MOVE COMMAND FIX: Patikrinti groupOwner ir naudoti tinkamą metodą
	private _owner = groupOwner _grp;
	private _targetPos = [((_base select 0)+(round((random 10)*(selectRandom[-1,1])))),((_base select 1)+(round((random 10)*(selectRandom[-1,1]))))];

	if(_owner <= 0 || isNil "_owner")then{
		//Tiesioginis move - saugiausias variantas gynybos grupėms
		_grp move _targetPos;
	}else{
		//RemoteExec į validų owner
		[_grp, _targetPos] remoteExec ["move", _owner, false];
	};
	sleep 181;
};