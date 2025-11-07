/*
	Author: IvosH
	
	Description:
		Change Factions on the mission start
		default factionW=="NATO", factionE=="CSAT"
		
	Parameter(s):
		0: VARIABLE respawned unit
		
	Returns:
		BOOL
		
	Dependencies:
		init.sqf (server)

	Execution:
		#include "V2factionChange.sqf";
		[] execVM "V2factionChange.sqf";
*/

//change side
call
{
	//AAF, LDF, UK Army, Desert rats, US Army
	if(sideE==independent)exitWith
	{
		//marker
		_mrk = createMarker [resStartE, (getMarkerPos "respawn_east_start")];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "empty";
		_mrk setMarkerText "BASE";
		//deleteMarker "respawn_east_start";
		
		{
			if((!isPlayer _x)&&(((str _x) select [0,1])=="E"))then
			{				
				waitUntil{alive _x};
				_x setPos getPos plH1;
				_x hideObjectGlobal true;	
			};
		}forEach playableUnits;
		
		E1=createGroup [independent, false];
		publicVariable "E1";
		E2=createGroup [independent, false];
		publicVariable "E2";
		E3=createGroup [independent, false];
		publicVariable "E3";
		E4=createGroup [independent, false];
		publicVariable "E4";
		["Changing to independent side"] remoteExec ["systemChat", 0, false];
		{
			if(!isPlayer _x)then
			{				
				if(((str _x) select [0,1])=="E")then
				{
					waitUntil{alive _x};
					_x setPos getPos plH2;
					_grp=[E1,E2,E3,E4] select ((parseNumber((str _x) select [1,1]))-1);
					_no=(parseNumber((str _x) select [3,1]));
					
					_i=0;
					while{side _x!=independent}do
					{
						_x joinAsSilent [_grp,_no];	
						_i=_i+1;	
					};
					if(DBG)then{[format ["Unit %1 changed. Try %2",_x,_i]] remoteExec ["systemChat", 0, false];};
					
					waitUntil{side _x==independent};
					[_x] call wrm_fnc_V2loadoutChange;
					[_x] call wrm_fnc_V2nationChange;
					_sec = getMarkerPos resStartE;
					_x setPos [((_sec select 0)+(round(10+(random 10))*(selectRandom[-1,1]))),((_sec select 1)+(round(10+(random 10))*(selectRandom[-1,1])))];
					_x hideObjectGlobal false;	
				}else
				{
					[_x] call wrm_fnc_V2loadoutChange;
					[_x] call wrm_fnc_V2nationChange;
				};
			};
		}forEach playableUnits;
		["AI units ready"] remoteExec ["systemChat", 0, false];
	};
	
	//AAF
	if(sideW==independent)exitWith
	{
		//marker
		_mrk = createMarker [resStartW, (getMarkerPos "respawn_west_start")];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "empty";
		_mrk setMarkerText "BASE";
		//deleteMarker "respawn_west_start";
		
		{
			if((!isPlayer _x)&&(((str _x) select [0,1])=="W"))then
			{				
				waitUntil{alive _x};
				_x setPos getPos plH1;
				_x hideObjectGlobal true;		
			};
		}forEach playableUnits;

		W1=createGroup [independent, false];
		publicVariable "W1";
		W2=createGroup [independent, false];
		publicVariable "W2";
		W3=createGroup [independent, false];
		publicVariable "W3";
		W4=createGroup [independent, false];
		publicVariable "W4";
		["Changing to independent side"] remoteExec ["systemChat", 0, false];
		{
			if(!isPlayer _x)then
			{
				if(((str _x) select [0,1])=="W")then
				{				
					waitUntil{alive _x};
					_x setPos getPos plH2;
					_grp=[W1,W2,W3,W4] select ((parseNumber((str _x) select [1,1]))-1);
					_no=(parseNumber((str _x) select [3,1]));
					
					_i=0;
					while{side _x!=independent}do
					{
						_x joinAsSilent [_grp,_no];	
						_i=_i+1;	
					};
					if(DBG)then{[format ["Unit %1 changed. Try %2",_x,_i]] remoteExec ["systemChat", 0, false];};
					
					waitUntil{side _x==independent};
					[_x] call wrm_fnc_V2loadoutChange;
					[_x] call wrm_fnc_V2nationChange;
					_sec = getMarkerPos resStartW;
					_x setPos [((_sec select 0)+(round(10+(random 10))*(selectRandom[-1,1]))),((_sec select 1)+(round(10+(random 10))*(selectRandom[-1,1])))];
					_x hideObjectGlobal false;	
				}else
				{
					[_x] call wrm_fnc_V2loadoutChange;
					[_x] call wrm_fnc_V2nationChange;
				};
			};
		}forEach playableUnits;
		["AI units ready"] remoteExec ["systemChat", 0, false];
	};
};

//change loadout (not side)
if(sideW!=independent&&sideE!=independent)then
{
	{[_x] call wrm_fnc_V2loadoutChange;} forEach playableUnits;
	{if(!isPlayer _x)then{[_x] call wrm_fnc_V2nationChange;};} forEach playableUnits;
	["AI units ready"] remoteExec ["systemChat", 0, false];
};
