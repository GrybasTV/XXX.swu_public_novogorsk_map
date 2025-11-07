/*
	Author: IvosH
	
	Description:
		hint for all members of the group when any player become leader
		
	Parameter(s):
		0: string (leader name)
		1: string (group)
		
	Returns:
		nothing
		
	Dependencies:
		fn_leaderUpdate
		
	Execution:
		[player] call wrm_fnc_leaderHint;
*/

if (!hasInterface) exitWith {}; //run on all players include server host

_ldr = _this select 0;
_grp = _this select 1;

if (group player != _grp) exitWith {};

if (profileName != _ldr) then 
{
	_gName = groupId (group player);
	hint parseText format ["Player %1<br/>is now leader of the squad %2",_ldr, _gName];
} else
{
	hint "You have become a squad leader";
};




