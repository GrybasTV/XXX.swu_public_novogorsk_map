/*
Author: IvosH

Description:
	AI revives player, runs on the pc where AI (_healer) is local

Parameter(s):
	_unit: incapacitated player
	_healer: AI reviving player
	_case: part of the reviving process

Returns:
	nothing

Dependencies:
	fn_plRevive.sqf
	
Execution:
	[_unit,_healer,_case] remoteExec ["wrm_fnc_aiRevive", 0, false];
	[_unit,_healer,_case] call wrm_fnc_aiRevive;
*/
params ["_unit","_healer","_case"];
if(!local _healer)exitWith{};

call
{
	//make healer dumb
	if(_case==0)exitWith 
	{
		{_healer disableAI _x;} forEach ["TARGET","AUTOTARGET","FSM","SUPPRESSION","COVER","AUTOCOMBAT"];
		_healer setBehaviour "AWARE";
		_healer setSpeedMode "FULL";
		//systemChat "make healer dumb"; //DEBUG
	};
	
	//move healer to player
	if(_case==1)exitWith 
	{
		_healer doMove (getPos _unit);
		//systemChat "move healer to player"; //DEBUG
	};
	
	//start healing
	if(_case==2)exitWith
	{
		_healer doMove (getPos _unit);
		waitUntil {_healer distance _unit<=2.5};
		doStop _healer;
		_healer doWatch (getPos _unit);
		sleep 1;
		_healer playAction "MedicOther";
		//systemChat "start healing"; //DEBUG
	};
	
	//make healer clever
	if(_case==3)exitWith
	{
		{_healer enableAI _x;} forEach ["TARGET","AUTOTARGET","FSM","SUPPRESSION","COVER","AUTOCOMBAT"];
		_healer setSpeedMode "UNCHANGED";
		_healer setUnitPos "AUTO";
		_healer doFollow leader _healer;
		//systemChat "make healer clever"; //DEBUG
	};
};