/*
	Author: IvosH
	Modified: GrybasTV & Antigravity
	
	Description:
		AI Artillery Logic - "Artillery Hell"
		Independent firing for Mortars and Howitzers.
		Frequent fire missions, expanded target list.

	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		
	Execution:
		[] spawn wrm_fnc_V2aiArtillery;
*/

// Helper function to fire artillery
_fnc_fireArti = {
	params ["_arti", "_targets", "_minDist", "_friendlyUnits", "_debugName", "_roundCount"];
	
	if (isNull _arti || !alive _arti) exitWith {};
	
	// Filter targets based on distance to friendly units (Safety) and distance to artillery itself (Min Range)
	_validTargets = [];
	{
		_tPos = _x;
		if (_tPos distance _arti > _minDist) then { // Min range check
			_safe = true;
			{
				if (_x distance _tPos < 75) exitWith {_safe = false;}; // Danger Close 75m
			} forEach _friendlyUnits;
			
			if (_safe) then {
				_validTargets pushBack _tPos;
			};
		};
	} forEach _targets;
	
	if (count _validTargets > 0) then {
		_targetPos = selectRandom _validTargets;
		_ammoType = (getArtilleryAmmo [_arti]) param [0, ""];

		// #region agent log - Artillery Fire Debug
		private _artilleryLogData = createHashMapFromArray [
			["sessionId", "debug-session"],
			["runId", "artillery-fire-debug"],
			["hypothesisId", "ARTILLERY_BUG"],
			["location", "fn_V2aiArtillery.sqf:45"],
			["message", "Artillery attempting to fire"],
			["data", createHashMapFromArray [
				["artilleryUnit", _arti],
				["artilleryType", typeOf _arti],
				["targetPos", _targetPos],
				["ammoType", _ammoType],
				["validTargetsCount", count _validTargets],
				["isAlive", alive _arti],
				["isNull", isNull _arti],
				["artilleryAmmo", getArtilleryAmmo _arti]
			]],
			["timestamp", time]
		];
		diag_log (str _artilleryLogData);
		// #endregion

		if (_ammoType != "") then {
			_rounds = _roundCount select 0;
			if (count _roundCount > 1) then {
				_rounds = (_roundCount select 0) + floor(random ((_roundCount select 1) - (_roundCount select 0) + 1));
			};

			// #region agent log - Artillery Pre-Fire Check
			private _eta = _arti getArtilleryETA [_targetPos, _ammoType];
			private _canFire = _eta > 0;
			private _artilleryPos = getPos _arti;
			private _distanceToTarget = _artilleryPos distance _targetPos;

			private _preFireLogData = createHashMapFromArray [
				["sessionId", "debug-session"],
				["runId", "artillery-fire-debug"],
				["hypothesisId", "ARTILLERY_BUG"],
				["location", "fn_V2aiArtillery.sqf:50"],
				["message", "Pre-fire artillery check"],
				["data", createHashMapFromArray [
					["artilleryUnit", _arti],
					["artilleryPos", _artilleryPos],
					["targetPos", _targetPos],
					["distanceToTarget", _distanceToTarget],
					["ammoType", _ammoType],
					["eta", _eta],
					["canFire", _canFire],
					["rounds", _rounds],
					["artilleryComputer", _arti getVariable ["BIS_artilleryComputer", "not_set"]]
				]],
				["timestamp", time]
			];
			diag_log (str _preFireLogData);
			// #endregion

			// Check if artillery can actually fire at this position
			if (_canFire) then {
				_arti doArtilleryFire [_targetPos, _ammoType, _rounds];

				// #region agent log - Artillery Fire Success
				private _fireLogData = createHashMapFromArray [
					["sessionId", "debug-session"],
					["runId", "artillery-fire-debug"],
					["hypothesisId", "ARTILLERY_BUG"],
					["location", "fn_V2aiArtillery.sqf:55"],
					["message", "Artillery fire command executed"],
					["data", createHashMapFromArray [
						["artilleryUnit", _arti],
						["targetPos", _targetPos],
						["ammoType", _ammoType],
						["rounds", _rounds],
						["eta", _arti getArtilleryETA [_targetPos, _ammoType]]
					]],
					["timestamp", time]
				];
				diag_log (str _fireLogData);
				// #endregion

				if (DBG) then {
					[format ["%1 firing %2 rounds at grid %3", _debugName, _rounds, mapGridPosition _targetPos]] remoteExec ["systemChat", 0, false];
				};
			} else {
				// #region agent log - Artillery Fire Failed - Invalid Target
				private _failLogData = createHashMapFromArray [
					["sessionId", "debug-session"],
					["runId", "artillery-fire-debug"],
					["hypothesisId", "ARTILLERY_BUG"],
					["location", "fn_V2aiArtillery.sqf:55"],
					["message", "Artillery cannot fire at target - invalid position"],
					["data", createHashMapFromArray [
						["artilleryUnit", _arti],
						["targetPos", _targetPos],
						["ammoType", _ammoType],
						["eta", _arti getArtilleryETA [_targetPos, _ammoType]],
						["distance", _arti distance _targetPos]
					]],
					["timestamp", time]
				];
				diag_log (str _failLogData);
				// #endregion

				if (DBG) then {
					[format ["%1 cannot fire at grid %2 - out of range", _debugName, mapGridPosition _targetPos]] remoteExec ["systemChat", 0, false];
				};
			};
		} else {
			// #region agent log - Artillery Fire Failed - No Ammo
			private _noAmmoLogData = createHashMapFromArray [
				["sessionId", "debug-session"],
				["runId", "artillery-fire-debug"],
				["hypothesisId", "ARTILLERY_BUG"],
				["location", "fn_V2aiArtillery.sqf:49"],
				["message", "Artillery has no ammo"],
				["data", createHashMapFromArray [
					["artilleryUnit", _arti],
					["artilleryType", typeOf _arti],
					["artilleryAmmo", getArtilleryAmmo _arti]
				]],
				["timestamp", time]
			];
			diag_log (str _noAmmoLogData);
			// #endregion
		};
	};
};

// Helper function to get targets known by spotters
_fn_getSpotterTargets = {
	params ["_spotterGroups", "_enemySide", "_maxRange"];

	private _targets = [];

	{
		private _group = _x;
		{
			if (alive _x && side _x != _enemySide) then {
				// Get targets known by this spotter
				private _knownTargets = _x nearTargets _maxRange;

				{
					private _targetInfo = _x;
					private _targetPos = _targetInfo select 0;
					private _targetSide = _targetInfo select 2;
					private _targetType = _targetInfo select 3;

					// Only add enemy targets
					if (_targetSide == _enemySide) then {
						_targets pushBack _targetPos;
					};
				} forEach _knownTargets;
			};
		} forEach units _group;
	} forEach _spotterGroups;

	_targets
};

// Main Loop
while {true} do
{
	// Short interval for intense artillery war (45-75 seconds)
	sleep (45 + random 30);

	if (count allPlayers > 0) then {
		// Define friendly units arrays for artillery safety checks
		private _unitsW = allUnits select {alive _x && side _x == sideW};
		private _unitsE = allUnits select {alive _x && side _x == sideE};

		// #region agent log - Artillery Loop Start
		private _artilleryLoopLogData = createHashMapFromArray [
			["sessionId", "debug-session"],
			["runId", "artillery-crash-fix"],
			["hypothesisId", "ARTILLERY_CRASH"],
			["location", "fn_V2aiArtillery.sqf:213"],
			["message", "Artillery loop iteration with defined variables"],
			["data", createHashMapFromArray [
				["unitsW_count", count _unitsW],
				["unitsE_count", count _unitsE],
				["spotterGroupsW_count", count _spotterGroupsW],
				["spotterGroupsE_count", count _spotterGroupsE],
				["objArtiW_alive", alive objArtiW],
				["objArtiE_alive", alive objArtiE],
				["objMortW_alive", alive objMortW],
				["objMortE_alive", alive objMortE]
			]],
			["timestamp", time]
		];
		diag_log (str _artilleryLoopLogData);
		// #endregion
		// Get spotter groups (you'll need to define these in mission)
		// Example: _spotterGroupsW = [grpSpotterW1, grpSpotterW2];
		private _spotterGroupsW = missionNamespace getVariable ["V2_spotterGroupsW", []];
		private _spotterGroupsE = missionNamespace getVariable ["V2_spotterGroupsE", []];

		// Alternative: use all AI groups as potential spotters (less realistic but easier)
		// private _spotterGroupsW = allGroups select {side _x == sideW && count units _x > 0};
		// private _spotterGroupsE = allGroups select {side _x == sideE && count units _x > 0};

		// --- WEST ARTILLERY ---
		if (alive objArtiW || alive objMortW) then {
			// Potential Targets for West (East Units/Objs)
			_targetsE = [];

			// 1. Static Objectives (always known - no spotter needed)
			if (alive objAAE) then {_targetsE pushBack (getPos objAAE);};
			if (getMarkerColor resCE != "") then {_targetsE pushBack posCas;};
			if (secBE1 && getMarkerColor resFobE != "") then {_targetsE pushBack posBaseE1;};
			if (secBE2 && getMarkerColor resBaseE != "") then {_targetsE pushBack posBaseE2;};

			// 2. Dynamic Targets - ONLY what spotters can see
			if (count _spotterGroupsW > 0) then {
				private _dynamicTargets = [_spotterGroupsW, sideE, 1500] call _fn_getSpotterTargets; // 1.5km spotting range

				// Filter for vehicles and groups (spotters report these specifically)
				{
					private _targetPos = _x;
					private _nearUnits = _targetPos nearEntities [["Tank", "Wheeled_APC_F", "Tracked_APC", "Car", "Man"], 50];

					{
						private _unit = _x;
						if (alive _unit && side _unit == sideE) then {
							private _isVeh = (_unit isKindOf "Tank" || _unit isKindOf "Wheeled_APC_F" || _unit isKindOf "Tracked_APC" || _unit isKindOf "Car");
							private _isGroup = ((count units group _unit) >= 3);

							if (_isVeh || _isGroup) then {
								_targetsE pushBack _targetPos;

								// Add spotting error (±30m for realism)
								if (random 1 < 0.7) then { // 70% chance of error
									private _errorPos = _targetPos vectorAdd [random 60 - 30, random 60 - 30, 0];
									_targetsE pushBack _errorPos;
								};
							};
						};
					} forEach _nearUnits;
				} forEach _dynamicTargets;
			};
			
			// 3. Harassment (Random spots near active sector if no other targets)
			if (count _targetsE == 0) then {
				// Logic to find active sector center could be added here, for now fallback to known enemy positions
			};

			// Fire Howitzer (Long Range > 1000m, 1-2 rounds)
			[objArtiW, _targetsE, 1000, _unitsW, "West Howitzer", [1, 2]] call _fnc_fireArti;
			
			// Fire Mortar (Short Range > 100m, 2-4 rounds)
			[objMortW, _targetsE, 100, _unitsW, "West Mortar", [2, 4]] call _fnc_fireArti;
		};

		// INTEGRATION: AI FPV Drone Support for WEST
		if (count _targetsE > 0 && count _spotterGroupsW > 0) then {
			// Find AI groups that can call FPV drones (Ukraine 2025 faction)
			private _fpvGroups = allGroups select {
				side _x == sideW &&
				count units _x >= 3 &&
				alive leader _x &&
				factionW == "Ukraine 2025" &&
				getMarkerColor resFobW != ""
			};

			if (count _fpvGroups > 0) then {
				// Select random AI group to potentially call FPV drone
				private _selectedGroup = selectRandom _fpvGroups;
				private _fpvTargets = [_spotterGroupsW, sideE, 1000] call _fn_getSpotterTargets;

				if (count _fpvTargets > 0) then {
					[_selectedGroup, _fpvTargets] call wrm_fnc_V2aiFPVLogic;
				};
			};
		};

		// --- EAST ARTILLERY ---
		if (alive objArtiE || alive objMortE) then {
			// Potential Targets for East (West Units/Objs)
			_targetsW = [];

			// 1. Static Objectives (always known - no spotter needed)
			if (alive objAAW) then {_targetsW pushBack (getPos objAAW);};
			if (getMarkerColor resCW != "") then {_targetsW pushBack posCas;};
			if (secBW1 && getMarkerColor resFobW != "") then {_targetsW pushBack posBaseW1;};
			if (secBW2 && getMarkerColor resBaseW != "") then {_targetsW pushBack posBaseW2;};

			// 2. Dynamic Targets - ONLY what spotters can see
			if (count _spotterGroupsE > 0) then {
				private _dynamicTargets = [_spotterGroupsE, sideW, 1500] call _fn_getSpotterTargets; // 1.5km spotting range

				// Filter for vehicles and groups (spotters report these specifically)
				{
					private _targetPos = _x;
					private _nearUnits = _targetPos nearEntities [["Tank", "Wheeled_APC_F", "Tracked_APC", "Car", "Man"], 50];

					{
						private _unit = _x;
						if (alive _unit && side _unit == sideW) then {
							private _isVeh = (_unit isKindOf "Tank" || _unit isKindOf "Wheeled_APC_F" || _unit isKindOf "Tracked_APC" || _unit isKindOf "Car");
							private _isGroup = ((count units group _unit) >= 3);

							if (_isVeh || _isGroup) then {
								_targetsW pushBack _targetPos;

								// Add spotting error (±30m for realism)
								if (random 1 < 0.7) then { // 70% chance of error
									private _errorPos = _targetPos vectorAdd [random 60 - 30, random 60 - 30, 0];
									_targetsW pushBack _errorPos;
								};
							};
						};
					} forEach _nearUnits;
				} forEach _dynamicTargets;
			};

			// Fire Howitzer (Long Range > 1000m, 1-2 rounds)
			[objArtiE, _targetsW, 1000, _unitsE, "East Howitzer", [1, 2]] call _fnc_fireArti;
			
			// Fire Mortar (Short Range > 100m, 2-4 rounds)
			[objMortE, _targetsW, 100, _unitsE, "East Mortar", [2, 4]] call _fnc_fireArti;
		};

		// INTEGRATION: AI FPV Drone Support for EAST
		if (count _targetsW > 0 && count _spotterGroupsE > 0) then {
			// Find AI groups that can call FPV drones (Russia 2025 faction)
			private _fpvGroups = allGroups select {
				side _x == sideE &&
				count units _x >= 3 &&
				alive leader _x &&
				factionE == "Russia 2025" &&
				getMarkerColor resFobE != ""
			};

			if (count _fpvGroups > 0) then {
				// Select random AI group to potentially call FPV drone
				private _selectedGroup = selectRandom _fpvGroups;
				private _fpvTargets = [_spotterGroupsE, sideW, 1000] call _fn_getSpotterTargets;

				if (count _fpvTargets > 0) then {
					[_selectedGroup, _fpvTargets] call wrm_fnc_V2aiFPVLogic;
				};
			};
		};
	};
};
