/*
Author: IvosH
Description [dependencies]
Custom command activated by trigger - radio, teleports player [Description.ext, initServer.sqf]

IN EDITOR:
Place trigger - repeatable
Text: Teleport
Activation: Radio Carlie
On activation: null = [] execVM "admin\teleport.sqf";
*/

//close dialog window
closeDialog 0;
//open map
openMap [true, false];
//set variable when script starts (teleportMarker does not exist)
hint "Select a position by left mouse button click (LMB)";
markerCreated = 0;
//eventhandler for creating marker = When player clicks on the map (LMB), teleportMarker is created
["telCreate", "onMapSingleClick", 
	{
		//create marker
		telMarker = createMarkerLocal ["teleportMarker", _pos];
		telMarker setMarkerShapeLocal "ICON";
		telMarker setMarkerTypeLocal "select";
		telMarker setMarkerTextLocal "Teleport";
		//change variable (teleportMarker exists)
		markerCreated = 1;
	}
] call BIS_fnc_addStackedEventHandler;
//wait until teleportMarker is created
waitUntil {markerCreated == 1;};
//remove eventhandler for creating marker
["telCreate", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
//eventhandler for moving the marker = When player clicks on the map (LMB), position of the teleportMarker is changed
["telMove", "onMapSingleClick", 
	{
		//change position of the marker
		telMarker setMarkerPosLocal _pos;
	}
] call BIS_fnc_addStackedEventHandler;
//wait until player close the map
waitUntil {!visibleMap};
//remove eventhandler for moving the marker
["telMove", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
//teleports player to the marker location
vehicle player setPos getMarkerPos telMarker; 
//delete teleportMarker
deleteMarkerLocal telMarker; //"teleportMarker"
//change variable (teleportMarker does not exist)
markerCreated = 0;