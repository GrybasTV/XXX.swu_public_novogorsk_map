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
		[] spawn wrm_fnc_V2mortarW;
*/
if((count mortW==0)&&(count mortE==0)) exitWith {};

[objMortE, supArtiV2] remoteExec ["BIS_fnc_removeSupportLink", 0, true];
if(!isNull objMortE)then
{
	{objMortE deleteVehicleCrew _x} forEach crew objMortE;
	deleteVehicle objMortE;
};
if(count mortW!=0)then
{
	_vSel = selectRandom mortW;
	_typ="";_tex="";
	// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
	if (_vSel isEqualType [])then{_typ=_vSel param [0, ""];_tex=_vSel param [1, ""];}else{_typ=_vSel;};
	objMortW = createVehicle [_typ, [posArti param [0, 0], posArti param [1, 0], 50], [], 0, "NONE"];
	[objMortW,[_tex,1]] call bis_fnc_initVehicle;
}else
{
	_vSel = selectRandom mortE;
	_typ="";_tex="";
	// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
	if (_vSel isEqualType [])then{_typ=_vSel param [0, ""];_tex=_vSel param [1, ""];}else{_typ=_vSel;};
	objMortW = createVehicle [_typ, [posArti param [0, 0], posArti param [1, 0], 50], [], 0, "NONE"];
	[objMortW,[_tex,1]] call bis_fnc_initVehicle;
};
[objMortW] call wrm_fnc_parachute;
objMortW lockDriver true;
_grpArtiW=createGroup [sideW, true];			
for "_i" from 1 to (objMortW emptyPositions "Gunner") step 1 do
{
	_unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
	_unit moveInGunner objMortW;
};
for "_i" from 1 to (objMortW emptyPositions "Commander") step 1 do
{
	_unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
	_unit moveInCommander objMortW;
};
objMortW allowCrewInImmobile true;
{ _x addMPEventHandler
	["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
} forEach (crew objMortW);
[objMortW, supArtiV2] remoteExec ["BIS_fnc_addSupportLink", 0, true];				
publicvariable "objMortW";
sleep 1;
z1 addCuratorEditableObjects [[objMortW],true];
defW pushBackUnique _grpArtiW;