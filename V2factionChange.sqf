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
				//Laukti, kol AI unit'as taps gyvas su timeout'u
				private _timeout = time + 10; //10 sekundžių timeout
				waitUntil {alive _x || time > _timeout};
				if (time > _timeout || !alive _x) exitWith {}; //Jei timeout'as pasiektas arba unit'as neegzistuoja, išeiti
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
					//Laukti, kol AI unit'as taps gyvas su timeout'u
					private _timeout = time + 10; //10 sekundžių timeout
					waitUntil {alive _x || time > _timeout};
					if (time > _timeout || !alive _x) exitWith {}; //Jei timeout'as pasiektas arba unit'as neegzistuoja, išeiti
					_x setPos getPos plH2;
					_grp=[E1,E2,E3,E4] select ((parseNumber((str _x) select [1,1]))-1);
					_no=(parseNumber((str _x) select [3,1]));
					
					_i=0;
					//Pridėti timeout'ą, kad ciklas neužstrigtų, jei side niekada netampa independent
					//Be sleep, šis ciklas gali sukelti begalinę kilpą ir "No alive" timeout'us
					//Timeout'as 15 sekundžių - pakankamai ilgas, kad side keitimasis galėtų įvykti net ir su tinklo delsa
					private _timeout = time + 15; //15 sekundžių timeout (pakankamai ilgas, kad side keitimasis įvyktų)
					while{side _x!=independent && time < _timeout}do
					{
						_x joinAsSilent [_grp,_no];	
						_i=_i+1;
						sleep 0.1; //Pridėti sleep, kad neapkrautumėme procesoriaus
					};
					if(DBG)then{[format ["Unit %1 changed. Try %2",_x,_i]] remoteExec ["systemChat", 0, false];};
					
					//Laukti, kol side taps independent su timeout'u
					//Jei while ciklas jau padarė joinAsSilent, side turėtų būti independent per kelias sekundes
					//Bet jei yra tinklo delsa arba kitų problemų, gali užtrukti
					_timeout = time + 10; //10 sekundžių timeout (pakankamai ilgas po joinAsSilent)
					waitUntil{side _x==independent || time > _timeout};
					if (time > _timeout) then {
						//Jei timeout'as pasiektas, pranešti apie problemą, bet tęsti darbą
						//Tęsti loadout ir nation change, nes tai gali padėti
						if(DBG)then{[format ["WARNING: Unit %1 side change timeout - continuing anyway",_x]] remoteExec ["systemChat", 0, false];};
					};
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
				//Laukti, kol AI unit'as taps gyvas su timeout'u
				private _timeout = time + 10; //10 sekundžių timeout
				waitUntil {alive _x || time > _timeout};
				if (time > _timeout || !alive _x) exitWith {}; //Jei timeout'as pasiektas arba unit'as neegzistuoja, išeiti
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
					//Laukti, kol AI unit'as taps gyvas su timeout'u
					private _timeout = time + 10; //10 sekundžių timeout
					waitUntil {alive _x || time > _timeout};
					if (time > _timeout || !alive _x) exitWith {}; //Jei timeout'as pasiektas arba unit'as neegzistuoja, išeiti
					_x setPos getPos plH2;
					_grp=[W1,W2,W3,W4] select ((parseNumber((str _x) select [1,1]))-1);
					_no=(parseNumber((str _x) select [3,1]));
					
					_i=0;
					//Pridėti timeout'ą, kad ciklas neužstrigtų, jei side niekada netampa independent
					//Be sleep, šis ciklas gali sukelti begalinę kilpą ir "No alive" timeout'us
					//Timeout'as 15 sekundžių - pakankamai ilgas, kad side keitimasis galėtų įvykti net ir su tinklo delsa
					private _timeout = time + 15; //15 sekundžių timeout (pakankamai ilgas, kad side keitimasis įvyktų)
					while{side _x!=independent && time < _timeout}do
					{
						_x joinAsSilent [_grp,_no];	
						_i=_i+1;
						sleep 0.1; //Pridėti sleep, kad neapkrautumėme procesoriaus
					};
					if(DBG)then{[format ["Unit %1 changed. Try %2",_x,_i]] remoteExec ["systemChat", 0, false];};
					
					//Laukti, kol side taps independent su timeout'u
					//Jei while ciklas jau padarė joinAsSilent, side turėtų būti independent per kelias sekundes
					//Bet jei yra tinklo delsa arba kitų problemų, gali užtrukti
					_timeout = time + 10; //10 sekundžių timeout (pakankamai ilgas po joinAsSilent)
					waitUntil{side _x==independent || time > _timeout};
					if (time > _timeout) then {
						//Jei timeout'as pasiektas, pranešti apie problemą, bet tęsti darbą
						//Tęsti loadout ir nation change, nes tai gali padėti
						if(DBG)then{[format ["WARNING: Unit %1 side change timeout - continuing anyway",_x]] remoteExec ["systemChat", 0, false];};
					};
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
	//Laukti šiek tiek, kad unit'ai būtų pilnai inicializuoti prieš pritaikant loadout'us
	//Tai padeda išvengti TFAR ir kitų mod'ų klaidų
	sleep 1;
	
	//Naudoti spawn, kad loadout'ai būtų pritaikomi asinchroniškai ir neblokuotų kitų funkcijų
	{[_x] spawn wrm_fnc_V2loadoutChange;} forEach playableUnits;
	{if(!isPlayer _x)then{[_x] call wrm_fnc_V2nationChange;};} forEach playableUnits;
	["AI units ready"] remoteExec ["systemChat", 0, false];
};
