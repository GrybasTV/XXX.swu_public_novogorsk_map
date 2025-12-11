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

// TIMEOUT: Laukti kol player side == sideW arba sideE
private _startTime = time;
waitUntil {
    sleep 0.5;
    ((side player == sideW)||(side player == sideE)) || (time - _startTime > 30)
};

if (time - _startTime > 30 && (side player != sideW) && (side player != sideE)) exitWith {
    ["WARNING: Player side timeout in flagActions - exiting"] remoteExec ["systemChat", player, false];
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
	if(player == leader player) then {
		private _grp = [player];
		{if(((_x distance player)<75)&&(!isPlayer _x))then{_grp pushBackUnique _x;};} forEach units group player;
		{_x setPos (_targetFlag getRelPos [random [3,6,9], random [135,180,225]]);} forEach _grp;
	} else {
		player setPos (_targetFlag getRelPos [3,180]);
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
		// To Transport
		if (!isNull _flgBW1) then {
			_flgBW2 addAction [_nameTr, _fnc_teleport, _flgBW1, 6, true, true, "", "", 5];
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
		// To Transport
		if (!isNull _flgBE1) then {
			_flgBE2 addAction [_nameTr, _fnc_teleport, _flgBE1, 6, true, true, "", "", 5];
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