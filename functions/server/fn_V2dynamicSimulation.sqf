/*
	Author: AI Assistant

	Description:
		Įjungia ir prižiūri Dynamic Simulation sistemą serverio pusėje.
		Sistema naudoja engine optimizacijas, kad nutolę AI ir transportas
		sustabdomi (freeze), kol žaidėjai priartėja.

	Parameter(s):
		NONE

	Returns:
		nothing

	Execution:
		call wrm_fnc_V2dynamicSimulation;

	MODIFICATIONS:
		- Sukurta nauja funkcija, kuri globaliai įgalina Dynamic Simulation
		- Automatiškai taikoma visoms grupėms ir transportui (įskaitant naujus spawns)
		- Naudojami aiškūs nuotoliai (foot, vehicle, prop) pagal hibridinį planą
*/

if(DBG)then{diag_log "[DYNAMIC_SIMULATION] Initializing Dynamic Simulation system"};
if (!isServer) exitWith {
	diag_log "[WRM][DYNSIM] Dynamic Simulation init iškviestas ne serveryje – nutraukiama.";
};

//Enable Dynamic Simulation system
enableDynamicSimulationSystem true;
if(DBG)then{diag_log "[DS] Dynamic Simulation enabled";};

//Distances by type
setDynamicSimulationDistance "Group", 1200;
setDynamicSimulationDistance "Vehicle", 1800;
setDynamicSimulationDistance "EmptyVehicle", 1500;
setDynamicSimulationDistance "Prop", 600;

//Optional coefficients
setDynamicSimulationDistanceCoef "Group", 1.0;
setDynamicSimulationDistanceCoef "Vehicle", 1.0;
setDynamicSimulationDistanceCoef "EmptyVehicle", 1.0;
setDynamicSimulationDistanceCoef "Prop", 1.0;

//Pagalbinė funkcija – pritaikyti dinaminę simuliaciją grupei
private _fnc_markGroup = {
	params ["_grp"];
	if (isNull _grp) exitWith {};
	if (_grp getVariable ["wrm_dynSimEnabled", false]) exitWith {};

	// IŠIMTYS: nepritaikyti DS grupėms su žaidėjais
	private _groupUnits = units _grp;
	if (_groupUnits findIf {isPlayer _x} > -1) exitWith {
		if(DBG)then{diag_log format ["[DS_GROUP_SKIP] Skipped group with player: %1", _grp]};
	};

	_grp enableDynamicSimulation true;
	_grp setVariable ["wrm_dynSimEnabled", true, false];
};

//Pagalbinė funkcija – pritaikyti dinaminę simuliaciją transportui/objektams
private _fnc_markVehicle = {
	params ["_veh"];
	if (isNull _veh) exitWith {};
	if !(_veh isKindOf "AllVehicles") exitWith {}; //ignoruoja kitus objektus
	if (_veh isKindOf "Man") exitWith {}; //žaidėjų ir AI pėstininkų neflaginam čia
	if (_veh getVariable ["wrm_dynSimEnabled", false]) exitWith {};

	// IŠIMTYS: nepritaikyti DS transportui su žaidėjais įguloje
	if ((crew _veh) findIf {isPlayer _x} > -1) exitWith {
		if(DBG)then{diag_log format ["[DS_VEHICLE_SKIP] Skipped vehicle with player crew: %1", typeOf _veh]};
	};

	// IŠIMTYS: nepritaikyti DS transportui su gyva įgula arba kroviniu
	// Gyva įgula = bet kokie vienetai įguloje (AI arba žaidėjai jau patikrinta aukščiau)
	private _hasCrew = count (crew _veh) > 0;
	private _hasCargo = count (getVehicleCargo _veh) > 0;

	if (_hasCrew || _hasCargo) exitWith {
		if(DBG)then{diag_log format ["[DS_VEHICLE_SKIP] Skipped vehicle with crew/cargo: %1 (crew: %2, cargo: %3)", typeOf _veh, _hasCrew, _hasCargo]};
	};

	_veh enableDynamicSimulation true;
	_veh setVariable ["wrm_dynSimEnabled", true, false];
};

//Padaryti pagalbines funkcijas prieinamas event handler'iui
missionNamespace setVariable ["wrm_fnc_dynSim_markGroup", _fnc_markGroup];
missionNamespace setVariable ["wrm_fnc_dynSim_markVehicle", _fnc_markVehicle];

//Initial pass – visos esamos grupės ir transportas
{
	[_x] call _fnc_markGroup;
} forEach allGroups;

{
	[_x] call _fnc_markVehicle;
} forEach vehicles;

//Kai sukuriamos naujos grupės – iškart įjungti DS
if (isNil "wrm_dynSim_groupEH") then {
	wrm_dynSim_groupEH = addMissionEventHandler [
		"GroupCreated",
		{
			params ["_grp"];
			private _fnc = missionNamespace getVariable ["wrm_fnc_dynSim_markGroup", {}];
			[_grp] call _fnc;
		}
	];
};

//Kai sukuriami nauji entitetai – jei tai transportas, įjungti DS
if (isNil "wrm_dynSim_entityCreatedEH") then {
	wrm_dynSim_entityCreatedEH = addMissionEventHandler [
		"EntityCreated",
		{
			params ["_entity"];
			private _fncVeh = missionNamespace getVariable ["wrm_fnc_dynSim_markVehicle", {}];
			[_entity] call _fncVeh;
		}
	];
};

//Periodinis „catch-up“ – kartą per 60 sekundžių patikrina, ar kas nepraslydo
[] spawn {
	while {true} do {
		sleep 60;
		if(DBG)then{diag_log "[DYNAMIC_SIMULATION] Running periodic enforcer check"};

		private _groupsProcessed = 0;
		private _vehiclesProcessed = 0;

		{
			[_x] call (missionNamespace getVariable ["wrm_fnc_dynSim_markGroup", {}]);
			_groupsProcessed = _groupsProcessed + 1;
		} forEach allGroups;

		{
			[_x] call (missionNamespace getVariable ["wrm_fnc_dynSim_markVehicle", {}]);
			_vehiclesProcessed = _vehiclesProcessed + 1;
		} forEach vehicles;

		if(DBG)then{diag_log format ["[DYNAMIC_SIMULATION] Enforcer processed: %1 groups, %2 vehicles", _groupsProcessed, _vehiclesProcessed]};
	};
};

