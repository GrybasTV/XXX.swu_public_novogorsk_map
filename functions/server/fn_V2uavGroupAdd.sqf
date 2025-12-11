/*
Author: IvosH

Description:
	Pridėti grupės UAV į masyvą serverio pusėje
	
Parameter(s):
	0: STRING grupės ID
	1: OBJECT UAV objektas
	
Returns:
	nothing
	
Dependencies:
	fn_V2uavRequest.sqf
	
Execution:
	[_grpId, _uav] call wrm_fnc_V2uavGroupAdd;
*/

if !(isServer) exitWith {}; //vykdoma tik serverio pusėje

//Naudojame param saugesniam masyvo elementų pasiekimui
_grpId = _this param [0, ""];
_uav = _this param [1, objNull];

//Patikrinti, ar grupė turi aktyvų cooldown - jei taip, sunaikinti UAV ir nutraukti
_groupCooldownIndex = uavGroupCooldowns findIf {(_x param [0, ""]) == _grpId};
if(_groupCooldownIndex != -1)then
{
	_groupCooldown = uavGroupCooldowns param [_groupCooldownIndex, []] param [1, 0];
	if(_groupCooldown > 0)then
	{
		//Grupė turi aktyvų cooldown - sunaikinti UAV ir nutraukti
		if(!isNull _uav) then {
			{deleteVehicle _x;} forEach crew _uav;
			deleteVehicle _uav;
		};
		//Nepridėti į masyvą
	};
}else
{
	//Patikrinti, ar grupė jau turi UAV masyve - naudojame param saugesniam masyvo elementų pasiekimui
	_groupUavIndex = uavGroupObjects findIf {(_x param [0, ""]) == _grpId};

	if(_groupUavIndex != -1)then
{
	//Patikrinti, ar esamas UAV dar gyvas
	_oldUav = uavGroupObjects param [_groupUavIndex, []] param [1, objNull];
	if(!isNull _oldUav && alive _oldUav) then {
		//Jei esamas UAV dar gyvas, sunaikinti naują ir grįžti
		//Tai apsaugo nuo greitų užklausų, kurios gali sukurti kelis UAV
		if(!isNull _uav) then {
			//Sunaikinti visą transporto priemonę su įgula
			{deleteVehicle _x;} forEach crew _uav;
			deleteVehicle _uav;
		};
		//Neatnaujiname masyvo, nes esamas UAV dar gyvas
	}else
	{
		//Atnaujinti esamą UAV, jei senasis jau negyvas
		uavGroupObjects set [_groupUavIndex, [_grpId, _uav]];
		publicVariable "uavGroupObjects";
		
		//Pridėti MPKilled event handler serverio pusėje - tai užtikrina, kad cooldown prasidės tinkamu metu
		//Event handler pridėtas serverio pusėje, nes čia saugomas UAV masyve
		//MPKilled yra globalus eventas, todėl handler veiks nepriklausomai nuo objekto lokalumo
		//Pagal SQF geriausias praktikas: event handler turėtų būti ten, kur yra duomenys, kuriuos reikia modifikuoti
		if(!isNull _uav) then {
			_uav addMPEventHandler ["MPKilled", {
				params ["_uav"];
				//Pašalinti UAV ir pradėti cooldown serverio pusėje
				//SVARBU: Nereikia tikrinti isNull, nes MPKilled vykdomas kai objektas jau dead
				//Naudojame call, nes fn_V2uavGroupRemove neblokuojanti ir veikia nesuplanuotoje aplinkoje
				[_uav] call wrm_fnc_V2uavGroupRemove;
			}];
		};
	};
}else
{
	//Pridėti naują UAV
	uavGroupObjects pushBack [_grpId, _uav];
	publicVariable "uavGroupObjects";
	
	//Pridėti MPKilled event handler serverio pusėje - tai užtikrina, kad cooldown prasidės tinkamu metu
	//Event handler pridėtas serverio pusėje, nes čia saugomas UAV masyve
	//MPKilled yra globalus eventas, todėl handler veiks nepriklausomai nuo objekto lokalumo
	//Pagal SQF geriausias praktikas: event handler turėtų būti ten, kur yra duomenys, kuriuos reikia modifikuoti
	if(!isNull _uav) then {
		_uav addMPEventHandler ["MPKilled", {
			params ["_uav"];
			//Pašalinti UAV ir pradėti cooldown serverio pusėje
			//SVARBU: Nereikia tikrinti isNull, nes MPKilled vykdomas kai objektas jau dead
			//Naudojame call, nes fn_V2uavGroupRemove neblokuojanti ir veikia nesuplanuotoje aplinkoje
			[_uav] call wrm_fnc_V2uavGroupRemove;
		}];
	};
	};
};

