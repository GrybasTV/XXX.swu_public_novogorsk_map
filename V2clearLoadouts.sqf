//delete wrong loadouts
systemChat "Checking loadouts";
_run=true;
private _timeout = time + 60; //1 minutės timeout
while{_run && time < _timeout}do
{
	if((count([missionNamespace, true] call BIS_fnc_getRespawnInventories))==0)then{_run=false;};
	sleep 1;
	{[missionNamespace, _x] call BIS_fnc_removeRespawnInventory;} forEach ([missionNamespace, true] call BIS_fnc_getRespawnInventories);
};
systemChat "Loadouts ready";

//show tasks
_run=true;
private _timeout2 = time + 60; //1 minutės timeout
while{_run && time < _timeout2}do
{
	if((count(player call BIS_fnc_tasksUnit))==(count((units independent) call BIS_fnc_tasksUnit)))then{_run=false;};
	sleep 1;
	{[_x,"",false] call BIS_fnc_taskSetState;} forEach ((units independent) call BIS_fnc_tasksUnit);
};
if(DBG)then{if(progress>1)then{systemChat "Tasks loaded";};};

//show tickets
call BIS_fnc_showMissionStatus;
