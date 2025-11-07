//Author: IvosH
waitUntil {!isNull player}; //JIP

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