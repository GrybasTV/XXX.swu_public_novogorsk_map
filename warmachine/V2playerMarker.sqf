/*
	Author: GrybasTV
	Description: Shows local player position on map with a smooth directional marker (Draw Event).
*/

if (!hasInterface) exitWith {};

[] spawn {
	waitUntil { !isNull player };
	waitUntil { !isNull (findDisplay 12) }; // Wait for map display to initialize

	// Remove old EventHandler if exists (to prevent duplicates on re-exec)
	if (!isNil "V2_PlayerMarker_EH") then {
		(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw", V2_PlayerMarker_EH];
	};

	V2_PlayerMarker_EH = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", {
		params ["_ctrl"];
		
		if (alive player) then {
			_ctrl drawIcon [
				"\A3\ui_f\data\map\markers\military\triangle_CA.paa", // Icon: Triangle
				[1, 0.8, 0, 1], // Color: Gold/Yellow
				getPosASLVisual player, // Position (Visual for smoothness)
				20, // Width
				20, // Height
				getDirVisual player, // Direction
				"", // Text (Empty for clean look)
				1, // Shadow
				0.04, // Text size
				"RobotoCondensed", // Font
				"right" // Align
			];
		};
	}];
};
