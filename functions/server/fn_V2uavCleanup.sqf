/*
Author: IvosH (Refactored)

Description:
	UAV cleanup funkcija - išvalo žaidėjo dronus iš masyvų kai žaidėjas miršta arba atsijungia
	Šalina dronus iš uavSquadW/uavSquadE masyvų ir sunaikina gyvus dronus

Parameter(s):
	0: STRING - playerUID žaidėjo, kurio dronai turi būti išvalyti
	1: SIDE - žaidėjo pusė (sideW arba sideE)

Returns:
	nothing

Dependencies:
	initServer.sqf (uavSquadW, uavSquadE)

Execution:
	[getPlayerUID player, side player] call wrm_fnc_V2uavCleanup;
*/

params ["_playerUID", "_side"];

if (isNil "_playerUID" || {typeName _playerUID != "STRING"} || {_playerUID == ""}) exitWith {
	systemChat "[UAV CLEANUP] ERROR: Invalid playerUID";
};

if (isNil "_side" || {typeName _side != "SIDE"}) exitWith {
	systemChat "[UAV CLEANUP] ERROR: Invalid side";
};

//Pasirinkti teisingą masyvą pagal pusę
private _uavSquad = [];
private _sideName = "";

call {
	if (_side == sideW) exitWith {
		_uavSquad = uavSquadW;
		_sideName = "WEST";
	};
	if (_side == sideE) exitWith {
		_uavSquad = uavSquadE;
		_sideName = "EAST";
	};
};

if (count _uavSquad == 0) exitWith {
	systemChat format ["[UAV CLEANUP] No UAVs to clean up for %1 player %2", _sideName, _playerUID];
};

//Ieškoti žaidėjo drono masyve
private _index = -1;
{
	if ((_x select 0) == _playerUID) exitWith {_index = _forEachIndex;};
} forEach _uavSquad;

if (_index >= 0) then {
	private _uavData = _uavSquad select _index;
	private _uavObj = _uavData select 1;
	private _cooldown = _uavData select 2;

	//Sunaikinti gyvą droną
	if (!isNull _uavObj && alive _uavObj) then {
		systemChat format ["[UAV CLEANUP] Destroying active UAV for %1 player %2", _sideName, _playerUID];
		deleteVehicle _uavObj;
	};

	//Pašalinti iš masyvo
	_uavSquad deleteAt _index;

	//Sinchronizuoti su klientais
	if (_side == sideW) then {
		uavSquadW = _uavSquad;
		publicvariable "uavSquadW";
	} else {
		uavSquadE = _uavSquad;
		publicvariable "uavSquadE";
	};

	systemChat format ["[UAV CLEANUP] Cleaned up UAV data for %1 player %2", _sideName, _playerUID];

	// Papildomai išvalyti pagrindinius objektus ir cooldown'us jei reikia
	// Šiuo metu pagrindiniai objektai yra globalūs ir gali būti naudojami kelių žaidėjų,
	// todėl jų neišvalome automatiškai - jie turi būti išvalomi kitais mechanizmais

} else {
	systemChat format ["[UAV CLEANUP] No UAV data found for %1 player %2", _sideName, _playerUID];
};
