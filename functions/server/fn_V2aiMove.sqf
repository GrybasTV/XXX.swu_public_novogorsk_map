/*
	Author: IvosH
	
	Description:
		Tels to all groups without player leadership what sectors to capture
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		fn_aiUpdate.sqf
		...
		
	Execution:
		[] call wrm_fnc_V2aiMove;
*/
if !(isServer) exitWith {}; //runs on the server/host
if(AIon==0)exitWith{}; //autonomous AI disabled
if(progress<2)exitWith{};

//sort groups
// Optimizuota: gauname allGroups vieną kartą, o ne du kartus
_allGroups = allGroups;
_grpsW=[]; _grpsE=[];

{
	_grp = _x;
	if ((side _grp==sideW)&&(!isPlayer leader _grp)&&({alive _x}count units _grp>0)&&(str _grp != "B HQ")&&(str _grp != "R HQ"))then{
		_grpsW pushBackUnique _grp;
	};
	if ((side _grp==sideE)&&(!isPlayer leader _grp)&&({alive _x}count units _grp>0)&&(str _grp != "O HQ")&&(str _grp != "R HQ"))then{
		_grpsE pushBackUnique _grp;
	};
} forEach _allGroups;
/*
//remove vehicles at objectives (AA, artillery)
if(alive objAAW) then {_grpsW=_grpsW-[(group driver objAAW)];};
if(alive objArtiW) then {_grpsW=_grpsW-[(group driver objArtiW)];};
if(alive objAAE) then {_grpsE=_grpsE-[(group driver objAAE)];};
if(alive objArtiE) then {_grpsE=_grpsE-[(group driver objArtiE)];};
*/
//remove UAVs
if(modA=="A3")then
{
	if(alive uavW)then{_grpsW=_grpsW-[(group driver uavW)];};
	if(alive uavE)then{_grpsE=_grpsE-[(group driver uavE)];};
	if(alive ugvW)then{_grpsW=_grpsW-[(group driver ugvW)];};
	if(alive ugvE)then{_grpsE=_grpsE-[(group driver ugvE)];};
};
//remove defending units
_grpsW=_grpsW-defW;
_grpsE=_grpsE-defE;

//sort sectors, priority: capture empty sectors > defend your base > attack enemy sectors > attack enemy groups with players, then AI > hold captured sectors / if all sectors captured search for enemy bases
_sec0=[]; _secDW=[]; _secDE=[]; _secW=[]; _secE=[]; _posPW=[]; _posPE=[]; _posGW=[]; _posGE=[]; _secAW=[]; _secAE=[];

//AA
call
{
	if((getMarkerColor resAW=="")&&(getMarkerColor resAE==""))exitWith{_sec0 pushBackUnique posAA;}; //empty
	if(getMarkerColor resAW!="")exitWith{_secW pushBackUnique posAA;}; //west
	if(getMarkerColor resAE!="")exitWith{_secE pushBackUnique posAA;}; //east
};

//Artillery
call
{
	if((getMarkerColor resBW=="")&&(getMarkerColor resBE==""))exitWith{_sec0 pushBackUnique posArti;};
	if(getMarkerColor resBW!="")exitWith{_secW pushBackUnique posArti;};
	if(getMarkerColor resBE!="")exitWith{_secE pushBackUnique posArti;};
};

//CAS Tower
call
{
	if((getMarkerColor resCW=="")&&(getMarkerColor resCE==""))exitWith{_sec0 pushBackUnique posCas;};
	if(getMarkerColor resCW!="")exitWith{_secW pushBackUnique posCas;};
	if(getMarkerColor resCE!="")exitWith{_secE pushBackUnique posCas;};
};

//BASES WEST
// Optimizuota: gauname allUnits vieną kartą ir filtruojame pagal šalis
_allUnits = allUnits;
//enemy
_en=[];
{if(side _x==sideE)then{_en pushBackUnique _x;};} forEach _allUnits;

//base vest 2 (armors)
_eBW2=false;
{if(_eBW2)exitWith{};if((_x distance posBaseW2)<200)then{_eBW2 = true;};} forEach _en;
call
{	
	if(secBW2&&(getMarkerColor resBaseW!="")&&_eBW2)exitWith{_secDW pushBackUnique posBaseW2;};
	if(secBW2&&(getMarkerColor resBaseW!=""))exitWith{_secW pushBackUnique posBaseW2;};
	if(getMarkerColor resBaseWE!="")exitWith{_secE pushBackUnique posBaseW2;};
};

//base vest 1 (transport)
_eBW1=false;
{if(_eBW1)exitWith{};if((_x distance posBaseW1)<200)then{_eBW1 = true;};} forEach _en;
call
{	
	if(secBW1&&(getMarkerColor resFobW!="")&&_eBW1)exitWith{_secDW pushBackUnique posBaseW1;};
	if(secBW1&&(getMarkerColor resFobW!=""))exitWith{_secW pushBackUnique posBaseW1;};
	if(getMarkerColor resFobWE!="")exitWith{_secE pushBackUnique posBaseW1;};
};

//BASES EAST
// Optimizuota: naudojame jau gautą _allUnits masyvą
//enemy
_en=[];
{if(side _x==sideW)then{_en pushBackUnique _x;};} forEach _allUnits;

//base east 2 (armors)
_eBE2=false;
{if(_eBE2)exitWith{};if((_x distance posBaseE2)<200)then{_eBE2 = true;};} forEach _en;
call
{	
	if(secBE2&&(getMarkerColor resBaseE!="")&&_eBE2)exitWith{_secDE pushBackUnique posBaseE2;};
	if(secBE2&&(getMarkerColor resBaseE!=""))exitWith{_secE pushBackUnique posBaseE2;};
	if(getMarkerColor resBaseEW!="")exitWith{_secW pushBackUnique posBaseE2;};
};

//base east 1 (transport)
_eBE1=false;
{if(_eBE1)exitWith{};if((_x distance posBaseE1)<200)then{_eBE1 = true;};} forEach _en;
call
{	
	if(secBE1&&(getMarkerColor resFobE!="")&&_eBE1)exitWith{_secDE pushBackUnique posBaseE1;};
	if(secBE1&&(getMarkerColor resFobE!=""))exitWith{_secE pushBackUnique posBaseE1;};
	if(getMarkerColor resFobEW!="")exitWith{_secW pushBackUnique posBaseE1;};
};

//attack enemy groups
_grW=[]; _grE=[]; // _posPW=[]; _posPE=[]; _posGW=[]; _posGE=[];
call
{
	{if ((side _x == sideW)&&({alive _x}count units group _x>0))then{_grW pushBackUnique (group _x)};} forEach allPlayers; //side, not empty group, not HQ
	{if ((side _x == sideE)&&({alive _x}count units group _x>0))then{_grE pushBackUnique (group _x)};} forEach allPlayers;
};

{_posPW pushBackUnique (getPos leader _x);} forEach _grW;
{_posGW pushBackUnique (getPos leader _x);} forEach _grpsW;
_posGW=_posGW-_posPW;
{_posPE pushBackUnique (getPos leader _x);} forEach _grE;
{_posGE pushBackUnique (getPos leader _x);} forEach _grpsE;
_posGE=_posGE-_posPE;

/*
call
{
	{if ((side _x == sideW)&&(count units _x > 0)&&(str _x != "B HQ")&&(str _x != "R HQ"))then{_grW pushBackUnique _x};} forEach allGroups; //side, not empty group, not HQ
	{if ((side _x == sideE)&&(count units _x > 0)&&(str _x != "O HQ")&&(str _x != "R HQ"))then{_grE pushBackUnique _x};} forEach allGroups;
};

//remove vehicles at objectives (AA, artillery)
if(alive objAAW) then {_grW=_grW-[(group driver objAAW)];};
if(alive objArtiW) then {_grW=_grW-[(group driver objArtiW)];};
if(alive objAAE) then {_grE=_grE-[(group driver objAAE)];};
if(alive objArtiE) then {_grE=_grE-[(group driver objArtiE)];};

//remove UAVs
if(modA=="A3")then
{
	if(alive uavW)then{_grW=_grW-[(group driver uavW)];};
	if(alive uavE)then{_grE=_grE-[(group driver uavE)];};
	if(alive ugvW)then{_grW=_grW-[(group driver ugvW)];};
	if(alive ugvE)then{_grE=_grE-[(group driver ugvE)];};
};

//remove defending units
_grW=_grW-defW;
_grE=_grE-defE;

{
	_g = _x;
	_pl = false;
	if(({alive _x} count units _g) > 0)then
	{
		{
			_u = _x;
			if(isPlayer _u)then{_pl = true;};
		} forEach units _g;
		if (_pl) then {_posPW pushBackUnique (getPos leader _g);} else {_posGW pushBackUnique (getPos leader _g);};
	};
} forEach _grW;
systemChat format ["grp west %1,%2,",(count _posPW),(count _posGW)];
{
	_g = _x;
	_pl = false;
	if(({alive _x} count units _g) > 0)then
	{
		{
			_u = _x;
			if(isPlayer _u)then{_pl = true;};
		} forEach units _g;
		if (_pl) then {_posPE pushBackUnique (getPos leader _g);} else {_posGE pushBackUnique (getPos leader _g);};
	};
} forEach _grE;
systemChat format ["grp east %1,%2,",(count _posPE),(count _posGE)];
*/

//search for enemy bases
if ((getMarkerColor resAW!="")&&(getMarkerColor resBW!="")&&(getMarkerColor resCW!="")&&(getMarkerColor resFobW!="")&&(getMarkerColor resBaseW!="")&&(!_eBW1)&&(!_eBW2))
then {_secAW pushBackUnique (selectRandom [posBaseE1,posBaseE2]);};
if ((getMarkerColor resAE!="")&&(getMarkerColor resBE!="")&&(getMarkerColor resCE!="")&&(getMarkerColor resFobE!="")&&(getMarkerColor resBaseE!="")&&(!_eBE1)&&(!_eBE2))
then {_secAE pushBackUnique (selectRandom [posBaseW1,posBaseW2]);};

//move groups west
_secS=[];
// Pridėtas įstrigimo patikrinimas pagal SQF_SYNTAX_BEST_PRACTICES.md rekomendacijas
{
	// Tikriname kiekvieną vienetą grupėje dėl įstrigimo
	{
		if (alive _x && {!isPlayer _x}) then {
			[_x, 1, 3] call wrm_fnc_V2aiStuckCheck;
		};
	} forEach units _x;

	if(count _secS<1)then{_secS=_sec0+_secDW+_secE+_posPE+_posGE+_secAW+_secW;}; //refill sectors array
	// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
	// Param grąžina [0, 0] jei masyvas tuščias, todėl patikriname ar pozicija nėra [0, 0]
	_sec=_secS param [0, [0, 0]];
	// Naudojame isEqualTo vietoj individualių koordinačių patikrinimo (geresnė praktika pagal dokumentaciją)
	if(!(_sec isEqualTo [0, 0])) then {
		[_x,[((_sec param [0, 0])+(round(20+(random 20))*(selectRandom[-1,1]))),((_sec param [1, 0])+(round(20+(random 20))*(selectRandom[-1,1])))]] remoteExec ["move", (groupOwner _x), false];
		if(count _secS>0)then{_secS=_secS-[_sec];}; //remove used sector from array
	};
} forEach _grpsW;

//move groups east
_secS=[];
// Pridėtas įstrigimo patikrinimas pagal SQF_SYNTAX_BEST_PRACTICES.md rekomendacijas
{
	// Tikriname kiekvieną vienetą grupėje dėl įstrigimo
	{
		if (alive _x && {!isPlayer _x}) then {
			[_x, 1, 3] call wrm_fnc_V2aiStuckCheck;
		};
	} forEach units _x;

	if(count _secS<1)then{_secS=_sec0+_secDE+_secW+_posPW+_posGW+_secAE+_secE;}; //refill sectors array
	// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
	// Param grąžina [0, 0] jei masyvas tuščias, todėl patikriname ar pozicija nėra [0, 0]
	_sec=_secS param [0, [0, 0]];
	// Naudojame isEqualTo vietoj individualių koordinačių patikrinimo (geresnė praktika pagal dokumentaciją)
	if(!(_sec isEqualTo [0, 0])) then {
		[_x,[((_sec param [0, 0])+(round(20+(random 20))*(selectRandom[-1,1]))),((_sec param [1, 0])+(round(20+(random 20))*(selectRandom[-1,1])))]] remoteExec ["move", (groupOwner _x), false];
		if(count _secS>0)then{_secS=_secS-[_sec];}; //remove used sector from array
	};
} forEach _grpsE;

if(DBG)then
{
	["AI moves to the objectives"] remoteExec ["systemChat", 0, false];
	[(format ["West %1 groups with players, %2 AI groups",(count _posPW),(count _posGW)])] remoteExec ["systemChat", 0, false];
	[(format ["East %1 groups with players, %2 AI groups",(count _posPE),(count _posGE)])] remoteExec ["systemChat", 0, false];
};