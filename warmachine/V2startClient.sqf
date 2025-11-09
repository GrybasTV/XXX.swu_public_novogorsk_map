
if (!hasInterface) exitWith {}; //is player

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
//center
posCenter = _this select 53;
minDis = _this select 54;
AOsize = _this select 55;

//delete client's markers
{deleteMarkerLocal _x;} forEach aoMarkers;
{deleteMarkerLocal _x;} forEach resMarkers;
if(count aoObjs!=0)then{{deleteVehicle _x;} forEach aoObjs;}; aoObjs = [];

titleFadeOut 3;

waitUntil {!isNull player}; //JIP
waitUntil {player == player}; //Ensure player is local and fully initialized
waitUntil {!alive player}; //orig: laukti kol senas vienetas nužudomas prieš perkelimą
waitUntil {progress > 1}; //mission is created and started 
waitUntil {alive player}; //tikras žaidėjo personažas jau respawnintas ir turi pusę

//REVIVE
if(revOn==0)then{[player] call bis_fnc_disableRevive;};
if(revOn==2)then{player addEventHandler ["Dammaged",{_this spawn wrm_fnc_plRevive;}];};
if(isClass(configfile >> "CfgMods" >> "SPE"))then
{
	if(revOn==3)then{[player] call bis_fnc_disableRevive;};
};

//3rd person view
if(difficultyOption "thirdPersonView"!=0)then
{
	call
	{
		if((viewType==1)&&(difficultyOption "thirdPersonView"==1))then
		{
			addMissionEventHandler ["EachFrame",
			{
				if(lifeState player=="HEALTHY"||lifeState player=="INJURED")then
				{
					if(vehicle player==player)then
					{
						if(cameraView == "External"||cameraView == "Group")
						then{vehicle player switchCamera "Internal";};
					}else
					{
						if(cameraView == "Group")
						then{vehicle player switchCamera "External";};
					};
				};
			}];
		};
		if(viewType==0)then
		{
			addMissionEventHandler ["EachFrame",
			{
				if(lifeState player=="HEALTHY"||lifeState player=="INJURED")then
				{
					if(cameraView == "External"||cameraView == "Group")
					then{vehicle player switchCamera "Internal";};
				};
			}];
		};
	};
};

//create local markers for players BASES
call
{
	if (side player == sideW) exitWith 
	{
		_mrkFob = createMarkerLocal ["mFobW", posBaseW1];
		_mrkFob setMarkerShapeLocal "ICON";
		_mrkFob setMarkerTypeLocal iconW;
		_mrkFob setMarkerTextLocal nameBW1;

		_mrkBase = createMarkerLocal ["mBaseW", posBaseW2];
		_mrkBase setMarkerShapeLocal "ICON";
		_mrkBase setMarkerTypeLocal iconW;
		_mrkBase setMarkerTextLocal nameBW2;
	};
	if (side player == sideE) exitWith 
	{
		_mrkFob = createMarkerLocal ["mFobE", posBaseE1];
		_mrkFob setMarkerShapeLocal "ICON";
		_mrkFob setMarkerTypeLocal iconE;
		_mrkFob setMarkerTextLocal nameBE1;

		_mrkBase = createMarkerLocal ["mBaseE", posBaseE2];
		_mrkBase setMarkerShapeLocal "ICON";
		_mrkBase setMarkerTypeLocal iconE;
		_mrkBase setMarkerTextLocal nameBE2;
	};
};

//ARSENAL
if("Param2" call BIS_fnc_getParamValue == 1)then
{
	call
	{
		if(side player == sideW)exitWith
		{
			[AmmoW1,sideW] call wrm_fnc_arsInit; 
			[AmmoW2,sideW] call wrm_fnc_arsInit;
		};
		if(side player == sideE)exitWith
		{
			[AmmoE1,sideE] call wrm_fnc_arsInit;
			[AmmoE2,sideE] call wrm_fnc_arsInit;			
		};
	};
};

systemChat "Mission created";

//hint displays for all players after mission is created
sleep 5;

boatArUsed = 0;
loc = text (nearestLocations [posCenter, ["NameCity","NameCityCapital","NameMarine","NameVillage","NameLocal","Airport"],minDis] select 0);
_mType="";
_ai="";
_rev="";
_viw="";
_tLim="";
_resTp = "";
_tic = format ["%1", [sideW] call BIS_fnc_respawnTickets]; //Tickets
_bleed = "";
_resPl = format ["%1", rTime]; //Respawn time player
_resTr = format ["%1", trTime/60]; //Respawn time transport vehicles
_resAr = format ["%1", arTime/60]; //Respawn time armed vehicles
_hour = floor daytime;
_minute = floor ((daytime - _hour) * 60);
_second = floor (((((daytime) - (_hour))*60) - _minute)*60);
_time = format ["%1:%2:%3",_hour,_minute,_second];
_wthr = "";
_rain = "";
_fog = "";
_ars = "";

call //Mission type
{
	if (missType == 1) exitWith {_mType = "INFANTRY MISSION";};
	if (missType == 2) exitWith {_mType = "COMBINED GROUND FORCES";};
	if (missType == 3) exitWith {_mType = "FULL SPECTRUM WARFARE";};
};

call //Autonomous AI
{
	if(AIon==0)exitWith{_ai="disabled";};
	if(AIon==1)exitWith{_ai="balanced";};
	if(AIon==2)exitWith{_ai="challenging";};
};

call //Revive
{
	if (revOn == 0) exitWith {_rev = "Revive disabled";};
	if (revOn == 1) exitWith {_rev = "Player can revive Player";};
	if (revOn == 2) exitWith {_rev = "Player/AI can revive Player";};
	if (revOn == 3) exitWith {_rev = "Player/AI can revive Player/AI";};
};

call //3rd person view
{
	if (viewType == 0) exitWith {_viw = "disabled";};
	if (viewType == 1) exitWith {_viw = "only in the vehicle";};
	if (viewType == 2) exitWith {_viw = "enabled";};
};

call //Time limit
{
	if (timeLim==0) exitWith {_tLim = "disabled";};
	if (timeLim==1) exitWith {_tLim = "60 minutes";};
	if (timeLim==2) exitWith {_tLim = "90 minutes";};
	if (timeLim==3) exitWith {_tLim = "120 minutes";};
};

call //Respawn type
{
	if (resType == 0) exitWith {_resTp = "Base, Sectors";};
	if (resType == 1) exitWith {_resTp = "Base, Sectors, Squad";};
};

if (ticBleed == 0) //Ticket bleed
then {_bleed = "disabled";}
else {_bleed = "enabled";};

if (Overcast < 0.2) //Overcast
then {_wthr = "Clear sky";} 
else 
{
	if (Overcast < 0.7) 
	then {_wthr = "Partly cloudy";} 
	else {_wthr = "Overcast";};
};

if (rain > 0.05) //Rain
then {_rain = " and rain";}  
else {_rain = ", no rain";};

if (fog > 0.05) //Fog
then {_fog = ", fog";} 
else {_fog = ", no fog";};

if ("Param2" call BIS_fnc_getParamValue > 0) //Arsenal
then {_ars = "<br/><br/>VIRTUAL ARSENAL<br/>is accessible at the supply box on the BASE";}
else {_ars = "";};

_text = ["VARMACHINE ",island,"<br/>Operation ",loc,"<br/>",factionW," vs ",factionE,"<br/><br/>",_mType,"<br/>Time ", _time,"<br/>",_wthr,_rain,_fog,"<br/>Autonomous AI ",_ai,"<br/>",_rev,"<br/>3rd person view ",_viw,"<br/>Time limit ",_tLim,"<br/><br/>RESPAWN<br/>",_resTp,"<br/>",_tic," Tickets<br/>Ticket bleed ",_bleed,"<br/>Respawn time<br/>","Players: ",_resPl," sec<br/>Transport vehicles: ",_resTr," min<br/>Armed vehicles: ",_resAr," min",_ars] joinString "";
hint parseText format ["%1", _text];

player createDiaryRecord 
["Diary",["Mission",_text]];

sleep 10;
[[[["Operation ",loc] joinString ""]]] spawn BIS_fnc_typeText;


