/*
	Author: IvosH
	
	Description:
		wait for any player to leave the BASE / FOB, then start countdown.
		
	Parameter(s):
		NONE
		
	Returns:
		nothing
		
	Dependencies:
		start.sqf
		
	Execution:
		[] execVM "warmachine\timerStart.sqf";
*/
if !( isServer ) exitWith {}; //run on the dedicated server or server host
sleep 60; //60
_t=0;
while {_t==0} do
{
	{
		if(!alive _x)exitWith{};
		if(side _x==sideW)then
		{
			if(_x distance posFobWest > 100 && _x distance posBaseWest > 100)then{[]spawn wrm_fnc_timer;_t=1;}
		}else
		{
			if(_x distance posFobEast > 100 && _x distance posBaseEast > 100)then{[]spawn wrm_fnc_timer;_t=1;}
		};
	} forEach allPlayers;
	sleep 7;
};