//Author: IvosH

//VARIABLES SETUP
progress = 0; publicVariable "progress";
posCenter = []; publicVariable "posCenter";
posAlpha = []; publicVariable "posAlpha";
dirAB = 0; publicVariable "dirAB";
posBravo = []; publicVariable "posBravo";
dirBA = 180; publicVariable "dirBA";
posCharlie = []; publicVariable "posCharlie";
posFobWest = []; publicVariable "posFobWest";
dirCenFobWest = 0; publicVariable "dirCenFobWest";
posFobEast = []; publicVariable "posFobEast";
dirCenFobEast = 180; publicVariable "dirCenFobEast";
posBaseWest = []; publicVariable "posBaseWest";
dirCenBaseWest = 0; publicVariable "dirCenBaseWest";
posBaseEast = []; publicVariable "posBaseEast";
dirCenBaseEast = 180; publicVariable "dirCenBaseEast";
minDis = 500; publicVariable "minDis";
flgDel = 0; publicVariable "flgDel";
aiDrive=0; publicVariable "aiDrive";
AIapcW=0; publicvariable "AIapcW";
AIapcE=0; publicvariable "AIapcE";
AIapcD=0; publicvariable "AIapcD";
coop=0; publicvariable "coop";
//ai vehicles
aiVehW=objNull; publicvariable "aiVehW";
aiVehE=objNull; publicvariable "aiVehE";
aiArmW=objNull; publicvariable "aiArmW"; //V2
aiArmE=objNull; publicvariable "aiArmE"; //V2
aiArmW2=objNull; publicvariable "aiArmW2"; //V2
aiArmE2=objNull; publicvariable "aiArmE2"; //V2
aiCasW=objNull; publicvariable "aiCasW";
aiCasE=objNull; publicvariable "aiCasE";
pltW=[]; publicvariable "pltW";
pltE=[]; publicvariable "pltE";
corpses=[]; publicVariable "corpses";
healers=[]; publicVariable "healers";
sectorF=objNull; publicvariable "sectorF";

//VERSION 2
version = 2; publicVariable "version";
dbgVehs = []; publicvariable "dbgVehs"; //debug vehicles at the bases
//objectives position
posArti =[]; publicVariable "posArti";
posCas =[]; publicVariable "posCas";
posAA =[]; publicVariable "posAA";
posBaseW1 =[]; publicVariable "posBaseW1";
posBaseW2 =[]; publicVariable "posBaseW2";
posBaseE1 =[]; publicVariable "posBaseE1"; 
posBaseE2 =[]; publicVariable "posBaseE2";
//infantry respawn 
resArtiW =[]; publicVariable "resArtiW";
resArtiE =[]; publicVariable "resArtiE";
resCasW =[]; publicVariable "resCasW";
resCasE =[]; publicVariable "resCasE";
resAAW =[]; publicVariable "resAAW";
resAAE =[]; publicVariable "resAAE";
resBaseW1W =[]; publicVariable "resBaseW1W";
resBaseW1E =[]; publicVariable "resBaseW1E";
resBaseW2W =[]; publicVariable "resBaseW2W";
resBaseW2E  =[]; publicVariable "resBaseW2E";
resBaseE1W =[]; publicVariable "resBaseE1W"; 
resBaseE1E =[]; publicVariable "resBaseE1E"; 
resBaseE2W =[]; publicVariable "resBaseE2W";
resBaseE2E =[]; publicVariable "resBaseE2E";  
//vehicle respawn
rBikeW =[]; publicVariable "rBikeW";
rTruckW =[]; publicVariable "rTruckW";
rHeliTrW =[]; publicVariable "rHeliTrW"; 
rCarArW =[]; publicVariable "rCarArW";
rCarW =[]; publicVariable "rCarW";
rArmorW1 =[]; publicVariable "rArmorW1";
rHeliArW =[]; publicVariable "rHeliArW";
rArmorW2 =[]; publicVariable "rArmorW2";
rBikeE =[]; publicVariable "rBikeE";
rTruckE =[]; publicVariable "rTruckE";
rHeliTrE =[]; publicVariable "rHeliTrE"; 
rCarArE =[]; publicVariable "rCarArE"; 
rCarE =[]; publicVariable "rCarE";
rArmorE1  =[]; publicVariable "rArmorE1";
rHeliArE  =[]; publicVariable "rHeliArE";
rArmorE2 =[]; publicVariable "rArmorE2";
//directions
dirBW = 0; 
dirBE = 0; 
//hiden vehicles if the base is captured by the enemy
hideVehBW1=[]; publicVariable "hideVehBW1";
hideVehBW2=[]; publicVariable "hideVehBW2";
hideVehBE1=[]; publicVariable "hideVehBE1";
hideVehBE2=[]; publicVariable "hideVehBE2";
//sector Vehicles
objArtiW=objNull; publicvariable "objArtiW";
objArtiE=objNull; publicvariable "objArtiE";
objAAW=objNull; publicvariable "objAAW";
objAAE=objNull; publicvariable "objAAE";
objMortW=objNull; publicvariable "objMortW";
objMortE=objNull; publicvariable "objMortE";
//check sectors at the bases
secBW1=false; publicvariable "secBW1";
secBW2=false; publicvariable "secBW2";
secBE1=false; publicvariable "secBE1";
secBE2=false; publicvariable "secBE2";
//UAV - grupės-based sistema Ukraine/Russia frakcijoms
//Masyvai saugo grupės ID ir cooldown laiką: [[groupId, cooldownTime], ...]
uavGroupCooldowns = []; publicVariable "uavGroupCooldowns";
//Masyvai saugo grupės ID ir UAV objektą: [[groupId, uavObject], ...]
uavGroupObjects = []; publicVariable "uavGroupObjects";
//Fiksuotas cooldown laikas: 3 minutės (180 sekundžių)
uavCooldownTime = 180; publicVariable "uavCooldownTime";
//Senoji sistema (paliekama suderinamumui su kitomis frakcijomis)
uavW=objNull; publicvariable "uavW"; uavWr=0; publicvariable "uavWr";
ugvW=objNull; publicvariable "ugvW"; ugvWr=0; publicvariable "ugvWr";
uavE=objNull; publicvariable "uavE"; uavEr=0; publicvariable "uavEr";
ugvE=objNull; publicvariable "ugvE"; ugvEr=0; publicvariable "ugvEr";
//Units placed by ZEUS will respawn
resZeus=true; publicvariable "resZeus";
//base defense
defW=[];
defE=[];
dBW1=false;
dBW2=false;
dBE1=false;
dBE2=false;
//dynamic squads - saugo dinamiškai spawnintų grupių ID
dynamicSquadsGroups=[]; publicVariable "dynamicSquadsGroups";

["Server variables loaded"] remoteExec ["systemChat", 0, false];
//ZEUS 
z1 addCuratorEditableObjects [allplayers+playableUnits]; //all players and playable units will be editable by Zeus
["Initialize"] call BIS_fnc_dynamicGroups; // Initializes the Dynamic Groups framework
["Zeus loaded"] remoteExec ["systemChat", 0, false];

if ("autoStart" call BIS_fnc_getParamValue != 0)then{[("autoStart" call BIS_fnc_getParamValue)] execVM "warmachine\autoStart.sqf"};

// Start performance monitoring system
[] spawn wrm_fnc_performanceMonitor;
diag_log "[INIT] Performance monitor started";

