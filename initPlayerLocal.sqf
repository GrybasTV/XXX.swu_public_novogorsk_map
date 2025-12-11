//Author: IvosH
waitUntil {!isNull player}; //JIP

// JIP (Join In Progress) patikrinimas
// didJIP yra built-in kintamasis, naudojame kitą kintamojo pavadinimą, kad išvengtume konflikto
playerDidJIP = false;
if (!isNil "didJIP") then {
	playerDidJIP = didJIP;
};

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

// Enable self-marker on map
null = [] execVM "warmachine\V2playerMarker.sqf";

// Admin Zeus rights check - periodic check for admins
[] spawn {
    while {true} do {
        if (serverCommandAvailable "#kick" && !isNull player && !isNil "z1" && {!isNull z1}) then {
            // Admin has access to Zeus - ensure they have curator editable objects
            [z1, [[player], true]] remoteExec ["addCuratorEditableObjects", 2, false];
        };
        sleep 10; // Check every 10 seconds
    };
};

// JIP (Join In Progress) sinchronizavimas
// Jei žaidėjas prisijungė prie vykstančios misijos, sinchronizuojame misijos būseną
// JIP (Join In Progress) sinchronizavimas
// Jei žaidėjas prisijungė prie vykstančios misijos, sinchronizuojame misijos būseną
if(playerDidJIP) then {
	// Laukime kol misija bus sukurta (jei dar nėra sukurta)
	// Timeout 10 minučių, nes misijos kūrimas gali užtrukti ilgai
	_timeout = time + 600; // 10 minučių timeout
	
	// Sukuriame atskirą giją laukimui, kad neužblokuotume kitų skriptų
	[_timeout] spawn {
		params ["_timeout"];
		
		waitUntil {
			sleep 1;
			progress > 1 || time >= _timeout
		};
		
		if(time >= _timeout && progress <= 1) then {
			["WARNING: JIP synchronization timeout. Mission may be stuck or initializing."] remoteExec ["systemChat", player, false];
			hint parseText "WARNING<br/>Mission synchronization timed out.<br/>Please wait or reconnect.";
			
			// Vis tiek bandome laukti toliau fone
			waitUntil {sleep 5; progress > 1};
			[player] remoteExec ["wrm_fnc_JIPSync", 2, false];
			systemChat "Mission initialized. Requesting synchronization...";
		} else {
			// Jei misija jau pradėta, sinchronizuojame misijos būseną
			if(progress > 1) then {
				// Sinchronizuojame misijos parametrus su serveriu
				[player] remoteExec ["wrm_fnc_JIPSync", 2, false];
				systemChat "JIP synchronization requested";
			};
		};
	};
};