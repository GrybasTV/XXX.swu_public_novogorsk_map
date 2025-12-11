//[EH] spawn wrm_fnc_removeDrop;

waitUntil {!visibleMap};
[(_this select 0), "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
hintSilent "";