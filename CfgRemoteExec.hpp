/*
    CfgRemoteExec - Remote Execution Whitelist
    Defines allowed remote execution functions to prevent security issues
    and BattlEye false-positives. Required when server has remoteExec restrictions.

    Usage: #include "CfgRemoteExec.hpp" in description.ext
*/

class CfgRemoteExec
{
    // Mode: 0 = disabled, 1 = whitelist, 2 = blacklist
    class Commands
    {
        mode = 1; // Whitelist mode

        // Core Arma 3 functions
        class BIS_fnc_endMission { allowedTargets = 0; }; // All clients
        class BIS_fnc_showMissionStatus { allowedTargets = 0; }; // All clients

        // Support system functions
        class setVariable { allowedTargets = 0; }; // All clients (for support providers)
        class addCuratorEditableObjects { allowedTargets = 2; }; // Server only
        class assignCurator { allowedTargets = 2; }; // Server only (confirmed)
        class unassignCurator { allowedTargets = 2; }; // Server only (confirmed)

        // Marker management
        class deleteMarkerLocal { allowedTargets = 0; }; // All clients
        class createMarker { allowedTargets = 2; }; // Server only
        class deleteMarker { allowedTargets = 2; }; // Server only

        // System chat and hints
        class systemChat { allowedTargets = 0; }; // All clients
        class hint { allowedTargets = 0; }; // All clients
        class hintSilent { allowedTargets = 0; }; // All clients
    };

    class Functions
    {
        mode = 1; // Whitelist mode

        // WRM Mission Functions
        class wrm_fnc_registerCrewEH { allowedTargets = 2; }; // Server only - crew EH registration
        class wrm_fnc_V2syncSupportProvidersClient { allowedTargets = 1; }; // Client only - support sync
        class wrm_fnc_V2hints { allowedTargets = 0; }; // All clients - mission hints
        class wrm_fnc_V2suppMrk { allowedTargets = 2; }; // Server only - supply marker creation
        class wrm_fnc_V2vehMrkW { allowedTargets = 2; }; // Server only - vehicle marker creation
        class wrm_fnc_V2vehMrkE { allowedTargets = 2; }; // Server only - vehicle marker creation
        class wrm_fnc_V2flagActions { allowedTargets = 2; }; // Server only - flag actions
        class wrm_fnc_V2coolDown { allowedTargets = 2; }; // Server only - cooldown management
        class wrm_fnc_V2entityKilled { allowedTargets = 2; }; // Server only - entity killed handler

        // CBA Functions (if CBA is used)
        class CBA_fnc_waitUntilAndExecute { allowedTargets = 2; }; // Server only
        class CBA_fnc_waitAndExecute { allowedTargets = 2; }; // Server only

        // BIS Module Functions
        class BIS_fnc_moduleSector { allowedTargets = 2; }; // Server only
        class BIS_fnc_moduleCAS { allowedTargets = 2; }; // Server only
        class BIS_fnc_moduleCAS_AI { allowedTargets = 2; }; // Server only
    };
};
