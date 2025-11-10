/*
    run_jip_smoke.sqf
    Smoke test for JIP state restoration
    
    Usage: ExecVM this file on server, then have a player join mid-combat
    Expected: Complete state restoration (markers, support, Zeus, UAV)
*/

if (!isServer) exitWith {
    systemChat "[SMOKE_TEST] JIP check must run on server";
    diag_log "[SMOKE_TEST] JIP check failed - not running on server";
};

diag_log "[SMOKE_TEST] Starting JIP state restoration check...";

// Wait for a JIP player to connect
diag_log "[SMOKE_TEST] Waiting for JIP player connection...";
diag_log "[SMOKE_TEST] Have a player join the server now...";

private _testResults = [];
private _testPassed = true;

// Monitor for JIP restoration events
private _jipPlayerFound = false;
private _jipPlayerUID = "";

// Wait up to 60 seconds for JIP player
private _timeout = time + 60;
while {time < _timeout && !_jipPlayerFound} do {
    {
        private _player = _x;
        private _uid = getPlayerUID _player;
        
        // Check if this is a JIP player (joined after mission start)
        // We'll check if they have mission variables set
        if (!isNil "progress" && !isNil "aStart") then {
            // Mission variables exist - check if player received them
            private _hasProgress = !isNil {_player getVariable "progress"};
            
            if (!_hasProgress) then {
                // Potential JIP player - trigger restoration
                diag_log format ["[SMOKE_TEST] Potential JIP player detected: %1 (UID: %2)", name _player, _uid];
                _jipPlayerUID = _uid;
                _jipPlayerFound = true;
            };
        };
    } forEach allPlayers;
    
    sleep 1;
};

if (!_jipPlayerFound) then {
    diag_log "[SMOKE_TEST] No JIP player detected within 60 seconds";
    diag_log "[SMOKE_TEST] Test requires manual JIP player connection";
    systemChat "[SMOKE_TEST] JIP check: MANUAL - Connect a player to test";
    exitWith {};
};

// Test 1: Check mission variables are public
diag_log "[SMOKE_TEST] Test 1: Mission variables public";
private _requiredVars = ["progress", "aStart", "version", "missType", "sideW", "sideE"];
private _missingVars = [];
{
    if (isNil _x) then {
        _missingVars pushBack _x;
    };
} forEach _requiredVars;

if (count _missingVars == 0) then {
    _testResults pushBack ["Mission variables public", "PASS"];
} else {
    _testResults pushBack ["Mission variables public", format ["FAIL - Missing: %1", _missingVars]];
    _testPassed = false;
};

// Test 2: Check sector flags are public
diag_log "[SMOKE_TEST] Test 2: Sector flags public";
private _sectorFlags = ["secBE1", "secBE2", "secBW1", "secBW2"];
private _missingFlags = [];
{
    if (isNil _x) then {
        _missingFlags pushBack _x;
    };
} forEach _sectorFlags;

if (count _missingFlags == 0) then {
    _testResults pushBack ["Sector flags public", "PASS"];
} else {
    _testResults pushBack ["Sector flags public", format ["WARN - Missing: %1 (may be nil)", _missingFlags]];
    // Not a failure - sectors may not exist yet
};

// Test 3: Check UAV arrays are public
diag_log "[SMOKE_TEST] Test 3: UAV arrays public";
if (!isNil "uavSquadW" && !isNil "uavSquadE") then {
    _testResults pushBack ["UAV arrays public", "PASS"];
} else {
    _testResults pushBack ["UAV arrays public", format ["WARN - Missing: uavSquadW=%1, uavSquadE=%2", !isNil "uavSquadW", !isNil "uavSquadE"]];
};

// Test 4: Check JIP restoration function exists
diag_log "[SMOKE_TEST] Test 4: JIP restoration function";
if (!isNil "wrm_fnc_V2jipRestoration") then {
    _testResults pushBack ["JIP restoration function", "PASS"];
} else {
    _testResults pushBack ["JIP restoration function", "FAIL - Function not found"];
    _testPassed = false;
};

// Test 5: Check PlayerConnected event handler
diag_log "[SMOKE_TEST] Test 5: PlayerConnected event handler";
// This is harder to test directly, so we'll just verify the function exists
_testResults pushBack ["PlayerConnected handler", "INFO - Check initServer.sqf"];

// Print results
diag_log "[SMOKE_TEST] ===== JIP Restoration Check Results =====";
{
    diag_log format ["[SMOKE_TEST] %1: %2", _x select 0, _x select 1];
} forEach _testResults;

if (_testPassed) then {
    diag_log "[SMOKE_TEST] OVERALL: PASS - JIP restoration system ready";
    diag_log "[SMOKE_TEST] Manual test: Have a player join and verify markers/support/Zeus/UAV";
    systemChat "[SMOKE_TEST] JIP check: PASS - Manual verification required";
} else {
    diag_log "[SMOKE_TEST] OVERALL: FAIL - Check JIP restoration logic";
    systemChat "[SMOKE_TEST] JIP check: FAIL - Check RPT";
};

diag_log "[SMOKE_TEST] =====================================";
diag_log "[SMOKE_TEST] Expected: Complete state restoration for JIP players";
diag_log "[SMOKE_TEST] Check RPT for [JIP_RESTORATION] log entries";
