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
if((count mortW==0)&&(count mortE==0)) exitWith {};

[objMortW, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
if(!isNull objMortW)then
{
	{objMortW deleteVehicleCrew _x} forEach crew objMortW;
	deleteVehicle objMortW;
};
if(count mortE!=0)then
{
	_vSel = selectRandom mortE;
	_typ="";_tex="";
	// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
	if (_vSel isEqualType [])then{_typ=_vSel param [0, ""];_tex=_vSel param [1, ""];}else{_typ=_vSel;};
	objMortE = createVehicle [_typ, [posArti param [0, 0], posArti param [1, 0], 50], [], 0, "NONE"];
	[objMortE,[_tex,1]] call bis_fnc_initVehicle;
}else
{
	_vSel = selectRandom mortW;
	_typ="";_tex="";
	// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
	if (_vSel isEqualType [])then{_typ=_vSel param [0, ""];_tex=_vSel param [1, ""];}else{_typ=_vSel;};
	objMortE = createVehicle [_typ, [posArti param [0, 0], posArti param [1, 0], 50], [], 0, "NONE"];
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
[objMortE, supArtiV2] remoteExec ["BIS_fnc_addSupportLink", 0, true];				
publicvariable "objMortE";
sleep 1;
z1 addCuratorEditableObjects [[objMortE],true];
defE pushBackUnique _grpArtiE;