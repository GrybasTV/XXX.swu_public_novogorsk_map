//BIG THINGS HERE

if !(isServer) exitWith {}; //only server

[0] remoteExec ["closeDialog", 0, false]; //close dialogs on clients

//mission parameters
aoType = _this select 0;
missType = _this select 1; 
day = _this select 2; 
resTickets = _this select 3; 
weather = _this select 4; 
ticBleed = _this select 5; 
fogLevel = _this select 6; 
timeLim = _this select 7; 
AIon = _this select 8; 
resType = _this select 9; 
revOn = _this select 10; 
resTime = _this select 11; 
viewType = _this select 12; 
vehTime = _this select 13; 
//objectives position
posArti = _this select 14; 
posCas = _this select 15; 
posAA = _this select 16; 
posBaseW1 = _this select 17;
posBaseW2 = _this select 18; 
posBaseE1 = _this select 19; 
posBaseE2 = _this select 20; 
//infantry respawn 
resArtiW = _this select 21; 
resArtiE = _this select 22; 
resCasW = _this select 23; 
resCasE = _this select 24; 
resAAW = _this select 25; 
resAAE = _this select 26; 
resBaseW1W = _this select 27; 
resBaseW1E = _this select 28; 
resBaseW2W = _this select 29; 
resBaseW2E = _this select 30; 
resBaseE1W = _this select 31; 
resBaseE1E = _this select 32; 
resBaseE2W = _this select 33; 
resBaseE2E = _this select 34;  
//vehicle respawn
rBikeW = _this select 35; 
rTruckW = _this select 36; 
rHeliTrW = _this select 37; 
rCarArW = _this select 38; 
rCarW = _this select 39; 
rArmorW1 = _this select 40; 
rHeliArW = _this select 41; 
rArmorW2 = _this select 42;
rBikeE = _this select 43; 
rTruckE = _this select 44; 
rHeliTrE = _this select 45; 
rCarArE = _this select 46; 
rCarE = _this select 47; 
rArmorE1 = _this select 48; 
rHeliArE = _this select 49; 
rArmorE2 = _this select 50; 
//directions
dirBW = _this select 51; 
dirBE = _this select 52;
AOsize = _this select 53;

//CREATE AO (Random)
if (aoType==0) then
{
	//select random location on the map
	AOcreated = 0;
	_locations = nearestLocations [[worldSize/2,worldSize/2], ["NameCity","NameCityCapital","NameVillage","NameLocal","Airport"], (worldSize/2)];
	_i=1;
	_maxAttempts = 1000; //Maksimalus bandymų skaičius - padidinta iki 100, kad sistema turėtų daugiau galimybių rasti tinkamą poziciją
	_l=count _locations;
	
	//Bandoma su lokacijomis iš žemėlapio
	//FIX: Pridėti timeout'ą waitUntil ciklams, kad sistema neužstrigtų
	while {(AOcreated == 0)&&(count _locations>0)&&(_i<=_maxAttempts)} do 
	{
		[parseText format ["Creating area of operation<br/>Location %1/%2",_i,_maxAttempts]] remoteExec ["hint", 0, false];
		_loc = _locations select (floor (random (count _locations)));
		_locations = _locations - [_loc];
		_p = locationPosition _loc;
		[_p] execVM "warmachine\V2aoCreate.sqf";
		//Timeout: maksimalus laukimo laikas 30 sekundžių
		private _timeout = time + 30;
		waitUntil {AOcreated == 2 || time > _timeout};
		if (time > _timeout) then {
			//Timeout'as pasiektas - AO sukurti nepavyko, bandyti kitą lokaciją
			AOcreated = 0;
			if(DBG)then{systemChat format ["AO creation timeout for location %1", _i];};
		} else {
			//AO sukurtas, laukti kol bus baigtas
			_timeout = time + 30;
			waitUntil {AOcreated != 2 || time > _timeout};
			if (time > _timeout && AOcreated == 2) then {
				//Timeout'as pasiektas, bet AO vis dar 2 - reikia reset'inti
				AOcreated = 0;
				if(DBG)then{systemChat format ["AO creation stuck at state 2 for location %1", _i];};
			};
		};
		_i=_i+1;
	};
	
	//Jei lokacijų nepakanka arba visos nepavyko, bandoma su random pozicijomis žemėlapyje
	//FIX: Pridėti timeout'ą waitUntil ciklams, kad sistema neužstrigtų
	while {(AOcreated == 0)&&(_i<=_maxAttempts)} do 
	{
		[parseText format ["Creating area of operation<br/>Random position %1/%2",_i,_maxAttempts]] remoteExec ["hint", 0, false];
		//Generuojama random pozicija žemėlapyje (atsitraukiant nuo kraštų)
		_p = [
			random [500, worldSize/2, worldSize-500],
			random [500, worldSize/2, worldSize-500],
			0
		];
		[_p] execVM "warmachine\V2aoCreate.sqf";
		//Timeout: maksimalus laukimo laikas 30 sekundžių
		private _timeout = time + 30;
		waitUntil {AOcreated == 2 || time > _timeout};
		if (time > _timeout) then {
			//Timeout'as pasiektas - AO sukurti nepavyko, bandyti kitą poziciją
			AOcreated = 0;
			if(DBG)then{systemChat format ["AO creation timeout for random position %1", _i];};
		} else {
			//AO sukurtas, laukti kol bus baigtas
			_timeout = time + 30;
			waitUntil {AOcreated != 2 || time > _timeout};
			if (time > _timeout && AOcreated == 2) then {
				//Timeout'as pasiektas, bet AO vis dar 2 - reikia reset'inti
				AOcreated = 0;
				if(DBG)then{systemChat format ["AO creation stuck at state 2 for random position %1", _i];};
			};
		};
		_i=_i+1;
	};
};

if(aoType==0 && AOcreated==0)exitWith
{
	[parseText format ["ERROR<br/>AO Creation failed<br/>Select AO manually"]] remoteExec ["hint", 0, false];
	progress = 0; 
	publicVariable "progress";
	[3] remoteExec ["titleFadeOut", 0, false];
};
if(aoType==0 && AOcreated>0)then{["AO created succesfuly"] remoteExec ["systemChat", 0, false];};

//random mission type
if (missType==0)then{missType = selectrandom [1,2,3]};
if(missType==1)then
{
	nameBW1 = format ["%1 Transport base",factionW]; publicvariable "nameBW1";
	nameBE1 = format ["%1 Transport base",factionE]; publicvariable "nameBE1";
	nameBW2 = format ["%1 Helicopter base",factionW];
	nameBE2 = format ["%1 Helicopter base",factionE];
	if(count HeliTrW==0)then{nameBW2 = format ["%1 Infantry base",factionW];};
	if(count HeliTrE==0)then{nameBE2 = format ["%1 Infantry base",factionE];};
	publicvariable "nameBW2";
	publicvariable "nameBE2";
};

//Base names are now defined in V2factionsSetup.sqf

if(DBG)then{"warmachine\V2debug.sqf" remoteExec ["execVM", 0, false];}; //delete debug vehicles

//RESPAWN TICKETS part 1/2 (sort players and AI)
_pls=count allPlayers;
_ais=0;
if(AIon>0)then
{
	_ais=(count playableUnits)-_pls;
}else
{
	_grs=[];
	{_grs pushBackUnique group _x} forEach allPlayers;
	{_ais=_ais+(count units _x)} forEach _grs;
	_ais=_ais-_pls;
};

//TIME OF DAY
[parseText format ["Setting time of day"]] remoteExec ["hint", 0, false];
call
{
	//random
	if (day == 0) exitWith {skiptime (((floor random 24) - daytime + 24) % 24);};
	//Dawn
	if (day == 1) exitWith {skiptime (((dawn select 1) - daytime + 24) % 24);};
	//Morning, 9:00
	if (day == 2) exitWith {skiptime ((9 - daytime + 24) % 24);};	
	//Noon, 12:00
	if (day == 3) exitWith {skiptime ((12 - daytime + 24) % 24);};
	//Afternoon, 16:00
	if (day == 4) exitWith {skiptime ((15 - daytime + 24) % 24);};	
	//Dusk
	if (day == 5) exitWith {skiptime (((dusk select 1) - daytime + 24) % 24);};
	//Night, 23:00
	if (day == 6) exitWith {skiptime ((23 - daytime + 24) % 24);};
};
["Time of day changed"] remoteExec ["systemChat", 0, false];

//BASE Structures part 1/2
//clear sorroundings
{
	_objs = nearestTerrainObjects [_x, 
	[
		"TREE","SMALL TREE","BUSH","BUILDING","HOUSE","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","CHURCH","CHAPEL","CROSS","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL","FENCE","WALL","HIDE","BUSSTOP","FOREST","TRANSMITTER","STACK","RUIN","TOURISM","WATERTOWER","ROCK","ROCKS","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK" //"MAIN ROAD","ROAD","RAILWAY","TRACK","TRAIL""POWER LINES",
	], 30, false, true];
	{
		_x hideObjectGlobal true;
	} forEach _objs;
} forEach [posBaseW1,posBaseW2,posBaseE1,posBaseE2];

//BASE 1 WEST (UAV Transport)
[parseText format ["Creating structures<br/>%1",nameBW1]] remoteExec ["hint", 0, false];

//main building
_selBaseW1 = selectRandom strFobWest;
objBaseW1 = _selBaseW1 createVehicle posBaseW1;
//objBaseW1 = _selBaseW1 createVehicle [posBaseW1 select 0,posBaseW1 select 1,50];
//[objBaseW1,posBaseW1,500] call wrm_fnc_V2clearArea;
objBaseW1 setDir dirBW+180;
publicVariable "objBaseW1";

//corners
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation
	_cor = strFobC createVehicle (objBaseW1 getRelPos [15, _a]);
	_cor setDir dirBW+_r;
	if(modA=="VN")then{_cor setDir (getDir _cor - 90);};
	if(modA=="IFA3")then{_cor setDir (getDir _cor + 180);};
	_cor setVectorUp surfaceNormal position _cor;
} forEach [[45,180],[135,270],[225,0],[315,90]];

//middle parts
_sel = selectRandom strFob;
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation	
	_mid = _sel createVehicle (objBaseW1 getRelPos [12, _a]);
	_mid setDir dirBW+_r;
	if(modA=="SPE")then{_mid setDir (getDir _mid + 90);};
	_mid setVectorUp surfaceNormal position _mid;
} forEach [[90,270],[180,0],[270,90]];

//BASE 2 WEST (armors)
[parseText format ["Creating structures<br/>%1",nameBW2]] remoteExec ["hint", 0, false];

//main building
_selBaseW2 = selectRandom strFobWest;
objBaseW2 = _selBaseW2 createVehicle posBaseW2;
//objBaseW2 = _selBaseW2 createVehicle [posBaseW2 select 0,posBaseW2 select 1,50];
//[objBaseW2,posBaseW2,500] call wrm_fnc_V2clearArea;
objBaseW2 setDir dirBW+180;
publicVariable "objBaseW2";

//corners
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation
	_cor = strFobC createVehicle (objBaseW2 getRelPos [15, _a]);
	_cor setDir dirBW+_r;
	if(modA=="VN")then{_cor setDir (getDir _cor - 90);};
	if(modA=="IFA3")then{_cor setDir (getDir _cor + 180);};
	_cor setVectorUp surfaceNormal position _cor;
} forEach [[45,180],[135,270],[225,0],[315,90]];

//middle parts
_sel = selectRandom strFob;
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation	
	_mid = _sel createVehicle (objBaseW2 getRelPos [12, _a]);
	_mid setDir dirBW+_r;
	if(modA=="SPE")then{_mid setDir (getDir _mid + 90);};
	_mid setVectorUp surfaceNormal position _mid;
} forEach [[90,270],[180,0],[270,90]];

//ammo boxes west (create)
deleteVehicle AmmoW;
AmmoW1 = (selectRandom supplyW) createVehicle (objBaseW1 getRelPos [12, 0]);
AmmoW1 setDir dirBW;
AmmoW2 = (selectRandom supplyW) createVehicle (objBaseW2 getRelPos [12, 0]);
AmmoW2 setDir dirBW;
publicVariable "AmmoW1";
publicVariable "AmmoW2";

//BASE 1 EAST (UAV Transport)
[parseText format ["Creating structures<br/>%1",nameBE1]] remoteExec ["hint", 0, false];

//main building
_selBaseE1 = selectRandom strFobEast;
objBaseE1 = _selBaseE1 createVehicle posBaseE1;
//objBaseE1 = _selBaseE1 createVehicle [posBaseE1 select 0,posBaseE1 select 1,50];
//[objBaseE1,posBaseE1,500] call wrm_fnc_V2clearArea;
objBaseE1 setDir dirBE+180;
publicVariable "objBaseE1";

//corners
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation
	_cor = strFobC createVehicle (objBaseE1 getRelPos [15, _a]);
	_cor setDir dirBE+_r;
	if(modA=="VN")then{_cor setDir (getDir _cor - 90);};
	if(modA=="IFA3")then{_cor setDir (getDir _cor + 180);};
	_cor setVectorUp surfaceNormal position _cor;
} forEach [[45,180],[135,270],[225,0],[315,90]];

//middle parts
_sel = selectRandom strFob;
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation	
	_mid = _sel createVehicle (objBaseE1 getRelPos [12, _a]);
	_mid setDir dirBE+_r;
	if(modA=="SPE")then{_mid setDir (getDir _mid + 90);};
	_mid setVectorUp surfaceNormal position _mid;
} forEach [[90,270],[180,0],[270,90]];

//BASE 2 EAST (armors)
[parseText format ["Creating structures<br/>%1",nameBE2]] remoteExec ["hint", 0, false];

//main building
_selBaseE2 = selectRandom strFobEast;
objBaseE2 = _selBaseE2 createVehicle posBaseE2;
//objBaseE2 = _selBaseE2 createVehicle [posBaseE2 select 0,posBaseE2 select 1,50];
//[objBaseE2,posBaseE2,500] call wrm_fnc_V2clearArea;
objBaseE2 setDir dirBE+180;
publicVariable "objBaseE2";

//corners
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation
	_cor = strFobC createVehicle (objBaseE2 getRelPos [15, _a]);
	_cor setDir dirBE+_r;
	if(modA=="VN")then{_cor setDir (getDir _cor - 90);};
	if(modA=="IFA3")then{_cor setDir (getDir _cor + 180);};
	_cor setVectorUp surfaceNormal position _cor;
} forEach [[45,180],[135,270],[225,0],[315,90]];

//middle parts
_sel = selectRandom strFob;
{
	_a=_x select 0; //angle
	_r=_x select 1; //rotation	
	_mid = _sel createVehicle (objBaseE2 getRelPos [12, _a]);
	_mid setDir dirBE+_r;
	if(modA=="SPE")then{_mid setDir (getDir _mid + 90);};
	_mid setVectorUp surfaceNormal position _mid;
} forEach [[90,270],[180,0],[270,90]];

//create ammo boxes (ARSENAL)
deleteVehicle AmmoE;
AmmoE1 = (selectRandom supplyE) createVehicle (objBaseE1 getRelPos [12, 0]);
AmmoE1 setDir dirBE;
AmmoE2 = (selectRandom supplyE) createVehicle (objBaseE2 getRelPos [12, 0]);
AmmoE2 setDir dirBE;
publicVariable "AmmoE1";
publicVariable "AmmoE2";
if (modA=="GM") then 
{
	[AmmoW1,sideW] call wrm_fnc_supplyBox;
	[AmmoW2,sideW] call wrm_fnc_supplyBox;
	[AmmoE1,sideE] call wrm_fnc_supplyBox;
	[AmmoE2,sideE] call wrm_fnc_supplyBox;
};

//ARSENAL
call
{
	if("Param2" call BIS_fnc_getParamValue == 1)exitWith
	{
		["AmmoboxInit",AmmoW1] spawn BIS_fnc_arsenal;
		["AmmoboxInit",AmmoW2] spawn BIS_fnc_arsenal;	
		["AmmoboxInit",AmmoE1] spawn BIS_fnc_arsenal;
		["AmmoboxInit",AmmoE2] spawn BIS_fnc_arsenal;	
	};
	if("Param2" call BIS_fnc_getParamValue == 2)exitWith
	{
		["AmmoboxInit",[AmmoW1,true]] spawn BIS_fnc_arsenal;
		["AmmoboxInit",[AmmoW2,true]] spawn BIS_fnc_arsenal;
		["AmmoboxInit",[AmmoE1,true]] spawn BIS_fnc_arsenal;
		["AmmoboxInit",[AmmoE2,true]] spawn BIS_fnc_arsenal;
	};
};

//VEHICLES RESPAWN TIME
[parseText format ["Creating vehicles<br/>Respawn time"]] remoteExec ["hint", 0, false];
call
{
	//30/90 sec, Unarmed/Armed
	if (vehTime == 0) exitWith
	{
		trTime = 30; publicvariable "trTime"; //30
		arTime = 90; publicvariable "arTime"; //90
	};
	//1/3 min
	if (vehTime == 1) exitWith
	{
		trTime = 60; publicvariable "trTime";
		arTime = 180; publicvariable "arTime";
	};
	//3/9 min
	if (vehTime == 2) exitWith
	{
		trTime = 180; publicvariable "trTime";
		arTime = 540; publicvariable "arTime";
	};
	//5/15 min
	if (vehTime == 3) exitWith
	{
		trTime = 300; publicvariable "trTime";
		arTime = 900; publicvariable "arTime";
	};
	//10/30 min
	if (vehTime == 4) exitWith
	{
		trTime = 600; publicvariable "trTime";
		arTime = 1800; publicvariable "arTime";
	};
};
//Dronų cooldown (4x greičiau nei automobilių - FPV dronai yra pigesni)
droneCooldownTime = floor (arTime / 4); 
publicvariable "droneCooldownTime";
["Vehicles respawn time set"] remoteExec ["systemChat", 0, false];
[format ["Drone cooldown set to %1 seconds (%2 min)", droneCooldownTime, floor (droneCooldownTime/60)]] remoteExec ["systemChat", 0, false];

//Cooldown sistema pranešimams apie transporto priemonių respawn
//Masyvas saugo paskutinio pranešimo laiką kiekvienai transporto priemonei: [typeOf veh, lastNotificationTime]
wrm_vehRespawnNotificationCooldown = [];
//Cooldown laikas sekundėmis - pranešimas bus rodomas ne dažniau nei kas 60 sekundžių
wrm_vehRespawnNotificationCooldownTime = 60;

//SORT AIRPORTS (support positions)
[parseText format ["Creating vehicles<br/>Combat support"]] remoteExec ["hint", 0, false];
//find center
_dc=[];
_d1=posBaseW1 distance posBaseE2;
_d2=posBaseW2 distance posBaseE1;
_d3=posBaseW1 distance posBaseE1;
_d4=posBaseW2 distance posBaseE2;
call
{
	if(_d1>_d2&&_d1>_d3&&_d1>_d4)exitwith{_dc=[posBaseW1,posBaseE2,_d1];};
	if(_d2>_d1&&_d2>_d3&&_d2>_d4)exitwith{_dc=[posBaseW2,posBaseE1,_d2];};
	if(_d3>_d1&&_d3>_d2&&_d3>_d4)exitwith{_dc=[posBaseW1,posBaseE1,_d3];};
	if(_d4>_d1&&_d4>_d2&&_d4>_d3)exitwith{_dc=[posBaseW2,posBaseE2,_d4];};
};

_obj="Land_HelipadEmpty_F" createVehicle (_dc select 0);
_obj setDir ((_dc select 0)getDir(_dc select 1));
posCenter = _obj getRelPos [(_dc select 2)/2, 0];
minDis = ((_dc select 2)/2)+500;
deleteVehicle _obj;
publicVariable "posCenter";
publicVariable "minDis";

//sort plHs
_plHs = [plH1,plH2,plH3];
call
{
	if(plH==4)exitWith{_plHs = [plH1,plH2,plH3,plH4];};
	if(plH==5)exitWith{_plHs = [plH1,plH2,plH3,plH4,plH5];};
};

//remove plHs too close
{if ((_x distance posCenter)<minDis) then {_plHs=_plHs-[_x];};} forEach _plHs;

//sort plHs for each side
_plHsW=[]; _plHsE=[]; _disW=[]; _disE=[];
{
	_d1=posBaseW1 distance _x;
	_d2=posBaseW2 distance _x;
	_d3=posBaseE1 distance _x;
	_d4=posBaseE2 distance _x;
	call
	{
		if(_d1<_d2&&_d1<_d3&&_d1<_d4)exitwith{_plHsW pushBackUnique _x; _disW pushBackUnique _d1;};
		if(_d2<_d1&&_d2<_d3&&_d2<_d4)exitwith{_plHsW pushBackUnique _x; _disW pushBackUnique _d2;};
		if(_d3<_d1&&_d3<_d2&&_d3<_d4)exitwith{_plHsE pushBackUnique _x; _disE pushBackUnique _d3;};
		if(_d4<_d1&&_d4<_d2&&_d4<_d3)exitwith{_plHsE pushBackUnique _x; _disE pushBackUnique _d4;};
	};
} forEach _plHs;

//selection, select an airfield with the best position
_index=0;
if (count _plHsW > 0) then 
{
	minW = selectMin _disW;
	{if (_x == minW) then {_index = _forEachIndex};} forEach _disW;
	plHW = _plHsW select _index;
};
if (count _plHsE > 0) then 
{
	minE = selectMin _disE;
	{if (_x == minE) then {_index = _forEachIndex};} forEach _disE;
	plHE = _plHsE select _index;
};
if (count _plHsW <= 0) then 
{
	_plHsW = _plHsE - [plHE];
	_disW = _disE - [minE];
	minW = selectMin _disW;
	{if (_x == minW) then {_index = _forEachIndex};} forEach _disW;
	plHW = _plHsW select _index;
};
if (count _plHsE <= 0) then 
{
	_plHsE = _plHsW - [plHW];
	_disE = _disW - [minW];
	minE = selectMin _disE;
	{if (_x == minE) then {_index = _forEachIndex};} forEach _disE;
	plHE = _plHsE select _index;
};
publicVariable "plHW";
publicVariable "plHE";

//COMBAT SUPPORT modules
{_x setPos (plHW getRelPos [20, 90]);} forEach [SupCasHW, SupCasBW];
{_x setPos (plHE getRelPos [20, 90]);} forEach [SupCasHE, SupCasBE];
{[_x,["bis_supp_cooldown", arTime]] remoteExec ["setVariable",0,false];} forEach [SupCasHW,SupCasBW,SupCasHE,SupCasBE]; //set coolDown time == arTime

_HeliArW=[];
if ((HeliArW select 0) isEqualType [])
then{{_HeliArW pushBackUnique (_x select 0);} forEach HeliArW;}
else{_HeliArW=HeliArW;};
[SupCasHW,["bis_supp_vehicles", _HeliArW]] remoteExec ["setVariable",0,false];

_PlaneW=[];
if ((PlaneW select 0) isEqualType [])
then{{_PlaneW pushBackUnique (_x select 0);} forEach PlaneW;}
else{_PlaneW=PlaneW;};
[SupCasBW,["bis_supp_vehicles", _PlaneW]] remoteExec ["setVariable",0,false];

_HeliArE=[];
if ((HeliArE select 0) isEqualType [])
then{{_HeliArE pushBackUnique (_x select 0);} forEach HeliArE;}
else{_HeliArE=HeliArE;};
[SupCasHE,["bis_supp_vehicles", _HeliArE]] remoteExec ["setVariable",0,false];

_PlaneE=[];
if ((PlaneE select 0) isEqualType [])
then{{_PlaneE pushBackUnique (_x select 0);} forEach PlaneE;}
else{_PlaneE=PlaneE;};
[SupCasBE,["bis_supp_vehicles", _PlaneE]] remoteExec ["setVariable",0,false];

if(modA=="IFA3")then
{
	{[_x,["bis_supp_vehicleinit",{_this setVelocityModelSpace [0, 100, 100];}]] remoteExec ["setVariable",0,false];} forEach [SupCasBW,SupCasBE]; //prevent the plane to fall down
};

//Sinhronizuoti CAS support provider'ius su teisingais lėktuvais visiems klientams (įskaitant JIP)
//Ši funkcija užtikrina, kad JIP žaidėjai gautų teisingus lėktuvus, o ne vanilla
[] call wrm_fnc_V2syncSupportProviders;

//PLANES, GUNSHIPS
if(missType==3)then
{
	//respawn
	if(
		(count HeliArW!=0) ||
		((count PlaneW!=0)&&(planes==1)) ||
		((count PlaneW!=0)&&(planes==2)&&((plHW==plH1)||(plHW==plH2))&&((plHe==plH1)||(plHe==plH2)))	
	)
	then{[sideW, (plHW getRelPos [25, 270]), (format ["%1 Air base",factionW])] call BIS_fnc_addRespawnPosition;};
	if(
		(count HeliArE!=0) ||
		((count PlaneE!=0)&&(planes==1)) ||
		((count PlaneE!=0)&&(planes==2)&&((plHW==plH1)||(plHW==plH2))&&((plHe==plH1)||(plHe==plH2)))	
	)
	then{[sideE, (plHE getRelPos [25, 270]), (format ["%1 Air base",factionE])] call BIS_fnc_addRespawnPosition;};
	
	if ((planes==1) || ((planes==2)&&((plHW==plH1)||(plHW==plH2))&&((plHe==plH1)||(plHe==plH2)))) then
	{ 
		//plane west
		if(count PlaneW!=0)then
		{
			[parseText format ["Creating vehicles<br/>%1 Plane",factionW]] remoteExec ["hint", 0, false];
			_pSelW = selectRandom PlaneW;
			_pPosW = getPos plHW;
			_pVehW = _pSelW createVehicle _pPosW;
			_pVehW setDir getDir plHW;
			_nme = format ["%1%2",_pSelW,(_pPosW select 0)];
			[_nme,"plane",_pPosW] remoteExec ["wrm_fnc_V2vehMrkW", 0, true];
			z1 addCuratorEditableObjects [[_pVehW],true];	
			[_pVehW,arTime,0,-1,{
				params ["_pVehW"];
				removeFromRemainsCollector [_pVehW];
				//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
				if (!isNull _pVehW && alive _pVehW) then {
					_vehType = typeOf _pVehW;
					_currentTime = time;
					//Patikrinti ar yra cooldown šiai transporto priemonei
					_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
					_canShowNotification = true;
					
					if (_lastNotificationIndex != -1) then {
						//Rasti paskutinį pranešimo laiką
						_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
						//Patikrinti ar praėjo pakankamai laiko (cooldown)
						if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
							_canShowNotification = false;
						} else {
							//Atnaujinti laiką
							wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
						};
					} else {
						//Pridėti naują įrašą į cooldown masyvą
						wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
					};
					
					//Rodyti pranešimą tik jei cooldown praėjo
					if (_canShowNotification) then {
						_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
						_vehPos = getPos _pVehW;
						_gridPos = mapGridPosition _vehPos;
						//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
						[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
					};
				};
			},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
			removeFromRemainsCollector [_pVehW];
			_pVehW allowDammage false;
			_pVehW addEventHandler ["GetIn", {params ["_veh"]; [_veh,posBaseW1] spawn wrm_fnc_safeZoneVeh;}];
		};

		//plane east
		if(count PlaneE!=0)then
		{
			[parseText format ["Creating vehicles<br/>%1 Plane",factionE]] remoteExec ["hint", 0, false];
			_pSelE = selectRandom PlaneE;
			_pPosE = getPos plHe;
			_pVehE = _pSelE createVehicle _pPosE;
			_pVehE setDir getDir plHe;
			_nme = format ["%1%2",_pSelE,(_pPosE select 0)];
			[_nme,"plane",_pPosE] remoteExec ["wrm_fnc_V2vehMrkE", 0, true];
			z1 addCuratorEditableObjects [[_pVehE],true];
			[_pVehE,arTime,0,-1,{
				params ["_pVehE"];
				removeFromRemainsCollector [_pVehE];
				//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
				if (!isNull _pVehE && alive _pVehE) then {
					_vehType = typeOf _pVehE;
					_currentTime = time;
					//Patikrinti ar yra cooldown šiai transporto priemonei
					_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
					_canShowNotification = true;
					
					if (_lastNotificationIndex != -1) then {
						//Rasti paskutinį pranešimo laiką
						_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
						//Patikrinti ar praėjo pakankamai laiko (cooldown)
						if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
							_canShowNotification = false;
						} else {
							//Atnaujinti laiką
							wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
						};
					} else {
						//Pridėti naują įrašą į cooldown masyvą
						wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
					};
					
					//Rodyti pranešimą tik jei cooldown praėjo
					if (_canShowNotification) then {
						_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
						_vehPos = getPos _pVehE;
						_gridPos = mapGridPosition _vehPos;
						//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
						[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
					};
				};
			},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
			removeFromRemainsCollector [_pVehE];
			_pVehE allowDammage false;
			_pVehE addEventHandler ["GetIn", {params ["_veh"]; [_veh,posBaseE1] spawn wrm_fnc_safeZoneVeh;}];
		};
		
	};

	//gunship west
	if(count HeliArW!=0)then
	{
		_res = plHW getRelPos [25, 90];
		if((count PlaneW==0)||(!((planes==1)||((planes==2)&&((plHW==plH1)||(plHW==plH2))&&((plHe==plH1)||(plHe==plH2))))))then{_res = getPos plHW;};
		//helipad
		_h = "Land_HelipadCircle_F" createVehicle _res;
		_h setDir getDir plHW;
		//vehicle
		_vSel = selectRandom HeliArW;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
		_veh = createVehicle [_typ,[_res select 0,_res select 1,50], [], 0, "NONE"];
		[_veh,_res,300] call wrm_fnc_V2clearArea;
		[_veh,[_tex,1]] call bis_fnc_initVehicle;
		_veh setDir getDir plHW;
		_veh setVectorUp surfaceNormal _res;			
		_nme = format ["%1%2",_typ,(_res select 0)];
		[_nme,"air",_res] remoteExec ["wrm_fnc_V2vehMrkW", 0, true];
		z1 addCuratorEditableObjects [[_veh],true];
		[_veh,arTime,0,-1,{
			params ["_veh"];
			removeFromRemainsCollector [_veh];
			//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
			if (!isNull _veh && alive _veh) then {
				_vehType = typeOf _veh;
				_currentTime = time;
				//Patikrinti ar yra cooldown šiai transporto priemonei
				_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
				_canShowNotification = true;
				
				if (_lastNotificationIndex != -1) then {
					//Rasti paskutinį pranešimo laiką
					_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
					//Patikrinti ar praėjo pakankamai laiko (cooldown)
					if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
						_canShowNotification = false;
					} else {
						//Atnaujinti laiką
						wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
					};
				} else {
					//Pridėti naują įrašą į cooldown masyvą
					wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
				};
				
				//Rodyti pranešimą tik jei cooldown praėjo
				if (_canShowNotification) then {
					_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
					_vehPos = getPos _veh;
					_gridPos = mapGridPosition _vehPos;
					//titleText reikalauja masyvo [text, type, duration], ne tik stringo
					//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
					[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
			};
		};
		},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
		removeFromRemainsCollector [_veh];
	};
	
	//gunship east
	if(count HeliArE!=0)then
	{
		_res = plHE getRelPos [25, 90];
		if((count PlaneE==0)||(!((planes==1)||((planes==2)&&((plHW==plH1)||(plHW==plH2))&&((plHe==plH1)||(plHe==plH2))))))then{_res = getPos plHE;};
		//helipad
		_h = "Land_HelipadCircle_F" createVehicle _res;
		_h setDir getDir plHe;
		//vehicle
		_vSel = selectRandom HeliArE;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
		_veh = createVehicle [_typ,[_res select 0,_res select 1,50], [], 0, "NONE"];
		[_veh,_res,300] call wrm_fnc_V2clearArea;
		[_veh,[_tex,1]] call bis_fnc_initVehicle;
		_veh setDir getDir plHe;
		_veh setVectorUp surfaceNormal _res;			
		_nme = format ["%1%2",_typ,(_res select 0)];
		[_nme,"air",_res] remoteExec ["wrm_fnc_V2vehMrkE", 0, true];
		z1 addCuratorEditableObjects [[_veh],true];
		[_veh,arTime,0,-1,{
			params ["_veh"];
			removeFromRemainsCollector [_veh];
			//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
			if (!isNull _veh && alive _veh) then {
				_vehType = typeOf _veh;
				_currentTime = time;
				//Patikrinti ar yra cooldown šiai transporto priemonei
				_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
				_canShowNotification = true;
				
				if (_lastNotificationIndex != -1) then {
					//Rasti paskutinį pranešimo laiką
					_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
					//Patikrinti ar praėjo pakankamai laiko (cooldown)
					if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
						_canShowNotification = false;
					} else {
						//Atnaujinti laiką
						wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
					};
				} else {
					//Pridėti naują įrašą į cooldown masyvą
					wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
				};
				
				//Rodyti pranešimą tik jei cooldown praėjo
				if (_canShowNotification) then {
					_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
					_vehPos = getPos _veh;
					_gridPos = mapGridPosition _vehPos;
					//titleText reikalauja masyvo [text, type, duration], ne tik stringo
					//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
					[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
			};
		};
		},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
		removeFromRemainsCollector [_veh];
	};
};

//sort vehicles by mission type
_vW=[]; _hW=[]; _vE=[]; _hE=[];
call
{
	if(missType==1)exitWith
	{
		_vW=[[BikeW,rBikeW,"unknown",trTime],[CarW,rCarW,"unknown",trTime],[TruckW,rTruckW,"unknown",trTime]];
		_hW=[[HeliTrW,rHeliTrW,"air",trTime]];
		_vE=[[BikeE,rBikeE,"unknown",trTime],[CarE,rCarE,"unknown",trTime],[TruckE,rTruckE,"unknown",trTime]];
		_hE=[[HeliTrE,rHeliTrE,"air",trTime]];
	};
	if(missType==2)exitWith
	{
		_vW=[[BikeW,rBikeW,"unknown",trTime],[CarW,rCarW,"unknown",trTime],[CarArW,rCarArW,"unknown",trTime],[TruckW,rTruckW,"unknown",trTime],[ArmorW1,rArmorW1,"armor",arTime],[ArmorW2,rArmorW2,"armor",arTime]];
		_hW=[[HeliTrW,rHeliTrW,"air",trTime]];
		_vE=[[BikeE,rBikeE,"unknown",trTime],[CarE,rCarE,"unknown",trTime],[CarArE,rCarArE,"unknown",trTime],[TruckE,rTruckE,"unknown",trTime],[ArmorE1,rArmorE1,"armor",arTime],[ArmorE2,rArmorE2,"armor",arTime]];
		_hE=[[HeliTrE,rHeliTrE,"air",trTime]];
	};
	if(missType==3)exitWith
	{
		_vW=[[BikeW,rBikeW,"unknown",trTime],[CarW,rCarW,"unknown",trTime],[CarArW,rCarArW,"unknown",trTime],[TruckW,rTruckW,"unknown",trTime],[ArmorW1,rArmorW1,"armor",arTime],[ArmorW2,rArmorW2,"armor",arTime]];
		_hW=[[HeliTrW,rHeliTrW,"air",trTime]]; //,[HeliArW,rHeliArW,"air",arTime]];
		_vE=[[BikeE,rBikeE,"unknown",trTime],[CarE,rCarE,"unknown",trTime],[CarArE,rCarArE,"unknown",trTime],[TruckE,rTruckE,"unknown",trTime],[ArmorE1,rArmorE1,"armor",arTime],[ArmorE2,rArmorE2,"armor",arTime]];
		_hE=[[HeliTrE,rHeliTrE,"air",trTime]]; //,[HeliArE,rHeliArE,"air",arTime]];
	};
};

//VEHICLES WEST
[parseText format ["Creating vehicles<br/>%1 vehicles",factionW]] remoteExec ["hint", 0, false];
{
	_vehs = _x select 0;
	_ress = _x select 1;
	_mrk = _x select 2;
	_time = _x select 3;
	{
		_res = _x;
		//vehicle
		_vSel = selectRandom _vehs;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
		_veh = createVehicle [_typ,[_res select 0,_res select 1,50], [], 0, "NONE"];
		[_veh,_res,300] call wrm_fnc_V2clearArea;
		[_veh,[_tex,1]] call bis_fnc_initVehicle;
		_veh setDir dirBW;
		_veh setVectorUp surfaceNormal _res;		
		_nme = format ["%1%2",_typ,(_res select 0)];
		[_nme,_mrk,_res] remoteExec ["wrm_fnc_V2vehMrkW", 0, true];
		z1 addCuratorEditableObjects [[_veh],true];
		[_veh,_time,0,-1,{
			params ["_veh"];
			removeFromRemainsCollector [_veh];
			//FIX: Pridėti delay prieš baseSideCheck, kad išvengtume respawn/hide ciklo
			//Jei transporto priemonė iškart paslėpiama po respawn'o, BIS_fnc_moduleRespawnVehicle gali manyti, kad ji sunaikinta ir respawn'ina vėl
			//Delay leidžia transporto priemonei stabilizuotis prieš patikrinant bazės sąlygas
			sleep 2;
			//Patikrinti ar transporto priemonė vis dar egzistuoja ir nėra paslėpta prieš tikrinant bazės sąlygas
			if (!isNull _veh && alive _veh && !(_veh in (hideVehBW1 + hideVehBW2 + hideVehBE1 + hideVehBE2))) then {
				[_veh] call wrm_fnc_V2baseSideCheck;
			};
			//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
			if (!isNull _veh && alive _veh) then {
				_vehType = typeOf _veh;
				_currentTime = time;
				//Patikrinti ar yra cooldown šiai transporto priemonei
				_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
				_canShowNotification = true;
				
				if (_lastNotificationIndex != -1) then {
					//Rasti paskutinį pranešimo laiką
					_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
					//Patikrinti ar praėjo pakankamai laiko (cooldown)
					if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
						_canShowNotification = false;
					} else {
						//Atnaujinti laiką
						wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
					};
				} else {
					//Pridėti naują įrašą į cooldown masyvą
					wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
				};
				
				//Rodyti pranešimą tik jei cooldown praėjo
				if (_canShowNotification) then {
					_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
					_vehPos = getPos _veh;
					_gridPos = mapGridPosition _vehPos;
					//titleText reikalauja masyvo [text, type, duration], ne tik stringo
					//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
					[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
			};
		};
		},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
		removeFromRemainsCollector [_veh];
	} forEach _ress;
} forEach _vW;

//helicopters
if (count _hW>0) then
{
	[parseText format ["Creating vehicles<br/>%1 helicopters",factionW]] remoteExec ["hint", 0, false];
	{
		_vehs = _x select 0;
		_ress = _x select 1;
		_mrk = _x select 2;
		_time = _x select 3;
		{
			_res = _x;
			//helipad
			_h = "Land_HelipadCircle_F" createVehicle _res;
			_h setDir dirBW;
			//vehicle
			_vSel = selectRandom _vehs;
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
			_veh = createVehicle [_typ,[_res select 0,_res select 1,50], [], 0, "NONE"];
			[_veh,_res,300] call wrm_fnc_V2clearArea;
			[_veh,[_tex,1]] call bis_fnc_initVehicle;
			_veh setDir dirBW;
			_veh setVectorUp surfaceNormal _res;			
			_nme = format ["%1%2",_typ,(_res select 0)];
			[_nme,_mrk,_res] remoteExec ["wrm_fnc_V2vehMrkW", 0, true];
			z1 addCuratorEditableObjects [[_veh],true];
			[_veh,_time,0,-1,{
				params ["_veh"];
				removeFromRemainsCollector [_veh];
				//FIX: Pridėti delay prieš baseSideCheck, kad išvengtume respawn/hide ciklo
				//Jei transporto priemonė iškart paslėpiama po respawn'o, BIS_fnc_moduleRespawnVehicle gali manyti, kad ji sunaikinta ir respawn'ina vėl
				//Delay leidžia transporto priemonei stabilizuotis prieš patikrinant bazės sąlygas
				sleep 2;
				//Patikrinti ar transporto priemonė vis dar egzistuoja ir nėra paslėpta prieš tikrinant bazės sąlygas
				if (!isNull _veh && alive _veh && !(_veh in (hideVehBW1 + hideVehBW2 + hideVehBE1 + hideVehBE2))) then {
					[_veh] call wrm_fnc_V2baseSideCheck;
				};
				//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
				if (!isNull _veh && alive _veh) then {
					_vehType = typeOf _veh;
					_currentTime = time;
					//Patikrinti ar yra cooldown šiai transporto priemonei
					_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
					_canShowNotification = true;
					
					if (_lastNotificationIndex != -1) then {
						//Rasti paskutinį pranešimo laiką
						_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
						//Patikrinti ar praėjo pakankamai laiko (cooldown)
						if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
							_canShowNotification = false;
						} else {
							//Atnaujinti laiką
							wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
						};
					} else {
						//Pridėti naują įrašą į cooldown masyvą
						wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
					};
					
					//Rodyti pranešimą tik jei cooldown praėjo
					if (_canShowNotification) then {
						_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
						_vehPos = getPos _veh;
						_gridPos = mapGridPosition _vehPos;
						//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
						[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
					};
				};
			},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
			removeFromRemainsCollector [_veh];
		} forEach _ress;
	} forEach _hW;
};
[format ["%1 vehicles created ",factionW]] remoteExec ["systemChat", 0, false];

//VEHICLES EAST
[parseText format ["Creating vehicles<br/>%1 vehicles",factionE]] remoteExec ["hint", 0, false];
{
	_vehs = _x select 0;
	_ress = _x select 1;
	_mrk = _x select 2;
	_time = _x select 3;
	{
		_res = _x;
		//vehicle
		_vSel = selectRandom _vehs;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
		_veh = createVehicle [_typ,[_res select 0,_res select 1,50], [], 0, "NONE"];
		[_veh,_res,300] call wrm_fnc_V2clearArea;
		[_veh,[_tex,1]] call bis_fnc_initVehicle;
		_veh setDir dirBE;
		_veh setVectorUp surfaceNormal _res;		
		_nme = format ["%1%2",_typ,(_res select 0)];
		[_nme,_mrk,_res] remoteExec ["wrm_fnc_V2vehMrkE", 0, true];
		z1 addCuratorEditableObjects [[_veh],true];
		[_veh,_time,0,-1,{
			params ["_veh"];
			removeFromRemainsCollector [_veh];
			//FIX: Pridėti delay prieš baseSideCheck, kad išvengtume respawn/hide ciklo
			//Jei transporto priemonė iškart paslėpiama po respawn'o, BIS_fnc_moduleRespawnVehicle gali manyti, kad ji sunaikinta ir respawn'ina vėl
			//Delay leidžia transporto priemonei stabilizuotis prieš patikrinant bazės sąlygas
			sleep 2;
			//Patikrinti ar transporto priemonė vis dar egzistuoja ir nėra paslėpta prieš tikrinant bazės sąlygas
			if (!isNull _veh && alive _veh && !(_veh in (hideVehBW1 + hideVehBW2 + hideVehBE1 + hideVehBE2))) then {
				[_veh] call wrm_fnc_V2baseSideCheck;
			};
			//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
			if (!isNull _veh && alive _veh) then {
				_vehType = typeOf _veh;
				_currentTime = time;
				//Patikrinti ar yra cooldown šiai transporto priemonei
				_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
				_canShowNotification = true;
				
				if (_lastNotificationIndex != -1) then {
					//Rasti paskutinį pranešimo laiką
					_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
					//Patikrinti ar praėjo pakankamai laiko (cooldown)
					if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
						_canShowNotification = false;
					} else {
						//Atnaujinti laiką
						wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
					};
				} else {
					//Pridėti naują įrašą į cooldown masyvą
					wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
				};
				
				//Rodyti pranešimą tik jei cooldown praėjo
				if (_canShowNotification) then {
					_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
					_vehPos = getPos _veh;
					_gridPos = mapGridPosition _vehPos;
					//titleText reikalauja masyvo [text, type, duration], ne tik stringo
					//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
					[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
			};
		};
		},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
		removeFromRemainsCollector [_veh];
	} forEach _ress;
} forEach _vE;

//helicopters
if (count _hE>0) then
{
	[parseText format ["Creating vehicles<br/>%1 helicopters",factionE]] remoteExec ["hint", 0, false];
	{
		_vehs = _x select 0;
		_ress = _x select 1;
		_mrk = _x select 2;
		_time = _x select 3;
		{
			_res = _x;
			//helipad
			_h = "Land_HelipadCircle_F" createVehicle _res;
			_h setDir dirBE;
			//vehicle
			_vSel = selectRandom _vehs;
			_typ="";_tex="";
			if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};	
			_veh = createVehicle [_typ,[_res select 0,_res select 1,50], [], 0, "NONE"];
			[_veh,_res,300] call wrm_fnc_V2clearArea;
			[_veh,[_tex,1]] call bis_fnc_initVehicle;
			_veh setDir dirBE;
			_veh setVectorUp surfaceNormal _res;			
			_nme = format ["%1%2",_typ,(_res select 0)];
			[_nme,_mrk,_res] remoteExec ["wrm_fnc_V2vehMrkE", 0, true];
			z1 addCuratorEditableObjects [[_veh],true];
			[_veh,_time,0,-1,{
				params ["_veh"];
				removeFromRemainsCollector [_veh];
				//FIX: Pridėti delay prieš baseSideCheck, kad išvengtume respawn/hide ciklo
				//Jei transporto priemonė iškart paslėpiama po respawn'o, BIS_fnc_moduleRespawnVehicle gali manyti, kad ji sunaikinta ir respawn'ina vėl
				//Delay leidžia transporto priemonei stabilizuotis prieš patikrinant bazės sąlygas
				sleep 2;
				//Patikrinti ar transporto priemonė vis dar egzistuoja ir nėra paslėpta prieš tikrinant bazės sąlygas
				if (!isNull _veh && alive _veh && !(_veh in (hideVehBW1 + hideVehBW2 + hideVehBE1 + hideVehBE2))) then {
					[_veh] call wrm_fnc_V2baseSideCheck;
				};
				//Rodyti pranešimą tik kai transporto priemonė tikrai respawn'ino (po cooldown)
				if (!isNull _veh && alive _veh) then {
					_vehType = typeOf _veh;
					_currentTime = time;
					//Patikrinti ar yra cooldown šiai transporto priemonei
					_lastNotificationIndex = wrm_vehRespawnNotificationCooldown findIf {(_x select 0) == _vehType};
					_canShowNotification = true;
					
					if (_lastNotificationIndex != -1) then {
						//Rasti paskutinį pranešimo laiką
						_lastNotificationTime = (wrm_vehRespawnNotificationCooldown select _lastNotificationIndex) select 1;
						//Patikrinti ar praėjo pakankamai laiko (cooldown)
						if ((_currentTime - _lastNotificationTime) < wrm_vehRespawnNotificationCooldownTime) then {
							_canShowNotification = false;
						} else {
							//Atnaujinti laiką
							wrm_vehRespawnNotificationCooldown set [_lastNotificationIndex, [_vehType, _currentTime]];
						};
					} else {
						//Pridėti naują įrašą į cooldown masyvą
						wrm_vehRespawnNotificationCooldown pushBack [_vehType, _currentTime];
					};
					
					//Rodyti pranešimą tik jei cooldown praėjo
					if (_canShowNotification) then {
						_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
						_vehPos = getPos _veh;
						_gridPos = mapGridPosition _vehPos;
						//remoteExec su titleText perduoda masyvą kaip argumentą, ne kaip masyvą masyve
						[format ["VEHICLE RESPAWNED %1 respawned at Grid %2", _vehName, _gridPos], "PLAIN", 3] remoteExec ["titleText", 0, false];
					};
				};
			},0,0,1,true,false,500,false] call BIS_fnc_moduleRespawnVehicle;
			removeFromRemainsCollector [_veh];
		} forEach _ress;
	} forEach _hE;
};
[format ["%1 vehicles created ",factionE]] remoteExec ["systemChat", 0, false];

//BASE Structures part 2/2
[parseText format ["Creating structures"]] remoteExec ["hint", 0, false];
//2nd building BASE 1 WEST (UAV Transport)
_posR = objBaseW1 getRelPos [30, random 360];
_pos2 = [posBaseW1, 20, 60, 10, 0, 0.2, 0, [], [_posR,_posR]] call BIS_fnc_findSafePos;
_obj2 = (selectRandom (strFobWest - [_selBaseW1])) createVehicle _pos2;
if(!isNull roadAt _obj2)then
{
	_obj2 setDir (getdir (roadAt _obj2)); 
	_obj2 setPos (_obj2 getRelPos [40,45]);
};
_obj2 setDir dirBW+180;

//respawn in the base (resBaseW1)
resBaseW1 = [];
_p = (objBaseW1 getRelPos [20, 0]) findEmptyPosition [0, 25, "B_soldier_F"];
if(count _p == 0) then {_p = (objBaseW1 getRelPos [20, 0]);};
resBaseW1 pushBackUnique _p;
publicVariable "resBaseW1";

if(modA=="GM")then
{
	{
		_obj = _x;
		{if(typeOf _obj==_x)then{_obj setDir dirBW;};} forEach ["land_gm_woodbunker_01_bags","land_gm_sandbags_02_bunker_high","land_gm_euro_deerstand_01","land_gm_woodbunker_01"];
	} forEach [objBaseW1,_obj2];
};
[format ["%1 created",nameBW1]] remoteExec ["systemChat", 0, false];

//2nd building BASE 2 WEST (Armors)
_posR = objBaseW2 getRelPos [30, random 360];
_pos2 = [posBaseW2, 20, 60, 10, 0, 0.2, 0, [], [_posR,_posR]] call BIS_fnc_findSafePos;
_obj2 = (selectRandom (strFobWest - [_selBaseW2])) createVehicle _pos2;
if(!isNull roadAt _obj2)then
{
	_obj2 setDir (getdir (roadAt _obj2)); 
	_obj2 setPos (_obj2 getRelPos [40,45]);
};
_obj2 setDir dirBW+180;

//respawn in the base (resBaseW2)
resBaseW2 = [];
_p = (objBaseW2 getRelPos [20, 0]) findEmptyPosition [0, 25, "B_soldier_F"];
if(count _p == 0) then {_p = (objBaseW2 getRelPos [20, 0]);};
resBaseW2 pushBackUnique _p;
publicVariable "resBaseW2";

if(modA=="GM")then
{
	{
		_obj = _x;
		{if(typeOf _obj==_x)then{_obj setDir dirBW;};} forEach ["land_gm_woodbunker_01_bags","land_gm_sandbags_02_bunker_high","land_gm_euro_deerstand_01","land_gm_woodbunker_01"];
	} forEach [objBaseW2,_obj2];
};
[format ["%1 created",nameBW2]] remoteExec ["systemChat", 0, false];

//2nd building BASE 1 EAST (UAV Transport)
_posR = objBaseE1 getRelPos [30, random 360];
_pos2 = [posBaseE1, 20, 60, 10, 0, 0.2, 0, [], [_posR,_posR]] call BIS_fnc_findSafePos;
_obj2 = (selectRandom (strFobEast - [_selBaseE1])) createVehicle _pos2;
if(!isNull roadAt _obj2)then
{
	_obj2 setDir (getdir (roadAt _obj2)); 
	_obj2 setPos (_obj2 getRelPos [40,45]);
};
_obj2 setDir dirBE+180;

//respawn in the base (resBaseE1)
resBaseE1 = [];
_p = (objBaseE1 getRelPos [20, 0]) findEmptyPosition [0, 25, "B_soldier_F"];
if(count _p == 0) then {_p = (objBaseE1 getRelPos [20, 0]);};
resBaseE1 pushBackUnique _p;
publicVariable "resBaseE1";

if(modA=="GM")then
{
	{
		_obj = _x;
		{if(typeOf _obj==_x)then{_obj setDir dirBE;};} forEach ["land_gm_woodbunker_01_bags","land_gm_sandbags_02_bunker_high","land_gm_euro_deerstand_01","land_gm_woodbunker_01"];
	} forEach [objBaseE1,_obj2];
};
[format ["%1 created",nameBE1]] remoteExec ["systemChat", 0, false];

//2nd building BASE 2 EAST (Armors)
_posR = objBaseE2 getRelPos [30, random 360];
_pos2 = [posBaseE2, 20, 60, 10, 0, 0.2, 0, [], [_posR,_posR]] call BIS_fnc_findSafePos;
_obj2 = (selectRandom (strFobEast - [_selBaseE2])) createVehicle _pos2;
if(!isNull roadAt _obj2)then
{
	_obj2 setDir (getdir (roadAt _obj2)); 
	_obj2 setPos (_obj2 getRelPos [40,45]);
};
_obj2 setDir dirBE+180;

//respawn in the base (resBaseE2)
resBaseE2 = [];
_p = (objBaseE2 getRelPos [20, 0]) findEmptyPosition [0, 25, "B_soldier_F"];
if(count _p == 0) then {_p = (objBaseE2 getRelPos [20, 0]);};
resBaseE2 pushBackUnique _p;
publicVariable "resBaseE2";

if(modA=="GM")then
{
	{
		_obj = _x;
		{if(typeOf _obj==_x)then{_obj setDir dirBE;};} forEach ["land_gm_woodbunker_01_bags","land_gm_sandbags_02_bunker_high","land_gm_euro_deerstand_01","land_gm_woodbunker_01"];
	} forEach [objBaseE2,_obj2];
};
[format ["%1 created",nameBE2]] remoteExec ["systemChat", 0, false];

//RESPAWN markers (for respawn menu)
{
	_nme = _x select 0;
	_res = (_x select 1) select 0;
	_txt = _x select 2;

	_mrkRfW = createMarker [_nme, _res];
	_mrkRfW setMarkerShape "ELLIPSE";
	_mrkRfW setMarkerSize  [10, 10];
	_mrkRfW setMarkerAlpha  0;
	_mrkRfW setMarkerText _txt;
} forEach
[
	[resFobW,resBaseW1,nameBW1],
	[resBaseW,resBaseW2,nameBW2],
	[resFobE,resBaseE1,nameBE1],
	[resBaseE,resBaseE2,nameBE2]
];
//delete start respawn markers
[resStartW] remoteExec ["deleteMarker", 0, true];
[resStartE] remoteExec ["deleteMarker", 0, true];

//WEATHER
[parseText format ["Generating Weather"]] remoteExec ["hint", 0, false];
_overcast = [0, 0.5, 0.7, 1];
call //overcast
{
	//Random
	if (weather == 0) exitWith {0 setOvercast selectRandom _overcast;};
	//Clear
	if (weather == 1) exitWith {0 setOvercast (_overcast select 0);};
	//Cloudy
	if (weather == 2) exitWith {0 setOvercast (_overcast select 1);};
	//Rain
	if (weather == 3) exitWith {0 setOvercast (_overcast select 2);};
	//Stormy
	if (weather == 4) exitWith {0 setOvercast (_overcast select 3);};
};

call //fog
{
	//Random
	if (fogLevel == 0) exitWith {0 setFog selectRandom fogs;};
	//Yes
	if (fogLevel == 1) exitWith {0 setFog (fogs select 1);};
	//No
	if (fogLevel == 2) exitWith {0 setFog (fogs select 0);};
};

_rain = [0, 0.5, 1, 0];
call //rain
{
	//Random
	if (weather == 0) exitWith {0 setRain selectRandom _rain;};
	//Clear
	if (weather == 1) exitWith {0 setRain (_rain select 0);};
	//Cloudy
	if (weather == 2) exitWith {0 setRain (_rain select 0);};
	//Rain
	if (weather == 3) exitWith {0 setRain (_rain select 1);};
	//Stormy
	if (weather == 4) exitWith {0 setRain (_rain select 2);};
};

forceWeatherChange;
["Weather generated"] remoteExec ["systemChat", 0, false];

//create flags (teleports)
[parseText format ["Create flags"]] remoteExec ["hint", 0, false];
_fpos=(objBaseW1 getRelPos [25,0]) findEmptyPosition [0, 50, "B_soldier_F"];
if(count _fpos==0)then{_fpos=objBaseW1 getRelPos [25,0];};
flgBW1 = flgW createVehicle _fpos;

_fpos=(objBaseW2 getRelPos [25,324]) findEmptyPosition [0, 50, "B_soldier_F"];
if(count _fpos==0)then{_fpos=objBaseW2 getRelPos [25,324];};
flgBW2 = flgW createVehicle _fpos;

_fpos=(objBaseE1 getRelPos [25,0]) findEmptyPosition [0, 50, "B_soldier_F"];
if(count _fpos==0)then{_fpos=objBaseE1 getRelPos [25,0];};
flgBE1 = flgE createVehicle _fpos;

_fpos=(objBaseE2 getRelPos [25,324]) findEmptyPosition [0, 50, "B_soldier_F"];
if(count _fpos==0)then{_fpos=objBaseE2 getRelPos [25,324];};
flgBE2 = flgE createVehicle _fpos;

flgJetW = ""; flgJetE = "";
if (missType == 3) then 
{
	if(
		(count HeliArW!=0) ||
		((count PlaneW!=0)&&(planes==1)) ||
		((count PlaneW!=0)&&(planes==2)&&((plHW==plH1)||(plHW==plH2))&&((plHe==plH1)||(plHe==plH2)))	
	)then 
	{
		flgJetW = flgW createVehicle (plHW getRelPos [30, 270]);
	};

	if(
		(count HeliArE!=0) ||
		((count PlaneE!=0)&&(planes==1)) ||
		((count PlaneE!=0)&&(planes==2)&&((plHW==plH1)||(plHW==plH2))&&((plHe==plH1)||(plHe==plH2)))	
	)then 
	{
		flgJetE = flgE createVehicle (plHE getRelPos [30, 270]);
	};
};

[flgBW1,flgBW2,flgJetW,flgBE1,flgBE2,flgJetE,missType] remoteExec ["wrm_fnc_V2flagActions", 0, true]; 
["Flags created"] remoteExec ["systemChat", 0, false];

//kill players
{if (isPlayer _x)then{[_x] remoteExec ["forceRespawn", 0, false];};} forEach playableunits;
sleep 0.1;

//RESPAWN TIME
[parseText format ["Setting respawn time"]] remoteExec ["hint", 0, false];
call
{
	//5sec
	if (resTime == 0) exitWith {rTime = 5; publicvariable "rTime";};
	//30sec
	if (resTime == 1) exitWith {rTime = 30; publicvariable "rTime";};
	//60sec
	if (resTime == 2) exitWith {rTime = 60; publicvariable "rTime";};
	//120sec
	if (resTime == 3) exitWith {rTime = 120; publicvariable "rTime";};
	//180sec
	if (resTime == 4) exitWith {rTime = 180; publicvariable "rTime";};
};
["Respawn time set"] remoteExec ["systemChat", 0, false];

//Revive
if(isClass(configfile >> "CfgMods" >> "SPE"))then
{
	if(revOn==3)then
	{
		"SPE_Module_Advanced_Revive" createUnit [(position player),createGroup sideLogic,format
		["
			mdlRev=this;
			this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
			this setVariable ['name','modRev'];
			
			this setVariable ['SPE_ReviveEnabled',0,true];
			this setVariable ['SPE_ReviveMode',0,true];
			this setVariable ['SPE_ReviveRequiredTrait',0,true];
			this setVariable ['SPE_ReviveMedicSpeedMultiplier',1,true];
			this setVariable ['SPE_ReviveDelay',6,true];
			this setVariable ['SPE_ReviveForceRespawnDelay',6,true];
			this setVariable ['SPE_ReviveBleedOutDelay',180,true];
			this setVariable ['SPE_ReviveFakAmount',1,true];
			this setVariable ['SPE_ReviveIcons',0,true];
			this setVariable ['SPE_ReviveAutoCall',2,true];
			this setVariable ['SPE_ReviveAutoWithstand',2,true];
			this setVariable ['SPE_WithstandExtraFAK',0,true];
			this setVariable ['SPE_WithstandEnabled',0,true];
			this setVariable ['SPE_WithstandEnabledAI',0,true];
			this setVariable ['SPE_ReviveUnits',0,true];
		"]];
		publicVariable "mdlRev";
	};
};

//create Tasks
[sideW, "WW", ["Control ALL objectives, friendly and enemy bases<br/><br/>Reward:<br/>Win the battle","Control All",""], objNull, "CREATED", -1, true, "attack", true] call BIS_fnc_taskCreate;
[sideE, "EW", ["Control ALL objectives, friendly and enemy bases<br/><br/>Reward:<br/>Win the battle","Control All",""], objNull, "CREATED", -1, true, "attack", true] call BIS_fnc_taskCreate;
[sideW, "WA", ["Locate and capture enemy BASES<br/><br/>Reward:<br/>Enemy lost acces to vehicles<br/>Respawn position","Recon",""], objNull, "CREATED", -1, true, "scout", true] call BIS_fnc_taskCreate;
[sideE, "EA", ["Locate and capture enemy BASES<br/><br/>Reward:<br/>Enemy lost acces to vehicles<br/>Respawn position","Recon",""], objNull, "CREATED", -1, true, "scout", true] call BIS_fnc_taskCreate;
[sideW, "WD", ["Protect your BASES<br/><br/>Reward:<br/>Acces to vehicles<br/>Respawn position","Defend",""], objNull, "CREATED", -1, true, "defend", true] call BIS_fnc_taskCreate;
[sideE, "ED", ["Protect your BASES<br/><br/>Reward:<br/>Acces to vehicles<br/>Respawn position","Defend",""], objNull, "CREATED", -1, true, "defend", true] call BIS_fnc_taskCreate;

//CREATE SECTORS
[parseText format ["Creating sectors"]] remoteExec ["hint", 0, false];

//clear sorroundings
{
	_objs = nearestTerrainObjects [_x, 
	[
		"TREE","SMALL TREE","BUSH","BUILDING","HOUSE","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","CHURCH","CHAPEL","CROSS","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL","FENCE","WALL","HIDE","BUSSTOP","FOREST","TRANSMITTER","STACK","RUIN","TOURISM","WATERTOWER","ROCK","ROCKS","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK" //"MAIN ROAD","ROAD","RAILWAY","TRACK","TRAIL""POWER LINES",
	], 25, false, true];
	{
		_x hideObjectGlobal true;
	} forEach _objs;
} forEach [posArti,posAA,posCas];

//sector Anti Air
"ModuleSector_F" createUnit [posAA,createGroup sideLogic,format
["
	sectorAA=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name','A: Anti Air'];
	this setVariable ['Designation','A'];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','
		call
		{
			 if ((_this select 1) == sideW) exitWith 
			 {
				if(getMarkerColor resAW!='''')exitWith{};
				_mrkRbW = createMarker [resAW, posAA];
				_mrkRbW setMarkerShape ''ICON'';
				_mrkRbW setMarkerType ''empty'';
				_mrkRbW setMarkerText ''Anti Air'';
				deleteMarker resAE;
				if(!isNull objAAE)then
				{
					{objAAE deleteVehicleCrew _x} forEach crew objAAE;
					deleteVehicle objAAE;
				};
				if(count aaW!=0)then
				{
					_vSel = selectRandom aaW;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objAAW = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, ''NONE''];
					[objAAW,[_tex,1]] call bis_fnc_initVehicle;
				}else
				{
					_vSel = selectRandom aaE;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objAAW = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, ''NONE''];
					[objAAW,[_tex,1]] call bis_fnc_initVehicle;
				};
				[objAAW] call wrm_fnc_parachute;
				objAAW lockDriver true;
				_grpAAW=createGroup [sideW, true];			
				for ''_i'' from 1 to (objAAW emptyPositions ''Gunner'') step 1 do
				{
					_unit = _grpAAW createUnit [crewW, posAA, [], 0, ''NONE''];
					_unit moveInGunner objAAW;
				};
				for ''_i'' from 1 to (objAAW emptyPositions ''Commander'') step 1 do
				{
					_unit = _grpAAW createUnit [crewW, posAA, [], 0, ''NONE''];
					_unit moveInCommander objAAW;
				};
				objAAW allowCrewInImmobile true;
				{ _x addMPEventHandler
					[''MPKilled'',{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
				} forEach (crew objAAW);				
				publicvariable ''objAAW'';
				sleep 1;
				z1 addCuratorEditableObjects [[objAAW],true];
				defW pushBackUnique _grpAAW;
				[posAA,sideW] call wrm_fnc_V2secDefense;
			 };

			 if ((_this select 1) == sideE) exitWith  
			 {
				if(getMarkerColor resAE!='''')exitWith{};
				_mrkRbE = createMarker [resAE, posAA];
				_mrkRbE setMarkerShape ''ICON'';
				_mrkRbE setMarkerType ''empty'';
				_mrkRbE setMarkerText ''Anti Air'';
				deleteMarker resAW;
				if(!isNull objAAW)then
				{
					{objAAW deleteVehicleCrew _x} forEach crew objAAW;
					deleteVehicle objAAW;
				};
				if(count aaE!=0)then
				{
					_vSel = selectRandom aaE;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objAAE = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, ''NONE''];
					[objAAE,[_tex,1]] call bis_fnc_initVehicle;
				}else
				{
					_vSel = selectRandom aaW;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objAAE = createVehicle [_typ, [posAA select 0, posAA select 1, 50], [], 0, ''NONE''];
					[objAAE,[_tex,1]] call bis_fnc_initVehicle;
				};
				[objAAE] call wrm_fnc_parachute;
				objAAE lockDriver true;
				_grpAAE=createGroup [sideE, true];			
				for ''_i'' from 1 to (objAAE emptyPositions ''Gunner'') step 1 do
				{
					_unit = _grpAAE createUnit [crewE, posAA, [], 0, ''NONE''];
					_unit moveInGunner objAAE;
				};
				for ''_i'' from 1 to (objAAE emptyPositions ''Commander'') step 1 do
				{
					_unit = _grpAAE createUnit [crewE, posAA, [], 0, ''NONE''];
					_unit moveInCommander objAAE;
				};
				objAAE allowCrewInImmobile true;
				{ _x addMPEventHandler
					[''MPKilled'',{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
				} forEach (crew objAAE);				
				publicvariable ''objAAE'';
				sleep 1;
				z1 addCuratorEditableObjects [[objAAE],true];
				defE pushBackUnique _grpAAE;
				[posAA,sideE] call wrm_fnc_V2secDefense;
			 };
		};
		if (AIon>0) then {[] call wrm_fnc_V2aiMove;};
	'];
	this setVariable ['CaptureCoef','0.05']; 	
	this setVariable ['CostInfantry','0.2'];
	this setVariable ['CostWheeled','0.2'];
	this setVariable ['CostTracked','0.2'];
	this setVariable ['CostWater','0.2'];
	this setVariable ['CostAir','0.2'];
	this setVariable ['CostPlayers','0.2'];
	this setVariable ['DefaultOwner','-1'];
	this setVariable ['TaskOwner','3'];
	this setVariable ['TaskTitle','Anti Air'];
	this setVariable ['taskDescription','Seize ANTI AIR position<br/><br/>Reward:<br/>Anti air defence<br/>Respawn position'];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[sideE,sideW]];
	this setVariable ['objectArea',[75,75,0,false]];
"]];

[sectorAA] call BIS_fnc_moduleSector; //initialize sector

//Priskirti sektoriaus task'us visiems žaidėjams
private _sectorName = sectorAA getVariable ["name", "A: Anti Air"];
private _taskID_AA = format ["BIS_sector_%1", _sectorName];
if ([_taskID_AA] call BIS_fnc_taskExists) then {
    {
        if (isPlayer _x && (side _x == sideW || side _x == sideE)) then {
            [_taskID_AA, [_x]] call BIS_fnc_taskAssign;
        };
    } forEach allPlayers;
} else {
    //Fallback: bandyti kitus galimus task ID
    private _altTaskID = format ["TaskSector_%1", sectorAA];
    if ([_altTaskID] call BIS_fnc_taskExists) then {
        {
            if (isPlayer _x && (side _x == sideW || side _x == sideE)) then {
                [_altTaskID, [_x]] call BIS_fnc_taskAssign;
            };
        } forEach allPlayers;
    };
};

//sector Artillery
"ModuleSector_F" createUnit [posArti,createGroup sideLogic,format
["
	
	sectorArti=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name','B: Artillery'];
	this setVariable ['Designation','B'];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','
		call
		{
			 if ((_this select 1) == sideW) exitWith 
			 {
				if(getMarkerColor resBW!='''')exitWith{};
				_mrkRaW = createMarker [resBW, posArti];
				_mrkRaW setMarkerShape ''ICON'';
				_mrkRaW setMarkerType ''empty'';
				_mrkRaW setMarkerText ''Artillery'';
				deleteMarker resBE;
				[objArtiE, supArtiV2] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
				[SupReqE, SupArtiV2] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
				[SupReqW, SupArtiV2] remoteExec [''BIS_fnc_addSupportLink'', 0, true];
				if(!isNull objArtiE)then
				{
					{objArtiE deleteVehicleCrew _x} forEach crew objArtiE;
					deleteVehicle objArtiE;
				};
				if(count artiW!=0)then
				{
					_vSel = selectRandom artiW;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objArtiW = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, ''NONE''];
					[objArtiW,[_tex,1]] call bis_fnc_initVehicle;
				}else
				{
					_vSel = selectRandom artiE;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objArtiW = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, ''NONE''];
					[objArtiW,[_tex,1]] call bis_fnc_initVehicle;
				};
				[objArtiW] call wrm_fnc_parachute;
				objArtiW lockDriver true;
				_grpArtiW=createGroup [sideW, true];			
				for ''_i'' from 1 to (objArtiW emptyPositions ''Gunner'') step 1 do
				{
					_unit = _grpArtiW createUnit [crewW, posArti, [], 0, ''NONE''];
					_unit moveInGunner objArtiW;
				};
				for ''_i'' from 1 to (objArtiW emptyPositions ''Commander'') step 1 do
				{
					_unit = _grpArtiW createUnit [crewW, posArti, [], 0, ''NONE''];
					_unit moveInCommander objArtiW;
				};
				objArtiW allowCrewInImmobile true;
				{ _x addMPEventHandler
					[''MPKilled'',{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
				} forEach (crew objArtiW);
				[objArtiW, supArtiV2] remoteExec [''BIS_fnc_addSupportLink'', 0, true];				
				publicvariable ''objArtiW'';
				sleep 1;
				z1 addCuratorEditableObjects [[objArtiW],true];
				defW pushBackUnique _grpArtiW;
				[] spawn wrm_fnc_V2mortarW;
				[posArti,sideW] call wrm_fnc_V2secDefense;
			 };
			 
			 if ((_this select 1) == sideE) exitWith  
			 {
				if(getMarkerColor resBE!='''')exitWith{};
				_mrkRaE = createMarker [resBE, posArti];
				_mrkRaE setMarkerShape ''ICON'';
				_mrkRaE setMarkerType ''empty'';
				_mrkRaE setMarkerText ''Artillery'';
				deleteMarker resBW;
				[objArtiW, supArtiV2] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
				[SupReqW, SupArtiV2] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
				[SupReqE, SupArtiV2] remoteExec [''BIS_fnc_addSupportLink'', 0, true];
				if(!isNull objArtiW)then
				{
					{objArtiW deleteVehicleCrew _x} forEach crew objArtiW;
					deleteVehicle objArtiW;
				};
				if(count artiE!=0)then
				{
					_vSel = selectRandom artiE;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objArtiE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, ''NONE''];
					[objArtiE,[_tex,1]] call bis_fnc_initVehicle;
				}else
				{
					_vSel = selectRandom artiW;
					_typ='''';_tex='''';
					if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
					objArtiE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, ''NONE''];
					[objArtiE,[_tex,1]] call bis_fnc_initVehicle;
				};
				[objArtiE] call wrm_fnc_parachute;
				objArtiE lockDriver true;
				_grpArtiE=createGroup [sideE, true];			
				for ''_i'' from 1 to (objArtiE emptyPositions ''Gunner'') step 1 do
				{
					_unit = _grpArtiE createUnit [crewE, posArti, [], 0, ''NONE''];
					_unit moveInGunner objArtiE;
				};
				for ''_i'' from 1 to (objArtiE emptyPositions ''Commander'') step 1 do
				{
					_unit = _grpArtiE createUnit [crewE, posArti, [], 0, ''NONE''];
					_unit moveInCommander objArtiE;
				};
				objArtiE allowCrewInImmobile true;
				{ _x addMPEventHandler
					[''MPKilled'',{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
				} forEach (crew objArtiE);
				[objArtiE, supArtiV2] remoteExec [''BIS_fnc_addSupportLink'', 0, true];				
				publicvariable ''objArtiE'';
				sleep 1;
				z1 addCuratorEditableObjects [[objArtiE],true];
				defE pushBackUnique _grpArtiE;
				[] spawn wrm_fnc_V2mortarE;
				[posArti,sideE] call wrm_fnc_V2secDefense;
			};
		};
		if (AIon>0) then {[] call wrm_fnc_V2aiMove;};
	'];
	this setVariable ['CaptureCoef','0.05']; 	
	this setVariable ['CostInfantry','0.2'];
	this setVariable ['CostWheeled','0.2'];
	this setVariable ['CostTracked','0.2'];
	this setVariable ['CostWater','0.2'];
	this setVariable ['CostAir','0.2'];
	this setVariable ['CostPlayers','0.2'];
	this setVariable ['DefaultOwner','-1'];
	this setVariable ['TaskOwner','3'];
	this setVariable ['TaskTitle','Artillery'];
	this setVariable ['taskDescription','Seize ARTILLERY position<br/><br/>Reward:<br/>Artillery support<br/>Respawn position'];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[sideE,sideW]];
	this setVariable ['objectArea',[75,75,0,false]];
	this setVariable ['taskType','Attack'];

"]];

[sectorArti] call BIS_fnc_moduleSector; //initialize sector

//Priskirti sektoriaus task'us visiems žaidėjams
private _sectorName = sectorArti getVariable ["name", "B: Artillery"];
private _taskID_Arti = format ["BIS_sector_%1", _sectorName];
if ([_taskID_Arti] call BIS_fnc_taskExists) then {
    {
        if (isPlayer _x && (side _x == sideW || side _x == sideE)) then {
            [_taskID_Arti, [_x]] call BIS_fnc_taskAssign;
        };
    } forEach allPlayers;
} else {
    //Fallback: bandyti kitus galimus task ID
    private _altTaskID = format ["TaskSector_%1", sectorArti];
    if ([_altTaskID] call BIS_fnc_taskExists) then {
        {
            if (isPlayer _x && (side _x == sideW || side _x == sideE)) then {
                [_altTaskID, [_x]] call BIS_fnc_taskAssign;
            };
        } forEach allPlayers;
    };
};

//sector CAS Tower
"ModuleSector_F" createUnit [posCas,createGroup sideLogic,format
["
	sectorCas=this;
	this setvariable ['BIS_fnc_initModules_disableAutoActivation',false];
	this setVariable ['name','C: CAS Tower'];
	this setVariable ['Designation','C'];
	this setVariable ['OwnerLimit','1'];
	this setVariable ['OnOwnerChange','
		call
		{
			 if ((_this select 1) == sideW) exitWith 
			 {
				if(getMarkerColor resCW!='''')exitWith{};
				if(missType>1||count PlaneW==0)then
				{
					if(count HeliArW!=0)then
					{
						_v = HeliArW select 0; _typ='''';
						if (_v isEqualType [])then{_typ=_v select 0;}else{_typ=_v;};
						if(_typ iskindof ''helicopter'')then
						{
							[SupReqW, SupCasHW] remoteExec [''BIS_fnc_addSupportLink'', 0, true];
							[SupReqE, SupCasHE] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
						};
					};
				};
				if(count PlaneW!=0)then
				{
					_v = PlaneW select 0; _typ='''';
					if (_v isEqualType [])then{_typ=_v select 0;}else{_typ=_v;};
					if(_typ iskindof ''plane'')then
					{
						[SupReqW, SupCasBW] remoteExec [''BIS_fnc_addSupportLink'', 0, true];
						[SupReqE, SupCasBE] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
					};
				};				
				_mrkRcW = createMarker [resCW, posCas];
				_mrkRcW setMarkerShape ''ICON'';
				_mrkRcW setMarkerType ''empty'';
				_mrkRcW setMarkerText ''CAS Tower''; 
				deleteMarker resCE;
				[posCas,sideW] call wrm_fnc_V2secDefense;
			 };
			 
			 if ((_this select 1) == sideE) exitWith  
			 {
				if(getMarkerColor resCE!='''')exitWith{};
				if(missType>1||count PlaneE==0)then
				{
					if(count HeliArE!=0)then
					{
						_v = HeliArE select 0; _typ='''';
						if (_v isEqualType [])then{_typ=_v select 0;}else{_typ=_v;};
						if(_typ iskindof ''helicopter'')then
						{
							[SupReqE, SupCasHE] remoteExec [''BIS_fnc_addSupportLink'', 0, true];
							[SupReqW, SupCasHW] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
						};
					};
				};
				if(count PlaneE!=0)then
				{
					_v = PlaneE select 0; _typ='''';
					if (_v isEqualType [])then{_typ=_v select 0;}else{_typ=_v;};
					if(_typ iskindof ''plane'')then
					{
						[SupReqE, SupCasBE] remoteExec [''BIS_fnc_addSupportLink'', 0, true];
						[SupReqW, SupCasBW] remoteExec [''BIS_fnc_removeSupportLink'', 0, true];
					};
				};
				_mrkRcE = createMarker [resCE, posCas];
				_mrkRcE setMarkerShape ''ICON'';
				_mrkRcE setMarkerType ''empty'';
				_mrkRcE setMarkerText ''CAS Tower'';
				deleteMarker resCW;
				[posCas,sideE] call wrm_fnc_V2secDefense;
			 };
		};
		if (AIon>0) then {[] call wrm_fnc_V2aiMove;};
	'];
	this setVariable ['CaptureCoef','0.05']; 	
	this setVariable ['CostInfantry','0.2'];
	this setVariable ['CostWheeled','0.2'];
	this setVariable ['CostTracked','0.2'];
	this setVariable ['CostWater','0.2'];
	this setVariable ['CostAir','0.2'];
	this setVariable ['CostPlayers','0.2'];
	this setVariable ['DefaultOwner','-1'];
	this setVariable ['TaskOwner','3'];
	this setVariable ['TaskTitle','CAS Tower'];
	this setVariable ['taskDescription','Seize CAS TOWER position<br/><br/>Reward:<br/>Close air support<br/>Respawn position'];
	this setVariable ['ScoreReward','0'];
	this setVariable ['Sides',[sideE,sideW]];
	this setVariable ['objectArea',[75,75,0,false]];
"]];

//CAS sektorius inicializuojamas iš karto kaip originalo versijoje
[sectorCas] call BIS_fnc_moduleSector; //initialize sector

//create tower
objCas = createVehicle [selectRandom tower, posCas];
objCas setVectorUp [0,0,1];
objCas allowDamage false;
z1 addCuratorEditableObjects [[objCas],true];
publicVariable "objCas";

//range 0
_mrkArtiRng = createMarker ["mRng0", posArti];
_mrkArtiRng setMarkerShape "ELLIPSE";
_mrkArtiRng setMarkerSize [(artiRange select 0),(artiRange select 0)];
_mrkArtiRng setMarkerColor "ColorBlack";
_mrkArtiRng setMarkerBrush "Border";

//range 1
_mrkArtiRng = createMarker ["mRng1", posArti];
_mrkArtiRng setMarkerShape "ELLIPSE";
_mrkArtiRng setMarkerSize [(artiRange select 1),(artiRange select 1)];
_mrkArtiRng setMarkerColor "ColorBlack";
_mrkArtiRng setMarkerBrush "Border";
if(modA=="CSLA")then{_mrkArtiRng setMarkerAlpha 0};
if(modA=="SPE")then{_mrkArtiRng setMarkerAlpha 0};

["Sectors created"] remoteExec ["systemChat", 0, false];

//RESPAWN TICKETS
[parseText format ["Setting respawn tickets"]] remoteExec ["hint", 0, false];
call
{
	if (resTickets == 0) exitWith 
	{
		_vhs=0;
		if (AIon>0&&missType>1)then
		{
			_n=3;
			if(missType==3)then{_n=4;};
			call
			{
				if(vehTime==0)exitWith{_vhs=(120*_n);};
				if(vehTime==1)exitWith{_vhs=(60*_n);};
				if(vehTime==2)exitWith{_vhs=(20*_n);};
				if(vehTime==3)exitWith{_vhs=(12*_n);};
				if(vehTime==4)exitWith{_vhs=(6*_n);};
			};
		};
		tic=(_pls*40)+(_ais*15)+_vhs;
		if (ticBleed==0)then
		{tic=tic/2;};
	};
	if (resTickets == 1) exitWith {tic = 200;};
	if (resTickets == 2) exitWith {tic = 400;};
	if (resTickets == 3) exitWith {tic = 800;};
	if (resTickets == 4) exitWith {tic = 1200;};
	if (resTickets == 5) exitWith {tic = 1600;};
	if (resTickets == 6) exitWith {tic = 2000};
	if (resTickets == 7) exitWith {tic = 2400;};
	if (resTickets == 8) exitWith {tic = 2800;};
	if (resTickets == 9) exitWith {tic = 3200;};
	if (resTickets == 10) exitWith {tic = 3600;};
	if (resTickets == 11) exitWith {tic = 4000;};
};
[sideW, tic] call BIS_fnc_respawnTickets; 
[sideE, tic] call BIS_fnc_respawnTickets;

["Respawn tickets set"] remoteExec ["systemChat", 0, false];

//launch scripts
[] spawn wrm_fnc_resGrpsUpdate; //group respawn
[] spawn wrm_fnc_V2secBE1; //create sector for base if enemy is close
[] spawn wrm_fnc_V2secBE2;
[] spawn wrm_fnc_V2secBW1;
[] spawn wrm_fnc_V2secBW2;
[] execVM "warmachine\V2sectorSmoke.sqf"; //create smoke on the sector
[] spawn wrm_fnc_V2sectorSmoke;
[] spawn wrm_fnc_V2sectorLight;
{[_x] spawn wrm_fnc_equipment;} forEach playableUnits; //add GPS and NVG
remoteExec ["wrm_fnc_leaderUpdate", 0, true]; //loop check if player is leader
"warmachine\V2firstSpawn.sqf" remoteExec ["execVM", 0, false]; //replace units to player (leader) on the first spawn
[] execVM "warmachine\V2aiStart.sqf"; //spawn AI vehicles, timer, ticket bleed
[] execVM "warmachine\clearFences.sqf"; //Weferlingen border
if (AIon>0) then {[] spawn wrm_fnc_V2aiUpdate;};
[] spawn wrm_fnc_V2endGame;
[] spawn wrm_fnc_V2unhideVeh;

//progress = 2; publicVariable "progress";

//CLIENTS START SCRIPT
[[
	//mission parameters
	aoType, missType, day, resTickets, weather, ticBleed, fogLevel, timeLim, AIon, resType, revOn, resTime, viewType, vehTime, 
	//objectives position
	posArti, posCas, posAA, posBaseW1,posBaseW2, posBaseE1, posBaseE2, 
	//infantry respawn 
	resArtiW, resArtiE, resCasW, resCasE, resAAW, resAAE, resBaseW1W, resBaseW1E, resBaseW2W, resBaseW2E, resBaseE1W, resBaseE1E, resBaseE2W, resBaseE2E,  
	//vehicle respawn
	rBikeW, rTruckW, rHeliTrW, rCarArW, rCarW, rArmorW1, rHeliArW, rArmorW2, rBikeE, rTruckE, rHeliTrE, rCarArE, rCarE, rArmorE1, rHeliArE, rArmorE2,
	//directions
	dirBW, dirBE,
	//center
	posCenter,minDis,
	AOsize
], "warmachine\V2startClient.sqf"] remoteExec ["execVM", 0, true];

//teleport units to the BASES
[parseText format ["Teleporting units"]] remoteExec ["hint", 0, false];

_grpsA= [];_grpsW=[];_grpsE=[];
{_grpsA pushBackUnique group _x} forEach playableUnits;
{if(side _x==sideW)then{_grpsW pushBackUnique _x;}else{_grpsE pushBackUnique _x;};}forEach _grpsA;

//west
_i=1;
{
	_base=flgBW1; if(_i==2)then{_base=flgBW2;};
	{_x setPos (_base getRelPos [random [3,6,9],random 360]);}forEach units _x;
	if(_i==1)then{_i=2;}else{_i=1;};
}forEach _grpsW;

//east
_i=1;
{
	_base=flgBE1; if(_i==2)then{_base=flgBE2;};
	{_x setPos (_base getRelPos [random [3,6,9],random 360]);}forEach units _x;
	if(_i==1)then{_i=2;}else{_i=1;};
}forEach _grpsE;

{[_x] remoteExec ["hideBody", 0, false];} forEach allDeadMen;
["Units teleported"] remoteExec ["systemChat", 0, false];

[parseText format ["MISSION CREATED SUCCESFULY"]] remoteExec ["hint", 0, false];
["Server is ready"] remoteExec ["systemChat", 0, false];
sleep 1;
progress = 2; publicVariable "progress";