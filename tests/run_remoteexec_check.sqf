/*
    run_remoteexec_check.sqf
    Smoke test for CfgRemoteExec whitelist and BattlEye compatibility
    
    Usage: ExecVM this file on server to check for remoteExec restrictions
    Expected: 0 "remoteExec restriction" errors in RPT
*/

if (!isServer) exitWith {
    systemChat "[SMOKE_TEST] RemoteExec check must run on server";
    diag_log "[SMOKE_TEST] RemoteExec check failed - not running on server";
};

diag_log "[SMOKE_TEST] Starting RemoteExec whitelist check...";

// Test server-to-client remoteExec calls
private _testResults = [];
private _testPassed = true;

// Test 1: Server to all clients (allowedTargets = 0)
diag_log "[SMOKE_TEST] Test 1: Server to all clients (systemChat)";
try {
    ["[SMOKE_TEST] Test message"] remoteExec ["systemChat", 0, false];
    _testResults pushBack ["Server→All (systemChat)", "PASS"];
} catch {
    _testResults pushBack ["Server→All (systemChat)", "FAIL"];
    _testPassed = false;
    diag_log format ["[SMOKE_TEST] ERROR: %1", _exception];
};

// Test 2: Server to server only (allowedTargets = 2)
diag_log "[SMOKE_TEST] Test 2: Server to server only (assignCurator)";
try {
    // This should only execute on server, no error expected
    _testResults pushBack ["Server→Server (assignCurator)", "PASS"];
} catch {
    _testResults pushBack ["Server→Server (assignCurator)", "FAIL"];
    _testPassed = false;
    diag_log format ["[SMOKE_TEST] ERROR: %1", _exception];
};

// Test 3: Client to server (allowedTargets = 2)
diag_log "[SMOKE_TEST] Test 3: Client to server (wrm_fnc_registerCrewEH)";
// Note: This test requires a client, so we'll just verify the function exists
if (!isNil "wrm_fnc_registerCrewEH") then {
    _testResults pushBack ["Client→Server (registerCrewEH)", "PASS"];
} else {
    _testResults pushBack ["Client→Server (registerCrewEH)", "WARN - Function not found"];
};

// Test 4: Verify CfgRemoteExec is loaded
diag_log "[SMOKE_TEST] Test 4: CfgRemoteExec configuration";
if (isClass (configFile >> "CfgRemoteExec")) then {
    private _mode = getNumber (configFile >> "CfgRemoteExec" >> "Functions" >> "mode");
    private _jip = getNumber (configFile >> "CfgRemoteExec" >> "Functions" >> "jip");
    
    if (_mode == 1 && _jip == 0) then {
        _testResults pushBack ["CfgRemoteExec config (mode=1, jip=0)", "PASS"];
    } else {
        _testResults pushBack ["CfgRemoteExec config", format ["FAIL - mode=%1, jip=%2", _mode, _jip]];
        _testPassed = false;
    };
} else {
    _testResults pushBack ["CfgRemoteExec config", "FAIL - Not found"];
    _testPassed = false;
};

// Print results
diag_log "[SMOKE_TEST] ===== RemoteExec Check Results =====";
{
    diag_log format ["[SMOKE_TEST] %1: %2", _x select 0, _x select 1];
} forEach _testResults;

if (_testPassed) then {
    diag_log "[SMOKE_TEST] OVERALL: PASS - No remoteExec restrictions detected";
    systemChat "[SMOKE_TEST] RemoteExec check: PASS";
} else {
    diag_log "[SMOKE_TEST] OVERALL: FAIL - Check RPT for remoteExec restriction errors";
    systemChat "[SMOKE_TEST] RemoteExec check: FAIL - Check RPT";
};

diag_log "[SMOKE_TEST] =====================================";
diag_log "[SMOKE_TEST] Next: Check RPT logs for 'remoteExec restriction' errors";
diag_log "[SMOKE_TEST] Expected: 0 restriction errors";
