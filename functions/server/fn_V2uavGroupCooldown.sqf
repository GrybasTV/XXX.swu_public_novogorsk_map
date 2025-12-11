/*
Author: IvosH

Description:
	Grupės-based UAV cooldown sistema Ukraine/Russia frakcijoms
	Kiekviena grupė turi savo cooldown laiką (3 minutės)
	
Parameter(s):
	0: STRING grupės ID
	
Returns:
	nothing
	
Dependencies:
	fn_V2uavRequest.sqf
	
Execution:
	[_grpId] call wrm_fnc_V2uavGroupCooldown;
*/

if !(isServer) exitWith {}; //vykdoma tik serverio pusėje

//Naudojame param saugesniam masyvo elementų pasiekimui
_grpId = _this param [0, ""];

// Nustatyti dinamišką cooldown laiką pagal CAS bazės kontrolę
// Jei pusė NETURI CAS bazės → 3x ilgesnis cooldown (540s vietoj 180s)
_cooldownTime = uavCooldownTime; // Default 180s

// Nustatyti grupės pusę per _grpId formatą (pvz "1-1-A" prasideda su "1" = West, "2" = East)
_side = civilian;
if (_grpId select [0,1] == "1") then {_side = sideW;};
if (_grpId select [0,1] == "2") then {_side = sideE;};

// Patikrinti CAS bazės valdymą
if (_side == sideW) then {
	// West: patikrinti ar kontroliuoja resCasW
	if (getMarkerColor "resCasW" == "") then {
		_cooldownTime = uavCooldownTime * 3; // Neturi CAS bazės → 3x ilgesnis
		diag_log format ["[UAV] West group %1 lost CAS base - cooldown increased to %2s", _grpId, _cooldownTime];
	};
};
if (_side == sideE) then {
	// East: patikrinti ar kontroliuoja resCasE
	if (getMarkerColor "resCasE" == "") then {
		_cooldownTime = uavCooldownTime * 3; // Neturi CAS bazės → 3x ilgesnis
		diag_log format ["[UAV] East group %1 lost CAS base - cooldown increased to %2s", _grpId, _cooldownTime];
	};
};

//Patikrinti, ar grupė jau turi cooldown - naudojame param saugesniam masyvo elementų pasiekimui
_groupCooldownIndex = uavGroupCooldowns findIf {(_x param [0, ""]) == _grpId};

if(_groupCooldownIndex != -1)then
{
	//Atnaujinti esamą cooldown su dinaminiu laiku
	uavGroupCooldowns set [_groupCooldownIndex, [_grpId, _cooldownTime]];
}else
{
	//Pridėti naują cooldown su dinaminiu laiku
	uavGroupCooldowns pushBack [_grpId, _cooldownTime];
};

publicVariable "uavGroupCooldowns";

//Informuoti grupės narius apie cooldown pradžią su formatuotu laiku
//Siųsti pranešimą visiems, bet jis bus rodomas tik grupės nariams (patikrinimas fn_V2uavCooldownHint viduje)
[_grpId, _cooldownTime] remoteExec ["wrm_fnc_V2uavCooldownHint", 0, false];

//Cooldown ciklas - pradėti asinchroninį countdown
[_grpId] spawn {
	params ["_grpId"];
	
	while {true} do
	{
		sleep 1;

		//Rasti grupės cooldown indeksą
		_groupCooldownIndex = uavGroupCooldowns findIf {(_x param [0, ""]) == _grpId};

		//Jei grupės cooldown neberado, baigti ciklą
		if(_groupCooldownIndex == -1)exitWith{};

		//Gauti dabartinį cooldown laiką - naudojame param saugesniam masyvo elementų pasiekimui
		_currentCooldown = uavGroupCooldowns param [_groupCooldownIndex, []] param [1, 0];
		_newCooldown = _currentCooldown - 1;

		//Jei cooldown baigėsi, pašalinti iš masyvo
		if(_newCooldown <= 0)then
		{
			uavGroupCooldowns deleteAt _groupCooldownIndex;
			publicVariable "uavGroupCooldowns";
			
			//Informuoti grupės narius, kad cooldown baigėsi
			[_grpId] remoteExec ["wrm_fnc_V2uavCooldownEnded", 0, false];
			break; //Baigti ciklą
		}else
		{
			//Atnaujinti cooldown laiką
			uavGroupCooldowns set [_groupCooldownIndex, [_grpId, _newCooldown]];
			publicVariable "uavGroupCooldowns";
			
			//Kas 30 sekundžių (arba kai mažiau nei 60 sekundžių - kas 10 sekundžių) informuoti grupės narius apie likusį laiką
			if((_newCooldown mod 30 == 0) || (_newCooldown < 60 && _newCooldown mod 10 == 0)) then {
				[_grpId, _newCooldown] remoteExec ["wrm_fnc_V2uavCooldownHint", 0, false];
			};
		};
	};
};

