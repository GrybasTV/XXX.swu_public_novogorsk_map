//Author: IvosH

// Very basic debug message to check if file is loaded at all
systemChat "[DEBUG] initPlayerLocal.sqf FILE LOADED - BEFORE waitUntil";
diag_log "[DEBUG] initPlayerLocal.sqf FILE LOADED - BEFORE waitUntil";

// Emergency backup: Try to add items immediately without waiting for player
if (!isNil "player" && {alive player}) then {
    systemChat "[DEBUG] EMERGENCY: Player exists, adding items immediately";
    if !("ItemMap" in assignedItems player) then {
        player addItem "ItemMap";
        player assignItem "ItemMap";
        systemChat "[DEBUG] EMERGENCY: Added ItemMap";
    };
    if !("ItemGPS" in assignedItems player) then {
        player addItem "ItemGPS";
        player assignItem "ItemGPS";
        systemChat "[DEBUG] EMERGENCY: Added ItemGPS";
    };
} else {
    systemChat "[DEBUG] EMERGENCY: Player not ready yet";
};

waitUntil {!isNull player}; //JIP

systemChat "[DEBUG] initPlayerLocal.sqf STARTED - Player initialized";
systemChat format ["[DEBUG] Player: %1, Side: %2, Time: %3", name player, side player, time];

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

// Give players map and GPS items (essential for navigation in this mission)
systemChat format ["[DEBUG] Checking items - Map assigned: %1, GPS assigned: %2", "ItemMap" in assignedItems player, "ItemGPS" in assignedItems player];

if !("ItemMap" in assignedItems player) then {
    systemChat "[DEBUG] Adding ItemMap";
    player addItem "ItemMap";
    player assignItem "ItemMap";
};

if !("ItemGPS" in assignedItems player) then {
    systemChat "[DEBUG] Adding ItemGPS";
    player addItem "ItemGPS";
    player assignItem "ItemGPS";
};

systemChat format ["[DEBUG] After adding - Map assigned: %1, GPS assigned: %2", "ItemMap" in assignedItems player, "ItemGPS" in assignedItems player];

// Handle map and GPS giving on respawn
player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];

    systemChat format ["[DEBUG] Respawn triggered for %1", name _unit];

    private _needsItems = false;

    systemChat format ["[DEBUG] Respawn - Before: Map assigned: %1, GPS assigned: %2", "ItemMap" in assignedItems _unit, "ItemGPS" in assignedItems _unit];

    if !("ItemMap" in assignedItems _unit) then {
        systemChat "[DEBUG] Respawn - Adding ItemMap";
        _unit addItem "ItemMap";
        _unit assignItem "ItemMap";
        _needsItems = true;
    };

    if !("ItemGPS" in assignedItems _unit) then {
        systemChat "[DEBUG] Respawn - Adding ItemGPS";
        _unit addItem "ItemGPS";
        _unit assignItem "ItemGPS";
        _needsItems = true;
    };

    systemChat format ["[DEBUG] Respawn - After: Map assigned: %1, GPS assigned: %2", "ItemMap" in assignedItems _unit, "ItemGPS" in assignedItems _unit];

    if (_needsItems) then {
        systemChat "Map and GPS restored after respawn";
    };
}];

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