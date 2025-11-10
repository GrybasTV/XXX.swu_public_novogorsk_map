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

//Įjungti dinaminės simuliacijos sistemą
enableDynamicSimulationSystem true;

//Atstumai (metrais) pagal objektų kategorijas
setDynamicSimulationDistance "Group", 1200;        //pėstininkams (AI grupėms)
setDynamicSimulationDistance "Vehicle", 1800;      //transportui su įgula
setDynamicSimulationDistance "EmptyVehicle", 1500; //palikti arti kovos
setDynamicSimulationDistance "Prop", 600;          //statiniams objektams

//Koeficientai – kiek greitai suaktyvinami nuo žaidėjų judėjimo
setDynamicSimulationDistanceCoef "Group", 1.0;
setDynamicSimulationDistanceCoef "Vehicle", 1.0;
setDynamicSimulationDistanceCoef "EmptyVehicle", 1.0;
setDynamicSimulationDistanceCoef "Prop", 1.0;

//Pagalbinė funkcija – pritaikyti dinaminę simuliaciją grupei
private _fnc_markGroup = {
	params ["_grp"];
	if (isNull _grp) exitWith {};
	if (_grp getVariable ["wrm_dynSimEnabled", false]) exitWith {};

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

//Periodinis „catch-up“ – kartą per 2 minutes patikrina, ar kas nepraslydo
[] spawn {
	while {true} do {
		sleep 120;
		if(DBG)then{diag_log "[DYNAMIC_SIMULATION] Running periodic enforcer check"};

		{
			[_x] call (missionNamespace getVariable ["wrm_fnc_dynSim_markGroup", {}]);
		} forEach allGroups;

		{
			[_x] call (missionNamespace getVariable ["wrm_fnc_dynSim_markVehicle", {}]);
		} forEach vehicles;
	};
};

