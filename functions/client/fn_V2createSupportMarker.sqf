/*
	Author: AI Assistant - Sukurtas pagal V2aoCreate.sqf pavyzdį

	Description:
		Create local support marker for artillery, CAS, and anti-air sectors

	Parameter(s):
		0: STRING, marker name
		1: ARRAY, position
		2: STRING, marker type
		3: STRING, marker text

	Returns:
		nothing

	Dependencies:
		none

	Execution:
		[_name, _pos, _type, _text] call wrm_fnc_V2createSupportMarker;
*/

if (!hasInterface) exitWith {}; //Tik klientuose su interface

params ["_name", "_pos", "_type", "_text"];

private _mrk = createMarkerLocal [_name, _pos];
_mrk setMarkerShapeLocal "ICON";
_mrk setMarkerTypeLocal _type;
_mrk setMarkerTextLocal _text;
_mrk setMarkerColorLocal "ColorBlack";

if(DBG)then{systemChat format ["[SUPPORT_MARKER] Created marker: %1 at %2", _name, _pos]};
