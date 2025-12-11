/*
Author: IvosH

Description:
	Pašalinti grupės UAV iš masyvo ir pradėti cooldown serverio pusėje
	
Parameter(s):
	0: OBJECT UAV objektas
	
Returns:
	nothing
	
Dependencies:
	fn_V2uavRequest.sqf
	fn_V2uavGroupCooldown.sqf
	
Execution:
	[_uav] call wrm_fnc_V2uavGroupRemove;
*/

if !(isServer) exitWith {}; //vykdoma tik serverio pusėje

//Naudojame param saugesniam masyvo elementų pasiekimui
_uav = _this param [0, objNull];

//Rasti grupę, kuriai priklauso šis UAV - naudojame param saugesniam masyvo elementų pasiekimui
_uavIndex = uavGroupObjects findIf {(_x param [1, objNull]) == _uav};

if(_uavIndex != -1)then
{
	//Naudojame param saugesniam masyvo elementų pasiekimui
	_grpId = uavGroupObjects param [_uavIndex, []] param [0, ""];
	if(_grpId != "")then
	{
		uavGroupObjects deleteAt _uavIndex;
		publicVariable "uavGroupObjects";

		//Pradėti cooldown - fn_V2uavGroupCooldown informuos grupės narius apie cooldown su formatuotu laiku
		[_grpId] call wrm_fnc_V2uavGroupCooldown;
	};
}else
{
	//UAV nerastas masyve - tai gali nutikti, jei UAV sunaikintas greitai arba dėl race condition
	//Tačiau dabar MPKilled event handler pridėtas serverio pusėje PO to, kai UAV pridėtas į masyvą,
	//todėl šis atvejis neturėtų vykti normaliomis sąlygomis
	if(DBG) then {
		["DEBUG: UAV not found in uavGroupObjects - this should not happen"] remoteExec ["systemChat", 0, false];
	};
};

