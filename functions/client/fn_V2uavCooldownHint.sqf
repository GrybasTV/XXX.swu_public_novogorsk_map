/*
Author: IvosH

Description:
	Rodo UAV cooldown pranešimą tik grupės lyderiui
	
Parameter(s):
	0: STRING grupės ID
	1: NUMBER likęs cooldown laikas sekundėmis
	
Returns:
	nothing
	
Dependencies:
	fn_V2uavGroupCooldown.sqf
	
Execution:
	[_grpId, _cooldownTime] call wrm_fnc_V2uavCooldownHint;
*/

if (!hasInterface) exitWith {}; //vykdoma tik klientuose su interface

params ["_grpId", "_cooldownTime"];

//Patikrinti, ar žaidėjas priklauso tai grupei IR yra grupės lyderis
if(str (group player) != _grpId) exitWith {};
if(leader (group player) != player) exitWith {}; //Rodo tik grupės lyderiui

//Konvertuoti laiką į min:sek formatą
_cooldownMinutes = floor (_cooldownTime / 60);
_cooldownSeconds = _cooldownTime mod 60;

//Formatuoti pranešimą
_cooldownText = "";
if(_cooldownMinutes > 0) then {
	_cooldownText = format ["%1 min %2 sec", _cooldownMinutes, _cooldownSeconds];
} else {
	_cooldownText = format ["%1 sec", _cooldownSeconds];
};

//Rodyti hint pranešimą su formatuotu laiku
hint parseText format ["UAV destroyed<br/>Cooldown: %1<br/><br/>Use UAV terminal to request new UAV", _cooldownText];

