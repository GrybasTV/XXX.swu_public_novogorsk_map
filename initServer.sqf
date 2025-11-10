//Author: IvosH

//CLEANUP: Išvalyti senus UAV/UGV duomenis iš ankstesnių misijų (restart protection)
if (!isNil "uavSquadW") then { uavSquadW = []; };
if (!isNil "uavSquadE") then { uavSquadE = []; };

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
objArtiW=objNull; publicvariable "objVehW";
objArtiE=objNull; publicvariable "objVehW";
objAAW=objNull; publicvariable "objVehW";
objAAE=objNull; publicvariable "objVehW";
objMortW=objNull; publicvariable "objMortW";
objMortE=objNull; publicvariable "objMortE";
//check sectors at the bases
secBW1=false; publicvariable "secBW1";
secBW2=false; publicvariable "secBW2";
secBE1=false; publicvariable "secBE1";
secBE2=false; publicvariable "secBE2";
//UAV (originali sistema - naudojama A3 modui)
uavW=objNull; publicvariable "uavW"; uavWr=0; publicvariable "uavWr";
ugvW=objNull; publicvariable "ugvW"; ugvWr=0; publicvariable "ugvWr";
uavE=objNull; publicvariable "uavE"; uavEr=0; publicvariable "uavEr";
ugvE=objNull; publicvariable "ugvE"; ugvEr=0; publicvariable "ugvEr";

//Per-squad dronų sistema (Ukraine 2025 / Russia 2025)
//Struktūra: [[playerUID, uavObject, cooldownTime], ...]
uavSquadW = []; publicvariable "uavSquadW";
uavSquadE = []; publicvariable "uavSquadE";
//Units placed by ZEUS will respawn
resZeus=true; publicvariable "resZeus";
//base defense
defW=[];
defE=[];
dBW1=false;
dBW2=false;
dBE1=false;
dBE2=false;

["Server variables loaded"] remoteExec ["systemChat", 0, false];
//ZEUS 
z1 addCuratorEditableObjects [allplayers+playableUnits]; //all players and playable units will be editable by Zeus
["Initialize"] call BIS_fnc_dynamicGroups; // Initializes the Dynamic Groups framework
["Zeus loaded"] remoteExec ["systemChat", 0, false];

//Prestige Strategic AI Balance sistema - dinaminis AI boost pagal strateginius sektorius
[] spawn wrm_fnc_V2strategicAiBalance;

//Dynamic Simulation - engine optimization: užšaldo tolimus AI/transportą (mažesnė CPU apkrova)
[] call wrm_fnc_V2dynamicSimulation;

//Cleanup mechanizmas mirusiems objektams - VALIDUOTA SU ARMA 3 BEST PRACTICES
//Periodiškai valo mirusius objektus, kad sumažintų atminties naudojimą ir pagreitintų allUnits kvietimus
[] spawn wrm_fnc_V2cleanup;

//JIP State Restoration - užtikrina, kad JIP žaidėjai gautų teisingą misijos būseną
addMissionEventHandler ["PlayerConnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

	if (_jip) then {
		//Wait for player object to be created
		[_uid] spawn {
			params ["_playerUID"];
			sleep 1; //Give time for player object to initialize
			private _player = objNull;
			{
				if (getPlayerUID _x == _playerUID) exitWith {
					_player = _x;
				};
			} forEach allPlayers;

			if (!isNull _player) then {
				[_player, _playerUID] call wrm_fnc_V2jipRestoration;
			};
		};
	};
}];

//UAV Cleanup on Player Disconnect - išvalo žaidėjo dronus kai jis atsijungia
addMissionEventHandler ["PlayerDisconnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

	//Cleanup WEST dronai
	[_uid, sideW] call wrm_fnc_V2uavCleanup;

	//Cleanup EAST dronai
	[_uid, sideE] call wrm_fnc_V2uavCleanup;

	systemChat format ["[UAV CLEANUP] Player %1 (%2) disconnected - cleaned up UAVs", _name, _uid];
}];

if ("autoStart" call BIS_fnc_getParamValue != 0)then{[("autoStart" call BIS_fnc_getParamValue)] execVM "warmachine\autoStart.sqf"};
