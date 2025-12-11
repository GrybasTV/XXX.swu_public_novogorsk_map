/*
Author: GrybasTV + AI
Description:
	Simple debug marker for critical script locations
	Logs to server RPT file to track execution flow
	
Parameter(s):
	0: STRING - Script name
	1: STRING - Checkpoint description
	2: (Optional) ARRAY - Additional data to log
	
Returns:
	nothing
	
Execution:
	["V2secDefense", "Starting unit spawn"] call wrm_fnc_scriptMarker;
	["V2secDefense", "Finished unit spawn", [_unitCount, _groupId]] call wrm_fnc_scriptMarker;
*/

if (!isServer) exitWith {};

params [
	["_scriptName", "Unknown", [""]],
	["_checkpoint", "Checkpoint", [""]],
	["_data", [], [[]]]
];

private _timestamp = time;
private _logMessage = format ["[SCRIPT] %1 > %2 @ %3s", _scriptName, _checkpoint, _timestamp];

if (count _data > 0) then {
	_logMessage = _logMessage + format [" | Data: %1", _data];
};

diag_log _logMessage;
