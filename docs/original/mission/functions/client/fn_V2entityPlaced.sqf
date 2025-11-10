/*
Author: IvosH

Description:
	Unit Placed by Zeus will respawn. Event handler. Runs when entity is placed.

Parameter(s):
	0: OBJECT, _entity (Placed unit)

Returns:
	nothing

Dependencies:
	init.sqf
	fn_V2entityKilled.sqf

Execution:
z1 addEventHandler ["CuratorObjectPlaced", {
	params ["_curator", "_entity"];
	[_entity] call wrm_fnc_V2entityPlaced;	
}];

[_entity] execVM "entityPlacedEH.sqf"; //test
*/

params ["_entity"];

if(!local _entity)exitWith{["LOC Placed"] remoteExec ["systemChat", 0, false];};
if (!resZeus) exitWith {if(DBG)then{systemchat "Zeus respawn disabled";};};
if(!((side _entity==sideW)||(side _entity==sideE))) exitWith {if(DBG)then{systemchat "No respawn for this side";};};
if (!(_entity isKindOf "AllVehicles")) exitWith {if(DBG)then{systemchat "Not Vehicle - No respawn";};};
if (_entity isKindOf "StaticWeapon") exitWith {if(DBG)then{systemchat "Static Weapon - No respawn";};};
if ((count crew _entity)==0) exitWith {if(DBG)then{systemchat "Empty Vehicle - No respawn";};};

_entity addMPEventHandler ["MPKilled", {
	params ["_corpse", "_killer", "_instigator", "_useEffects"];
	[_corpse] spawn wrm_fnc_V2entityKilled;
}];

call
{
	if(side _entity==WEST)exitWith{{_x addMPEventHandler ["MPKilled",{[(_this select 0),WEST] spawn wrm_fnc_killedEH;}];} forEach crew _entity;};
	if(side _entity==EAST)exitWith{{_x addMPEventHandler ["MPKilled",{[(_this select 0),EAST] spawn wrm_fnc_killedEH;}];} forEach crew _entity;};
	if(side _entity==INDEPENDENT)exitWith{{_x addMPEventHandler ["MPKilled",{[(_this select 0),INDEPENDENT] spawn wrm_fnc_killedEH;}];} forEach crew _entity;};
};

if (_entity isKindOf "Man") then
{
	group _entity deleteGroupWhenEmpty false;
};

if(DBG)then{systemchat "Placed unit will respawn";};




