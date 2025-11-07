/*
Author: IvosH (Refactored)

Description:
	UAV automatinis hover mechanizmas - palaiko droną ore, kol jis nepradėtas naudoti per terminalą
	Optimizuota versija su geresniu performance ir error handling
	
Parameter(s):
	0: OBJECT - UAV objektas
	1: NUMBER - Target aukštis (metrais)

Returns:
	nothing

Dependencies:
	fn_V2uavRequest.sqf

Execution:
	[_uav, _targetHeight] spawn wrm_fnc_V2uavHover;
*/

params ["_uav", "_targetHeight"];

//Validacija: patikrinti, ar dronas yra teisingas
if (isNull _uav) exitWith {
	systemChat "[UAV HOVER ERROR] UAV is null";
};

//Laukti, kol dronas bus sukurtas su timeout'u (10 sekundžių)
private _timeout = time + 10;
waitUntil {(!isNull _uav && alive _uav) || time > _timeout};

//Patikrinti, ar dronas egzistuoja po timeout'o
if (time > _timeout || isNull _uav || !alive _uav) exitWith {
	systemChat format ["[UAV HOVER] UAV %1 failed to initialize or was destroyed", typeOf _uav];
};

//Palaukti 1 sekundę, kad dronas stabilizuotųsi
sleep 1;

//Cached connected UAV - optimizacija performance
private _cachedConnectedPlayer = objNull;
private _lastCheckTime = 0;

//Tikrinti, ar dronas naudojamas per terminalą - jei taip, sustabdyti automatinį hover
while {alive _uav && (_uav getVariable ["wrm_uav_autoHover", true])} do {
	//Optimizacija: tikrinti kas 2 sekundes, ne kas sekundę (jei dronas nenaudojamas)
	//Jei dronas naudojamas, tikrinti iškart
	if (time - _lastCheckTime > 2 || !isNull _cachedConnectedPlayer) then {
		//Patikrinti, ar dronas prijungtas prie terminalo (bet kuris žaidėjas valdo per terminalą)
		_isControlled = false;
		_cachedConnectedPlayer = objNull;
		
		//Optimizacija: tikrinti tik jei yra žaidėjų
		if (count allPlayers > 0) then {
			{
				private _connectedUAV = getConnectedUAV _x;
				if (!isNull _connectedUAV && _connectedUAV == _uav) exitWith {
					_isControlled = true;
					_cachedConnectedPlayer = _x;
				};
			} forEach allPlayers;
		};
		
		_lastCheckTime = time;
		
		//Jei dronas valdomas per terminalą, sustabdyti automatinį hover
		if (_isControlled) exitWith {
			_uav setVariable ["wrm_uav_autoHover", false, true];
			systemChat format ["[UAV HOVER] Auto-hover disabled for %1 - controlled by player", typeOf _uav];
		};
	};
	
	//Jei dronas laisvas, naudoti flyInHeight (jei turi driver) arba fizinį flight control (jei neturi)
	private _driver = driver _uav;
	
	if (!isNull _driver) then {
		//Jei turi driver, naudoti flyInHeight (sklandesnė nei setVelocity)
		_driver flyInHeight _targetHeight;
	} else {
		//Jei neturi driver, naudoti fizinį flight control (nėra teleportacijos!)
		private _currentPos = getPosATL _uav;
		private _currentHeight = _currentPos select 2;
		private _heightDiff = _targetHeight - _currentHeight;

		//Apskaičiuoti reikiamą vertikalų velocity (maksimaliai 3 m/s)
		private _desiredVerticalVelocity = _heightDiff * 0.3; //0.3 - kontrolės koeficientas
		_desiredVerticalVelocity = _desiredVerticalVelocity max -3 min 3; //Riboti greitį

		//Taikyti velocity tik vertikaliai, išlaikyti horizontalų greitį
		private _currentVelocity = velocity _uav;
		private _newVelocity = [_currentVelocity select 0, _currentVelocity select 1, _desiredVerticalVelocity];

		//Tik taikyti jei reikalingas pakeitimas
		if (abs _heightDiff > 1) then {
			_uav setVelocity _newVelocity;

			//Užtikrinti, kad variklis veikia
			if (!isEngineOn _uav) then {_uav engineOn true;};
			if (fuel _uav < 0.1) then {_uav setFuel 1;};
		} else {
			//Mažas stabilizavimas mažiems nukrypimams
			_uav setVelocity [_currentVelocity select 0, _currentVelocity select 1, 0];
		};
	};
	
	//Patikrinti kas sekundę (arba kas 2 sekundes, jei dronas nenaudojamas)
	sleep 1;
};

//UAV hover baigtas (dronas sunaikintas arba valdomas per terminalą)
if (!alive _uav) then {
	systemChat format ["[UAV HOVER] UAV %1 was destroyed", typeOf _uav];
} else {
	systemChat format ["[UAV HOVER] UAV %1 hover disabled - now player controlled", typeOf _uav];
};

