//fn_V2clearArea.sqf
//[_obj,_p,_r] call wrm_fnc_V2clearArea;

_obj=_this select 0;
_p=_this select 1;
_r=_this select 2;

_obj allowDammage false;
_sor = nearestTerrainObjects [_p, 
[
	"TREE","SMALL TREE","BUSH","BUILDING","HOUSE","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","CHURCH","CHAPEL","CROSS","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL","FENCE","WALL","HIDE","BUSSTOP","FOREST","TRANSMITTER","STACK","RUIN","TOURISM","WATERTOWER","ROCK","ROCKS","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK" //"MAIN ROAD","ROAD","RAILWAY","TRACK","TRAIL""POWER LINES",
], _r, false, true];
{
if((_p distance2D _x)<((((boundingBox _obj) select 2)+(((boundingBox _x) select 2)/2))))
then {_x hideObjectGlobal true;};
} forEach _sor;
_obj setVehiclePosition [_p, [], 0, "NONE"];
_obj allowDammage true;