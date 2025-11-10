/*
[_pos,_shift,_alt] execVM "warmachine\V2aoSelect.sqf";
hint parseText format ["SELECT AREA OF OPERATION<br/><br/>By left mouse button click<br/>LMB<br/><br/>To select any sector and change its location<br/>Press Shift+LMB"];


TRIGGER ON
call{["AOselect", "onMapSingleClick", {[_pos,_shift,_alt] execVM "warmachine\V2aoSelect.sqf";}] call BIS_fnc_addStackedEventHandler}
TRIGGER OFF
call {["AOselect", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler}
*/

_posLMB = _this select 0;
_shiftLMB = _this select 1;
_altLMB = _this select 2;
mkr = "";

call
{
	if (!_shiftLMB && !_altLMB) exitWith {[_posLMB] execVM "warmachine\V2aoCreate.sqf";};
	if (_shiftLMB) exitWith
	{
		call
		{
			if ((_posLMB distance (getMarkerPos "mArti"))<200) 
			exitWith {["AOselect", "onMapSingleClick", {[_pos] execVM "warmachine\V2aoChange.sqf";}] call BIS_fnc_addStackedEventHandler; mrk="mArti"; mrk setMarkerTypeLocal "mil_end_noShadow"; hint "Select new position by LMB click";};
			if ((_posLMB distance (getMarkerPos "mCas"))<200) 
			exitWith {["AOselect", "onMapSingleClick", {[_pos] execVM "warmachine\V2aoChange.sqf";}] call BIS_fnc_addStackedEventHandler; mrk="mCas"; mrk setMarkerTypeLocal "mil_end_noShadow"; hint "Select new position by LMB click";};
			if ((_posLMB distance (getMarkerPos "mAA"))<200) 
			exitWith {["AOselect", "onMapSingleClick", {[_pos] execVM "warmachine\V2aoChange.sqf";}] call BIS_fnc_addStackedEventHandler; mrk="mAA"; mrk setMarkerTypeLocal "mil_end_noShadow"; hint "Select new position by LMB click";};
			if ((_posLMB distance (getMarkerPos "mB1W"))<200) 
			exitWith {["AOselect", "onMapSingleClick", {[_pos] execVM "warmachine\V2aoChange.sqf";}] call BIS_fnc_addStackedEventHandler; mrk="mB1W"; mrk setMarkerTypeLocal "mil_end_noShadow"; hint "Select new position by LMB click";};
			if ((_posLMB distance (getMarkerPos "mB2W"))<200) 
			exitWith {["AOselect", "onMapSingleClick", {[_pos] execVM "warmachine\V2aoChange.sqf";}] call BIS_fnc_addStackedEventHandler; mrk="mB2W"; mrk setMarkerTypeLocal "mil_end_noShadow"; hint "Select new position by LMB click";};
			if ((_posLMB distance (getMarkerPos "mB1E"))<200) 
			exitWith {["AOselect", "onMapSingleClick", {[_pos] execVM "warmachine\V2aoChange.sqf";}] call BIS_fnc_addStackedEventHandler; mrk="mB1E"; mrk setMarkerTypeLocal "mil_end_noShadow"; hint "Select new position by LMB click";};
			if ((_posLMB distance (getMarkerPos "mB2E"))<200) 
			exitWith {["AOselect", "onMapSingleClick", {[_pos] execVM "warmachine\V2aoChange.sqf";}] call BIS_fnc_addStackedEventHandler; mrk="mB2E"; mrk setMarkerTypeLocal "mil_end_noShadow"; hint "Select new position by LMB click";};
		};
	}; 
	if (_altLMB) exitWith {};
};
//waitUntil {!visibleMap};
//["AOselect", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;