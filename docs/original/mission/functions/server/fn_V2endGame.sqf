/*
	Author: IvosH
	
	Description:
		terminates the mission if tickets are depleted or all sectors are captured by one side
	
	Parameter(s):
		NA
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf

	Execution: 
		[] spawn wrm_fnc_V2endGame;
*/
if !(isServer) exitWith {}; //only server
if (progress==5) exitWith {};

while {progress<5} do
{
	sleep 7;
	//west own all sectors
	if((getMarkerColor resFobW!="")&&(getMarkerColor resBaseW!="")&&(getMarkerColor resFobEW!="")&&(getMarkerColor resBaseEW!="")&&(getMarkerColor resAW!="")&&(getMarkerColor resBW!="")&&(getMarkerColor resCW!=""))
	then{[sideE,(([sideE] call BIS_fnc_respawnTickets)*-1)] call BIS_fnc_respawnTickets;};

	//east own all sectors
	if((getMarkerColor resFobE!="")&&(getMarkerColor resBaseE!="")&&(getMarkerColor resFobWE!="")&&(getMarkerColor resBaseWE!="")&&(getMarkerColor resAE!="")&&(getMarkerColor resBE!="")&&(getMarkerColor resCE!=""))
	then{[sideW,(([sideW] call BIS_fnc_respawnTickets)*-1)] call BIS_fnc_respawnTickets;};

	_restW = [sideW] call BIS_fnc_respawnTickets;
	_restE = [sideE] call BIS_fnc_respawnTickets;

	call
	{
		//failed
		if (_restW==0 && _restE==0) exitWith
		{
			progress = 5; publicVariable "progress";
			if(sideW==independent)then{[west,1] call BIS_fnc_respawnTickets;[west,-1] call BIS_fnc_respawnTickets;};
			if(sideE==independent)then{[east,1] call BIS_fnc_respawnTickets;[east,-1] call BIS_fnc_respawnTickets;};
			["EndFailed"] remoteExec ["BIS_fnc_endMission", 0, true];
		};
		//west wins
		if (_restE==0) exitWith
		{
			progress = 5; publicVariable "progress";
			if(sideW==independent)then{[west,_restW] call BIS_fnc_respawnTickets;};
			if(sideE==independent)then{[east,1] call BIS_fnc_respawnTickets;[east,-1] call BIS_fnc_respawnTickets;};
			if((sideW!=independent)&&(sideE!=independent))then{[independent,1] call BIS_fnc_respawnTickets;[independent,-1] call BIS_fnc_respawnTickets;};
			[endW] remoteExec ["BIS_fnc_endMission", 0, true];
		};
		//east wins
		if (_restW==0) exitWith
		{
			progress = 5; publicVariable "progress";
			if(sideW==independent)then{[west,1] call BIS_fnc_respawnTickets;[west,-1] call BIS_fnc_respawnTickets;};
			if(sideE==independent)then{[east,_restE] call BIS_fnc_respawnTickets;};
			if((sideW!=independent)&&(sideE!=independent))then{[independent,1] call BIS_fnc_respawnTickets;[independent,-1] call BIS_fnc_respawnTickets;};
			[endE] remoteExec ["BIS_fnc_endMission", 0, true];
		};
	};
};

//TASKS
//west control all
if((getMarkerColor resFobW!="")&&(getMarkerColor resBaseW!="")&&(getMarkerColor resFobEW!="")&&(getMarkerColor resBaseEW!="")&&(getMarkerColor resAW!="")&&(getMarkerColor resBW!="")&&(getMarkerColor resCW!=""))
then{["WW", "SUCCEEDED", true] call BIS_fnc_taskSetState;}
else{["WW", "FAILED", true] call BIS_fnc_taskSetState;};
//east control all
if((getMarkerColor resFobE!="")&&(getMarkerColor resBaseE!="")&&(getMarkerColor resFobWE!="")&&(getMarkerColor resBaseWE!="")&&(getMarkerColor resAE!="")&&(getMarkerColor resBE!="")&&(getMarkerColor resCE!=""))
then{["EW", "SUCCEEDED", true] call BIS_fnc_taskSetState;}
else{["EW", "FAILED", true] call BIS_fnc_taskSetState;};
//west captured east bases
if((getMarkerColor resFobEW!="")&&(getMarkerColor resBaseEW!=""))
then{["WA", "SUCCEEDED", true] call BIS_fnc_taskSetState; ["ED", "FAILED", true] call BIS_fnc_taskSetState;}
else{["WA", "FAILED", true] call BIS_fnc_taskSetState; ["ED", "SUCCEEDED", true] call BIS_fnc_taskSetState;};
//east captured west bases
if((getMarkerColor resFobWE!="")&&(getMarkerColor resBaseWE!=""))
then{["EA", "SUCCEEDED", true] call BIS_fnc_taskSetState; ["WD", "FAILED", true] call BIS_fnc_taskSetState;}
else{["EA", "FAILED", true] call BIS_fnc_taskSetState; ["WD", "SUCCEEDED", true] call BIS_fnc_taskSetState;};