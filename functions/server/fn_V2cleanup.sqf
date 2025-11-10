/*
	Author: AI Assistant

	Description:
		Cleanup mechanizmas mirusiems objektams - VALIDUOTA SU ARMA 3 BEST PRACTICES
		Periodiškai valo mirusius vienetus ir transporto priemones, kad sumažintų atminties naudojimą
		ir pagreitintų allUnits / entities kvietimus

	Parameter(s):
		NONE

	Returns:
		nothing

	Execution:
		[] spawn wrm_fnc_V2cleanup;

	MODIFICATIONS:
		- Sukurta nauja cleanup funkcija pagal Arma 3 best practices
		- Naudoja deleteVehicle vietoj hideObjectGlobal (VALIDUOTA)
		- Valo tik mirusius objektus, ne gyvus
*/

//Cleanup sistema su engine manageriais, eilėmis ir TTL - VALIDUOTA SU ARMA 3 BEST PRACTICES
[] spawn {
	if (!isServer) exitWith {
		//Saugiklis: valymą turi paleisti tik serveris
		diag_log "[WRM][CLEANUP] V2cleanup paleistas ne serveryje - išjungiamas.";
	};

	//Apsauga nuo dvigubo inicializavimo (pvz., dėl mission restart)
	if !(isNil "wrm_gc_initialized") exitWith {
		diag_log "[WRM][CLEANUP] V2cleanup jau inicializuotas - antro egzemplioriaus nestartuojame.";
	};
	wrm_gc_initialized = true;

	//Eilių sandėlis: [[obj, registracijosLaikas], ...]
	wrm_gc_corpses = [];
	wrm_gc_wrecks = [];
	wrm_gc_holderTimestamps = createHashMap; //ground šiukšlių registrui

	//TTL ir kvotos – derinti pagal performance ir žemėlapio dydį
	private _ttlCorpse = 15 * 60;   //15 min lavonams
	private _ttlWreck = 30 * 60;    //30 min nuolaužoms
	private _ttlGround = 10 * 60;   //10 min ginklų laikikliams ir crater'iams
	private _maxCorpses = 20;       //Maksimalus „vitrininių“ lavonų kiekis
	private _maxWrecks = 12;        //Maksimalus „vitrininių“ nuolaužų kiekis
	private _keepRadius = 700;      //Metrai – nieko neliesti, jei arti aktyvių žaidėjų
	private _groundCleanupInterval = 180; //Kas 3 min praeiname per WeaponHolder/Crater
	private _lastGroundCleanup = diag_tickTime;

	//Pagalbinė – nustato ar objektas dar egzistuoja ir yra tinkamas
	private _fnc_isValidDead = {
		params ["_obj"];
		if (isNull _obj) exitWith {false};
		if (alive _obj) exitWith {false};
		true
	};

	//Pagalbinė – ar objektas arti žaidėjų (paliekame atmosferai)
	private _fnc_isNearPlayers = {
		params ["_obj", "_radius"];
		if (isNull _obj) exitWith {false};
		(allPlayers findIf {alive _x && _x distance _obj < _radius}) > -1
	};

	//Registravimo funkcija – kviečiama iš EntityKilled ir kitų šaltinių
	missionNamespace setVariable [
		"wrm_fnc_gcRegister",
		{
			params ["_obj"];
			if (isNull _obj) exitWith {};
			if (!isServer) exitWith {
				//Jei kas nors iškviečia iš kliento – permesti į serverį
				[_obj] remoteExec ["wrm_fnc_gcRegister", 2];
			};

			private _now = diag_tickTime;
			private _targetArray = if (_obj isKindOf "Man") then {
				wrm_gc_corpses
			} else {
				wrm_gc_wrecks
			};

			//Pašalinti seną įrašą (jei objektas jau buvo eilėje)
			private _idx = _targetArray findIf {(_x select 0) isEqualTo _obj};
			if (_idx > -1) then {
				_targetArray set [_idx, [_obj, _now]];
			} else {
				_targetArray pushBack [_obj, _now];
			};
		}
	];

	//Globalus event handler – registruojame visas mirtis į eiles
	if (isNil "wrm_gc_entityKilledEH") then {
		wrm_gc_entityKilledEH = addMissionEventHandler [
			"EntityKilled",
			{
				params ["_dead"];
				private _fncReg = missionNamespace getVariable ["wrm_fnc_gcRegister", {}];
				[_dead] call _fncReg;
			}
		];
	};

	//Pagalbinė ground objektų registracija (weapon holder'iams ir crater'iams)
	private _fnc_registerGround = {
		params ["_obj", "_now"];
		if (isNull _obj) exitWith {};
		if !(_obj getVariable ["wrm_gc_registered", false]) then {
			_obj setVariable ["wrm_gc_registered", _now, false];
			wrm_gc_holderTimestamps set [_obj, _now];
		};
	};

	//Pagrindinis valymo ciklas
	while {true} do {
		sleep 90; //balansas tarp reakcijos ir našumo
		private _now = diag_tickTime;

		//1) Lavonų valymas su TTL + FIFO kvota
		for [{private _i = count wrm_gc_corpses - 1}, {_i >= 0}, {_i = _i - 1}] do {
			private _entry = wrm_gc_corpses select _i;
			_entry params ["_obj", "_stamp"];
			if (!([_obj] call _fnc_isValidDead)) then {
				wrm_gc_corpses deleteAt _i;
				continue;
			};

			private _age = _now - _stamp;
			private _nearPlayers = [_obj, _keepRadius] call _fnc_isNearPlayers;
			if ((_age > _ttlCorpse && !_nearPlayers)) then {
				deleteVehicle _obj;
				wrm_gc_corpses deleteAt _i;
			};
		};

		//Jei viršyta kvota – šalinti seniausius tolimesnius objektus (FIFO)
		if ((count wrm_gc_corpses) > _maxCorpses) then {
			private _excess = (count wrm_gc_corpses) - _maxCorpses;
			for "_j" from 1 to _excess do {
				private _oldestIdx = -1;
				private _oldestStamp = 1e12;
				for [{private _k = 0}, {_k < count wrm_gc_corpses}, {_k = _k + 1}] do {
					private _entry = wrm_gc_corpses select _k;
					_entry params ["_obj", "_stamp"];
					if (!([_obj, _keepRadius] call _fnc_isNearPlayers) && {_stamp < _oldestStamp}) then {
						_oldestStamp = _stamp;
						_oldestIdx = _k;
					};
				};
				if (_oldestIdx > -1) then {
					private _victim = wrm_gc_corpses select _oldestIdx;
					deleteVehicle (_victim select 0);
					wrm_gc_corpses deleteAt _oldestIdx;
				} else {
					//Visi lavonai arti žaidėjų – tolesnį perteklių paliekame
					break;
				};
			};
		};

		//2) Nuolaužų valymas analogiškai
		for [{private _i = count wrm_gc_wrecks - 1}, {_i >= 0}, {_i = _i - 1}] do {
			private _entry = wrm_gc_wrecks select _i;
			_entry params ["_obj", "_stamp"];
			if (!([_obj] call _fnc_isValidDead)) then {
				wrm_gc_wrecks deleteAt _i;
				continue;
			};

			private _age = _now - _stamp;
			private _nearPlayers = [_obj, _keepRadius] call _fnc_isNearPlayers;
			if ((_age > _ttlWreck && !_nearPlayers)) then {
				deleteVehicle _obj;
				wrm_gc_wrecks deleteAt _i;
			};
		};

		if ((count wrm_gc_wrecks) > _maxWrecks) then {
			private _excess = (count wrm_gc_wrecks) - _maxWrecks;
			for "_j" from 1 to _excess do {
				private _oldestIdx = -1;
				private _oldestStamp = 1e12;
				for [{private _k = 0}, {_k < count wrm_gc_wrecks}, {_k = _k + 1}] do {
					private _entry = wrm_gc_wrecks select _k;
					_entry params ["_obj", "_stamp"];
					if (!([_obj, _keepRadius] call _fnc_isNearPlayers) && {_stamp < _oldestStamp}) then {
						_oldestStamp = _stamp;
						_oldestIdx = _k;
					};
				};
				if (_oldestIdx > -1) then {
					private _victim = wrm_gc_wrecks select _oldestIdx;
					deleteVehicle (_victim select 0);
					wrm_gc_wrecks deleteAt _oldestIdx;
				} else {
					break;
				};
			};
		};

		//3) Tuščios grupės – saugiai trinamos kiekvieno ciklo pabaigoje
		{
			if (count units _x == 0) then {
				deleteGroup _x;
			};
		} forEach allGroups;

		//4) Ground šiukšlės: WeaponHolder, GroundWeaponHolder, CraterLong
		if ((_now - _lastGroundCleanup) >= _groundCleanupInterval) then {
			_lastGroundCleanup = _now;
			private _holders = (allMissionObjects "WeaponHolderSimulated") +
				(allMissionObjects "GroundWeaponHolder");
			private _craters = allMissionObjects "CraterLong";

			{
				[_x, _now] call _fnc_registerGround;
			} forEach (_holders + _craters);

			//HashMap iteracija - naudojame toArray false saugesniam variantui
			{
				_x params ["_obj", "_ts"];
				if (isNull _obj) then {
					wrm_gc_holderTimestamps deleteAt _obj;
				} else {
					private _age = _now - _ts;
					if (_age > _ttlGround && !([_obj, _keepRadius] call _fnc_isNearPlayers)) then {
						deleteVehicle _obj;
						wrm_gc_holderTimestamps deleteAt _obj;
					};
				};
			} forEach (wrm_gc_holderTimestamps toArray false);
		};

		//Debug informacija (įjungti tik testams)
		if (DBG) then {
			private _msg = format [
				"[WRM][CLEANUP] Corpses: %1/%2 | Wrecks: %3/%4 | GroundTracked: %5",
				count wrm_gc_corpses,
				_maxCorpses,
				count wrm_gc_wrecks,
				_maxWrecks,
				count wrm_gc_holderTimestamps
			];
			[_msg] remoteExec ["systemChat", 0, false];
		};
	};
};

