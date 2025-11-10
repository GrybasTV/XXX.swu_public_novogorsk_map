/*
	OnOwnerChange Event Handler for Sectors
	Centralized handler for all sector ownership changes
	Executed via execVM from ModuleSector init strings

	Parameters:
		0: STRING - Sector ID (e.g., "BE1", "BW2", etc.)
		1: ARRAY - Original _this array from OnOwnerChange event [_module, _newOwner, _oldOwner]

	Returns:
		Nothing
*/

params ["_sectorId", "_args"];
_args params ["_module", "_newOwner", "_oldOwner"];

if(DBG)then{diag_log format ["[SEC_CHANGE] %1: ownership %2->%3 (side %4)", _sectorId, _oldOwner, _newOwner, side _module]};

// Handle sector-specific logic based on sector ID
switch (_sectorId) do {
	case "BE1": {
		call {
			if ((_newOwner) == sideW) exitWith {
				if(getMarkerColor resFobEW != "") exitWith{};
				_mrkRaW = createMarker [resFobEW, posBaseE1];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBE1;
				deleteMarker resFobE;
				if(dBE1)then{[posBaseE1,sideW] call wrm_fnc_V2secDefense;};
			};

			if ((_newOwner) == sideE) exitWith {
				if(getMarkerColor resFobE != "") exitWith{};
				_mrkRaW = createMarker [resFobE, posBaseE1];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBE1;
				deleteMarker resFobEW;

				_eBE1 = true;
				{
					if (side _x == sideW && _x distance posBaseE1 < 250) then { _eBE1 = false; };
				} forEach ((entities [["Man"], [], true, false]) select {alive _x});
				if((getMarkerColor resFobE != "") && (_eBE1)) then {
					{ _x hideObjectGlobal false; } forEach hideVehBE1;
					hideVehBE1 = [];
				};
				if(dBE1)then{[posBaseE1,sideE] call wrm_fnc_V2secDefense;};
			};
		};
		if (AIon > 0) then {[] call wrm_fnc_V2aiMove;};
	};

	case "BW1": {
		call {
			if ((_newOwner) == sideW) exitWith {
				if(getMarkerColor resFobW != "") exitWith{};
				_mrkRaW = createMarker [resFobW, posBaseW1];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBW1;
				deleteMarker resFobWE;

				_eBW1 = true;
				{
					if (side _x == sideE && _x distance posBaseW1 < 250) then { _eBW1 = false; };
				} forEach ((entities [["Man"], [], true, false]) select {alive _x});
				if((getMarkerColor resFobW != "") && (_eBW1)) then {
					{ _x hideObjectGlobal false; } forEach hideVehBW1;
					hideVehBW1 = [];
				};
				if(dBW1)then{[posBaseW1,sideW] call wrm_fnc_V2secDefense;};
			};

			if ((_newOwner) == sideE) exitWith {
				if(getMarkerColor resFobWE != "") exitWith{};
				_mrkRaW = createMarker [resFobWE, posBaseW1];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBW1;
				deleteMarker resFobW;
				if(dBW1)then{[posBaseW1,sideE] call wrm_fnc_V2secDefense;};
			};
		};
		if (AIon > 0) then {[] call wrm_fnc_V2aiMove;};
	};

	case "BE2": {
		call {
			if ((_newOwner) == sideW) exitWith {
				if(getMarkerColor resBaseEW != "") exitWith{};
				_mrkRaW = createMarker [resBaseEW, posBaseE2];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBE2;
				deleteMarker resBaseE;
				if(dBE2)then{[posBaseE2,sideW] call wrm_fnc_V2secDefense;};
			};

			if ((_newOwner) == sideE) exitWith {
				if(getMarkerColor resBaseE != "") exitWith{};
				_mrkRaW = createMarker [resBaseE, posBaseE2];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBE2;
				deleteMarker resBaseEW;

				_eBE2 = true;
				{
					if (side _x == sideW && _x distance posBaseE2 < 250) then { _eBE2 = false; };
				} forEach ((entities [["Man"], [], true, false]) select {alive _x});
				if((getMarkerColor resBaseE != "") && (_eBE2)) then {
					{ _x hideObjectGlobal false; } forEach hideVehBE2;
					hideVehBE2 = [];
				};
				if(dBE2)then{[posBaseE2,sideE] call wrm_fnc_V2secDefense;};
			};
		};
		if (AIon > 0) then {[] call wrm_fnc_V2aiMove;};
	};

	case "BW2": {
		call {
			if ((_newOwner) == sideW) exitWith {
				if(getMarkerColor resBaseW != "") exitWith{};
				_mrkRaW = createMarker [resBaseW, posBaseW2];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBW2;
				deleteMarker resBaseWE;

				_eBW2 = true;
				{
					if (side _x == sideE && _x distance posBaseW2 < 250) then { _eBW2 = false; };
				} forEach ((entities [["Man"], [], true, false]) select {alive _x});
				if((getMarkerColor resBaseW != "") && (_eBW2)) then {
					{ _x hideObjectGlobal false; } forEach hideVehBW2;
					hideVehBW2 = [];
				};
				if(dBW2)then{[posBaseW2,sideW] call wrm_fnc_V2secDefense;};
			};

			if ((_newOwner) == sideE) exitWith {
				if(getMarkerColor resBaseWE != "") exitWith{};
				_mrkRaW = createMarker [resBaseWE, posBaseW2];
				_mrkRaW setMarkerShape "ICON";
				_mrkRaW setMarkerType "empty";
				_mrkRaW setMarkerText nameBW2;
				deleteMarker resBaseW;
				if(dBW2)then{[posBaseW2,sideE] call wrm_fnc_V2secDefense;};
			};
		};
		if (AIon > 0) then {[] call wrm_fnc_V2aiMove;};
	};

	default {
		if(DBG)then{diag_log format ["[SEC_ERROR] Unknown sector ID: %1", _sectorId]};
	};
};

if(DBG)then{diag_log format ["[SEC_CHANGE] %1: completed (processed units: %2)", _sectorId, count ((entities [["Man"], [], true, false]) select {alive _x})]};
