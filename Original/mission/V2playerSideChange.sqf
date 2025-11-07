/*
	Author: IvosH
	
	Description:
		Change players side to independent, dedicated server and JIP players
		
	Parameter(s):
		NA
		
	Returns:
		NA
		
	Dependencies:
		init.sqf (client)

	Execution:
		[] execVM "V2playerSideChange.sqf";
*/

waitUntil{!isNull player};
waitUntil{!alive player};

if(((sideW==independent)&&(playerSide==west))||((sideE==independent)&&(playerSide==east)))then
{
	//change side
	_grps=[];
	if(playerSide==west)then{_grps=[W1,W2,W3,W4]};
	if(playerSide==east)then{_grps=[E1,E2,E3,E4]};
	_grp=_grps select ((parseNumber((str player) select [1,1]))-1);
	//if JIP then delete AI
	{
		if(!isPlayer _x)then
		{
			if((str _x)==(str player))then
			{
				_grp=group _x;
				deleteVehicle _x;
				if(DBG)then{systemChat "AI deleted";};
			};
		};
	}forEach allUnits;

	_no=(parseNumber((str player) select [3,1]));
	player joinAsSilent [_grp,_no];
	
	//wait to all AI units are independent on client
	hint "Waiting for Factions synchronisation";
	systemChat "Waiting for Factions synchronisation";
	_wait=true;
	while {_wait} do
	{
		if(({side _x==west} count (playableunits-AllPlayers))==0)then{_wait=false;};
		if(({side _x==east} count (playableunits-AllPlayers))==0)then{_wait=false;};
		sleep 0.1;
	};
	rTime=5;
	setPlayerRespawnTime rTime;	
	hintSilent "";	
	systemChat "Factions loaded";
	[] execVM "V2clearLoadouts.sqf";
	while{playerSide!=independent}do
	{
		player joinAsSilent [_grp,_no];
		sleep 1;
	};
	
	if(didJip)then
	{
		
		//respawn EH
		player addMPEventHandler
		["MPRespawn", 
			{
				params ["_unit","_corpse"];
				if(version==2)then{[_unit,_corpse] spawn wrm_fnc_V2respawnEH;}else{[_unit] spawn wrm_fnc_respawnEH;};
			}
		];
	};
		
	//killed EH
	player addMPEventHandler
	["MPKilled",{[(_this select 0),(playerSide)] spawn wrm_fnc_killedEH;}];
	
	//add to zeus
	[z1,[[player],true]] remoteExec ["addCuratorEditableObjects", 2, false];
		
	waitUntil{alive player};
	[player] call wrm_fnc_V2nationChange;
	
	//leader
	if(_no==1)then
	{
		if(!isPlayer(leader player))then
		{
			[group player, player] remoteExec ["selectLeader", 0, false];
		};
	};
	
	//check the position in the squad > reorder the squd
	if(!didJip)then
	{		
		_i=0;
		while{((str((units _grp) select (_no-1)))!=(str player))}do
		{
			{
				_n=(parseNumber((str _x) select [3,1]));
				_x joinAsSilent [_grp,(_n+10)];
			}forEach (units _grp);
			{
				_n=(parseNumber((str _x) select [3,1]));
				_x joinAsSilent [_grp,_n];
			}forEach (units _grp);
			_i=_i+1;
			sleep 1;
		};
		if(DBG)then{systemChat format ["Player No.%1 Try %2",_no,_i];};		
	};
	systemChat "Player Side Changed";
}else
{
	rTime=5;
	setPlayerRespawnTime rTime;
	systemChat "Factions loaded";
	[] execVM "V2clearLoadouts.sqf";
	waitUntil{alive player};
	sleep 1;
	[player] call wrm_fnc_V2nationChange;
};

