//[EH] spawn wrm_fnc_removeDrop;

private _startTime = time;
waitUntil {
    sleep 0.1;
    (!visibleMap) || (time - _startTime > 60)
};

if (time - _startTime > 60 && visibleMap) exitWith {
    // Timeout - uždarome žemėlapį priverstinai
    openMap false;
};

[(_this select 0), "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
hintSilent "";