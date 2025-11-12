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

//Patikrinti, ar grupė jau turi cooldown - naudojame param saugesniam masyvo elementų pasiekimui
_groupCooldownIndex = uavGroupCooldowns findIf {(_x param [0, ""]) == _grpId};

if(_groupCooldownIndex != -1)then
{
	//Atnaujinti esamą cooldown
	uavGroupCooldowns set [_groupCooldownIndex, [_grpId, uavCooldownTime]];
}else
{
	//Pridėti naują cooldown
	uavGroupCooldowns pushBack [_grpId, uavCooldownTime];
};

publicVariable "uavGroupCooldowns";

//Cooldown ciklas - mažinti kas 10 sekundžių
while {true} do
{
	sleep 10;
	
	//Rasti grupės cooldown indeksą
	_groupCooldownIndex = uavGroupCooldowns findIf {(_x param [0, ""]) == _grpId};
	
	//Jei grupės cooldown neberado, baigti ciklą
	if(_groupCooldownIndex == -1)exitWith{};
	
	//Gauti dabartinį cooldown laiką - naudojame param saugesniam masyvo elementų pasiekimui
	_currentCooldown = uavGroupCooldowns param [_groupCooldownIndex, []] param [1, 0];
	_newCooldown = _currentCooldown - 10;
	
	//Jei cooldown baigėsi, pašalinti iš masyvo
	if(_newCooldown <= 0)then
	{
		uavGroupCooldowns deleteAt _groupCooldownIndex;
		publicVariable "uavGroupCooldowns";
		break; //Baigti ciklą
	}else
	{
		//Atnaujinti cooldown laiką
		uavGroupCooldowns set [_groupCooldownIndex, [_grpId, _newCooldown]];
		publicVariable "uavGroupCooldowns";
	};
};

