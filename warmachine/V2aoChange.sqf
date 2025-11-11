/*
[_pos] execVM "warmachine\V2aoChange.sqf";
*/

_posLMB = _this select 0;

mrk setMarkerPos _posLMB;
mrk setMarkerType "select";

call
{
	if (mrk =="mArti") exitWith {posArti = _posLMB; "mArtiRng0" setMarkerPos _posLMB;  "mArtiRng1" setMarkerPos _posLMB; if(DBG)then{vehArti setVehiclePosition [_posLMB, [], 0, "NONE"];};};
	if (mrk =="mCas") exitWith {posCas = _posLMB; if(DBG)then{vehCas setVehiclePosition [_posLMB, [], 0, "NONE"];};};
	if (mrk =="mAA") exitWith {posAA = _posLMB; if(DBG)then{vehAA setVehiclePosition [_posLMB, [], 0, "NONE"];};};
	if (mrk =="mB1W") exitWith {posBaseW1 = _posLMB;};
	if (mrk =="mB2W") exitWith {posBaseW2 = _posLMB;};
	if (mrk =="mB1E") exitWith {posBaseE1 = _posLMB;};
	if (mrk =="mB2E") exitWith {posBaseE2 = _posLMB;};
};

["AOselect", "onMapSingleClick", {[_pos,_shift,_alt] execVM "warmachine\V2aoSelect.sqf";}] call BIS_fnc_addStackedEventHandler;
AOcreated = 1;

//respawn positions
if(DBG && (count dbgVehs!=0))then
{
	{deleteVehicle _x;} forEach (dbgVehs-[vehArti,vehCas,vehAA]);
	dbgVehs = [vehArti,vehCas,vehAA];
};
#include "V2aoRespawn.sqf";

if (AOcreated == 1) then {hint parseText format 
["
	AO CREATED SUCCESFULY <br/><br/>
	Press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout<br/><br/>
	Press Shift+LMB<br/>
	To select any sector and change its location
"];};

//control
call
{
	//if ((posArti distance posCas)>(artiRange select 0)) exitWith {hint parseText format ["CAS TOWER<br/>position is too far from the Artillery<br/><br/>Select another location<br/>Shift+LMB"]; AOcreated = 0;};
	
	if ((posArti distance posAA)<(artiRange select 1)) exitWith {hint parseText format 
	["AO CREATED SUCCESFULY<br/><br/>
	ANTI AIR<br/>
	position is too close to the Artillery<br/>
	Game might be unbalanced<br/>
	You can change the location by<br/>
	Shift+LMB<br/><br/>
	Press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout"]; /*AOcreated = 0;*/};
	
	if ((posArti distance posBaseW1)<(artiRange select 1)) exitWith {hint parseText format 
	["AO CREATED SUCCESFULY<br/><br/>
	%1<br/>
	position is too close to the Artillery<br/>
	Game might be unbalanced<br/>
	You can change the location by<br/>
	Shift+LMB<br/><br/>
	Press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout",nameBW1]; /*AOcreated = 0;*/};
	
	if ((posArti distance posBaseW2)<(artiRange select 1)) exitWith {hint parseText format 
	["AO CREATED SUCCESFULY<br/><br/>
	%1<br/>
	position is too close to the Artillery<br/>
	Game might be unbalanced<br/>
	You can change the location by<br/>
	Shift+LMB<br/><br/>
	Press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout",nameBW2]; /*AOcreated = 0;*/};
	
	if ((posArti distance posBaseE1)<(artiRange select 1)) exitWith {hint parseText format 
	["AO CREATED SUCCESFULY<br/><br/>
	%1<br/>
	position is too close to the Artillery<br/>
	Game might be unbalanced<br/>
	You can change the location by<br/>
	Shift+LMB<br/><br/>
	Press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout",nameBE1];/*AOcreated = 0;*/};
	
	if ((posArti distance posBaseE2)<(artiRange select 1)) exitWith {hint parseText format 
	["AO CREATED SUCCESFULY<br/><br/>%1<br/>position is too close to the Artillery<br/>Game might be unbalanced<br/>You can change the location by<br/>Shift+LMB<br/><br/>press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout",nameBE2]; /*AOcreated = 0;*/};
	
	if 
	(
		((posBaseW1 distance posBaseE1)<((artiRange select 1)+250)) ||
		((posBaseW1 distance posBaseE2)<((artiRange select 1)+250)) ||
		((posBaseW2 distance posBaseE1)<((artiRange select 1)+250)) ||
		((posBaseW2 distance posBaseE1)<((artiRange select 1)+250))
	) 
	exitWith {hint parseText format 
	["AO CREATED SUCCESFULY<br/><br/>
	Enemy BASES are too close<br/>
	Game might be unbalanced<br/>
	You can select another location<br/>
	And increase distance between enemy bases<br/>
	Shift+LMB<br/><br/>
	Press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout"]; /*AOcreated = 0;*/};
};

_out=false;
{
	if
	(
		(_x select 0 < 200) ||
		(_x select 0 > (worldSize - 200)) ||
		(_x select 1 < 200) ||
		(_x select 1 > (worldSize - 200))
	) then {_out=true;};
} forEach [posArti,posCas,posAA,posBaseW1,posBaseW2,posBaseE1,posBaseE2];
if(_out)then{hint parseText format [
"AO CREATED SUCCESFULY<br/><br/>
Area of operation is OUT of the map<br/>
You can select another location<br/>
LMB<br/><br/>
You can change position<br/>
of the objectives / bases<br/>
Shift+LMB<br/><br/>
To return to the Mission Generator menu<br/>
press M or ESC"
]; /*AOcreated = 0;*/};

if (AOcreated == 0) exitWith {};
