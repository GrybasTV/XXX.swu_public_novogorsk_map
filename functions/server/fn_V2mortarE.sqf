/*
	Author: IvosH
	
	Description:
		Ceate mortar at the artillery position (captured)
		Mortars = objMortW, objMortE
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		
	Execution:
		[] spawn wrm_fnc_V2mortarE;
*/
//Inicijuojame mortar masyvus (saugumas - jei neapibrėžti frakcijų failuose)
if(isNil "mortW")then{mortW = [];};
if(isNil "mortE")then{mortE = [];};

if((count mortW==0)&&(count mortE==0)) exitWith {};

[objMortW, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 2, false];
if(!isNull objMortW)then
{
	{objMortW deleteVehicleCrew _x} forEach crew objMortW;
	deleteVehicle objMortW;
};
if(count mortE!=0)then
{
	_vSel = selectRandom mortE;
	_typ="";_tex="";
	if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
	objMortE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
	[objMortE,[_tex,1]] call bis_fnc_initVehicle;
}else
{
	_vSel = selectRandom mortW;
	_typ="";_tex="";
	if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
	objMortE = createVehicle [_typ, [posArti select 0, posArti select 1, 50], [], 0, "NONE"];
	[objMortE,[_tex,1]] call bis_fnc_initVehicle;
};
[objMortE] call wrm_fnc_parachute;
objMortE lockDriver true;
_grpArtiE=createGroup [sideE, true];			
for "_i" from 1 to (objMortE emptyPositions "Gunner") step 1 do
{
	_unit = _grpArtiE createUnit [crewE, posArti, [], 0, "NONE"];
	_unit moveInGunner objMortE;
};
for "_i" from 1 to (objMortE emptyPositions "Commander") step 1 do
{
	_unit = _grpArtiE createUnit [crewE, posArti, [], 0, "NONE"];
	_unit moveInCommander objMortE;
};
objMortE allowCrewInImmobile true;
{ _x addMPEventHandler
	["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
} forEach (crew objMortE);
[objMortE, supArtiV2] remoteExec ["BIS_fnc_addSupportLink", 2, false];				
publicvariable "objMortE";
sleep 1;
z1 addCuratorEditableObjects [[objMortE],true];
defE pushBackUnique _grpArtiE;