/*
	Author: IvosH
	
	Description:
		Deploy parachute
		
	Parameter(s):
		0: VARIABLE spawned vehicle
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		fn_V2aiVehicle
		fn_V2uavRequest.sqf
		fn_aitDrop.sqf

	Execution:
		[_object] call wrm_fnc_parachute;
		[objNull, vehAA] call BIS_fnc_curatorObjectEdited;
*/

params ["_object"];

_type="";
_attachPos=[];
(_object call BIS_fnc_objectType) params ["_objectCategory", "_objectType"];
call
{
    if (_objectCategory == "Object" && {_objectType == "AmmoBox"}) exitWith {
       _type="B_Parachute_02_F";
	   _attachPos=[0, 0, 1];
    };

    if (_objectCategory in ["Vehicle", "VehicleAutonomous"] && {_objectType in ["Car", "Motorcycle", "Ship", "Submarine", "TrackedAPC", "Tank", "WheeledAPC","StaticWeapon"]}) exitWith {
        _type="B_Parachute_02_F";
		_attachPos=[0, 0, abs (boundingBox _object select 0 select 2)]
    };
};

if (_objectCategory in ["Vehicle", "VehicleAutonomous"] && {_objectType in ["StaticWeapon"]}) exitWith 
{
	_object setVehiclePosition [[(getPos _object select 0),(getPos _object select 1),0], [], 0, "NONE"];
};
_parachute = createVehicle [_type, _object, [], 0, "NONE"];
_parachute setDir getDir _object;
_parachute setVelocity [0, 0, -1];
_object attachTo [_parachute, _attachPos];