/*
	Register Event Handlers for Crew Members
	Centralized function to register MPKilled event handlers for vehicle crew
	Prevents duplicate EH registration with consistent naming

	Parameters:
		0: OBJECT - Vehicle to register crew EH for
		1: SIDE - Side for killed EH logic

	Returns:
		Nothing

	Usage:
		[_vehicle, _side] call wrm_fnc_registerCrewEH;
*/

params ["_vehicle", "_side"];

if (isNull _vehicle) exitWith {
	if(DBG)then{diag_log format ["[EH_REGISTRATION] Skipped - null vehicle provided"]};
};

if (!(_vehicle isKindOf "AllVehicles")) exitWith {
	if(DBG)then{diag_log format ["[EH_REGISTRATION] Skipped - not a vehicle: %1", typeOf _vehicle]};
};

private _crew = crew _vehicle;
if (count _crew == 0) exitWith {
	if(DBG)then{diag_log format ["[EH_REGISTRATION] Skipped - no crew in vehicle: %1", typeOf _vehicle]};
};

if(DBG)then{diag_log format ["[EH_REGISTRATION] Registering EH for vehicle %1 (%2 crew members)", typeOf _vehicle, count _crew]};

// Register MPKilled EH for each crew member (preventing duplicates)
{
	if (!(_x getVariable ["wrm_eh_mpkilled", false])) then {
		_x setVariable ["wrm_eh_mpkilled", true, false];
		_x addMPEventHandler ["MPKilled", {
			params ["_unit"];
			[_unit, _side] spawn wrm_fnc_killedEH;
		}];
		if(DBG)then{diag_log format ["[EH_REGISTRATION] Registered MPKilled EH for unit: %1", name _x]};
	} else {
		if(DBG)then{diag_log format ["[EH_REGISTRATION] MPKilled EH already exists for unit: %1", name _x]};
	};
} forEach _crew;

if(DBG)then{diag_log format ["[EH_REGISTRATION] Completed EH registration for vehicle: %1", typeOf _vehicle]};
