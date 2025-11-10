/*
Author: IvosH (Modified by AI Assistant)

Description:
	Server-side UAV/UGV creation and management
	Handles actual vehicle creation, crew assignment, and event handlers

Parameter(s):
	0: NUMBER type of the UAV/UGV (0=UAV, 1=UGV)
	1: SIDE player side
	2: STRING player UID
	3: ARRAY spawn position [x,y,z]

Returns:
	OBJECT created UAV/UGV or objNull on failure

Dependencies:
	fn_V2coolDown.sqf

Execution:
	[_typ, _sde, _playerUID, _spawnPos] call wrm_fnc_V2uavRequest_srv
*/

params ["_typ","_sde","_playerUID","_spawnPos"];

private _result = objNull;

if(DBG)then{diag_log format ["[UAV_CREATION] Starting UAV/UGV creation - Type: %1, Side: %2, UID: %3", _typ, _sde, _playerUID]};

// Validate parameters
if (isNil "_typ" || isNil "_sde" || isNil "_playerUID" || isNil "_spawnPos") exitWith {
	if(DBG)then{diag_log "[UAV_CREATION] Failed - invalid parameters"};
	["[UAV SERVER] Invalid parameters provided"] remoteExec ["systemChat", 0, false];
	objNull
};

//UAV
if(_typ==0)exitWith
{
	// Determine if using per-squad system
	private _usePerSquad = false;
	if (modA == "RHS") then {
		if (_sde == sideW && factionW == "Ukraine 2025") then {_usePerSquad = true;};
		if (_sde == sideE && factionE == "Russia 2025") then {_usePerSquad = true;};
	};

	call
	{
		if(_sde==sideW)exitWith
		{
			if (_usePerSquad) then {
				//PER-SQUAD SYSTEM (Ukraine 2025)
				private _cooldownType = 11;
				private _uavsArray = uavsW;
				private _uavSquadArray = uavSquadW;
				private _uavGlobalVar = "uavW"; // Not used in per-squad, but for compatibility

				// Find player entry in array
				private _index = -1;
				{
					if ((_x select 0) == _playerUID) exitWith {_index = _forEachIndex;};
				} forEach _uavSquadArray;

				// Validate UAV array
				if (count _uavsArray == 0) exitWith {
					["[UAV SERVER] uavsW array is empty"] remoteExec ["systemChat", 0, false];
				};

				// Create UAV
				private _uavClass = selectRandom _uavsArray;
				private _uav = createVehicle [_uavClass, _spawnPos, [], 0, "FLY"];

				if (isNull _uav) exitWith {
					["[UAV SERVER] Failed to create UAV"] remoteExec ["systemChat", 0, false];
				};

				// Create crew
				createVehicleCrew _uav;

				if (isNull driver _uav) exitWith {
					deleteVehicle _uav;
					["[UAV SERVER] Failed to create UAV crew"] remoteExec ["systemChat", 0, false];
				};

				// Set UAV metadata
				_uav setVariable ["wrm_uav_cooldownType", _cooldownType, true];
				_uav setVariable ["wrm_uav_playerUID", _playerUID, true];
				_uav setVariable ["wrm_uav_side", _sde, true];

				// Add to squad array or update existing
				if (_index >= 0) then {
					_uavSquadArray set [_index, [_playerUID, _uav, 0]];
				} else {
					_uavSquadArray pushBack [_playerUID, _uav, 0];
				};
				publicvariable "uavSquadW";

				// Set movement and group ownership
				(group driver _uav) move posCenter;

				// Add MPKilled event handler
				_uav addMPEventHandler ["MPKilled", {
					params ["_uav"];
					private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
					private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
					private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

					if (_cooldownType > 0 && _playerUID != "") then {
						[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
					};
				}];

				// Add to curator
				[z1,[[_uav],true]] remoteExec ["addCuratorEditableObjects", 2, false];

				[11] remoteExec ["wrm_fnc_V2hints", 0, false];
				["[UAV SERVER] Ukraine 2025 drone created"] remoteExec ["systemChat", 0, false];

				_result = _uav;

			} else {
				//ORIGINAL SYSTEM (A3 modas)
				private _cooldownType = 5;
				private _uavsArray = uavsW;

				// Validate UAV array
				if (count _uavsArray == 0) exitWith {
					["[UAV SERVER] uavsW array is empty"] remoteExec ["systemChat", 0, false];
				};

				// Create UAV
				private _uavClass = selectRandom _uavsArray;
				uavW = createVehicle [_uavClass, _spawnPos, [], 0, "FLY"];

				if (isNull uavW) exitWith {
					["[UAV SERVER] Failed to create UAV"] remoteExec ["systemChat", 0, false];
				};

				// Create crew
				createVehicleCrew uavW;

				if (isNull driver uavW) exitWith {
					deleteVehicle uavW;
					uavW = objNull;
					["[UAV SERVER] Failed to create UAV crew"] remoteExec ["systemChat", 0, false];
				};

				// Set UAV metadata
				uavW setVariable ["wrm_uav_cooldownType", _cooldownType, true];
				uavW setVariable ["wrm_uav_playerUID", _playerUID, true];
				uavW setVariable ["wrm_uav_side", _sde, true];

				publicvariable "uavW";
				(group driver uavW) move posCenter;

				// Add MPKilled event handler
				uavW addMPEventHandler ["MPKilled", {
					params ["_uav"];
					private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
					private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
					private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

					if (_cooldownType > 0 && _playerUID != "") then {
						[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
					};
				}];

				[5] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[uavW],true]] remoteExec ["addCuratorEditableObjects", 2, false];

				_result = uavW;
			};
		};

		if(_sde==sideE)exitWith
		{
			if (_usePerSquad) then {
				//PER-SQUAD SYSTEM (Russia 2025)
				private _cooldownType = 12;
				private _uavsArray = uavsE;
				private _uavSquadArray = uavSquadE;

				// Find player entry in array
				private _index = -1;
				{
					if ((_x select 0) == _playerUID) exitWith {_index = _forEachIndex;};
				} forEach _uavSquadArray;

				// Validate UAV array
				if (count _uavsArray == 0) exitWith {
					["[UAV SERVER] uavsE array is empty"] remoteExec ["systemChat", 0, false];
				};

				// Create UAV
				private _uavClass = selectRandom _uavsArray;
				private _uav = createVehicle [_uavClass, _spawnPos, [], 0, "FLY"];

				if (isNull _uav) exitWith {
					["[UAV SERVER] Failed to create UAV"] remoteExec ["systemChat", 0, false];
				};

				// Create crew
				createVehicleCrew _uav;

				// For FPV drones, manual control via UAV terminal
				systemChat "[UAV SERVER] FPV drone deployed - connect manually via UAV terminal to control";

				if (isNull driver _uav) exitWith {
					deleteVehicle _uav;
					["[UAV SERVER] Failed to create UAV crew"] remoteExec ["systemChat", 0, false];
				};

				// Set UAV metadata
				_uav setVariable ["wrm_uav_cooldownType", _cooldownType, true];
				_uav setVariable ["wrm_uav_playerUID", _playerUID, true];
				_uav setVariable ["wrm_uav_side", _sde, true];

				// Add to squad array or update existing
				if (_index >= 0) then {
					_uavSquadArray set [_index, [_playerUID, _uav, 0]];
				} else {
					_uavSquadArray pushBack [_playerUID, _uav, 0];
				};
				publicvariable "uavSquadE";

				// Set movement and group ownership
				(group driver _uav) move posCenter;

				// Add MPKilled event handler
				_uav addMPEventHandler ["MPKilled", {
					params ["_uav"];
					private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
					private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
					private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

					if (_cooldownType > 0 && _playerUID != "") then {
						[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
					};
				}];

				[12] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[_uav],true]] remoteExec ["addCuratorEditableObjects", 2, false];

				["[UAV SERVER] Russia 2025 drone created"] remoteExec ["systemChat", 0, false];

				_result = _uav;

			} else {
				//ORIGINAL SYSTEM (A3 modas)
				private _cooldownType = 6;
				private _uavsArray = uavsE;

				// Validate UAV array
				if (count _uavsArray == 0) exitWith {
					["[UAV SERVER] uavsE array is empty"] remoteExec ["systemChat", 0, false];
				};

				// Create UAV
				private _uavClass = selectRandom _uavsArray;
				uavE = createVehicle [_uavClass, _spawnPos, [], 0, "FLY"];

				if (isNull uavE) exitWith {
					["[UAV SERVER] Failed to create UAV"] remoteExec ["systemChat", 0, false];
				};

				// Create crew
				createVehicleCrew uavE;

				if (isNull driver uavE) exitWith {
					deleteVehicle uavE;
					uavE = objNull;
					["[UAV SERVER] Failed to create UAV crew"] remoteExec ["systemChat", 0, false];
				};

				// Set UAV metadata
				uavE setVariable ["wrm_uav_cooldownType", _cooldownType, true];
				uavE setVariable ["wrm_uav_playerUID", _playerUID, true];
				uavE setVariable ["wrm_uav_side", _sde, true];

				publicvariable "uavE";
				(group driver uavE) move posCenter;

				// Add MPKilled event handler
				uavE addMPEventHandler ["MPKilled", {
					params ["_uav"];
					private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
					private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
					private _side = _uav getVariable ["wrm_uav_side", sideUnknown];

					if (_cooldownType > 0 && _playerUID != "") then {
						[_cooldownType, _playerUID, _side] spawn wrm_fnc_V2coolDown;
					};
				}];

				[6] remoteExec ["wrm_fnc_V2hints", 0, false];
				sleep 1;
				[z1,[[uavE],true]] remoteExec ["addCuratorEditableObjects", 2, false];

				_result = uavE;
			};
		};
	};

	_result
};

//UGV
if(_typ==1)exitWith
{
	call
	{
		if(_sde==sideW)exitWith
		{
			private _ugvsArray = ugvsW;

			// Validate UGV array
			if (count _ugvsArray == 0) exitWith {
				["[UGV SERVER] ugvsW array is empty"] remoteExec ["systemChat", 0, false];
				objNull
			};

			private _ugvClass = selectRandom _ugvsArray;
			private _spawnPosUGV = _spawnPos findEmptyPosition [0, 50, _ugvClass];
			if (count _spawnPosUGV == 0) then {_spawnPosUGV = _spawnPos;};

			ugvW = createVehicle [_ugvClass, [_spawnPosUGV select 0, _spawnPosUGV select 1, 50], [], 0, "NONE"];
			createVehicleCrew ugvW;
			[ugvW] call wrm_fnc_parachute;
			publicvariable "ugvW";

			ugvW addMPEventHandler ["MPKilled",{[7] spawn wrm_fnc_V2coolDown;}];
			[7] remoteExec ["wrm_fnc_V2hints", 0, false];
			sleep 1;
			[z1,[[ugvW],true]] remoteExec ["addCuratorEditableObjects", 2, false];

			_result = ugvW;
		};

		if(_sde==sideE)exitWith
		{
			private _ugvsArray = ugvsE;

			// Validate UGV array
			if (count _ugvsArray == 0) exitWith {
				["[UGV SERVER] ugvsE array is empty"] remoteExec ["systemChat", 0, false];
				objNull
			};

			private _ugvClass = selectRandom _ugvsArray;
			private _spawnPosUGV = _spawnPos findEmptyPosition [0, 50, _ugvClass];
			if (count _spawnPosUGV == 0) then {_spawnPosUGV = _spawnPos;};

			ugvE = createVehicle [_ugvClass, [_spawnPosUGV select 0, _spawnPosUGV select 1, 50], [], 0, "NONE"];
			createVehicleCrew ugvE;
			[ugvE] call wrm_fnc_parachute;
			publicvariable "ugvE";

			ugvE addMPEventHandler ["MPKilled",{[8] spawn wrm_fnc_V2coolDown;}];
			[8] remoteExec ["wrm_fnc_V2hints", 0, false];
			sleep 1;
			[z1,[[ugvE],true]] remoteExec ["addCuratorEditableObjects", 2, false];

			_result = ugvE;
		};
	};

	if(DBG)then{diag_log format ["[UAV_CREATION] Completed - Result: %1", _result]};
	_result
};

_result
