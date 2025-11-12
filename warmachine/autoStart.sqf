/*
	[("autoStart" call BIS_fnc_getParamValue)] execVM "warmachine\autoStart.sqf"
*/
_a = _this select 0;
if !(isServer) exitWith {}; //runs on the server/host


aStart=1; publicVariable "aStart";
// Wait until there is at least one human player who is fully initialized and alive.
waitUntil {
    sleep 1;
    !((allPlayers - entities "HeadlessClient_F") isEqualTo []) &&
    {
        private _player = (allPlayers - entities "HeadlessClient_F") select 0;
        !isNull _player && alive _player
    }
};
sleep 5;
_tx1="";
call
{
	if("wmgenerator" call BIS_fnc_getParamValue == 2)exitWith{_tx1="<br/><br/>Or you can create your own mission in the <br/>MISSION GENERATOR<br/>(actions menu)<br/><br/>STOP COUNTDOWN<br/>(actions menu)";}; //2
	if(serverCommandAvailable "#kick")exitWith{_tx1="<br/><br/>Or you can create your own mission in the <br/>MISSION GENERATOR<br/>(actions menu)<br/><br/>STOP COUNTDOWN<br/>(actions menu)";}; //0
	if(("wmgenerator" call BIS_fnc_getParamValue == 1)&&(count(allPlayers - entities "HeadlessClient_F")==1))exitWith{_tx1="<br/><br/>Or you can create your own mission in the <br/>MISSION GENERATOR<br/>(actions menu)<br/><br/>STOP COUNTDOWN<br/>(actions menu)";}; //1
};
if (_a==1) then
{
	if (aStart==0) exitWith {};
	if (progress>0) exitWith {};
	[parseText format ["Mission will start in 3 min. automatically%1",_tx1]] remoteExec ["hint", 0, false];
	sleep 60;
	if (aStart==0) exitWith {};
	if (progress>0) exitWith {};
	[parseText format ["Mission will start in 2 min. automatically%1",_tx1]] remoteExec ["hint", 0, false];
	sleep 60;
	if (aStart==0) exitWith {};
	if (progress>0) exitWith {};
	[parseText format ["Mission will start in 1 min. automatically%1",_tx1]] remoteExec ["hint", 0, false];
	sleep 60;
	if (aStart==0) exitWith {};
	if (progress>0) exitWith {};
};
if (aStart==0) exitWith {["Countdown canceled"] remoteExec ["hint", 0, false];};
if (progress>0) exitWith {};
//close dialog window
[0] remoteExec ["closeDialog", 0, false]; //closeDialog 0;
//countdown
for "_i" from 10 to 0 step -1 do //loop 10
{
	[parseText format ["MISSION START IN %1%2", _i,_tx1]] remoteExec ["hint", 0, false];
	sleep 1;
};
if (aStart==0) exitWith {["Countdown canceled"] remoteExec ["hint", 0, false];};
if (progress>0) exitWith {};
progress = 1;  publicVariable "progress";
[""] remoteExec ["hint", 0, false];
[["CREATING MISSION", "BLACK", 3]] remoteExec ["titleText", 0, false];
sleep 3;

aoType=0; //AO selection method

missType=("asp1" call BIS_fnc_getParamValue); //Mission type
day=("asp2" call BIS_fnc_getParamValue); //Time of day
weather=("asp3" call BIS_fnc_getParamValue); //Weather
fogLevel=("asp4" call BIS_fnc_getParamValue); //Fog
AIon=("asp5" call BIS_fnc_getParamValue); //Autonomous AI
revOn=("asp6" call BIS_fnc_getParamValue); //Revive
if(revOn==3)then
{
	if(!isClass(configfile >> "CfgMods" >> "SPE"))then{revOn=2};
};
viewType=("asp7" call BIS_fnc_getParamValue); //3rd person view
call
{
	if(viewType==1)exitWith
	{
		if(difficultyOption "thirdPersonView"==0)then{viewType=0;};
	};
	if(viewType==2)exitWith
	{
		if(difficultyOption "thirdPersonView"==0)then{viewType=0;};
		if(difficultyOption "thirdPersonView"==2)then{viewType=1;};
	};
};
resTickets=("asp8" call BIS_fnc_getParamValue); //Respawn tickets
ticBleed=("asp9" call BIS_fnc_getParamValue); //Ticket bleed
timeLim=("asp10" call BIS_fnc_getParamValue); //Time limit
resType=("asp11" call BIS_fnc_getParamValue); //Respawn type
resTime=("asp12" call BIS_fnc_getParamValue); //Player respawn time
vehTime=("asp13" call BIS_fnc_getParamValue); //Vehicles respawn time
aoSize=("asp14" call BIS_fnc_getParamValue); //AO size

//version 1
//secNo=("asp14" call BIS_fnc_getParamValue); //Number of sectors
//support=("asp15" call BIS_fnc_getParamValue); //Combat support

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
	aoSize
], "warmachine\V2startServer.sqf"] remoteExec ["execVM", 0, false];
