//Author: IvosH
waitUntil {!isNull player}; //JIP

//FIX: Nustatyti respawn timer anksčiau, prieš pirmą respawn
//Prieš misijos inicijavimą naudojamas description.ext respawnDelay (100 sekundžių)
//Reikia nustatyti rTime pagal config parametrus anksčiau
private _resTime = "asp12" call BIS_fnc_getParamValue;
private _initialRTime = 100; //Default reikšmė iš description.ext
call
{
	if (_resTime == 0) exitWith {_initialRTime = 5;};
	if (_resTime == 1) exitWith {_initialRTime = 30;};
	if (_resTime == 2) exitWith {_initialRTime = 60;};
	if (_resTime == 3) exitWith {_initialRTime = 120;};
	if (_resTime == 4) exitWith {_initialRTime = 180;};
	if (_resTime == 5) exitWith {_initialRTime = 200;};
};
//Nustatyti respawn timer anksčiau, kad žaidėjas negautų 100 sekundžių respawn laiko
if (isNil "rTime") then {
	rTime = _initialRTime;
};
setPlayerRespawnTime _initialRTime;

//variables setup
lUpdate = 0;
suppUsed=0;
carUsed=0;
truckUsed=0;
boatArUsed=0;
boatTrUsed=0;
fort1 = 0;
fort2 = 0;
fort3 = 0;
stuck=[];
fs=0;

systemChat "Client variables loaded";

//VERSION 2
aoMarkers = []; resMarkers = []; aoObjs = [];
dbgVehs = []; //debug vehicles V2aoCreate.sqf, V2aoChange.sqf, V2aoRespawn.sqf

//add all unit traits to every player
_trait = ["medic", "engineer", "explosiveSpecialist", "UAVHacker"];
{player setUnitTrait [_x, true];} forEach _trait;
//load wepons by role, disable save load buttons when Virtual Arsenal opens
if ("param2" call BIS_fnc_getParamValue == 1) then
{
	[missionNamespace, "arsenalOpened", 
		{
			disableSerialization;
			params ["_display"];
			_display displayAddEventHandler ["keydown", "_this select 3"];
			{(_display displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
		}
	] call BIS_fnc_addScriptedEventHandler;
};
//save gear when Virtual Arsenal closes
if ("param2" call BIS_fnc_getParamValue > 0) then
{
	[missionNamespace, "arsenalClosed", 
		{	
			[player, [player, "Custom Loadout"]] call BIS_fnc_saveInventory;
			[player,["player:Custom Loadout"]] call bis_fnc_setrespawninventory;
			hint parseText format ["CUSTOM LOADOUT SAVED<br/><br/>Available in the respawn menu<br/>Default > Custom Loadout"];
		}
	] call BIS_fnc_addScriptedEventHandler;
};

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; // Initializes the player/client side Dynamic Groups framework

null = [] execVM "admin\radio.sqf"; //admin menu
systemChat "Admin menu loaded";

//Sinhronizuoti support provider'ius JIP žaidėjams
//Ši funkcija užtikrina, kad JIP žaidėjai gautų teisingus CAS lėktuvus ir artilerijos prieigą
//Laukti, kol misija bus pradėta (progress > 1)
[] spawn {
	waitUntil {progress > 1};
	sleep 2; //Laukti, kol bus inicializuoti support provider'iai
	[] call wrm_fnc_V2syncSupportProvidersClient;
};