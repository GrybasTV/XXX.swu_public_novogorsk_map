/*
Author: IvosH

Description:
	Unit Placed by Zeus will respawn. Event handler. Runs when entity (soldier or vehicle) is killed.
	New unit respawns, join the same group, select position to spawn, add EH again.
Parameter(s):
	0: OBJECT, _corpse (killed unit)

Returns:
	nothing

Dependencies:
	fn_V2entityPlaced.sqf
	init.sqf
	
Execution:
_entity addMPEventHandler ["MPKilled", {
	params ["_corpse", "_killer", "_instigator", "_useEffects"];
	[_corpse] spawn wrm_fnc_V2entityKilled;
}];

[_corpse] execVM "entityKilledEH.sqf"; //test
*/

params ["_corpse"];

if(!local _corpse)exitWith{};
if (!resZeus) exitWith {if(DBG)then{systemchat "Zeus respawn disabled";};};

_type = typeOf _corpse;
_post = _corpse getRelPos [20,random 360];
_grp = group _corpse;
_unit = objNull;

if (_corpse isKindOf "Man") then 
{
	sleep 100; //100 (respawn delay)

	_unit = _grp createUnit [_type, _post, [], 10, "NONE"];
	[_unit,_corpse] spawn wrm_fnc_V2respawnEH;
	
	_unit addMPEventHandler ["MPKilled", {
		params ["_corpse", "_killer", "_instigator", "_useEffects"];
		[_corpse] spawn wrm_fnc_V2entityKilled;
		//[_corpse] execVM "entityKilledEH.sqf";
	}];

	if(DBG)then{systemchat "Zeus soldier respawned";};
}else
{
	if(progress>1)then{sleep arTime;}else{sleep 100;}; //arTime (respawn delay)
	
	_unit=[_post, 0, _type, _grp] call BIS_fnc_spawnVehicle;
	_unit=(_unit select 0);

	if(progress>1)then
	{
		_post=[];
		if(side _unit==sideW)then
		{
			if(_unit isKindOf "AIR")then{_post=[plHW];}else
			{
				if(getMarkerColor resFobW!="")then{_post pushBackUnique posW1;};
				if(getMarkerColor resBaseW!="")then{_post pushBackUnique posW2;};
				if(getMarkerColor resFobEW!="")then{_post pushBackUnique posE1;};
				if(getMarkerColor resBaseEW!="")then{_post pushBackUnique posE2;};
			};
			if(count _post==0)then{_post=[plHW];};
		}else //sideE
		{
			if(_unit isKindOf "AIR")then{_post=[plHE];}else
			{
				if(getMarkerColor resFobE!="")then{_post pushBackUnique posE1;};
				if(getMarkerColor resBaseE!="")then{_post pushBackUnique posE2;};
				if(getMarkerColor resFobWE!="")then{_post pushBackUnique posW1;};
				if(getMarkerColor resBaseWE!="")then{_post pushBackUnique posW2;};
			};
			if(count _post==0)then{_post=[plHE];};
		};
		_post=(selectRandom _post);
		_unit setVehiclePosition [_post, [], 20, "FLY"];
		if(_unit isKindOf "Plane")then{_unit setVelocityModelSpace [0, 100, 0];};
	};

	_unit addMPEventHandler ["MPKilled", {
		params ["_corpse", "_killer", "_instigator", "_useEffects"];
		[_corpse] spawn wrm_fnc_V2entityKilled;
	}];
	
	if(DBG)then{systemchat "Zeus vehicle respawned";};
};

call
{
	if(side _unit==WEST)exitWith{{_x addMPEventHandler ["MPKilled",{[(_this select 0),WEST] spawn wrm_fnc_killedEH;}];} forEach crew _unit;};
	if(side _unit==EAST)exitWith{{_x addMPEventHandler ["MPKilled",{[(_this select 0),EAST] spawn wrm_fnc_killedEH;}];} forEach crew _unit;};
	if(side _unit==INDEPENDENT)exitWith{{_x addMPEventHandler ["MPKilled",{[(_this select 0),INDEPENDENT] spawn wrm_fnc_killedEH;}];} forEach crew _unit;};
};

[z1,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 2, false]; //add unit to zeus