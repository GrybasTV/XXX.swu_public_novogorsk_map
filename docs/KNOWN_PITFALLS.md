# Known Pitfalls & Common Issues

**Last Updated:** 2025-11-10  
**Version:** 2.0-production-ready

This document outlines common pitfalls, edge cases, and solutions encountered during development. Most issues have been resolved in v2.0, but this serves as a reference for troubleshooting and future development.

---

## 🔴 Critical Pitfalls (Resolved in v2.0)

### 1. ModuleSector Init String Fragility

**Problem:**
- Complex logic embedded in `ModuleSector` init strings caused syntax errors
- Quote escaping (`'` vs `"`) led to parsing failures
- Local variables not accessible in init string context
- Difficult to debug and maintain

**Solution:**
- Moved `OnOwnerChange` logic to separate `.sqf` file (`sectors/OnOwnerChange.sqf`)
- Init string now only calls `execVM` with sector ID parameter
- All logic centralized in one maintainable file

**Example (Before - Fragile):**
```sqf
this setVariable ['OnOwnerChange', format ["if (side _this == sideW) then { { _x hideObjectGlobal false; } forEach hideVehBE1; };", 'BE1']];
```

**Example (After - Robust):**
```sqf
this setVariable ['OnOwnerChange', format ["['%1', _this] execVM 'sectors\OnOwnerChange.sqf';", 'BE1']];
```

**Key Rules:**
- Never use nested quotes in init strings (`'` inside `"` or vice versa)
- Use `format` for dynamic values, but keep logic minimal
- Prefer `execVM` calls over inline code blocks

---

### 2. Event Handler Duplicate Registration

**Problem:**
- `MPKilled` event handlers registered multiple times for same unit
- Caused memory leaks and performance degradation
- Difficult to track which handler was responsible

**Solution:**
- Centralized EH registration in `wrm_fnc_registerCrewEH`
- Uses `wrm_eh_mpkilled` variable flag to prevent duplicates
- Server-side registration ensures single source of truth

**Example (Before - Duplicate Risk):**
```sqf
_unit addMPEventHandler ["MPKilled", { ... }];
// Later in code...
_unit addMPEventHandler ["MPKilled", { ... }]; // Duplicate!
```

**Example (After - Protected):**
```sqf
if (!(_unit getVariable ["wrm_eh_mpkilled", false])) then {
    _unit setVariable ["wrm_eh_mpkilled", true, false];
    _unit addMPEventHandler ["MPKilled", { ... }];
};
```

**Key Rules:**
- Always check for existing EH before registration
- Use consistent variable naming (`wrm_eh_<type>_added`)
- Register EHs server-side when possible

---

### 3. Dynamic Simulation Player Exclusion

**Problem:**
- DS enforcer applied to all groups/vehicles, including player-controlled
- Caused player groups to freeze or behave incorrectly
- Active vehicles with crew/cargo incorrectly flagged with DS

**Solution:**
- Added explicit checks for player presence before DS enable
- Exclude vehicles with crew/cargo from DS
- Periodic enforcer runs every 60s to catch new spawns

**Example (Before - No Exclusion):**
```sqf
_grp enableDynamicSimulation true; // Applied to ALL groups
```

**Example (After - Protected):**
```sqf
private _groupUnits = units _grp;
if (_groupUnits findIf {isPlayer _x} > -1) exitWith {
    // Skip player groups
};
_grp enableDynamicSimulation true;
```

**Key Rules:**
- Always check `isPlayer` before enabling DS
- Check `crew _veh` and `getVehicleCargo _veh` for vehicles
- Use periodic enforcer for mod-spawned entities

---

### 4. JIP State Desynchronization

**Problem:**
- JIP players received incomplete mission state
- Markers, support links, Zeus objects missing
- UAV arrays not synchronized
- Relied on JIP replay (unreliable)

**Solution:**
- Server-side state push in `wrm_fnc_V2jipRestoration`
- `PlayerConnected` event handler triggers restoration
- All critical variables `publicVariable`'d before push

**Example (Before - JIP Replay):**
```sqf
remoteExec ["someFunction", 0, true]; // jip=true unreliable
```

**Example (After - Server Push):**
```sqf
// In initServer.sqf
addMissionEventHandler ["PlayerConnected", {
    params ["_id", "_uid", "_name", "_jip", "_owner"];
    if (_jip) then {
        [_player, _uid] call wrm_fnc_V2jipRestoration;
    };
}];
```

**Key Rules:**
- Never rely on JIP replay (`jip=true` in `remoteExec`)
- Always push state from server on `PlayerConnected`
- Use `publicVariable` for all mission-critical variables

---

## ⚠️ Common Issues (Prevented in v2.0)

### 5. Quote Escaping in Format Strings

**Problem:**
- Nested quotes in `format` strings caused parsing errors
- Apostrophes in names/descriptions broke init strings

**Solution:**
- Use `%1`, `%2` placeholders in `format`
- Escape quotes with `''` (double single quote) if needed
- Prefer `execVM` over complex format strings

**Example (Problematic):**
```sqf
format ["Name: '%1'", "O'Brien"]; // Breaks if not escaped
```

**Example (Safe):**
```sqf
private _name = "O'Brien";
format ["Name: %1", _name]; // Safe
```

---

### 6. Race Conditions in Sector Creation

**Problem:**
- `sectorBE1 = this;` assignment in init string not immediate
- `BIS_fnc_moduleSector` called before variable exists
- Caused `undefined variable` errors

**Solution:**
- Added `waitUntil {!(isNil 'sectorBE1')}` before module init
- Timeout protection prevents infinite loops

**Example (Before - Race Condition):**
```sqf
"ModuleSector_F" createUnit [...];
[sectorBE1, sideE] call BIS_fnc_moduleSector; // May fail!
```

**Example (After - Protected):**
```sqf
"ModuleSector_F" createUnit [...];
waitUntil {!(isNil 'sectorBE1')};
[sectorBE1, sideE] call BIS_fnc_moduleSector; // Safe
```

---

### 7. Infinite Loops in While/WaitUntil

**Problem:**
- `while` loops without timeout caused scheduler freeze
- "No alive in 10000ms" errors from blocked scheduler
- Mission became unresponsive

**Solution:**
- Added timeout checks to all `while`/`waitUntil` loops
- Fallback logging for timeout cases
- Maximum timeout limits (30s-60s for most operations)

**Example (Before - Infinite Risk):**
```sqf
while {_condition} do {
    // No timeout - can freeze forever
    sleep 1;
};
```

**Example (After - Protected):**
```sqf
private _timeout = time + 60;
while {_condition && time < _timeout} do {
    sleep 1;
};
if (time >= _timeout) then {
    diag_log "[ERROR] Timeout reached";
};
```

---

### 8. Performance: allUnits vs entities

**Problem:**
- `allUnits` iterates over ALL units (including dead, vehicles, etc.)
- Very expensive operation (300+ calls/sec in some cases)
- Caused scheduler lag and FPS drops

**Solution:**
- Replaced `allUnits` with `entities [["Man"], [], true, false]`
- Pre-filtered for alive units: `select {alive _x}`
- Cached results when possible

**Example (Before - Expensive):**
```sqf
{if (side _x == sideW) then { ... }} forEach allUnits; // Slow!
```

**Example (After - Optimized):**
```sqf
private _men = (entities [["Man"], [], true, false]) select {alive _x};
{if (side _x == sideW) then { ... }} forEach _men; // Fast!
```

---

## 📝 Best Practices

### Code Organization
- **Centralize Logic**: Move complex logic out of init strings
- **Single Source of Truth**: Server-side state management
- **Consistent Naming**: Use `wrm_` prefix for mission variables

### Performance
- **Cache Expensive Calls**: Store `allPlayers` results
- **Use entities()**: Prefer over `allUnits`/`allDeadMen`
- **Throttle Operations**: Don't run expensive checks every frame

### Error Handling
- **Timeout Protection**: All loops need timeout checks
- **Fallback Logging**: Log timeout cases for debugging
- **Graceful Degradation**: Mission continues even if non-critical features fail

### Network Optimization
- **RemoteExec Locality**: Use `[2, false]` for server-only, `[0, false]` for all clients
- **JIP Handling**: Server push, not replay
- **PublicVariable**: Only for mission-critical state

---

## 🔍 Debugging Tips

### RPT Log Analysis
- Search for `[ERROR]`, `[FAIL]`, `[TIMEOUT]` tags
- Check `[SMOKE_TEST]` entries for validation results
- Monitor `[JIP_RESTORATION]` for JIP issues
- Watch `[DS_GROUP_SKIP]` / `[DS_VEHICLE_SKIP]` for DS problems

### Common Error Patterns
- **"No alive in 10000ms"**: Infinite loop blocking scheduler
- **"remoteExec restriction"**: CfgRemoteExec whitelist missing/incorrect
- **"undefined variable"**: Race condition or missing initialization
- **"script error"**: Syntax error in init string or format

### Performance Profiling
- Use `diag_fps` and `diag_tickTime` for baseline
- Monitor `entities()` and `allPlayers()` call frequency
- Check scheduler lag spikes (> 100ms indicates problem)

---

## 📚 Related Documentation

- **[MODIFICATIONS.md](MODIFICATIONS.md)** - Detailed technical changes
- **[PRE_FLIGHT_CHECKLIST.md](PRE_FLIGHT_CHECKLIST.md)** - Testing procedures
- **[ROLLBACK_PLAN.md](ROLLBACK_PLAN.md)** - Rollback instructions

---

**For questions or issues, see [GitHub Issues](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/issues)**
