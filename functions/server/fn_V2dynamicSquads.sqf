/*
	Author: Auto-generated
	Modified: Dinamiškai spawnina papildomas AI grupes pagal AIon reikšmę
	
	Description:
		Funkcija dinamiškai spawnina papildomas AI grupes pagal AIon reikšmę
		- AIon >= 3: Spawnina papildomas grupes kiekvienoje bazėje (jei jos dar nespawintos)
		- AIon < 3: Nieko nedaro (grupės miršta natūraliai kovoje)
		
		Funkcija naudoja globalų kintamąjį dynamicSquadsGroups, kuris saugo spawnintų grupių ID
		Pagrįsta moreSquads.sqf logika - naudoja unitsW/unitsE masyvus
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		fn_V2dynamicAIon.sqf - kviečia šią funkciją, kai AIon pasikeičia
		V2aiStart.sqf - inicializuoja dynamicSquadsGroups
		
	Execution:
		[] call wrm_fnc_V2dynamicSquads;
*/

if !(isServer) exitWith {}; // Veikia tik serveryje

// Jei AIon == 0 (Disabled), nieko nedarome
if (AIon == 0) exitWith {
	if (DBG) then {
		["Dynamic Squads: AIon disabled, skipping"] remoteExec ["systemChat", 0, false];
	};
};

// Inicializuojame globalų kintamąjį, jei jis dar neegzistuoja
if (isNil "dynamicSquadsGroups") then {
	dynamicSquadsGroups = [];
	publicVariable "dynamicSquadsGroups";
};

// Skaičiuojame žaidėjus, kad nustatytume, kuri pusė yra žaidėjų pusė
_plw = {side _x == sideW} count allPlayers;
_ple = {side _x == sideE} count allPlayers;

// Nustatome coop kintamąjį
call {
	if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
	if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
	if(_plw>0)exitWith{coop=1; publicvariable "coop";};
	if(_ple>0)exitWith{coop=2; publicvariable "coop";};
};

// Jei AIon < 3, nieko nedarome (grupės miršta natūraliai kovoje)
if (AIon < 3) exitWith {
	if (DBG) then {
		["Dynamic Squads: AIon < 3, no additional squads needed"] remoteExec ["systemChat", 0, false];
	};
};

// Jei AIon >= 3, spawniname papildomas grupes
// Patikriname, ar jau yra grupės kiekvienoje bazėje (maksimaliai 4 grupės: 2 West + 2 East)
// Saugome bazės informaciją grupės kintamajame, kad žinotume, kuri bazė priklauso kuriai grupei
_shouldSpawnW1 = true;
_shouldSpawnW2 = true;
_shouldSpawnE1 = true;
_shouldSpawnE2 = true;

if (count dynamicSquadsGroups > 0) then {
	// Patikriname, ar visos grupes dar egzistuoja
	_aliveGroups = [];
	{
		_grp = _x;
		if (!isNull _grp && {count units _grp > 0}) then {
			_aliveGroups pushBack _grp;
		};
	} forEach dynamicSquadsGroups;
	
	// Atnaujiname masyvą su gyvomis grupėmis
	dynamicSquadsGroups = _aliveGroups;
	publicVariable "dynamicSquadsGroups";
	
	// Patikriname, ar jau yra grupės kiekvienoje bazėje
	// Naudojame grupės kintamąjį, kuris saugo bazės informaciją
	{
		_grp = _x;
		if (!isNull _grp && {count units _grp > 0}) then {
			_basePos = _grp getVariable ["dynamicSquadBase", []];
			if (count _basePos > 0) then {
				// Tikriname, kuri bazė priklauso šiai grupei (naudojame distance, nes pozicijos gali būti netikslūs)
				if (!isNil "posBaseW1" && {count posBaseW1 > 0} && {_basePos distance posBaseW1 < 10}) then {
					_shouldSpawnW1 = false;
				};
				if (!isNil "posBaseW2" && {count posBaseW2 > 0} && {_basePos distance posBaseW2 < 10}) then {
					_shouldSpawnW2 = false;
				};
				if (!isNil "posBaseE1" && {count posBaseE1 > 0} && {_basePos distance posBaseE1 < 10}) then {
					_shouldSpawnE1 = false;
				};
				if (!isNil "posBaseE2" && {count posBaseE2 > 0} && {_basePos distance posBaseE2 < 10}) then {
					_shouldSpawnE2 = false;
				};
			};
		};
	} forEach _aliveGroups;
	
	// Jei visos 4 bazės jau turi grupes, nieko nedarome
	if (!_shouldSpawnW1 && !_shouldSpawnW2 && !_shouldSpawnE1 && !_shouldSpawnE2) then {
		if (DBG) then {
			[format ["Dynamic Squads: All bases already have squads (%1 groups alive)", count _aliveGroups]] remoteExec ["systemChat", 0, false];
		};
		_shouldSpawnW1 = false;
		_shouldSpawnW2 = false;
		_shouldSpawnE1 = false;
		_shouldSpawnE2 = false;
	};
};

// Spawniname papildomas grupes WEST pusėje
if(coop == 0 || coop == 2) then {
	// Patikriname, ar bazės pozicijos yra apibrėžtos
	if (isNil "posBaseW1" || {count posBaseW1 == 0} || {isNil "posBaseW2"} || {count posBaseW2 == 0}) then {
		if (DBG) then {
			["Dynamic Squads: West base positions not defined yet"] remoteExec ["systemChat", 0, false];
		};
	} else {
		// Custom units West pusėje (pagal moreSquads.sqf)
		_useCustomUnits = false;
		
		// Spawniname grupes tik jei reikia (tikriname kiekvieną bazę atskirai)
		_basePositions = [];
		if (_shouldSpawnW1) then {_basePositions pushBack posBaseW1;};
		if (_shouldSpawnW2) then {_basePositions pushBack posBaseW2;};
		
		// Spawniname grupes tik bazėse, kur dar nėra grupių
		{
			_spawnPos = _x;
			
			// Sukuriame grupių vienetus
			_toSpawn = [];
			_attempts = 0;
			while {(count _toSpawn < 6) && (_attempts < 100)} do {
				_attempts = _attempts + 1;
				if (_useCustomUnits) then {
					// Custom units (jei būtų reikalinga)
					_unitsW = ["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F","B_engineer_F","B_soldier_M_F","B_soldier_AT_F","B_Soldier_GL_F","B_soldier_AA_F","B_recon_TL_F","B_recon_LAT_F","B_recon_M_F","B_recon_medic_F","B_recon_JTAC_F","B_recon_F","B_recon_exp_F","B_sniper_F"];
					_toSpawn pushBackUnique (selectRandom _unitsW);
				} else {
					// Naudojame unitsW masyvą
					if (!isNil "unitsW" && {count unitsW > 0}) then {
						_validUnitsW = unitsW select {_x != ""};
						if (count _validUnitsW > 0) then {
							_toSpawn pushBackUnique (selectRandom _validUnitsW);
						} else {
							// Fallback: default vienetai
							_unitsW = ["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F"];
							_toSpawn pushBackUnique (selectRandom _unitsW);
						};
					} else {
						// Fallback: default vienetai
						_unitsW = ["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F"];
						_toSpawn pushBackUnique (selectRandom _unitsW);
					};
				};
			};

			// Fallback: užpildyti likusius slotus, jei unique selection nepavyksta
			while {(count _toSpawn < 6)} do {
				_toSpawn pushBack (selectRandom _unitsW);
			};

		// Spawniname grupę
		_grp = [_spawnPos, sideW, _toSpawn, [], [], [], [], [-1, 1]] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		
		// Saugome bazės informaciją grupės kintamajame
		_grp setVariable ["dynamicSquadBase", _spawnPos, true];
		
		// Loadout ir nation (tik custom units)
		if (_useCustomUnits) then {
			{
				[_x] call wrm_fnc_V2loadoutChange;
				[_x] call wrm_fnc_V2nationChange;
			} forEach units _grp;
		};
		
		// Pridedame event handlerius
		{
			_x addMPEventHandler ["MPKilled", {[(_this select 0), sideW] spawn wrm_fnc_killedEH;}];
			_x addMPEventHandler ["MPKilled", {params ["_corpse", "_killer", "_instigator", "_useEffects"]; [_corpse] spawn wrm_fnc_V2entityKilled;}];
		} forEach units _grp;
		
		// Pridedame į Zeus
		if (!isNil "z1") then {
			z1 addCuratorEditableObjects [(units _grp), true];
		};
		
		// Pridedame grupę į masyvą
		dynamicSquadsGroups pushBack _grp;
		
		} forEach _basePositions;
	};
};

// Spawniname papildomas grupes EAST pusėje
if(coop == 0 || coop == 1) then {
	// Patikriname, ar bazės pozicijos yra apibrėžtos
	if (isNil "posBaseE1" || {count posBaseE1 == 0} || {isNil "posBaseE2"} || {count posBaseE2 == 0}) then {
		if (DBG) then {
			["Dynamic Squads: East base positions not defined yet"] remoteExec ["systemChat", 0, false];
		};
	} else {
		// Custom units East pusėje (pagal moreSquads.sqf)
		_useCustomUnits = false;
		if (!isNil "factionE" && !isNil "env") then {
			if ((factionE == "CSAT") && (env == "woodland")) then {
				_useCustomUnits = true;
			};
		};
		
		// Spawniname grupes tik jei reikia (tikriname kiekvieną bazę atskirai)
		_basePositions = [];
		if (_shouldSpawnE1) then {_basePositions pushBack posBaseE1;};
		if (_shouldSpawnE2) then {_basePositions pushBack posBaseE2;};
		
		// Spawniname grupes tik bazėse, kur dar nėra grupių
		{
			_spawnPos = _x;
			
			// Sukuriame grupių vienetus
			_toSpawn = [];
			_attempts = 0;
			while {(count _toSpawn < 6) && (_attempts < 100)} do {
				_attempts = _attempts + 1;
				if (_useCustomUnits) then {
					// Custom units (CSAT woodland)
					_unitsE = ["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F","O_engineer_F","O_soldier_M_F","O_soldier_AT_F","O_Soldier_GL_F","O_soldier_AA_F","O_recon_TL_F","O_recon_LAT_F","O_recon_M_F","O_recon_medic_F","O_recon_JTAC_F","O_recon_F","O_recon_exp_F","O_sniper_F"];
					_toSpawn pushBackUnique (selectRandom _unitsE);
				} else {
					// Naudojame unitsE masyvą
					if (!isNil "unitsE" && {count unitsE > 0}) then {
						_validUnitsE = unitsE select {_x != ""};
						if (count _validUnitsE > 0) then {
							_toSpawn pushBackUnique (selectRandom _validUnitsE);
						} else {
							// Fallback: default vienetai
							_unitsE = ["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F"];
							_toSpawn pushBackUnique (selectRandom _unitsE);
						};
					} else {
						// Fallback: default vienetai
						_unitsE = ["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F"];
						_toSpawn pushBackUnique (selectRandom _unitsE);
					};
				};
			};

			// Fallback: užpildyti likusius slotus, jei unique selection nepavyksta
			while {(count _toSpawn < 6)} do {
				_toSpawn pushBack (selectRandom _unitsE);
			};

			// Spawniname grupę
			_grp = [_spawnPos, sideE, _toSpawn, [], [], [], [], [-1, 1]] call BIS_fnc_spawnGroup;
			_grp deleteGroupWhenEmpty true;
			
			// Saugome bazės informaciją grupės kintamajame
			_grp setVariable ["dynamicSquadBase", _spawnPos, true];
			
		// Loadout ir nation (tik custom units)
		if (_useCustomUnits) then {
			{
				[_x] call wrm_fnc_V2loadoutChange;
				[_x] call wrm_fnc_V2nationChange;
			} forEach units _grp;
		};
		
		// Pridedame event handlerius
		{
			_x addMPEventHandler ["MPKilled", {[(_this select 0), sideE] spawn wrm_fnc_killedEH;}];
			_x addMPEventHandler ["MPKilled", {params ["_corpse", "_killer", "_instigator", "_useEffects"]; [_corpse] spawn wrm_fnc_V2entityKilled;}];
		} forEach units _grp;
		
		// Pridedame į Zeus
		if (!isNil "z1") then {
			z1 addCuratorEditableObjects [(units _grp), true];
		};
		
		// Pridedame grupę į masyvą
		dynamicSquadsGroups pushBack _grp;
		
		} forEach _basePositions;
	};
};

// Atnaujiname globalų kintamąjį
publicVariable "dynamicSquadsGroups";

if (DBG) then {
	[format ["Dynamic Squads: Spawned %1 additional squads (AIon: %2)", count dynamicSquadsGroups, AIon]] remoteExec ["systemChat", 0, false];
};

