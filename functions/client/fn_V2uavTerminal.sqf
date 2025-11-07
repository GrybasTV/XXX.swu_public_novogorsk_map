/*
Author: IvosH (Refactored)

Description:
	UAV terminalo prijungimo funkcija - bando prijungti terminalą prie drono
	Patobulinta versija su geresniu error handling ir timeout'ais
	
Parameter(s):
	0: OBJECT - UAV objektas
	1: OBJECT - Žaidėjas (player), kuris turi prijungti terminalą

Returns:
	BOOL - true jei terminalas sėkmingai prijungtas, false jei nepavyko

Dependencies:
	fn_V2uavRequest.sqf

Execution:
	[_uav, player] spawn wrm_fnc_V2uavTerminal;
*/

params ["_uav", "_player"];

//Validacija: patikrinti, ar dronas ir žaidėjas yra teisingi
if (isNull _uav) exitWith {
	systemChat "[UAV TERMINAL ERROR] UAV is null";
	false
};

if (isNull _player) exitWith {
	systemChat "[UAV TERMINAL ERROR] Player is null";
	false
};

//Patikrinti, ar dronas yra gyvas
if (!alive _uav) exitWith {
	systemChat format ["[UAV TERMINAL] UAV %1 is not alive", typeOf _uav];
	false
};

//Patikrinti, ar dronas yra UAV tipo
if (!(_uav isKindOf "UAV") && str typeOf _uav find "UAV" < 0 && str typeOf _uav find "UAFPV" < 0) exitWith {
	//Ne visi dronai turi palaikyti terminalą - tai normalus atvejis
	systemChat format ["[UAV TERMINAL] UAV %1 does not support terminal connection", typeOf _uav];
	false
};

//Nustatyti kaip UAV objektą
_uav setVariable ["isUAV", true, true];

//VIKTIGU: Leisti UAV sistemai inicijuotis prieš jungiant terminalą
sleep 2; //Palaukti 2 sekundes, kol UAV sistema inicializuosis

//Patikrinti, ar dronas vis dar gyvas po laukimo
if (!alive _uav) exitWith {
	systemChat format ["[UAV TERMINAL] UAV %1 was destroyed during initialization", typeOf _uav];
	false
};

//Patikrinti atstumą (terminalas turi būti pakankamai arti)
if (player distance _uav > 500) exitWith {
	systemChat format ["[UAV TERMINAL] UAV %1 is too far away (max 500m)", typeOf _uav];
	false
};

//Bandyti prijungti terminalą kelis kartus (maksimaliai 3 bandymai)
private _connected = false;
private _maxAttempts = 3;
private _attempt = 0;

while {_attempt < _maxAttempts && !_connected && alive _uav && player distance _uav < 500} do {
	_attempt = _attempt + 1;
	
	//Bandyti prijungti terminalą
	_player connectTerminalToUAV _uav;
	sleep 1; //Palaukti, kol terminalas prijungsis

	//Patikrinti ar pavyko prisijungti
	private _connectedUAV = getConnectedUAV _player;
	if (!isNull _connectedUAV && _connectedUAV == _uav) then {
		_connected = true;
		systemChat format ["[UAV TERMINAL] Terminal connected to %1 (attempt %2)", typeOf _uav, _attempt];
	} else {
		//Jei nepavyko, palaukti prieš kitą bandymą
		if (_attempt < _maxAttempts) then {
			sleep 1;
		};
	};
};

//Rezultatas
if (!_connected) then {
	systemChat format ["[UAV TERMINAL] Failed to connect terminal to %1 after %2 attempts", typeOf _uav, _maxAttempts];
} else {
	systemChat format ["[UAV TERMINAL] Successfully connected to %1", typeOf _uav];
};

_connected

