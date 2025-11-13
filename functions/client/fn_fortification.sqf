/*
Author: IvosH

Description:
	Add actions to build fortification

Parameter(s):
	none

Returns:
	nothing

Dependencies:
	fn_leaderActions.sqf

Execution:
	[] call wrm_fnc_fortification
*/

// Inicializuoti fortifikacijų masyvus jei dar neegzistuoja
if (isNil "fortifications_player") then {
	fortifications_player = [];
};

// Išvalyti null objektus (sugadintas fortifikacijas)
fortifications_player = fortifications_player select {!isNull (_x select 0)};

// Maksimalus kiekis kiekvieno tipo - po 3
#define FORT_LIMIT_PER_TYPE 3

// Funkcija patikrinti ir išvalyti limitus
fnc_checkFortLimits = {
	params ["_type"];
	private _fortsOfType = fortifications_player select {(_x select 2) == _type};

	// Jei viršijamas limitas, ištrinti seniausią
	if (count _fortsOfType >= FORT_LIMIT_PER_TYPE) then {
		// Surūšiuoti pagal laiką (seniausi pirmi)
		_fortsOfType sort true; // sort pagal timestamp (antro elementas)
		private _oldestFort = _fortsOfType select 0;
		private _oldestObj = _oldestFort select 0;

		// Ištrinti objektą saugiai
		if (!isNull _oldestObj) then {
			deleteVehicle _oldestObj;
		};

		// Pašalinti iš masyvo naudojant teisingą metodą
		private _indexToRemove = fortifications_player find _oldestFort;
		if (_indexToRemove != -1) then {
			fortifications_player deleteAt _indexToRemove;
		};

		systemChat format ["Seniausia %1 fortifikacija buvo ištrinta (viršytas limitas %2)", _type, FORT_LIMIT_PER_TYPE];
	};
};

if(progress<2)exitWith{};

f1=[
	player, //target
	"+ Trench T", //title
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //idleIcon
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //progressIcon
	"player==leader player && vehicle player==player && fort1==0 && fort==1", //conditionShow
	"true", //conditionProgress
	{
		hint"Barricade will be build in front of you";
		bar = createVehicle ["rnt_graben_t", (player getRelPos [1.8, 0]), [], 0, "CAN_COLLIDE"];
		bar attachTo [player,[0,3,1.3]];
	}, //codeStart
	{}, //codeProgress
	{
		detach bar;		
		_p=getPosAtl bar;
		
		call
		{
			if(!isTouchingGround bar)exitWith
			{
				_i=0;
				while{!isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i-0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.05)];
			};
			if(isTouchingGround bar)exitWith
			{
				_i=0;
				while{isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i+0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.1)];
			};
		};
		
		ground=((getPosAtl bar select 2)-(getPos bar select 2))<0.15;
		steep=(surfaceNormal getPos bar select 2)<0.95;
		if((!ground)||(ground&&steep))then{bar setVectorUp [0,0,1];};

		// Patikrinti limitus ir ištrinti seniausią jei reikia
		["Trench T"] call fnc_checkFortLimits;

		// Įrašyti naują fortifikaciją į masyvą su timestamp
		fortifications_player pushBack [bar, time, "Trench T"];

		[1] spawn wrm_fnc_V2coolDown;
		fort1 = 1;
		hintSilent"";
		systemChat "fortification built";
	}, //codeCompleted
	{
		deleteVehicle bar;
		hintSilent"";
	}, //codeInterrupted
	[], //arguments
	5, //duration
	0.3, //priority
	false, //removeCompleted
	false //showUnconscious
] call BIS_fnc_holdActionAdd;

f2=[
	player, //target
	"+ Trench Bunker", //title
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //idleIcon
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //progressIcon
	"player==leader player && vehicle player==player && fort2==0 && fort==1", //conditionShow
	"true", //conditionProgress
	{
		hint"Barricade will be build in front of you";
		bar = createVehicle ["rnt_graben_bunker", (player getRelPos [1.8, 0]), [], 0, "CAN_COLLIDE"];
		bar attachTo [player,[0,3,0.7]];
	}, //codeStart
	{}, //codeProgress
	{
		detach bar;		
		_p=getPosAtl bar;
		
		call
		{
			if(!isTouchingGround bar)exitWith
			{
				_i=0;
				while{!isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i-0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.05)];
			};
			if(isTouchingGround bar)exitWith
			{
				_i=0;
				while{isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i+0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.1)];
			};
		};
		
		ground=((getPosAtl bar select 2)-(getPos bar select 2))<0.15;
		if(!ground)then{bar setVectorUp [0,0,1];};

		// Patikrinti limitus ir ištrinti seniausią jei reikia
		["Trench Bunker"] call fnc_checkFortLimits;

		// Įrašyti naują fortifikaciją į masyvą su timestamp
		fortifications_player pushBack [bar, time, "Trench Bunker"];

		[2] spawn wrm_fnc_V2coolDown;
		fort2 = 1;
		hintSilent"";
		systemChat "fortification built";
	}, //codeCompleted
	{
		deleteVehicle bar;
		hintSilent"";
	}, //codeInterrupted
	[], //arguments
	5, //duration
	0.2, //priority
	false, //removeCompleted
	false //showUnconscious
] call BIS_fnc_holdActionAdd;

f3=[
	player, //target
	"+ Trench Firing Position", //title
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //idleIcon
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //progressIcon
	"player==leader player && vehicle player==player && fort3==0 && fort==1", //conditionShow
	"true", //conditionProgress
	{
		hint"Barricade will be build in front of you";
		bar = createVehicle ["rnt_graben_stellung", (player getRelPos [1.8, 0]), [], 0, "CAN_COLLIDE"];
		bar attachTo [player,[0,3,0.7]];		
	}, //codeStart
	{}, //codeProgress
	{
		detach bar;		
		_p=getPosAtl bar;
		
		call
		{
			if(!isTouchingGround bar)exitWith
			{
				_i=0;
				while{!isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i-0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.05)];
			};
			if(isTouchingGround bar)exitWith
			{
				_i=0;
				while{isTouchingGround bar}do
				{	
					bar setPos [(_p select 0),(_p select 1),((_p select 2)+_i)];
					_i=_i+0.05;
				};
				_z=getPosAtl bar;
				bar setPos [(_p select 0),(_p select 1),((_z select 2)-0.1)];
			};
		};
		
		ground=((getPosAtl bar select 2)-(getPos bar select 2))<0.15;
		if(!ground)then{bar setVectorUp [0,0,1];};

		// Patikrinti limitus ir ištrinti seniausią jei reikia
		["Trench Firing Position"] call fnc_checkFortLimits;

		// Įrašyti naują fortifikaciją į masyvą su timestamp
		fortifications_player pushBack [bar, time, "Trench Firing Position"];

		[3] spawn wrm_fnc_V2coolDown;
		fort3 = 1;
		hintSilent"";
		systemChat "fortification built";
	}, //codeCompleted
	{
		deleteVehicle bar;
		hintSilent"";
	}, //codeInterrupted
	[], //arguments
	5, //duration
	0.1, //priority
	false, //removeCompleted
	false //showUnconscious
] call BIS_fnc_holdActionAdd;

// Pridėti action ištrinti artimiausią fortifikaciją
if (player == leader player) then {
	player addAction [
		"- Demolish nearest fortification", // title
		{
			// Rasti artimiausią savo fortifikaciją
			private _nearestIndex = -1;
			private _minDistance = 999999;

			{
				private _index = _forEachIndex;
				_x params ["_obj", "_timestamp", "_type"];
				if (!isNull _obj && alive _obj) then {
					private _distance = player distance _obj;
					if (_distance < _minDistance && _distance < 10) then { // Maksimalus atstumas 10m
						_minDistance = _distance;
						_nearestIndex = _index;
					};
				};
			} forEach fortifications_player;

			if (_nearestIndex != -1) then {
				private _nearestFort = fortifications_player select _nearestIndex;
				_nearestFort params ["_obj", "_timestamp", "_type"];

				// Ištrinti objektą saugiai
				if (!isNull _obj) then {
					deleteVehicle _obj;
				};

				// Pašalinti iš masyvo naudojant deleteAt
				fortifications_player deleteAt _nearestIndex;

				systemChat format ["%1 fortifikacija ištrinta", _type];
			} else {
				systemChat "Nėra fortifikacijų šalia (10m spindulys)";
			};
		}, // script
		nil, // arguments
		0.2, // priority
		false, // showWindow
		false, // hideOnUse
		"", // shortcut
		"player == leader player && count fortifications_player > 0", // condition
		5, // radius
		false, // unconscious
		"" // selection
	];
};

