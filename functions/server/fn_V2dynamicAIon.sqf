/*
	Author: Auto-generated
	Modified: Rubber Band Mechanizmas - išlaiko pusiausvyrą
	
	Description:
		Dinamiškai keičia AIon pagal sektorių/bazių kontrolės skirtumą
		RUBBER BAND EFEKTAS:
		- Jei žaidėjas laimi (kontroliuoja daug sektorių) → AIon didėja (priešas stiprėja)
		- Jei AI dominuoja (kontroliuoja daug sektorių) → AIon mažėja (žaidėjas gauna boostą)
		
		Funkcija skaičiuoja visus sektorius ir bazes pagal puses (kaip fn_V2ticketBleed.sqf)
		Po AIon keitimo atnaujinamas coop kintamasis
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		fn_V2aiVehicle.sqf - naudoja AIon ir coop
		fn_V2ticketBleed.sqf - sektorių skaičiavimo logika
		
	Execution:
		[] spawn wrm_fnc_V2dynamicAIon;
*/

if !(isServer) exitWith {}; // Veikia tik serveryje

// Jei AIon == 0 (Disabled), dinaminis keitimas neveikia
if (AIon == 0) exitWith {
	if (DBG) then {
		["Dynamic AIon: Disabled, exiting"] remoteExec ["systemChat", 0, false];
	};
};

// Laikome pradinę AIon reikšmę
_initialAIon = AIon;

// Laukime, kol misija prasidės (progress >= 2)
// KRITINIS FIX: Pridedame timeout, kad išvengtų amžino užstrigimo
// Jei progress niekada nepasiekia 2 (pvz., JIP problemos), funkcija sustabdys laukimą po 600 sekundžių
private _startTime = time;
private _timeout = 600; // 10 minučių timeout
waitUntil {
	sleep 1;
	progress >= 2 || {time - _startTime > _timeout}
};

// Jei timeout įvyko, išeiname su warning
if (time - _startTime > _timeout && progress < 2) exitWith {
	["WARNING: Dynamic AIon timeout - mission progress did not reach 2 within 10 minutes"] remoteExec ["systemChat", 0, false];
};

if (DBG) then {
	[format ["Dynamic AIon: Started monitoring (Initial AIon: %1)", _initialAIon]] remoteExec ["systemChat", 0, false];
};

// Pagrindinis ciklas - tikriname kas 60 sekundžių
while {true} do {
	sleep 60; // Tikriname kas 60 sekundžių - suplanuotoje aplinkoje (spawn)
	
	// Jei AIon == 0, sustabome dinaminį keitimą
	if (AIon == 0) exitWith {
		if (DBG) then {
			["Dynamic AIon: AIon set to 0, stopping dynamic updates"] remoteExec ["systemChat", 0, false];
		};
	};
	
	// Inicializuojame kintamuosius prieš naudojimą (pagal SQF_SYNTAX_BEST_PRACTICES.md)
	_secW = 0; // West pusės kontroliuojami sektoriai
	_secE = 0; // East pusės kontroliuojami sektoriai
	_plw = 0; // Žaidėjų skaičius West pusėje
	_ple = 0; // Žaidėjų skaičius East pusėje
	_playerSide = ""; // Žaidėjų pusė (WEST, EAST, BOTH, NONE)
	_aiSide = ""; // AI pusė (WEST, EAST, BOTH, NONE)
	_playerSectors = 0; // Žaidėjų kontroliuojami sektoriai
	_aiSectors = 0; // AI kontroliuojami sektoriai
	_sectorDiff = 0; // Skirtumas tarp žaidėjų ir AI sektorių
	_newAIon = _initialAIon; // Nauja AIon reikšmė
	
	// Skaičiuojame sektorius/bazes pagal puses (kaip fn_V2ticketBleed.sqf)
	// Bazės West
	if (getMarkerColor resFobW != "") then {_secW = _secW + 1;}; // BaseW1 (transport) is under control of sideW
	if (getMarkerColor resFobWE != "") then {_secE = _secE + 1;}; // BaseW1 užimta East
	if (getMarkerColor resBaseW != "") then {_secW = _secW + 1;}; // BaseW2 (armors)
	if (getMarkerColor resBaseWE != "") then {_secE = _secE + 1;}; // BaseW2 užimta East
	
	// Bazės East
	if (getMarkerColor resFobEW != "") then {_secW = _secW + 1;}; // BaseE1 užimta West
	if (getMarkerColor resFobE != "") then {_secE = _secE + 1;}; // BaseE1 (transport)
	if (getMarkerColor resBaseEW != "") then {_secW = _secW + 1;}; // BaseE2 užimta West
	if (getMarkerColor resBaseE != "") then {_secE = _secE + 1;}; // BaseE2 (armors)
	
	// Neutralūs sektoriai
	if (getMarkerColor resAW != "") then {_secW = _secW + 1;}; // AA West
	if (getMarkerColor resAE != "") then {_secE = _secE + 1;}; // AA East
	if (getMarkerColor resBW != "") then {_secW = _secW + 1;}; // Artillery West
	if (getMarkerColor resBE != "") then {_secE = _secE + 1;}; // Artillery East
	if (getMarkerColor resCW != "") then {_secW = _secW + 1;}; // CAS West
	if (getMarkerColor resCE != "") then {_secE = _secE + 1;}; // CAS East
	
	// Skaičiuojame žaidėjus, kad nustatytume, kuri pusė yra žaidėjų pusė
	_plw = {side _x == sideW} count allPlayers;
	_ple = {side _x == sideE} count allPlayers;
	
	// Nustatome, kuri pusė yra žaidėjų pusė (SP/COOP režime)
	call {
		// PvP režimas - abiejose pusėse yra žaidėjų
		if ((_plw > 0) && (_ple > 0)) exitWith {
			_playerSide = "BOTH";
			_aiSide = "NONE";
		};
		
		// SP/COOP - žaidėjai tik West pusėje
		if (_plw > 0) exitWith {
			_playerSide = "WEST";
			_aiSide = "EAST";
		};
		
		// SP/COOP - žaidėjai tik East pusėje
		if (_ple > 0) exitWith {
			_playerSide = "EAST";
			_aiSide = "WEST";
		};
		
		// Nėra žaidėjų
		_playerSide = "NONE";
		_aiSide = "BOTH";
	};
	
	// Skaičiuojame sektorių skirtumą
	if (_playerSide == "WEST") then {
		_playerSectors = _secW;
		_aiSectors = _secE;
	} else {
		if (_playerSide == "EAST") then {
			_playerSectors = _secE;
			_aiSectors = _secW;
		} else {
			// PvP režimas - naudojame skirtumą tarp pusių
			_playerSectors = _secW;
			_aiSectors = _secE;
		};
	};
	
	// Skaičiuojame skirtumą (teigiamas = žaidėjai laimi, neigiamas = AI laimi)
	_sectorDiff = _playerSectors - _aiSectors;
	
	// RUBBER BAND LOGIKA: Atvirkščiai nei intuityviai
	// Jei žaidėjas laimi (teigiamas skirtumas) → AIon didėja (priešas stiprėja)
	// Jei AI laimi (neigiamas skirtumas) → AIon mažėja (žaidėjas gauna boostą)
	
	if (_playerSide == "BOTH") then {
		// PvP režimas - rubber band veikia abiem kryptimis
		if (_sectorDiff > 2) then {
			// West pusė (žaidėjai) laimi → East pusės AI stiprėja
			_newAIon = 3; // Overwhelming - East pusės AI gauna daugiau transporto priemonių
		} else {
			if (_sectorDiff < -2) then {
				// East pusė (žaidėjai) laimi → West pusės AI stiprėja
				_newAIon = 3; // Overwhelming - West pusės AI gauna daugiau transporto priemonių
			} else {
				if (_sectorDiff > 0) then {
					// West pusė šiek tiek laimi
					_newAIon = 2; // Challenging
				} else {
					if (_sectorDiff < 0) then {
						// East pusė šiek tiek laimi
						_newAIon = 2; // Challenging
					} else {
						// Pusiausvyra
						_newAIon = 1; // Balanced
					};
				};
			};
		};
	} else {
		// SP/COOP režimas - rubber band veikia pilnai
		if (_sectorDiff > 2) then {
			// Žaidėjas kontroliuoja daug daugiau sektorių → AIon didėja (priešas stiprėja)
			_newAIon = 3; // Overwhelming - priešo pusės AI gauna daugiau transporto priemonių + antro lygio šarvuotieji
		} else {
			if (_sectorDiff > 0) then {
				// Žaidėjas kontroliuoja daugiau sektorių → AIon didėja (priešas stiprėja)
				_newAIon = 2; // Challenging - priešo pusės AI gauna daugiau transporto priemonių
			} else {
				if (_sectorDiff == 0) then {
					// Pusiausvyra → vidutinis sunkumas
					_newAIon = 2; // Challenging
				} else {
					if (_sectorDiff > -2) then {
						// AI kontroliuoja šiek tiek daugiau → AIon mažėja (žaidėjas gauna boostą)
						_newAIon = 1; // Balanced - žaidėjo pusės AI gauna daugiau transporto priemonių (PvP režimas)
					} else {
						// AI kontroliuoja daug daugiau sektorių → AIon mažėja (žaidėjas gauna boostą)
						_newAIon = 1; // Balanced - žaidėjo pusės AI gauna daugiau transporto priemonių
					};
				};
			};
		};
	};
	
	// Apribojame AIon reikšmę nuo 1 iki 3
	if (_newAIon < 1) then { _newAIon = 1; };
	if (_newAIon > 3) then { _newAIon = 3; };
	
	// Atnaujiname AIon tik jei pasikeitė
	if (AIon != _newAIon) then {
			AIon = _newAIon;
			publicVariable "AIon";
			
			if (DBG) then {
				[format ["Dynamic AIon updated: %1 (Player sectors: %2, AI sectors: %3, Diff: %4)", _newAIon, _playerSectors, _aiSectors, _sectorDiff]] remoteExec ["systemChat", 0, false];
			};
			
			// Atnaujiname coop kintamąjį, nes jis priklauso nuo AIon
			// SVARBU: Jei AIon = 1, coop = 0, tai abiejose pusėse spawninamos transporto priemonės (boost žaidėjui SP/COOP režime)
			// Visada nustatome coop = 0, kad abi pusės gautų AI paramą (kaip PvP režime)
			coop = 0; publicVariable "coop";
			
			if (DBG) then {
				[format ["Coop updated: %1 (Players W: %2, E: %3)", coop, _plw, _ple]] remoteExec ["systemChat", 0, false];
			};
			
			// Dinamiškai atnaujiname papildomas grupes pagal naują AIon reikšmę
			[] call wrm_fnc_V2dynamicSquads;
		};
};

