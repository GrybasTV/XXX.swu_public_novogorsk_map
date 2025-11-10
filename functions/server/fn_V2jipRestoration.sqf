/*
	JIP State Restoration
	Ensures JIP players receive correct mission state
	Handles markers, Zeus objects, support providers, etc.

	Parameters:
		0: OBJECT - Player unit
		1: STRING - Player UID

	Returns:
		Nothing

	Execution:
		[_unit, _uid] call wrm_fnc_V2jipRestoration;
*/

params ["_unit", "_uid"];

if (!isServer) exitWith {};
if (isNull _unit) exitWith {};

if(DBG)then{diag_log format ["[JIP_RESTORATION] Starting state restoration for player: %1 (UID: %2)", name _unit, _uid]};

// Wait a bit for player to fully initialize
sleep 2;

// 1. Restore Zeus curator access if applicable
if (!isNull z1) then {
	private _assignedUnit = getAssignedCuratorUnit z1;
	if (isNull _assignedUnit) then {
		// Zeus is available, but don't auto-assign
		if(DBG)then{diag_log "[JIP_RESTORATION] Zeus curator available for assignment"};
	} else {
		if(DBG)then{diag_log format ["[JIP_RESTORATION] Zeus curator assigned to: %1", name _assignedUnit]};
	};

	// Add player to editable objects if Zeus is active
	if (!isNull _assignedUnit) then {
		z1 addCuratorEditableObjects [[_unit], true];
		if(DBG)then{diag_log format ["[JIP_RESTORATION] Added player to Zeus editable objects: %1", name _unit]};
	};
};

// 2. Sync support providers (should already be handled by V2syncSupportProviders)
// But ensure player gets the current state
if (!isNil "wrm_fnc_V2syncSupportProvidersClient") then {
	[_unit] remoteExec ["wrm_fnc_V2syncSupportProvidersClient", _unit, false];
};

// 3. Restore any mission-critical markers that might be missing
// This is handled by individual systems (sector markers are created when sectors activate)

// 4. Ensure UAV/UGV arrays are properly synced
if (!isNil "uavW" && {alive uavW}) then {
	publicVariable "uavW";
};
if (!isNil "ugvW" && {alive ugvW}) then {
	publicVariable "ugvW";
};
if (!isNil "uavE" && {alive uavE}) then {
	publicVariable "uavE";
};
if (!isNil "ugvE" && {alive ugvE}) then {
	publicVariable "ugvE";
};

// 5. Sync any other critical mission variables that JIP players need
if (!isNil "progress") then {
	publicVariable "progress";
};
if (!isNil "aStart") then {
	publicVariable "aStart";
};

if(DBG)then{diag_log format ["[JIP_RESTORATION] Completed state restoration for player: %1", name _unit]};
