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
private _timeout = time + 3600; //1 valandos timeout
while {_t==0 && time < _timeout} do
{
	//OPTIMIZATION: Cache allPlayers - VALIDUOTA SU ARMA 3 BEST PRACTICES
	private _cachedPlayers = allPlayers select {alive _x};
	{
		if(side _x==sideW)then
		{
			if(_x distance posFobWest > 100 && _x distance posBaseWest > 100)then{[]spawn wrm_fnc_timer;_t=1;}
		}else
		{
			if(_x distance posFobEast > 100 && _x distance posBaseEast > 100)then{[]spawn wrm_fnc_timer;_t=1;}
		};
	} forEach _cachedPlayers;
	sleep 7;
};
if (time >= _timeout && _t==0) then {
	if(DBG)then{diag_log "[TIMER_START] ABORTED - timeout reached, players may still be too close to bases"};
	systemChat "Timer start timeout - mission timer may not start automatically";
};