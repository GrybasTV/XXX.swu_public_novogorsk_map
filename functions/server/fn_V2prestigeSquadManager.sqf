/*
	Author: IvosH (modifikuota Prestige sistemai)

	Description:
		Dinaminis squad management Prestige AI Balance sistemai
		Valdo papildomų AI squad'ų spawn'inimą ir naikinimą pagal Prestige lygį

	Parameter(s):
		_targetAILevel - naujas AI lygis (1, 2, arba 3)

	Returns:
		nothing

	Dependencies:
		fn_V2strategicAiBalance.sqf

	Execution:
		[_targetAILevel] call wrm_fnc_V2prestigeSquadManager;
*/

//Parametrai
params ["_targetAILevel"];

if !(isServer) exitWith {}; //Tik serveryje

//Globalūs kintamieji sekti squad'ams
if (isNil "prestigeSquadsWest") then {prestigeSquadsWest = [];};
if (isNil "prestigeSquadsEast") then {prestigeSquadsEast = [];};

//Funkcija spawn'inti squad'ą su error handling (SQF best practices)
private _spawnSquad = {
	params ["_side", "_basePos"];

	//Validation prieš spawn (SQF best practices)
	if (isNil "_basePos") exitWith {
		diag_log format ["[PRESTIGE] Error: Spawn position is nil for %1 side", _side];
		grpNull
	};

	if (!(_basePos isEqualTypeArray [0,0,0])) exitWith {
		diag_log format ["[PRESTIGE] Error: Spawn position is not array for %1 side", _side];
		grpNull
	};

	if (count _basePos != 3) exitWith {
		diag_log format ["[PRESTIGE] Error: Spawn position array has wrong size (%2) for %1 side", _side, count _basePos];
		grpNull
	};

	private _unitsArray = if (_side == sideW) then {unitsW} else {unitsE};
	private _availableUnits = _unitsArray select {_x != "" && _x isEqualType ""};
	if (count _availableUnits == 0) then {
		_availableUnits = if (_side == sideW) then {
			["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F"]
		} else {
			["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F"]
		};
	};

	//6 unitai squad'e
	private _toSpawn = [];
	while {count _toSpawn < 6} do {
		_toSpawn pushBackUnique (selectRandom _availableUnits);
	};

	if (count _toSpawn == 0) exitWith {
		diag_log format ["[PRESTIGE] Error: No units to spawn for %1 side", _side];
		grpNull
	};

	//Spawn grupę
	private _grp = [_basePos, _side, _toSpawn, [], [], [], [], [-1, 1]] call BIS_fnc_spawnGroup;

	//Error handling po spawn
	if (isNil "_grp" || {isNull _grp}) exitWith {
		diag_log format ["[PRESTIGE] Error: Failed to spawn group for %1 side at %2", _side, _basePos];
		grpNull
	};

	_grp deleteGroupWhenEmpty true;

	//Apply loadouts ir nation change
	{
		[_x] call wrm_fnc_V2loadoutChange;
		[_x] call wrm_fnc_V2nationChange;

		//Event handler'iai
		private _unitSide = _side; // Capture side in closure
		_x addMPEventHandler ["MPKilled", {
			[(_this select 0), _unitSide] spawn wrm_fnc_killedEH;
		}];
		_x addMPEventHandler ["MPKilled", {
			params ["_corpse", "_killer", "_instigator", "_useEffects"];
			[_corpse] spawn wrm_fnc_V2entityKilled;
		}];
	} forEach units _grp;

	//Pridėti į curator (su validation)
	if (!isNil "z1" && {!isNull z1}) then {
		z1 addCuratorEditableObjects [(units _grp), true];
	};

	_grp
};

//Funkcija išvalyti squad'ą - DAUGIAU NENAUDOJAMA (one-way scaling)
//Nėra despawn, todėl ši funkcija nereikalinga
//private _cleanupSquad = {
//	params ["_grp"];
//	if (!isNull _grp && count units _grp > 0) then {
//		{deleteVehicle _x} forEach units _grp;
//		deleteGroup _grp;
//	};
//};

//Skaičiuoti kiek squad'ų reikia kiekvienam lygiui
private _squadsNeededWest = 0;
private _squadsNeededEast = 0;

call {
	if (_targetAILevel == 1) exitWith {
		_squadsNeededWest = 0;
		_squadsNeededEast = 0;
	};
	if (_targetAILevel == 2) exitWith {
		_squadsNeededWest = 1;
		_squadsNeededEast = 1;
	};
	if (_targetAILevel == 3) exitWith {
		_squadsNeededWest = 2;
		_squadsNeededEast = 2;
	};
};

//Valdyti WEST squad'us - TIK SPAWNINTI, NE DESPAWNINTI (one-way scaling)
//AI gali stiprėti, bet nesilpnėti - išlaikyti visus istorinius spawn'us
private _currentSquadsWest = count prestigeSquadsWest;

//Jei reikia daugiau squad'ų (tik kai lygis KYLA)
if (_squadsNeededWest > _currentSquadsWest) then {
	private _toAdd = _squadsNeededWest - _currentSquadsWest;
	for "_i" from 1 to _toAdd do {
		private _basePos = selectRandom [posBaseW1, posBaseW2];
		private _newGrp = [sideW, _basePos] call _spawnSquad;
		prestigeSquadsWest pushBack _newGrp;

		if (DBG) then {
			systemChat format ["[PRESTIGE SQUADS] Spawned additional WEST squad (total: %1)", count prestigeSquadsWest];
		};
	};
};

//DESPAWN LOGIKA PAŠALINTA - AI niekada nesilpnėja dinamiškai
//if (_squadsNeededWest < _currentSquadsWest) then { ... };

//Valdyti EAST squad'us - TIK SPAWNINTI, NE DESPAWNINTI (one-way scaling)
//AI gali stiprėti, bet nesilpnėti - išlaikyti visus istorinius spawn'us
private _currentSquadsEast = count prestigeSquadsEast;

//Jei reikia daugiau squad'ų (tik kai lygis KYLA)
if (_squadsNeededEast > _currentSquadsEast) then {
	private _toAdd = _squadsNeededEast - _currentSquadsEast;
	for "_i" from 1 to _toAdd do {
		private _basePos = selectRandom [posBaseE1, posBaseE2];
		private _newGrp = [sideE, _basePos] call _spawnSquad;
		prestigeSquadsEast pushBack _newGrp;

		if (DBG) then {
			systemChat format ["[PRESTIGE SQUADS] Spawned additional EAST squad (total: %1)", count prestigeSquadsEast];
		};
	};
};

//DESPAWN LOGIKA PAŠALINTA - AI niekada nesilpnėja dinamiškai
//if (_squadsNeededEast < _currentSquadsEast) then { ... };

//Debug info apie bendrą būklę
if (DBG) then {
	private _totalWest = {alive _x} count (flatten (prestigeSquadsWest apply {units _x}));
	private _totalEast = {alive _x} count (flatten (prestigeSquadsEast apply {units _x}));
	systemChat format ["[PRESTIGE SQUADS] AI Level %1 - WEST squads: %2 (%3 units), EAST squads: %4 (%5 units)",
		_targetAILevel, count prestigeSquadsWest, _totalWest, count prestigeSquadsEast, _totalEast];
};
