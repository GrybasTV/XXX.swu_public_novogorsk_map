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
// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
_base = _this param [0, [0, 0]];
_grp = _this param [1, grpNull];

while {({alive _x} count (units _grp)) > 0} do 
{
	[_grp,[((_base param [0, 0])+(round((random 10)*(selectRandom[-1,1])))),((_base param [1, 0])+(round((random 10)*(selectRandom[-1,1]))))]] remoteExec ["move", (groupOwner _grp), false];
	sleep 181;
};