/*
Author: IvosH

Description:
	Rodo pranešimą, kad UAV cooldown baigėsi tik grupės lyderiui
	
Parameter(s):
	0: STRING grupės ID
	
Returns:
	nothing
	
Dependencies:
	fn_V2uavGroupCooldown.sqf
	
Execution:
	[_grpId] call wrm_fnc_V2uavCooldownEnded;
*/

if (!hasInterface) exitWith {}; //vykdoma tik klientuose su interface

params ["_grpId"];

//Patikrinti, ar žaidėjas priklauso tai grupei IR yra grupės lyderis
if(str (group player) != _grpId) exitWith {};
if(leader (group player) != player) exitWith {}; //Rodo tik grupės lyderiui

//Rodyti hint pranešimą
hint parseText "UAV cooldown ended<br/>UAV available again<br/><br/>Use UAV terminal to request new UAV";

