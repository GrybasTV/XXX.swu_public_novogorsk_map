/*
	Author: IvosH
	
	Description:
		0 - Disabled (Only AI units lead by the player join the battle)
		1 - Continuous support-balanced (AI vehicles spawn continuously for both sides)
		2 - Continuous support-challenging (In coop AI vehicles spawn continuously on the enemy side)
	
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf

	Execution:
		[] execVM "warmachine\V2aiStart.sqf";
*/
if !(isServer) exitWith {}; //runs on the server/host

//RESPAWN positions for Continuous mechanized support and Units placed by Zeus
//if(missType>1&&AIon>0)then
if(true)then
{ 
	//find AI car base 1 west respawn position - optimizuota pagal dokumentacijos rekomendacijas
	posW1=[];
	_roadW1 = [posBaseW1,150,(posBaseW1 nearRoads 20)] call BIS_fnc_nearestRoad; //Sumažintas spindulys nuo 200->150 ir 30->20
	if(isNull _roadW1)then
	{
		_prW=objBaseW1 getRelPos [100,random 360];
		_vSel = selectRandom CarArW;
		if (_vSel isEqualType [])then{_vSel=_vSel select 0;};
		posW1 = _prW findEmptyPosition [0, 50, _vSel];
		if(count posW1==0)then{posW1=_prW;};
	}else
	{posW1= getPosATL _roadW1;};
	publicvariable "posW1";	
	
	//find AI armors base 2 west respawn position - optimizuota pagal dokumentacijos rekomendacijas
	posW2=[];
	_roadW2 = [posBaseW2,150,(posBaseW2 nearRoads 20)] call BIS_fnc_nearestRoad; //Sumažintas spindulys nuo 200->150 ir 30->20
	if(isNull _roadW2)then
	{
		_prW=objBaseW2 getRelPos [100,random 360];
		_vSel = selectRandom ArmorW2;
		if (_vSel isEqualType [])then{_vSel=_vSel select 0;};
		posW2 = _prW findEmptyPosition [0, 50, _vSel];
		if(count posW2==0)then{posW2=_prW;};
	}else
	{posW2= getPosATL _roadW2;};
	publicvariable "posW2";

	//find AI car base 1 east respawn position - optimizuota pagal dokumentacijos rekomendacijas
	posE1=[];
	_roadE1 = [posBaseE1,150,(posBaseE1 nearRoads 20)] call BIS_fnc_nearestRoad; //Sumažintas spindulys nuo 200->150 ir 30->20
	if(isNull _roadE1)then
	{
		_prW=objBaseE1 getRelPos [100,random 360];
		_vSel = selectRandom CarArE;
		if (_vSel isEqualType [])then{_vSel=_vSel select 0;};
		posE1 = _prW findEmptyPosition [0, 50, _vSel];
		if(count posE1==0)then{posE1=_prW;};
	}else
	{posE1= getPosATL _roadE1;};
	publicvariable "posE1";	
	
	//find AI armors base 2 east respawn position - optimizuota pagal dokumentacijos rekomendacijas
	posE2=[];
	_roadE2 = [posBaseE2,150,(posBaseE2 nearRoads 20)] call BIS_fnc_nearestRoad; //Sumažintas spindulys nuo 200->150 ir 30->20
	if(isNull _roadE2)then
	{
		_prW=objBaseE2 getRelPos [100,random 360];
		_vSel = selectRandom ArmorE2;
		if (_vSel isEqualType [])then{_vSel=_vSel select 0;};
		posE2 = _prW findEmptyPosition [0, 50, _vSel];
		if(count posE2==0)then{posE2=_prW;};
	}else
	{posE2= getPosATL _roadE2;};
	publicvariable "posE2";		
};

//wait for any player to leave the base OR first sector is captured
sleep rTime;
_t=true;
while {_t} do
{
	{
		if(!alive _x)exitWith{};
		call
		{
			if(side _x==sideW) exitWith {
				if((_x distance posBaseW1 > 200)&&(_x distance posBaseW2 > 200)) then {
					// Tikriname plHW tik jei jis apibrėžtas ir nėra null
					// Pagal oficialią dokumentaciją: pirmiausia patikriname isNil, tada isNull
					// Code block {} užtikrina trumpąjį patikrinimą (short-circuit evaluation)
					if(!isNil "plHW" && {!isNull plHW} && {_x distance plHW > 200}) then {
						_t=false;
					};
				};
			};
			if(side _x==sideE) exitWith {
				if((_x distance posBaseE1 > 200)&&(_x distance posBaseE2 > 200)) then {
					// Tikriname plHE tik jei jis apibrėžtas ir nėra null
					// Pagal oficialią dokumentaciją: pirmiausia patikriname isNil, tada isNull
					// Code block {} užtikrina trumpąjį patikrinimą (short-circuit evaluation)
					if(!isNil "plHE" && {!isNull plHE} && {_x distance plHE > 200}) then {
						_t=false;
					};
				};
			};
		};
	} forEach allPlayers;
	
	if(!_t)exitWith{};
	
	if((getMarkerColor resAW!="")||(getMarkerColor resAE!="")||(getMarkerColor resBW!="")||(getMarkerColor resBE!="")||(getMarkerColor resCW!="")||(getMarkerColor resCE!=""))then{_t=false;};
	
	sleep 11;
};
//spawn additional units
if (AIon>2) then 
{
	#include "moreSquads.sqf";
};
sleep 7;

//start countdown
if(timeLim>0)then{[]spawn wrm_fnc_timer;}; 

//teleport AI units to the objectives
if(AIon>0)then
{ 
	_plw={side _x==sideW} count allplayers;
	_ple={side _x==sideE} count allplayers;
	_grps=[];
	call
	{
		if ((_plw>0)&&(_ple==0))
		exitWith {{if ((side _x==sideE)&&(!isPlayer leader _x)&&(count units _x>0)&&(str _x != "O HQ")&&(str _x != "R HQ"))then{_grps pushBackUnique _x};} forEach allGroups;}; //teleport EAST
		if((_ple>0)&&(_plw==0))
		exitWith{{if ((side _x==sideW)&&(!isPlayer leader _x)&&(count units _x>0)&&(str _x != "B HQ")&&(str _x != "R HQ"))then{_grps pushBackUnique _x};} forEach allGroups;}; //teleport WEST
	};

	if(count _grps!=0)then
	{
		_s= selectRandom [
		[posAA,posArti,posCas],[posAA,posArti],[posAA],
		[posAA,posArti,posCas],[posAA,posCas],[posArti],
		[posAA,posArti,posCas],[posArti,posCas],[posCas]
		];
		if(ticBleed==0)then
		{
			_s= selectRandom [
			[posAA,posArti,posCas],[posAA,posArti],
			[posAA,posArti,posCas],[posAA,posCas],
			[posAA,posArti,posCas],[posArti,posCas],
			[posAA,posArti,posCas]
			];
		};
		_secs=_s;
		//while{(count _grps!=0)&&(count _secs!=0)}do
		while{(count _grps!=0)}do
		{
			if(count _secs==0)then{_secs=_s;};
			_grp=_grps select 0;
			_sec=_secs select 0;
			{_x setVehiclePosition [[((_sec select 0)+(round(20+(random 20))*(selectRandom[-1,1]))),((_sec select 1)+(round(20+(random 20))*(selectRandom[-1,1])))], [], 0, "NONE"];}forEach units _grp;
			_grps=_grps-[_grp];
			_secs=_secs-[_sec];
		};
	};
	
};

#include "baseDefense.sqf"; //spawn base defense

//Įjungiame Dinaminę Simuliaciją pagal dokumentacijos rekomendacijas
enableDynamicSimulationSystem true;
"Group" setDynamicSimulationDistance 1000;
"Vehicle" setDynamicSimulationDistance 2500;
"EmptyVehicle" setDynamicSimulationDistance 500;

[] spawn wrm_fnc_V2aiVehUpdate;

//wait for any player to be close to any sector or enemy base
if(count allPlayers>0)then
{
	_t=true;
	while {_t} do
	{
		{
			if(!alive _x)exitWith{};
			if(_x distance posArti < 300)then{_t=false;};
			if(_x distance posCas < 300)then{_t=false;};
			if(_x distance posAA < 300)then{_t=false;};
			call
			{
				if(side _x==sideW)exitWith
				{
					if(_x distance posBaseE1 < 600)then{_t=false;};
					if(_x distance posBaseE2 < 600)then{_t=false;};
				};
				if(side _x==sideE)exitWith
				{
					if(_x distance posBaseW1 < 600)then{_t=false;};
					if(_x distance posBaseW2 < 600)then{_t=false;};
				};
			};
		} forEach allPlayers;
		sleep 11;
	};
};

//AI use artillery & CAS
if(AIon>0)then
{ 
	[] spawn wrm_fnc_V2aiArtillery;
	[] spawn wrm_fnc_V2aiCAS;
};

//ticket bleed
if(ticBleed>0)then{[] spawn wrm_fnc_V2ticketBleed;};