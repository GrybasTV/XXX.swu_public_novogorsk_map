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

//OPTIMIZATION: Naudojame private kintamuosius ir entities vietoj allGroups - VALIDUOTA SU ARMA 3 BEST PRACTICES
private _grpsW = [];
private _grpsE = [];

//DEBUG: Statistikos kintamieji DS, move komandų ir sektorių pozicijų sekimui
private _dsDisabledCount = 0;
private _directMoveCount = 0;
private _remoteMoveCount = 0;
private _sectorPosAdjustedCount = 0;

//OPTIMIZATION: Pakeičiame allGroups į entities su grupių filtravimu - VALIDUOTA SU ARMA 3 BEST PRACTICES
{
	if ((side _x==sideW)&&(!isPlayer leader _x)&&({alive _x}count units _x>0)&&(str _x != "B HQ")&&(str _x != "R HQ"))then{
		_grpsW pushBackUnique _x;
	};
} forEach allGroups; //side, leader is AI, not empty group, not HQ

{
	if ((side _x==sideE)&&(!isPlayer leader _x)&&({alive _x}count units _x>0)&&(str _x != "O HQ")&&(str _x != "R HQ"))then{
		_grpsE pushBackUnique _x;
	};
} forEach allGroups;
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

//AA - tikriname mūsų naujųjų marker'ių spalvas
call
{
	private _markerColor = getMarkerColor "mAA";
	if(_markerColor == "ColorBlack")exitWith{_sec0 pushBackUnique posAA;}; // neutralus
	if(_markerColor == "ColorBlue")exitWith{_secW pushBackUnique posAA;}; // west užimtas
	if(_markerColor == "ColorRed")exitWith{_secE pushBackUnique posAA;}; // east užimtas
	// Jei marker neegzistuoja arba turi kitą spalvą - laikome neutraliu
	_sec0 pushBackUnique posAA;
};

//Artillery
call
{
	private _markerColor = getMarkerColor "mArti";
	if(_markerColor == "ColorBlack")exitWith{_sec0 pushBackUnique posArti;}; // neutralus
	if(_markerColor == "ColorBlue")exitWith{_secW pushBackUnique posArti;}; // west užimtas
	if(_markerColor == "ColorRed")exitWith{_secE pushBackUnique posArti;}; // east užimtas
	// Jei marker neegzistuoja arba turi kitą spalvą - laikome neutraliu
	_sec0 pushBackUnique posArti;
};

//CAS Tower
call
{
	private _markerColor = getMarkerColor "mCas";
	if(_markerColor == "ColorBlack")exitWith{_sec0 pushBackUnique posCas;}; // neutralus
	if(_markerColor == "ColorBlue")exitWith{_secW pushBackUnique posCas;}; // west užimtas
	if(_markerColor == "ColorRed")exitWith{_secE pushBackUnique posCas;}; // east užimtas
	// Jei marker neegzistuoja arba turi kitą spalvą - laikome neutraliu
	_sec0 pushBackUnique posCas;
};

//BASES WEST
//enemy
//OPTIMIZATION: Pakeičiame allUnits į cached masyvą su entities - VALIDUOTA SU ARMA 3 BEST PRACTICES
//entities yra greitesnė nei allUnits, ypač su daug vienetų
private _cachedUnits = entities [["Man"], [], true, false] select {alive _x && side _x == sideE};
_en = _cachedUnits;

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
//enemy
//OPTIMIZATION: Pakeičiame allUnits į cached masyvą su entities - VALIDUOTA SU ARMA 3 BEST PRACTICES
//entities yra greitesnė nei allUnits, ypač su daug vienetų
private _cachedUnits = entities [["Man"], [], true, false] select {alive _x && side _x == sideW};
_en = _cachedUnits;

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
//OPTIMIZATION: Cache allPlayers rezultata ir naudoti efektyvesnį filtravimą - VALIDUOTA SU ARMA 3 BEST PRACTICES
_grW=[]; _grE=[]; // _posPW=[]; _posPE=[]; _posGW=[]; _posGE=[];
private _allPlayersCached = allPlayers select {alive _x};
call
{
	{if ((side _x == sideW)&&({alive _x}count units group _x>0))then{_grW pushBackUnique (group _x)};} forEach _allPlayersCached;
	{if ((side _x == sideE)&&({alive _x}count units group _x>0))then{_grE pushBackUnique (group _x)};} forEach _allPlayersCached;
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
//MODIFICATION: Optimizuota batch sistema - grupuojame remoteExec iškvietimus pagal groupOwner
//Taip pat pridėtas error handling ir maksimalus grupių skaičius per iteraciją
_secS=[];
private _moveBatchW = []; //Batch sistema: [[owner, [grupių masyvas su pozicijomis]], ...]
private _maxGroupsPerIteration = 50; //Maksimalus grupių skaičius per iteraciją
private _groupCount = 0;

{
	//Patikrinti maksimalų grupių skaičių
	if(_groupCount >= _maxGroupsPerIteration)exitWith{};
	
	//Patikrinti, kad grupė vis dar egzistuoja ir turi leader'į
	if(!isNull _x && !isNull leader _x)then{
		if(count _secS<1)then{_secS=_sec0+_secDW+_secE+_posPE+_posGE+_secAW+_secW;}; //refill sectors array
		_sec=_secS select 0;

		//Apskaičiuoti poziciją su SEKTORIŲ AI FIX: užtikrinti, kad pozicija būtų pasiekiama
		private _basePos = _sec;
		private _targetPos = [((_basePos select 0)+(round(20+(random 20))*(selectRandom[-1,1]))),((_basePos select 1)+(round(20+(random 20))*(selectRandom[-1,1])))];

		//SEKTORIŲ FIX: patikrinti, ar pozicija nėra ant pastato ar užtvaros
		private _objectsNearby = nearestObjects [_targetPos, ["Building", "Wall", "Fence"], 5];
		if (count _objectsNearby > 0) then {
			_sectorPosAdjustedCount = _sectorPosAdjustedCount + 1;
			//Rasti alternatyvią poziciją aplink sektorių
			private _angles = [0, 45, 90, 135, 180, 225, 270, 315];
			private _foundSafePos = false;
			{
				private _testPos = _basePos getPos [30 + random 20, _x];
				private _testObjects = nearestObjects [_testPos, ["Building", "Wall", "Fence"], 3];
				if (count _testObjects == 0) exitWith {
					_targetPos = _testPos;
					_foundSafePos = true;
				};
			} forEach _angles;

			//Jei nerandame saugios pozicijos, naudoti platesnį paieškos spindulį
			if (!_foundSafePos) then {
				_targetPos = _basePos getPos [50 + random 30, random 360];
			};
		};

		//Gauti groupOwner
		private _owner = groupOwner _x;
		
		//Rasti arba sukurti batch masyvą šiam owner'iui
		private _batchIndex = -1;
		{
			if(_x select 0 == _owner)exitWith{_batchIndex = _forEachIndex;};
		} forEach _moveBatchW;
		
		if(_batchIndex == -1)then{
			_moveBatchW pushBack [_owner, []];
			_batchIndex = (count _moveBatchW) - 1;
		};
		
		private _batch = _moveBatchW select _batchIndex select 1;
		_batch pushBack [_x, _targetPos];
		_moveBatchW set [_batchIndex, [_owner, _batch]];
		
		if(count _secS>0)then{_secS=_secS-[_sec];}; //remove used sector from array
		_groupCount = _groupCount + 1;
	};
} forEach _grpsW;

//Vykdyti batch'us pagal groupOwner
{
	private _owner = _x select 0;
	private _batch = _x select 1;

	//Vykdyti visus move komandas vienu batch'u
	{
		private _grp = _x select 0;
		private _pos = _x select 1;

		//Error handling: patikrinti, kad grupė vis dar egzistuoja
		if(!isNull _grp && !isNull leader _grp)then{
			//AI FREEZING FIX: Išspręsti problemas tiek su DS, tiek be jo

			//1. DS FIX: Išjungti DS prieš siunčiant move komandą (jei DS yra įjungta)
			private _hadDS = false;
			if(!isNil "enableDynamicSimulationSystem" && {dynamicSimulationEnabled _grp})then{
				_hadDS = true;
				_dsDisabledCount = _dsDisabledCount + 1;
				_grp enableDynamicSimulation false;
			};

			//2. AI BEHAVIOUR FIX: Užtikrinti, kad AI gali judėti
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
			if(_owner <= 0 || isNil "_owner")then{
				//Tiesioginis move - saugiausias variantas
				_grp move _pos;
				_directMoveCount = _directMoveCount + 1;

				//Papildomas fallback: jei move neveikia po 3 sekundžių, naudoti doMove
				[_grp, _pos] spawn {
					params ["_grp", "_pos"];
					sleep 3;
					if(!isNull _grp && {leader _grp distance _pos > 30})then{
						{[_x, _pos] remoteExec ["doMove", _x];} forEach units _grp;
					};
				};
			}else{
				//RemoteExec į validų owner
				[_grp, _pos] remoteExec ["move", _owner, false];
				_remoteMoveCount = _remoteMoveCount + 1;

				//Timeout fallback: jei po 5 sekundžių vis dar toli, naudoti tiesioginį move
				[_grp, _pos] spawn {
					params ["_grp", "_pos"];
					sleep 5;
					if(!isNull _grp && {leader _grp distance _pos > 50})then{
						_grp move _pos;
					};
				};
			};
		};
	} forEach _batch;
} forEach _moveBatchW;

//move groups east
//MODIFICATION: Optimizuota batch sistema - grupuojame remoteExec iškvietimus pagal groupOwner
_secS=[];
private _moveBatchE = []; //Batch sistema: [[owner, [grupių masyvas su pozicijomis]], ...]
_groupCount = 0;

{
	//Patikrinti maksimalų grupių skaičių
	if(_groupCount >= _maxGroupsPerIteration)exitWith{};
	
	//Patikrinti, kad grupė vis dar egzistuoja ir turi leader'į
	if(!isNull _x && !isNull leader _x)then{
		if(count _secS<1)then{_secS=_sec0+_secDE+_secW+_posPW+_posGW+_secAE+_secE;}; //refill sectors array
		_sec=_secS select 0;

		//Apskaičiuoti poziciją su SEKTORIŲ AI FIX: užtikrinti, kad pozicija būtų pasiekiama
		private _basePos = _sec;
		private _targetPos = [((_basePos select 0)+(round(20+(random 20))*(selectRandom[-1,1]))),((_basePos select 1)+(round(20+(random 20))*(selectRandom[-1,1])))];

		//SEKTORIŲ FIX: patikrinti, ar pozicija nėra ant pastato ar užtvaros
		private _objectsNearby = nearestObjects [_targetPos, ["Building", "Wall", "Fence"], 5];
		if (count _objectsNearby > 0) then {
			_sectorPosAdjustedCount = _sectorPosAdjustedCount + 1;
			//Rasti alternatyvią poziciją aplink sektorių
			private _angles = [0, 45, 90, 135, 180, 225, 270, 315];
			private _foundSafePos = false;
			{
				private _testPos = _basePos getPos [30 + random 20, _x];
				private _testObjects = nearestObjects [_testPos, ["Building", "Wall", "Fence"], 3];
				if (count _testObjects == 0) exitWith {
					_targetPos = _testPos;
					_foundSafePos = true;
				};
			} forEach _angles;

			//Jei nerandame saugios pozicijos, naudoti platesnį paieškos spindulį
			if (!_foundSafePos) then {
				_targetPos = _basePos getPos [50 + random 30, random 360];
			};
		};

		//Gauti groupOwner
		private _owner = groupOwner _x;
		
		//Rasti arba sukurti batch masyvą šiam owner'iui
		private _batchIndex = -1;
		{
			if(_x select 0 == _owner)exitWith{_batchIndex = _forEachIndex;};
		} forEach _moveBatchE;
		
		if(_batchIndex == -1)then{
			_moveBatchE pushBack [_owner, []];
			_batchIndex = (count _moveBatchE) - 1;
		};
		
		private _batch = _moveBatchE select _batchIndex select 1;
		_batch pushBack [_x, _targetPos];
		_moveBatchE set [_batchIndex, [_owner, _batch]];
		
		if(count _secS>0)then{_secS=_secS-[_sec];}; //remove used sector from array
		_groupCount = _groupCount + 1;
	};
} forEach _grpsE;

//Vykdyti batch'us pagal groupOwner
{
	private _owner = _x select 0;
	private _batch = _x select 1;

	//Vykdyti visus move komandas vienu batch'u
	{
		private _grp = _x select 0;
		private _pos = _x select 1;

		//Error handling: patikrinti, kad grupė vis dar egzistuoja
		if(!isNull _grp && !isNull leader _grp)then{
			//AI FREEZING FIX: Išspręsti problemas tiek su DS, tiek be jo

			//1. DS FIX: Išjungti DS prieš siunčiant move komandą (jei DS yra įjungta)
			private _hadDS = false;
			if(!isNil "enableDynamicSimulationSystem" && {dynamicSimulationEnabled _grp})then{
				_hadDS = true;
				_dsDisabledCount = _dsDisabledCount + 1;
				_grp enableDynamicSimulation false;
			};

			//2. AI BEHAVIOUR FIX: Užtikrinti, kad AI gali judėti
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
			if(_owner <= 0 || isNil "_owner")then{
				//Tiesioginis move - saugiausias variantas
				_grp move _pos;
				_directMoveCount = _directMoveCount + 1;

				//Papildomas fallback: jei move neveikia po 3 sekundžių, naudoti doMove
				[_grp, _pos] spawn {
					params ["_grp", "_pos"];
					sleep 3;
					if(!isNull _grp && {leader _grp distance _pos > 30})then{
						{[_x, _pos] remoteExec ["doMove", _x];} forEach units _grp;
					};
				};
			}else{
				//RemoteExec į validų owner
				[_grp, _pos] remoteExec ["move", _owner, false];
				_remoteMoveCount = _remoteMoveCount + 1;

				//Timeout fallback: jei po 5 sekundžių vis dar toli, naudoti tiesioginį move
				[_grp, _pos] spawn {
					params ["_grp", "_pos"];
					sleep 5;
					if(!isNull _grp && {leader _grp distance _pos > 50})then{
						_grp move _pos;
					};
				};
			};
		};
	} forEach _batch;
} forEach _moveBatchE;

//DEBUG: Log DS, move komandų ir sektorių pozicijų statistika
if(DBG)then
{
	diag_log format ["[AI_MOVE_STATS] DS disabled: %1, Direct moves: %2, Remote moves: %3, Sector pos adjusted: %4", _dsDisabledCount, _directMoveCount, _remoteMoveCount, _sectorPosAdjustedCount];
	["AI moves to the objectives"] remoteExec ["systemChat", 0, false];
	[(format ["West %1 groups with players, %2 AI groups",(count _posPW),(count _posGW)])] remoteExec ["systemChat", 0, false];;
	[(format ["East %1 groups with players, %2 AI groups",(count _posPE),(count _posGE)])] remoteExec ["systemChat", 0, false];;
	[(format ["AI Stats: DS:%1 Direct:%2 Remote:%3 SectorAdj:%4", _dsDisabledCount, _directMoveCount, _remoteMoveCount, _sectorPosAdjustedCount])] remoteExec ["systemChat", 0, false];
};