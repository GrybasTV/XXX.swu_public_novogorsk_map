/*
	Author: IvosH
	
	Description:
		Tell defense group return to their position
		
	Parameter(s):
		0: ARRAY Base position
		1: VARIABLE Group
		
	Returns:
		nothing
		
	Dependencies:
		baseDefense.sqf
		
	Execution:
		[_sec,_grp] spawn wrm_fnc_V2defBase;
*/
_base = _this select 0;
_grp = _this select 1;

while {({alive _x} count (units _grp)) > 0} do 
{
	[_grp,[((_base select 0)+(round((random 10)*(selectRandom[-1,1])))),((_base select 1)+(round((random 10)*(selectRandom[-1,1]))))]] remoteExec ["move", (groupOwner _grp), false];
	sleep 181;
};