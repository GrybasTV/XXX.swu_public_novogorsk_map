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
		
		if (_ammoType != "") then {
			_rounds = _roundCount select 0;
			if (count _roundCount > 1) then {
				_rounds = (_roundCount select 0) + floor(random ((_roundCount select 1) - (_roundCount select 0) + 1));
			};
			
			_arti doArtilleryFire [_targetPos, _ammoType, _rounds];
			if (DBG) then {
				[format ["%1 firing %2 rounds at grid %3", _debugName, _rounds, mapGridPosition _targetPos]] remoteExec ["systemChat", 0, false];
			};
		};
	};
};

// Main Loop
while {true} do 
{
	// Short interval for intense artillery war (45-75 seconds)
	sleep (45 + random 30);

	if (count allPlayers > 0) then {
		// Optimize: Get units once
		_allUnits = allUnits;
		_unitsW = [];
		_unitsE = [];
		
		{
			if (alive _x) then {
				if (side _x == sideW) then {_unitsW pushBack _x;};
				if (side _x == sideE) then {_unitsE pushBack _x;};
			};
		} forEach _allUnits;

		// --- WEST ARTILLERY ---
		if (alive objArtiW || alive objMortW) then {
			// Potential Targets for West (East Units/Objs)
			_targetsE = [];
			
			// 1. Static Objectives
			if (alive objAAE) then {_targetsE pushBack (getPos objAAE);};
			if (getMarkerColor resCE != "") then {_targetsE pushBack posCas;};
			if (secBE1 && getMarkerColor resFobE != "") then {_targetsE pushBack posBaseE1;};
			if (secBE2 && getMarkerColor resBaseE != "") then {_targetsE pushBack posBaseE2;};
			
			// 2. Dynamic Targets (Vehicles & Groups)
			{
				_unit = _x;
				_isVeh = (_unit isKindOf "Tank" || _unit isKindOf "Wheeled_APC_F" || _unit isKindOf "Tracked_APC" || _unit isKindOf "Car");
				_isGroup = ((count units group _unit) >= 3); // Target groups of 3+
				
				if (_isVeh || _isGroup) then {
					_targetsE pushBack (getPos _unit);
				};
			} forEach _unitsE;
			
			// 3. Harassment (Random spots near active sector if no other targets)
			if (count _targetsE == 0) then {
				// Logic to find active sector center could be added here, for now fallback to known enemy positions
			};

			// Fire Howitzer (Long Range > 1000m, 1-2 rounds)
			[objArtiW, _targetsE, 1000, _unitsW, "West Howitzer", [1, 2]] call _fnc_fireArti;
			
			// Fire Mortar (Short Range > 100m, 2-4 rounds)
			[objMortW, _targetsE, 100, _unitsW, "West Mortar", [2, 4]] call _fnc_fireArti;
		};

		// --- EAST ARTILLERY ---
		if (alive objArtiE || alive objMortE) then {
			// Potential Targets for East (West Units/Objs)
			_targetsW = [];
			
			// 1. Static Objectives
			if (alive objAAW) then {_targetsW pushBack (getPos objAAW);};
			if (getMarkerColor resCW != "") then {_targetsW pushBack posCas;};
			if (secBW1 && getMarkerColor resFobW != "") then {_targetsW pushBack posBaseW1;};
			if (secBW2 && getMarkerColor resBaseW != "") then {_targetsW pushBack posBaseW2;};
			
			// 2. Dynamic Targets
			{
				_unit = _x;
				_isVeh = (_unit isKindOf "Tank" || _unit isKindOf "Wheeled_APC_F" || _unit isKindOf "Tracked_APC" || _unit isKindOf "Car");
				_isGroup = ((count units group _unit) >= 3);
				
				if (_isVeh || _isGroup) then {
					_targetsW pushBack (getPos _unit);
				};
			} forEach _unitsW;

			// Fire Howitzer (Long Range > 1000m, 1-2 rounds)
			[objArtiE, _targetsW, 1000, _unitsE, "East Howitzer", [1, 2]] call _fnc_fireArti;
			
			// Fire Mortar (Short Range > 100m, 2-4 rounds)
			[objMortE, _targetsW, 100, _unitsE, "East Mortar", [2, 4]] call _fnc_fireArti;
		};
	};
};
