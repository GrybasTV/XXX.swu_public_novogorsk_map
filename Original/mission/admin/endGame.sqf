//terminates the mission
closeDialog 0;
if (progress<2) exitWith {["EndFailed"] remoteExec ["BIS_fnc_endMission", 0, false];};

if(progress<2)then
{
	progress = 5; publicVariable "progress";
	["EndFailed"] remoteExec ["BIS_fnc_endMission", 0, false];
};

if(progress==2)then
{
	progress = 5; publicVariable "progress";
	_restW = [sideW] call BIS_fnc_respawnTickets; 
	_restE = [sideE] call BIS_fnc_respawnTickets;
	call
	{
		if (_restW == _restE) exitWith
		{
			[sideW,(_restE*-1)] call BIS_fnc_respawnTickets; 
			[sideE,(_restE*-1)] call BIS_fnc_respawnTickets;
			if(sideW==independent)then{[west,_restW] call BIS_fnc_respawnTickets;};
			if(sideE==independent)then{[east,_restE] call BIS_fnc_respawnTickets;};
			//["EndFailed"] remoteExec ["BIS_fnc_endMission", 0, false];
		};
		if (_restW > _restE) exitWith 
		{
			_rest=_restW-_restE;
			[sideW,(_restE*-1)] call BIS_fnc_respawnTickets; 
			[sideE,(_restE*-1)] call BIS_fnc_respawnTickets;
			if(sideW==independent)then{[west,_rest] call BIS_fnc_respawnTickets;};
			if(sideE==independent)then{[east,1] call BIS_fnc_respawnTickets;[east,-1] call BIS_fnc_respawnTickets;};
			if((sideW!=independent)&&(sideE!=independent))then{[independent,1] call BIS_fnc_respawnTickets;[independent,-1] call BIS_fnc_respawnTickets;};
			//[endW] remoteExec ["BIS_fnc_endMission", 0, false];
			
		};
		if (_restE > _restW) exitWith 
		{
			_rest=_restE-_restW;
			[sideW,(_restW*-1)] call BIS_fnc_respawnTickets; 
			[sideE,(_restW*-1)] call BIS_fnc_respawnTickets;
			if(sideW==independent)then{[west,1] call BIS_fnc_respawnTickets;[west,-1] call BIS_fnc_respawnTickets;};
			if(sideE==independent)then{[east,_rest] call BIS_fnc_respawnTickets;};
			if((sideW!=independent)&&(sideE!=independent))then{[independent,1] call BIS_fnc_respawnTickets;[independent,-1] call BIS_fnc_respawnTickets;};
			//[endE] remoteExec ["BIS_fnc_endMission", 0, false];
		};
	};
};

//version 1
if(progress==3||progress==4)then
{
	progress = 5; publicVariable "progress";
	_restA = [sideA] call BIS_fnc_respawnTickets; 
	_restD = [sideD] call BIS_fnc_respawnTickets;
	call
	{
		if (_restA == _restD) exitWith
		{
				[sideA,(_restD*-1)] call BIS_fnc_respawnTickets; 
				[sideD,(_restD*-1)] call BIS_fnc_respawnTickets;
				[endA] remoteExec ["BIS_fnc_endMission", 0, false];
		};
		if (_restA > _restD) exitWith 
		{
			[sideA,(_restD*-1)] call BIS_fnc_respawnTickets; 
			[sideD,(_restD*-1)] call BIS_fnc_respawnTickets;
			[endA] remoteExec ["BIS_fnc_endMission", 0, false];
		};
		if (_restD > _restA) exitWith 
		{
			[sideA,(_restA*-1)] call BIS_fnc_respawnTickets; 
			[sideD,(_restA*-1)] call BIS_fnc_respawnTickets;
			[endD] remoteExec ["BIS_fnc_endMission", 0, false];
		};
	};
};