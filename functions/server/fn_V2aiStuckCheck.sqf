/*
	Author: Auto-generated from SQF_SYNTAX_BEST_PRACTICES.md audit

	Description:
		Aptinka ir taiso įstrigusius AI vienetus naudodamas pozicijos delta stebėjimą
		Pagal dokumentaciją, pakeičia nepakankamą canMove metodą

	Parameter(s):
		_unit: AI vienetas kurį reikia patikrinti
		_threshold: atstumo slenkstis metrais (numatytasis 1)
		_maxStuckCount: maksimalus įstrigimų skaičius prieš taisymą (numatytasis 3)

	Returns:
		nothing

	Dependencies:
		fn_V2aiVehUpdate.sqf

	Execution:
		[vehicleObject, 1, 3] call wrm_fnc_V2aiStuckCheck;
*/

// Patikriname parametrus
params [
	["_unit", objNull, [objNull]],
	["_threshold", 1, [0]],
	["_maxStuckCount", 3, [0]]
];

if (isNull _unit || {!alive _unit}) exitWith {};

// Inicializuojame pozicijos sekimo kintamuosius jei jie neegzistuoja
private _lastPosVar = format ["V2_stuckCheck_lastPos_%1", netId _unit];
private _stuckCountVar = format ["V2_stuckCheck_count_%1", netId _unit];

if (isNil _lastPosVar) then {
	_unit setVariable [_lastPosVar, getPosATL _unit, false];
	_unit setVariable [_stuckCountVar, 0, false];
};

// Gauname paskutinę poziciją ir dabartinę
private _lastPos = _unit getVariable [_lastPosVar, getPosATL _unit];
private _currentPos = getPosATL _unit;
private _currentStuckCount = _unit getVariable [_stuckCountVar, 0];

// Skaičiuojame atstumą
private _distance = _lastPos distance _currentPos;

// Atnaujiname paskutinę poziciją
_unit setVariable [_lastPosVar, _currentPos, false];

// Tikriname ar vienetas juda
if (_distance < _threshold) then {
	// Vienetas nejuda - didiname įstrigimo skaitiklį
	_currentStuckCount = _currentStuckCount + 1;
	_unit setVariable [_stuckCountVar, _currentStuckCount, false];

	// Jei įstrigęs per ilgai - bandome taisyti
	if (_currentStuckCount >= _maxStuckCount) then {
		// ĮSTRIGIMO TAISYMAS - pagal dokumentacijos rekomendacijas

		// 1. Pirmiausia bandome pakeisti kryptį (transporto priemonėms)
		if (_unit isKindOf "LandVehicle") then {
			private _newDir = (getDir _unit + 180) % 360;
			_unit setDir _newDir;

			// Bandome pajudėti į priekį
			if (alive driver _unit) then {
				_unit doMove (_unit getPos [50, _newDir]);
			};

			if (DBG) then {
				["AI Stuck: Transporto priemonė pakeitė kryptį", "systemChat", 0, false] remoteExec ["call", 0];
			};
		} else {
			// 2. Pėstininkams - perkeliame į saugią vietą
			private _safePos = _unit findEmptyPosition [0, 50, typeOf _unit];
			if (count _safePos > 0) then {
				_unit setPosATL _safePos;
				if (DBG) then {
					["AI Stuck: Pėstininkas perkeltas į saugią vietą", "systemChat", 0, false] remoteExec ["call", 0];
				};
			} else {
				// 3. Jei negalime perkelti - sunaikiname (fail-safe pagal dokumentaciją)
				_unit setDamage 1;
				if (DBG) then {
					["AI Stuck: Vienetas sunaikintas (fail-safe)", "systemChat", 0, false] remoteExec ["call", 0];
				};
			};
		};

		// Atstatome skaitiklį
		_unit setVariable [_stuckCountVar, 0, false];
	};
} else {
	// Vienetas juda - atstatome skaitiklį
	_unit setVariable [_stuckCountVar, 0, false];
};
