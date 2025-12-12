/*
	Author: IvosH, fixed by GrybasTV
	
	Description:
		Add actions to the flags. Teleports between flags.
		Rewritten to directly assign actions to flags instead of complex array subtraction.
	
	Parameter(s):
		0: OBJECT, flgBW1 (West Transport)
		1: OBJECT, flgBW2 (West Armor)
		2: OBJECT, flgJetW (West Air - optional)
		3: OBJECT, flgBE1 (East Transport)
		4: OBJECT, flgBE2 (East Armor)
		5: OBJECT, flgJetE (East Air - optional)
		6: VARIABLE, missType
*/

if (!hasInterface) exitWith {}; //run on the players only

// Laukti kol player side == sideW arba sideE su retry logika
private _retryCount = 0;
private _maxRetries = 120; // 60 sekundžių (120 * 0.5s)
private _sideInitialized = false;

while {!_sideInitialized && _retryCount < _maxRetries} do {
    if ((side player == sideW) || (side player == sideE)) then {
        _sideInitialized = true;
    } else {
        sleep 0.5;
        _retryCount = _retryCount + 1;

        // Loginti kas 10 sekundžių
        if (_retryCount % 20 == 0) then {
            private _elapsedTime = _retryCount * 0.5;
            systemChat format ["Waiting for player side initialization... (%1s elapsed)", _elapsedTime];
        };
    };
};

if (!_sideInitialized) exitWith {
    ["ERROR: Player side initialization failed after 60 seconds in flagActions - mission may be broken"] remoteExec ["systemChat", player, false];
    hint parseText "ERROR<br/>Player side initialization failed.<br/>Please reconnect or contact admin.";
};

private _flgBW1 = _this param [0, objNull];
private _flgBW2 = _this param [1, objNull];
private _flgJetW = _this param [2, objNull];
private _flgBE1 = _this param [3, objNull];
private _flgBE2 = _this param [4, objNull];
private _flgJetE = _this param [5, objNull];
private _missType = _this param [6, 1];

// Titles
private _nameTr = "Teleport to the Transport base";
private _nameAr = "Teleport to the Armors base";
private _nameAir = "Teleport to the Air base";

// Adapt names for Infantry mode
if(_missType < 2) then {
	_nameAr = "Teleport to the Helicopter base";
	// Infantry check logic from original
	if(((side player == sideW)&&(count HeliTrW==0)) || ((side player == sideE)&&(count HeliTrE==0))) then {
		_nameAr = "Teleport to the Infantry base";
	};
};

// Teleport function (Squad Leader moves group, regular moves self)
private _fnc_teleport = {
	params ["_targetFlag"];

	// #region agent log - Flag Teleport Bug Investigation
	private _currentPos = getPos player;
	private _targetPos = getPos _targetFlag;
	private _logData = [
		sessionId: "debug-session",
		runId: "flag-teleport-bug",
		hypothesisId: "FLAG_BUG",
		location: "fn_V2flagActions.sqf:68",
		message: "Flag teleport initiated",
		data: [
			playerPos: _currentPos,
			targetPos: _targetPos,
			targetFlag: _targetFlag,
			playerSide: side player,
			isLeader: player == leader player,
			distance: _currentPos distance _targetPos
		],
		timestamp: time
	];
	diag_log (str _logData);
	// #endregion

	// DEBUG: Identify target base type by checking global flag variables
	private _flagName = "UNKNOWN FLAG";

	// Check West flags
	if (!isNil "flgBW1" && {_targetFlag == flgBW1}) then {_flagName = "WEST Transport Base";};
	if (!isNil "flgBW2" && {_targetFlag == flgBW2}) then {_flagName = "WEST Armor Base";};
	if (!isNil "flgJetW" && {_targetFlag == flgJetW}) then {_flagName = "WEST Air Base";};

	// Check East flags
	if (!isNil "flgBE1" && {_targetFlag == flgBE1}) then {_flagName = "EAST Transport Base";};
	if (!isNil "flgBE2" && {_targetFlag == flgBE2}) then {_flagName = "EAST Armor Base";};
	if (!isNil "flgJetE" && {_targetFlag == flgJetE}) then {_flagName = "EAST Air Base";};

	// DEBUG: Log teleport attempt with clear messaging
	systemChat format ["[TELEPORT] Attempting to teleport to: %1", _flagName];
	systemChat format ["[TELEPORT] Current position: %1", mapGridPosition _currentPos];
	systemChat format ["[TELEPORT] Target position: %1 (distance: %2m)",
		mapGridPosition _targetPos,
		round (_currentPos distance _targetPos)
	];

	if(player == leader player) then {
		private _grp = [player];
		{if(((_x distance player)<75)&&(!isPlayer _x))then{_grp pushBackUnique _x;};} forEach units group player;

		systemChat format ["[TELEPORT] Moving squad leader + %1 AI units to %2", count _grp - 1, _flagName];

		{_x setPos (_targetFlag getRelPos [random [3,6,9], random [135,180,225]]);} forEach _grp;
	} else {
		player setPos (_targetFlag getRelPos [3,180]);
		systemChat format ["[TELEPORT] Single player teleported to %1", _flagName];
	};

	// DEBUG: Verify final position after short delay
	[] spawn {
		sleep 0.5;
		private _finalPos = getPos player;

		// #region agent log - Flag Teleport Result
		private _resultLogData = [
			sessionId: "debug-session",
			runId: "flag-teleport-bug",
			hypothesisId: "FLAG_BUG",
			location: "fn_V2flagActions.sqf:107",
			message: "Flag teleport completed",
			data: [
				finalPos: _finalPos,
				distanceFromTarget: _finalPos distance _targetPos,
				expectedTarget: _flagName,
				actuallyAtSameBase: (_finalPos distance _currentPos) < 50
			],
			timestamp: time
		];
		diag_log (str _resultLogData);
		// #endregion

		systemChat format ["[TELEPORT] ✓ Arrived at: %1", mapGridPosition _finalPos];
		if ((_finalPos distance _currentPos) < 50) then {
			systemChat format ["[TELEPORT] ⚠️ WARNING: Still at same location! Distance moved: %1m", round (_finalPos distance _currentPos)];
		};
	};
};

// --- WEST ---
if (side player == sideW) then {
	// 1. Transport Base Flag (flgBW1) -> Can go to Armor & Air
	if (!isNull _flgBW1) then {
		// To Armor
		if (!isNull _flgBW2) then {
			_flgBW1 addAction [_nameAr, _fnc_teleport, _flgBW2, 6, true, true, "", "", 5];
		};
		// To Air
		if (!isNull _flgJetW) then {
			_flgBW1 addAction [_nameAir, _fnc_teleport, _flgJetW, 5, true, true, "", "", 5];
		};
	};

	// 2. Armor Base Flag (flgBW2) -> Can go to Transport & Air
	if (!isNull _flgBW2) then {
		// To Transport (original had condition on this action)
		if (!isNull _flgBW1) then {
			_flgBW2 addAction [_nameTr, _fnc_teleport, _flgBW1, 5.5, true, true, "", "(flgDel==0||sideA == sideW)", 5];
		};
		// To Air
		if (!isNull _flgJetW) then {
			_flgBW2 addAction [_nameAir, _fnc_teleport, _flgJetW, 5, true, true, "", "", 5];
		};
	};

	// 3. Air Base Flag (flgJetW) -> Can go to Transport & Armor
	if (!isNull _flgJetW) then {
		// To Transport
		if (!isNull _flgBW1) then {
			_flgJetW addAction [_nameTr, _fnc_teleport, _flgBW1, 6, true, true, "", "", 5];
		};
		// To Armor
		if (!isNull _flgBW2) then {
			_flgJetW addAction [_nameAr, _fnc_teleport, _flgBW2, 5.5, true, true, "", "", 5];
		};
	};
};

// --- EAST ---
if (side player == sideE) then {
	// 1. Transport Base Flag (flgBE1) -> Can go to Armor & Air
	if (!isNull _flgBE1) then {
		// To Armor
		if (!isNull _flgBE2) then {
			_flgBE1 addAction [_nameAr, _fnc_teleport, _flgBE2, 6, true, true, "", "", 5];
		};
		// To Air
		if (!isNull _flgJetE) then {
			_flgBE1 addAction [_nameAir, _fnc_teleport, _flgJetE, 5, true, true, "", "", 5];
		};
	};

	// 2. Armor Base Flag (flgBE2) -> Can go to Transport & Air
	if (!isNull _flgBE2) then {
		// To Transport (original had condition on this action)
		if (!isNull _flgBE1) then {
			_flgBE2 addAction [_nameTr, _fnc_teleport, _flgBE1, 5.5, true, true, "", "(flgDel==0||sideA == sideE)", 5];
		};
		// To Air
		if (!isNull _flgJetE) then {
			_flgBE2 addAction [_nameAir, _fnc_teleport, _flgJetE, 5, true, true, "", "", 5];
		};
	};

	// 3. Air Base Flag (flgJetE) -> Can go to Transport & Armor
	if (!isNull _flgJetE) then {
		// To Transport
		if (!isNull _flgBE1) then {
			_flgJetE addAction [_nameTr, _fnc_teleport, _flgBE1, 6, true, true, "", "", 5];
		};
		// To Armor
		if (!isNull _flgBE2) then {
			_flgJetE addAction [_nameAr, _fnc_teleport, _flgBE2, 5.5, true, true, "", "", 5];
		};
	};
};