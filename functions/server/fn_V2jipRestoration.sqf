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

// 5. Sync critical mission variables
if (!isNil "progress") then { publicVariable "progress"; };
if (!isNil "aStart") then { publicVariable "aStart"; };
if (!isNil "version") then { publicVariable "version"; };
if (!isNil "missType") then { publicVariable "missType"; };

// 5.5. Force marker state synchronization
// Markers are created dynamically by sector logic, but ensure critical marker data is synced
if (!isNil "uavSquadW") then { publicVariable "uavSquadW"; };
if (!isNil "uavSquadE") then { publicVariable "uavSquadE"; };

// 6. Sync sector markers (ensure they exist for JIP players)
if (!isNil "secBE1" && secBE1) then { publicVariable "secBE1"; };
if (!isNil "secBW1" && secBW1) then { publicVariable "secBW1"; };
if (!isNil "secBE2" && secBE2) then { publicVariable "secBE2"; };
if (!isNil "secBW2" && secBW2) then { publicVariable "secBW2"; };

// 6.5. Ensure AO markers exist for JIP players (support sectors)
if (!isNil "posArti" && count posArti == 3) then {
    // Recreate artillery markers if they don't exist
    if (getMarkerType "mArti" == "") then {
        createMarker ["mArti", posArti];
        "mArti" setMarkerShape "ICON";
        "mArti" setMarkerType "select";
        "mArti" setMarkerText "Artillery";
        "mArti" setMarkerColor "ColorBlack";
        if(DBG)then{diag_log "[JIP_RESTORATION] Recreated artillery marker for JIP player"};
    };
};

if (!isNil "posCas" && count posCas == 3) then {
    // Recreate CAS markers if they don't exist
    if (getMarkerType "mCas" == "") then {
        createMarker ["mCas", posCas];
        "mCas" setMarkerShape "ICON";
        "mCas" setMarkerType "select";
        "mCas" setMarkerText "CAS Tower";
        "mCas" setMarkerColor "ColorBlack";
        if(DBG)then{diag_log "[JIP_RESTORATION] Recreated CAS marker for JIP player"};
    };
};

if (!isNil "posAA" && count posAA == 3) then {
    // Recreate AA markers if they don't exist
    if (getMarkerType "mAA" == "") then {
        createMarker ["mAA", posAA];
        "mAA" setMarkerShape "ICON";
        "mAA" setMarkerType "select";
        "mAA" setMarkerText "Anti Air";
        "mAA" setMarkerColor "ColorBlack";
        if(DBG)then{diag_log "[JIP_RESTORATION] Recreated AA marker for JIP player"};
    };
};

// 7. Sync base positions and other critical location data
if (!isNil "posArti") then { publicVariable "posArti"; };
if (!isNil "posCas") then { publicVariable "posCas"; };
if (!isNil "posAA") then { publicVariable "posAA"; };
if (!isNil "posBaseW1") then { publicVariable "posBaseW1"; };
if (!isNil "posBaseW2") then { publicVariable "posBaseW2"; };
if (!isNil "posBaseE1") then { publicVariable "posBaseE1"; };
if (!isNil "posBaseE2") then { publicVariable "posBaseE2"; };

// 8. Sync faction data
if (!isNil "factionW") then { publicVariable "factionW"; };
if (!isNil "factionE") then { publicVariable "factionE"; };
if (!isNil "nameBW1") then { publicVariable "nameBW1"; };
if (!isNil "nameBW2") then { publicVariable "nameBW2"; };
if (!isNil "nameBE1") then { publicVariable "nameBE1"; };
if (!isNil "nameBE2") then { publicVariable "nameBE2"; };

// 9. Sync timer and respawn settings
if (!isNil "rTime") then { publicVariable "rTime"; };
if (!isNil "arTime") then { publicVariable "arTime"; };

// 10. BIS_fnc_moduleSector automatiškai kuria task'us ir marker'ius su spalvomis
// Nereikia rankinio marker'ių kūrimo - BIS sistema tai padaro automatiškai pagal TaskOwner=3

if (DBG) then {
	diag_log format ["[JIP_RESTORATION] Completed state restoration for player: %1", name _unit];
};
