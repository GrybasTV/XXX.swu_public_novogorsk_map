/*
	Author: GrybasTv
	
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
//Patikrinti ir inicializuoti SupReq pagal žaidėjo pusę
//SupReqW ir SupReqE turėtų būti apibrėžti mission.sqm kaip SupportRequester objektai
call
{
	if (side player == sideW) exitWith 
	{
		//Patikrinti ar SupReqW yra apibrėžtas
		if (isNil "SupReqW") then 
		{
			SupReq = objNull;
			systemChat "ERROR: SupReqW is not defined! Squad leader menu may not work.";
		} else 
		{
			SupReq = SupReqW;
		};
	};
	if (side player == sideE) exitWith 
	{
		//Patikrinti ar SupReqE yra apibrėžtas
		if (isNil "SupReqE") then 
		{
			SupReq = objNull;
			systemChat "ERROR: SupReqE is not defined! Squad leader menu may not work.";
		} else 
		{
			SupReq = SupReqE;
		};
	};
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
			"" //selection (Optional)
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
			"" //selection (Optional)
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
		//Patikrinti ar SupReq yra teisingai inicializuotas prieš kviečiant BIS_fnc_addSupportLink
		if (!isNil "SupReq" && !isNull SupReq) then
		{
			[player, SupReq] call BIS_fnc_addSupportLink; //add support module - kviečiame kliento pusėje su call
		} else
		{
			//Debug: patikrinti ar SupReqW/SupReqE yra apibrėžti
			if (side player == sideW) then
			{
				if (isNil "SupReqW") then {systemChat "ERROR: SupReqW is nil!";} else {systemChat format ["SupReqW: %1", SupReqW];};
			} else
			{
				if (isNil "SupReqE") then {systemChat "ERROR: SupReqE is nil!";} else {systemChat format ["SupReqE: %1", SupReqE];};
			};
		};
	
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
					//Perkelti į spawn kontekstą dėl sleep naudojimo
					[] spawn {
						sleep 0.5;
						lUpdate = 1;
						[] spawn wrm_fnc_leaderActions;
					};

			}, //script
			nil, 0, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
		];		
	
		if(progress>1)then
		{			

			if(version==2)then
			{
				//Dronai prieinami tik jei misijos tipas >1 (ne infantry) ir yra dronų masyvuose
				_hasUAV = false;
				_hasUGV = false;
				call
				{
					if(side player == sideW)exitWith
					{
						_hasUAV = (count uavsW > 0);
						_hasUGV = (count ugvsW > 0);
					};
					if(side player == sideE)exitWith
					{
						_hasUAV = (count uavsE > 0);
						_hasUGV = (count ugvsE > 0);
					};
				};
				
				//UAV request - prieinamas A3 modui arba Ukraine/Russia frakcijoms (visuose režimuose)
				if((modA=="A3" || (modA=="UA2025_RU2025" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) && _hasUAV)then
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
						"" //selection (Optional)
					]; 
				};

				//UGV request - prieinamas tik A3 modui (ne Ukraine/Russia frakcijoms)
				//Ukraine/Russia frakcijoms prieinamas tik UAV
				if(modA=="A3" && _hasUGV)then
				{
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
						"" //selection (Optional)
					]; 
				};
			};
			
			if(airDrop==0)then
			{
				if (suppUsed==0||carUsed==0||truckUsed==0) then
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
						"" //selection (Optional)
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
				"" //selection (Optional)
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
					if((modA=="A3" || (modA=="UA2025_RU2025" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) )then
					{
						if(!isNil "uavAction")then{player removeAction uavAction;};
						if(!isNil "ugvAction")then{player removeAction ugvAction;};
					};
				};
				if(fort==0)then
				{
					player removeAction fortAction;
					fort=1;
				};

				if(airDrop==0)then
				{
					if (suppUsed==0||carUsed==0||truckUsed==0) then 
					{
						player removeAction dropAction;
					};
				}else
				{
					if (suppUsed==0) then {player removeAction supplyAction;};
					if (carUsed==0) then {player removeAction carAction;};
					if (truckUsed==0) then {player removeAction truckAction;};
					//Boat drop action'ų pašalinimas pašalintas - nenaudojame
					airDrop = 0;
				};
			};
		};
		
		//Patikrinti ar SupReq yra teisingai inicializuotas prieš šalinant support link
		if (!isNil "SupReq" && !isNull SupReq) then
		{
			[player, SupReq] call BIS_fnc_removeSupportLink; //remove support module - kviečiame kliento pusėje su call
		};
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
					//Perkelti į spawn kontekstą dėl sleep naudojimo
					[] spawn {
						sleep 0.5;
						lUpdate = 2;
						[] spawn wrm_fnc_leaderActions;
					};
				};	
			}, //script
			nil, 0, false, true, "", "", -1, false, "" //arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection
		];
	};
};
