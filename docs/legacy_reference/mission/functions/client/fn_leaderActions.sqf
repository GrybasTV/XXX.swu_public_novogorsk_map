/*
	Author: IvosH
	
	Description:
		Check if player is group leader add Actions. Update combat support and action menu available for the group leader.
		lUpdate: 0 = respawn, 1 = was leader in last update, 2 = wasn't leader last update
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		onPlayerRespawn.sqf
		fn_leaderUpdate.sqf
		
	Execution:
		[] spawn wrm_fnc_leaderActions;
*/

if (!hasInterface) exitWith {}; //run on all players include server host

divE=[]; divW=""; divM="";
call
{
	if (side player == sideW) exitWith {SupReq = SupReqW;};
	If (side player == sideE) exitWith {SupReq = SupReqE;};
};

//Before mission starts
if (progress < 1 && lUpdate < 1) then 
{
	_a=0;
	call
	{
		if("wmgenerator" call BIS_fnc_getParamValue == 2)exitWith{_a=1;}; //2
		if(serverCommandAvailable "#kick")exitWith{_a=1;}; //0
		if(("wmgenerator" call BIS_fnc_getParamValue == 1)&&(count(allPlayers - entities "HeadlessClient_F")==1))exitWith{_a=1;}; //1
	};
	if(_a==1)then //Mission generator
	{
		MGaction = player addAction 
		[
			"Open Mission generator", //title
			{
				if (progress < 1) then 
				{
					if (version==2) then {dialogOpen = createDialog "V2missionsGenerator";} else {dialogOpen = createDialog "missionsGenerator";};
				};
			}, //script
			nil, //arguments (Optional)
			6, //priority (Optional)
			true, //showWindow (Optional)
			true, //hideOnUse (Optional)
			"", //shortcut, (Optional) 
			"", //condition,  (Optional)
			-1, //radius, (Optional)
			false, //unconscious, (Optional)
			"" //selection]; (Optional)
		]; 
	if ("autoStart" call BIS_fnc_getParamValue != 0) then //Stop countdown
	{
		stopAction = player addAction 
		[
			"<t color='#FF0000'>Stop countdown</t>", //title
			{
				aStart=0; publicVariable "aStart";
			}, //script
			nil, //arguments (Optional)
			5.9, //priority (Optional)
			true, //showWindow (Optional)
			true, //hideOnUse (Optional)
			"", //shortcut, (Optional) 
			"aStart==1", //condition,  (Optional)
			-1, //radius, (Optional)
			false, //unconscious, (Optional)
			"" //selection]; (Optional)
		];
	};
	};
};

//player IS leader
if (leader player == player) then 
{
	if (lUpdate != 1) then 
	{
		if (lUpdate == 2) then //remove "Become leader"
		{
			player removeAction LDRaction;
		};			
		[player, SupReq] remoteExec ["BIS_fnc_addSupportLink", 0, false]; //add support module
	
		LDRdown = player addAction
		[
			"Leave Leader position", //title
			{
					_grp=(units group player)-[player];
					if((count _grp)<1)exitWith{hint "You are alone";};
					//player become leader of his group
					[group player, (_grp select 0)] remoteExec ["selectLeader", 0, false];
					player removeAction LDRdown;
					hint "You are no longer a squad leader";
					sleep 0.5;
					lUpdate = 1;
					[] spawn wrm_fnc_leaderActions;

			}, //script
			nil, 0, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
		];		
	
		if(progress>1)then
		{			

			if(version==2)then
			{
				if((modA=="A3")&&(missType>1))then
				{
					uavAction = player addAction 
					[
						"UAV request", //title
						{
							[0,(side player)] spawn wrm_fnc_V2uavRequest; //0=uav, 1=ugv
						}, //script
						nil, //arguments (Optional)
						1, //priority (Optional)
						false, //showWindow (Optional)
						true, //hideOnUse (Optional)
						"", //shortcut, (Optional) 
						"", //condition,  (Optional)
						0, //radius, (Optional) -1disable, 15max
						false, //unconscious, (Optional)
						"" //selection]; (Optional)
					]; 

					ugvAction = player addAction 
					[
						"UGV request", //title
						{
							[1,(side player)] spawn wrm_fnc_V2uavRequest; //0=uav, 1=ugv
						}, //script
						nil, //arguments (Optional)
						0.9, //priority (Optional)
						false, //showWindow (Optional)
						true, //hideOnUse (Optional)
						"", //shortcut, (Optional) 
						"", //condition,  (Optional)
						0, //radius, (Optional) -1disable, 15max
						false, //unconscious, (Optional)
						"" //selection]; (Optional)
					]; 
				};
			};
			
			if(airDrop==0)then
			{
				if (suppUsed==0||carUsed==0||truckUsed==0||boatArUsed==0||boatTrUsed==0) then
				{
					dropAction = player addAction 
					[
						"Air drop", //title
						{
							[] call wrm_fnc_airDrop;
							player removeAction dropAction;
							airDrop=1;
						}, //script
						nil, //arguments (Optional)
						0.8, //priority (Optional)
						false, //showWindow (Optional)
						false, //hideOnUse (Optional)
						"", //shortcut, (Optional) 
						"", //condition,  (Optional)
						0, //radius, (Optional) -1disable, 15max
						false, //unconscious, (Optional)
						"" //selection]; (Optional)
					]; 
				};
			};
			fort=0;
			fortAction = player addAction 
			[
				"Fortification", //title
				{
					//[] call wrm_fnc_fortification;
					player removeAction fortAction;
					fort=1;
				}, //script
				nil, //arguments (Optional)
				0.3, //priority (Optional)
				false, //showWindow (Optional)
				false, //hideOnUse (Optional)
				"", //shortcut, (Optional) 
				"", //condition,  (Optional)
				0, //radius, (Optional) -1disable, 15max
				false, //unconscious, (Optional)
				"" //selection]; (Optional)
			]; 

		};
		lUpdate = 1;
	};
} else 

//player is NOT leader
{
	if (lUpdate != 2) then 
	{
		if (lUpdate == 1) then 
		{
			player removeAction LDRdown; //remove "Leave Leader position"

			if(progress>1)then
			{
				if(version==2)then
				{
					if((modA=="A3")&&(missType>1))then
					{
						player removeAction uavAction;
						player removeAction ugvAction;
					};
				};
				if(fort==0)then
				{
					player removeAction fortAction;
					fort=1;
				};

				if(airDrop==0)then
				{
					if (suppUsed==0||carUsed==0||truckUsed==0||boatArUsed==0||boatTrUsed==0) then 
					{
						player removeAction dropAction;
					};
				}else
				{
					if (suppUsed==0) then {player removeAction supplyAction;};
					if (carUsed==0) then {player removeAction carAction;};
					if (truckUsed==0) then {player removeAction truckAction;};
					if (boatTrUsed==0) then {player removeAction BoatTrAction;};		
					if (((count boatArW!=0)&&(count boatArE!=0)) && boatArUsed==0) then {player removeAction BoatArAction;};
					airDrop = 0;
				};
			};
		};
		
		[player, SupReq] remoteExec ["BIS_fnc_removeSupportLink", 0, false];
		LDRaction = player addAction 
		[
			"Become Squad leader", //title
			{
				//condition: if squad leader is controled by any player
				if (isPlayer leader player) then
				{
					//leader is not changed, hint is displayed
					hint "Command is available only if squad leader is controled by an AI";
				} else
				//if squad leader is controled by an AI code is executed
				{
					//player become leader of his group
					[group player, player] remoteExec ["selectLeader", 0, false];
					player removeAction LDRaction;
					_ldr = profileName;
					_grp = group player;
					[_ldr,_grp] remoteExec ["wrm_fnc_leaderHint", 0, false];
					sleep 0.5;
					lUpdate = 2;
					[] spawn wrm_fnc_leaderActions;
				};	
			}, //script
			nil, 0, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
		]; 
		lUpdate = 2;
	};
};