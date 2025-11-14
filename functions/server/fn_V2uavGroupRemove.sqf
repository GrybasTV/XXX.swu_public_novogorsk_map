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

		//Pradėti cooldown - informuoti apie cooldown pradžią ir nustatyti nedelsiant
		["UAV destroyed - starting cooldown"] remoteExec ["systemChat", 0, false];
		[_grpId] call wrm_fnc_V2uavGroupCooldown;
	};
};

