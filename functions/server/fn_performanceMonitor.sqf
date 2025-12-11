/*
Author: GrybasTV + AI
Description:
	Server performance monitoring system - logs critical metrics to detect freeze causes
	
Parameter(s):
	NONE
	
Returns:
	nothing
	
Execution:
	[] spawn wrm_fnc_performanceMonitor;
*/

if (!isServer) exitWith {};

private _monitorInterval = 5; // Check every 5 seconds
private _logInterval = 30; // Detailed log every 30 seconds
private _lastLogTime = time;

diag_log "========================================";
diag_log "[PERF MONITOR] Started - monitoring server performance";
diag_log "========================================";

while {true} do {
	private _currentTime = time;
	
	// Get critical metrics
	private _fps = diag_fps;
	private _activeScripts = diag_activeScripts; // Returns NUMBER (total active scripts)
	private _minFPS = 15; // Critical threshold
	
	// Quick check every interval
	if (_fps < _minFPS) then {
		diag_log format ["[PERF ALERT] LOW FPS: %1 | Active Scripts: %2", 
			_fps, _activeScripts];
	};
	
	// Detailed log every 30 seconds
	if ((_currentTime - _lastLogTime) >= _logInterval) then {
		_lastLogTime = _currentTime;
		
		diag_log "========================================";
		diag_log format ["[PERF LOG] Time: %1", _currentTime];
		diag_log format ["[PERF LOG] Server FPS: %1", _fps];
		diag_log format ["[PERF LOG] Active Scripts: %1", _activeScripts];
		diag_log format ["[PERF LOG] All Players: %1", count allPlayers];
		diag_log format ["[PERF LOG] AI Units: %1", count allUnits - count allPlayers];
		diag_log format ["[PERF LOG] All Vehicles: %1", count vehicles];
		
		// Mission-specific metrics
		if (!isNil "progress") then {
			diag_log format ["[PERF LOG] Mission Progress: %1", progress];
		};
		
		diag_log "========================================";
		
		// Critical alert if too many scripts
		if ((_activeScripts select 0) > 100) then {
			diag_log format ["[PERF CRITICAL] Too many active scripts! Total: %1", _activeScripts];
		};
	};
	
	sleep _monitorInterval;
};
