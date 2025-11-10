/*
    run_ds_enforcer_smoke.sqf
    Smoke test for Dynamic Simulation enforcer exclusions
    
    Usage: ExecVM this file on server after 5-10 minutes of gameplay
    Expected: Player groups and active vehicles excluded from DS
*/

if (!isServer) exitWith {
    systemChat "[SMOKE_TEST] DS enforcer check must run on server";
    diag_log "[SMOKE_TEST] DS enforcer check failed - not running on server";
};

diag_log "[SMOKE_TEST] Starting DS enforcer exclusion check...";

private _testResults = [];
private _testPassed = true;

// Test 1: Check player groups are NOT flagged with DS
diag_log "[SMOKE_TEST] Test 1: Player groups exclusion";
private _playerGroupsWithDS = [];
{
    private _grp = _x;
    private _hasPlayer = (units _grp) findIf {isPlayer _x} > -1;
    
    if (_hasPlayer) then {
        private _hasDS = _grp getVariable ["wrm_dynSimEnabled", false];
        if (_hasDS) then {
            _playerGroupsWithDS pushBack _grp;
        };
    };
} forEach allGroups;

if (count _playerGroupsWithDS == 0) then {
    _testResults pushBack ["Player groups excluded from DS", "PASS"];
} else {
    _testResults pushBack ["Player groups excluded from DS", format ["FAIL - %1 groups with DS", count _playerGroupsWithDS]];
    _testPassed = false;
    {
        diag_log format ["[SMOKE_TEST] ERROR: Player group %1 has DS enabled", _x];
    } forEach _playerGroupsWithDS;
};

// Test 2: Check active vehicles with crew/cargo are NOT flagged with DS
diag_log "[SMOKE_TEST] Test 2: Active vehicles exclusion";
private _activeVehiclesWithDS = [];
{
    private _veh = _x;
    if (!(_veh isKindOf "Man")) then {
        private _hasCrew = count (crew _veh) > 0;
        private _hasCargo = count (getVehicleCargo _veh) > 0;
        private _hasPlayerCrew = (crew _veh) findIf {isPlayer _x} > -1;
        
        if ((_hasCrew || _hasCargo) && !_hasPlayerCrew) then {
            // AI crew/cargo - should be excluded
            private _hasDS = _veh getVariable ["wrm_dynSimEnabled", false];
            if (_hasDS) then {
                _activeVehiclesWithDS pushBack _veh;
            };
        };
    };
} forEach vehicles;

if (count _activeVehiclesWithDS == 0) then {
    _testResults pushBack ["Active vehicles (crew/cargo) excluded from DS", "PASS"];
} else {
    _testResults pushBack ["Active vehicles (crew/cargo) excluded from DS", format ["FAIL - %1 vehicles with DS", count _activeVehiclesWithDS]];
    _testPassed = false;
    {
        diag_log format ["[SMOKE_TEST] ERROR: Vehicle %1 (%2) has DS enabled with crew/cargo", typeOf _x, _x];
    } forEach _activeVehiclesWithDS;
};

// Test 3: Check player vehicles are NOT flagged with DS
diag_log "[SMOKE_TEST] Test 3: Player vehicles exclusion";
private _playerVehiclesWithDS = [];
{
    private _veh = _x;
    if (!(_veh isKindOf "Man")) then {
        private _hasPlayerCrew = (crew _veh) findIf {isPlayer _x} > -1;
        
        if (_hasPlayerCrew) then {
            private _hasDS = _veh getVariable ["wrm_dynSimEnabled", false];
            if (_hasDS) then {
                _playerVehiclesWithDS pushBack _veh;
            };
        };
    };
} forEach vehicles;

if (count _playerVehiclesWithDS == 0) then {
    _testResults pushBack ["Player vehicles excluded from DS", "PASS"];
} else {
    _testResults pushBack ["Player vehicles excluded from DS", format ["FAIL - %1 vehicles with DS", count _playerVehiclesWithDS]];
    _testPassed = false;
    {
        diag_log format ["[SMOKE_TEST] ERROR: Player vehicle %1 (%2) has DS enabled", typeOf _x, _x];
    } forEach _playerVehiclesWithDS;
};

// Test 4: Check AI groups DO have DS enabled
diag_log "[SMOKE_TEST] Test 4: AI groups DS enabled";
private _aiGroupsWithoutDS = [];
{
    private _grp = _x;
    private _hasPlayer = (units _grp) findIf {isPlayer _x} > -1;
    
    if (!_hasPlayer && count (units _grp) > 0) then {
        private _hasDS = _grp getVariable ["wrm_dynSimEnabled", false];
        if (!_hasDS) then {
            _aiGroupsWithoutDS pushBack _grp;
        };
    };
} forEach allGroups;

if (count _aiGroupsWithoutDS == 0) then {
    _testResults pushBack ["AI groups have DS enabled", "PASS"];
} else {
    _testResults pushBack ["AI groups have DS enabled", format ["WARN - %1 groups without DS (enforcer may run later)", count _aiGroupsWithoutDS]];
    // Not a failure - enforcer runs periodically
};

// Print results
diag_log "[SMOKE_TEST] ===== DS Enforcer Check Results =====";
{
    diag_log format ["[SMOKE_TEST] %1: %2", _x select 0, _x select 1];
} forEach _testResults;

if (_testPassed) then {
    diag_log "[SMOKE_TEST] OVERALL: PASS - DS exclusions working correctly";
    systemChat "[SMOKE_TEST] DS enforcer check: PASS";
} else {
    diag_log "[SMOKE_TEST] OVERALL: FAIL - Check DS enforcer logic";
    systemChat "[SMOKE_TEST] DS enforcer check: FAIL - Check RPT";
};

diag_log "[SMOKE_TEST] =====================================";
diag_log "[SMOKE_TEST] Expected: Player groups/vehicles excluded, AI groups enabled";
