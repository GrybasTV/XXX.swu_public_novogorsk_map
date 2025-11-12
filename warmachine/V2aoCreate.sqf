/*
[_posLMB] execVM "warmachine\V2aoCreate.sqf";

if(DBG)then{};
[center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos] call BIS_fnc_findSafePos;

*/
if(AOcreated==2)exitWith{systemchat "Already searching";};

// Saugumo patikrinimas: užtikriname, kad factionW ir factionE yra apibrėžti
// Tai reikalinga, kad išvengtume klaidų, kai šie kintamieji nėra inicializuoti
if (isNil "factionW") then { factionW = "NATO"; };
if (isNil "factionE") then { factionE = "CSAT"; };

// Saugumo patikrinimas: užtikriname, kad missType yra apibrėžtas
if (isNil "missType") then { missType = 1; };

// Apibrėžiame bazės pavadinimus pagal misijos tipą (tik jei jie dar neapibrėžti)
// Tai reikalinga, nes V2startServer.sqf apibrėžia šiuos kintamuosius tik vėliau
if (isNil "nameBW1") then 
{
	if(missType==1)then
	{
		nameBW1 = format ["%1 Infantry base",factionW];
		nameBE1 = format ["%1 Infantry base",factionE];
	} else
	{
		nameBW1 = format ["%1 Armor base",factionW];
		nameBE1 = format ["%1 Armor base",factionE];
	};
};

// Apibrėžiame nameBW2 ir nameBE2 tik jei jie dar neapibrėžti
if (isNil "nameBW2") then 
{
	if(missType==1)then
	{
		nameBW2 = format ["%1 Infantry base",factionW];
		nameBE2 = format ["%1 Infantry base",factionE];
	} else
	{
		nameBW2 = format ["%1 Armor base",factionW];
		nameBE2 = format ["%1 Armor base",factionE];
	};
};

_aoSize = 1;
call
{
	if (aoSize == 0) exitWith {_aoSize = selectRandom [1, 1.5, 2];};
	if (aoSize == 1) exitWith {_aoSize = 1;};
	if (aoSize == 2) exitWith {_aoSize = 1.5;};
	if (aoSize == 3) exitWith {_aoSize = 2;};
};
systemchat format ["AO size %1",_aoSize];
_posLMB = _this select 0;
AOcreated = 2;
//delete old markers
{deleteMarkerLocal _x;} forEach aoMarkers; aoMarkers = [];
if(count aoObjs!=0)then{{deleteVehicle _x;} forEach aoObjs;}; aoObjs = [];
if(DBG && (count dbgVehs!=0))then
{
	{
		_veh=_x;
		{_veh deleteVehicleCrew _x} forEach crew _veh;
		deleteVehicle _veh;
	} forEach dbgVehs;
	dbgVehs = [];
};

//ARTILLERY
hint parseText format ["Searching for Artillery position"];
posArti = [];
_vehs=""; if(count artiW!=0)then{_vehs=artiW;}else{ _vehs=artiE;};
_vSel = selectRandom _vehs;
_typ="";_tex="";
if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
		
if(aoType!=0)then
{
	posArti = _posLMB findEmptyPosition [0, 50, _typ];
	if(count posArti < 2)then
	{
		posArti = [_posLMB, 0, 200, 10, 0, 0.2, 0, [], [_posLMB, _posLMB]] call BIS_fnc_findSafePos;
	};
}else
{
	posArti = [_posLMB, 0, 500, 10, 0, 0.2, 0, [], [_posLMB, _posLMB]] call BIS_fnc_findSafePos;
};
//control
if(count posArti < 2)exitWith{hint parseText format ["ERROR<br/>No suitable terrain for<br/>ARTILLERY<br/>position was found<br/><br/>Select another location<br/>LMB"]; AOcreated = 0;};
if(!(posArti isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))exitWith{hint parseText format ["ERROR<br/>No suitable terrain for<br/>ARTILLERY<br/>position was found<br/><br/>Select another location<br/>LMB"]; AOcreated = 0;};

//create marker
_mrkArti = createMarkerLocal ["mArti", posArti];
_mrkArti setMarkerShapeLocal "ICON";
_mrkArti setMarkerTypeLocal "select";
_mrkArti setMarkerTextLocal "Artillery";
_mrkArti setMarkerColorLocal "ColorBlack";
aoMarkers pushBackUnique _mrkArti;

//range 0
_mrkArtiRng = createMarkerLocal ["mArtiRng0", posArti];
_mrkArtiRng setMarkerShapeLocal "ELLIPSE";
_mrkArtiRng setMarkerSizeLocal [(artiRange select 0),(artiRange select 0)];
_mrkArtiRng setMarkerColorLocal "ColorBlack";
_mrkArtiRng setMarkerBrushLocal "Border";
aoMarkers pushBackUnique _mrkArtiRng;

//range 1
_mrkArtiRng = createMarkerLocal ["mArtiRng1", posArti];
_mrkArtiRng setMarkerShapeLocal "ELLIPSE";
_mrkArtiRng setMarkerSizeLocal [(artiRange select 1),(artiRange select 1)];
_mrkArtiRng setMarkerColorLocal "ColorBlack";
_mrkArtiRng setMarkerBrushLocal "Border";
//if(modA=="CSLA")then{_mrkArtiRng setMarkerAlphaLocal 0};
aoMarkers pushBackUnique _mrkArtiRng;

systemchat "Artillery position found";

//create vehicle
if(DBG)then
{
	vehArti = createVehicle [_typ, posArti, [], 0, "NONE"];
	[z1,[[vehArti],true]] remoteExec ["addCuratorEditableObjects", 2, false];
	dbgVehs pushBackUnique vehArti;
};

//CAS - RADIO TOWER CAS
posCas=[];
_objDir1 = "Land_HelipadEmpty_F" createVehicle posArti;
aoObjs pushBackUnique _objDir1;
_objDir1 setDir random 360;

_i=0;
while {(count posCas < 2)&&(_i<36)} do
{	
	_posT = _objDir1 getRelPos [(((artiRange select 1)*_aoSize)+175), (0+10*_i)];
	if(count posCas < 2)then
	{
		posCas = [_posT, 0, 125, 10, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
	};
	if((posCas select 0==_posT select 0)&&(posCas select 1==_posT select 1))then{posCas=[];};
	_i=_i+1;
	hint parseText format ["Searching for CAS Tower position<br/>Round %1/36",_i];
};

//control
if(count posCas < 2)exitWith{hint parseText format ["ERROR<br/>No suitable terrain for<br/>CAS TOWER<br/>position was found<br/><br/>Select another location<br/>LMB"]; AOcreated = 0;};
if(!(posCas isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))exitWith{hint parseText format ["ERROR<br/>No suitable terrain for<br/>CAS TOWER<br/>position was found<br/><br/>Select another location<br/>LMB"]; AOcreated = 0;};

//create marker
_mrkCas = createMarkerLocal ["mCas", posCas];
_mrkCas setMarkerShapeLocal "ICON";
_mrkCas setMarkerTypeLocal "select";
_mrkCas setMarkerTextLocal "CAS Tower";
_mrkCas setMarkerColorLocal "ColorBlack";
aoMarkers pushBackUnique _mrkCas;

systemchat "CAS Tower position found";

//create tower
if(DBG)then
{
	vehCas = createVehicle [selectRandom tower, posCas];
	vehCas setVectorUp [0,0,1];
	[z1,[[vehCas],true]] remoteExec ["addCuratorEditableObjects", 2, false];
	dbgVehs pushBackUnique vehCas;
}; 

//AA - Anti Air
posAA=[];
_objDir1 setDir random 360;
_vehs=""; if(count aaW!=0)then{_vehs=aaW;}else{ _vehs=aaE;};
_vSel = selectRandom _vehs;
_typ="";_tex="";
if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};

_i=0;
while {(count posAA < 2)&&(_i<72)} do
{	
	_posT = _objDir1 getRelPos [(((artiRange select 1)*_aoSize)+175), (0+5*_i)];
	posAA = _posT findEmptyPosition [0, 50, _typ];
	if(count posAA < 2)then
	{
		posAA = [_posT, 0, 125, 10, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
	};
	if((posAA select 0==_posT select 0)&&(posAA select 1==_posT select 1))then{posAA=[];};
	_i=_i+1;
	hint parseText format ["Searching for Anti Air position<br/>Round %1/72",_i];
};

//control
if(count posAA < 2)exitWith{hint parseText format ["ERROR<br/>No suitable terrain for<br/>ANTI AIR<br/>position was found<br/><br/>Select another location<br/>LMB"]; AOcreated = 0;};
if(!(posAA isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))exitWith{hint parseText format ["ERROR<br/>No suitable terrain for<br/>ANTI AIR<br/>position was found<br/><br/>Select another location<br/>LMB"]; AOcreated = 0;};

//create marker
_mrkAA = createMarkerLocal ["mAA", posAA];
_mrkAA setMarkerShapeLocal "ICON";
_mrkAA setMarkerTypeLocal "select";
_mrkAA setMarkerTextLocal "Anti Air";
_mrkAA setMarkerColorLocal "ColorBlack";
aoMarkers pushBackUnique _mrkAA;

systemchat "Anti Air position found";

//create vehicle
if(DBG)then
{
	vehAA = createVehicle [_typ, posAA, [], 0, "NONE"];
	[z1,[[vehAA],true]] remoteExec ["addCuratorEditableObjects", 2, false];
	dbgVehs pushBackUnique vehAA;
};

//BASES
_posA=[];
_posB=[];
_posC=[];
_distArtiCas = posArti distance posCas;
_distArtiAA = posArti distance posAA;
_distCasAA = posCas distance posAA;

_min = selectMin [_distArtiCas,_distArtiAA,_distCasAA];
call
{
	if(_min==_distArtiCas)exitWith{_posA=posAA;_p = [posArti,posCas];_p call BIS_fnc_arrayShuffle;_posB=_p select 0;_posC=_p select 1;};
	if(_min==_distArtiAA)exitWith{_posA=posCas;_p = [posArti,posAA];_p call BIS_fnc_arrayShuffle;_posB=_p select 0;_posC=_p select 1;};
	if(_min==_distCasAA)exitWith{_posA=posArti;_p = [posCas,posAA];_p call BIS_fnc_arrayShuffle;_posB=_p select 0;_posC=_p select 1;};
};

_round = 1;

if(_round == 1) then
{
	//WEST round 1
	_d=0;
	_objDir1 setPos _posA;
	_objDir1 setDir (_posA getDir _posB);
	_objDir1 setPos (_objDir1 getRelPos [((_posA distance _posB)/2), 0]);
	if(((_objDir1 getRelPos [10, 90]) distance _posC) >= ((_objDir1 getRelPos [10, 270]) distance _posC)) then {_d=90;} else {_d=270;};
	_objDir1 setPos (_objDir1 getRelPos [(((artiRange select 1)*_aoSize)+250), _d]);
	_objDir1 setDir ((getDir _objDir1)+_d);
	
	//BASE 1 WEST
	posBaseW1=[];
	_i=0;
	while {(count posBaseW1 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir1 getRelPos [500, (105-10*_i)];
		_posT = _objDir1 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (105-10*_i)];
		posBaseW1 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseW1 < 2)then
		{
			posBaseW1 = [_posT, 0, 125, 0, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBW1,_i];
	};

	//BASE 2 WEST
	posBaseW2=[];
	_i=0;
	while {(count posBaseW2 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir1 getRelPos [500, (255+10*_i)];
		_posT = _objDir1 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (255+10*_i)];
		posBaseW2 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseW2 < 2)then
		{
			posBaseW2 = [_posT, 0, 125, 0, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBW2,_i];
	};

	//control
	if(count posBaseW1 < 2) exitWith {_round = 2;};
	if(!(posBaseW1 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 2;};
	if(count posBaseW2 < 2) exitWith {_round = 2;};
	if(!(posBaseW2 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 2;};
};

if (_round == 2) then
{
	//WEST round 2
	_round = 2;
	_d=0;
	_objDir1 setPos _posA;
	_objDir1 setDir (_posA getDir _posC);
	_objDir1 setPos (_objDir1 getRelPos [((_posA distance _posC)/2), 0]);
	if(((_objDir1 getRelPos [10, 90]) distance _posB) >= ((_objDir1 getRelPos [10, 270]) distance _posB)) then {_d=90;} else {_d=270;};
	_objDir1 setPos (_objDir1 getRelPos [(((artiRange select 1)*_aoSize)+250), _d]);
	_objDir1 setDir ((getDir _objDir1)+_d);
	
	//BASE 1 WEST
	posBaseW1=[];
	_i=0;
	while {(count posBaseW1 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir1 getRelPos [500, (105-10*_i)];
		_posT = _objDir1 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (105-10*_i)];
		posBaseW1 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseW1 < 2)then
		{
			posBaseW1 = [_posT, 0, 125, 0, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBW1,(_i+3)];
	};

	//BASE 2 WEST
	posBaseW2=[];
	_i=0;
	while {(count posBaseW2 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir1 getRelPos [500, (255+10*_i)];
		_posT = _objDir1 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (255+10*_i)];
		posBaseW2 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseW2 < 2)then
		{
			posBaseW2 = [_posT, 0, 125, 0, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBW2,(_i+3)];
	};
	
	//control
	if(count posBaseW1 < 2) exitWith {_round = 3;};
	if(!(posBaseW1 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 3;};
	if(count posBaseW2 < 2) exitWith {_round = 3;};
	if(!(posBaseW2 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 3;};
};

if(_round == 3)then{hint parseText format ["ERROR<br/>No suitable terrain for<br/>%1 BASES<br/>was found<br/><br/>Select another location<br/>LMB<br/><br/>Or select and change bases position<br/>Shift+LMB",factionW]; AOcreated = 0;};

//create marker
_mrB1W = createMarkerLocal ["mB1W", posBaseW1];
_mrB1W setMarkerShapeLocal "ICON";
_mrB1W setMarkerTypeLocal "select";
_mrB1W setMarkerTextLocal nameBW1;
_mrB1W setMarkerColorLocal colorW;
aoMarkers pushBackUnique _mrB1W;

//create marker
_mrB2W = createMarkerLocal ["mB2W", posBaseW2];
_mrB2W setMarkerShapeLocal "ICON";
_mrB2W setMarkerTypeLocal "select";
_mrB2W setMarkerTextLocal nameBW2;
_mrB2W setMarkerColorLocal colorW;
aoMarkers pushBackUnique _mrB2W;

_objDir2 = "Land_HelipadEmpty_F" createVehicle posArti;
aoObjs pushBackUnique _objDir2;
if (_round == 1) then
{
	//EAST round 1
	_d=0;
	_objDir2 setPos _posA;
	_objDir2 setDir (_posA getDir _posC);
	_objDir2 setPos (_objDir2 getRelPos [((_posA distance _posC)/2), 0]);
	if(((_objDir2 getRelPos [10, 90]) distance _posB) >= ((_objDir2 getRelPos [10, 270]) distance _posB)) then {_d=90;} else {_d=270;};
	_objDir2 setPos (_objDir2 getRelPos [(((artiRange select 1)*_aoSize)+250), _d]);
	_objDir2 setDir ((getDir _objDir2)+_d);

	//BASE 1 EAST
	posBaseE1=[];
	_i=0;
	while {(count posBaseE1 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir2 getRelPos [500, (105-10*_i)];
		_posT = _objDir2 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (105-10*_i)];
		posBaseE1 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseE1 < 2)then
		{
			posBaseE1 = [_posT, 0, 125, 0, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBE1,_i];
	};

	//BASE 2 EAST
	posBaseE2=[];
	_i=0;
	while {(count posBaseE2 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir2 getRelPos [500, (255+10*_i)];
		_posT = _objDir2 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (255+10*_i)];
		posBaseE2 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseE2 < 2)then
		{
			posBaseE2 = [_posT, 0, 125, 0, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBE2,_i];
	};
	
	//control
	if(count posBaseE1 < 2) exitWith {_round = 2;};
	if(!(posBaseE1 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 2;};
	if(count posBaseE2 < 2) exitWith {_round = 2;};
	if(!(posBaseE2 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 2;};
};

if (_round == 2) then
{
	//EAST round 2
	_d=0;
	_objDir2 setPos _posB;
	_objDir2 setDir (_posB getDir _posC);
	_objDir2 setPos (_objDir2 getRelPos [((_posB distance _posC)/2), 0]);
	if(((_objDir2 getRelPos [10, 90]) distance _posA) >= ((_objDir2 getRelPos [10, 270]) distance _posA)) then {_d=90;} else {_d=270;};
	_objDir2 setPos (_objDir2 getRelPos [(((artiRange select 1)*_aoSize)+250), _d]);
	_objDir2 setDir ((getDir _objDir2)+_d);

	//BASE 1 EAST
	posBaseE1=[];
	_i=0;
	while {(count posBaseE1 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir2 getRelPos [500, (105-10*_i)];
		_posT = _objDir2 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (105-10*_i)];
		posBaseE1 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseE1 < 2)then
		{
			posBaseE1 = [_posT, 0, 125, 22, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBE1,(_i+3)];
	};

	//BASE 2 EAST
	posBaseE2=[];
	_i=0;
	while {(count posBaseE2 < 2)&&(_i<20)} do
	{	
		//_posT = _objDir2 getRelPos [500, (255+10*_i)];
		_posT = _objDir2 getRelPos [(((artiRange select 1)*_aoSize)*0.6), (255+10*_i)];
		posBaseE2 = _posT findEmptyPosition [0, 50, (tower select 0)];
		if(count posBaseE2 < 2)then
		{
			posBaseE2 = [_posT, 0, 125, 0, 0, 0.2, 0, [], [_posT,_posT]] call BIS_fnc_findSafePos;
		};
		_i=_i+1;
		hint parseText format ["Searching for %1 position<br/>Round %2/3",nameBE2,(_i+3)];
	};
	
	//control
	if(count posBaseE1 < 2) exitWith {_round = 3;};
	if(!(posBaseE1 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 3;};
	if(count posBaseE2 < 2) exitWith {_round = 3;};
	if(!(posBaseE2 isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])) exitWith {_round = 3;};
};

if(_round == 3)then{hint parseText format ["ERROR<br/>No suitable terrain for<br/>%1 BASES<br/>was found<br/><br/>Select another location<br/>LMB<br/><br/>Or select and change bases position<br/>Shift+LMB",factionE];};

//create marker
_mrB1E = createMarkerLocal ["mB1E", posBaseE1];
_mrB1E setMarkerShapeLocal "ICON";
_mrB1E setMarkerTypeLocal "select";
_mrB1E setMarkerTextLocal nameBE1;
_mrB1E setMarkerColorLocal colorE;
aoMarkers pushBackUnique _mrB1E;

//create marker
_mrB2E = createMarkerLocal ["mB2E", posBaseE2];
_mrB2E setMarkerShapeLocal "ICON";
_mrB2E setMarkerTypeLocal "select";
_mrB2E setMarkerTextLocal nameBE2;
_mrB2E setMarkerColorLocal colorE;
aoMarkers pushBackUnique _mrB2E;

if(_round == 3)exitWith{AOcreated = 0;};
systemchat "Bases positions found";

//control
if 
(
	((posBaseW1 distance posBaseE1)<((artiRange select 1)+250)) ||
	((posBaseW1 distance posBaseE2)<((artiRange select 1)+250)) ||
	((posBaseW2 distance posBaseE1)<((artiRange select 1)+250)) ||
	((posBaseW2 distance posBaseE1)<((artiRange select 1)+250))
) 
exitWith {hint parseText format ["ERROR<br/>Enemy BASES are too close<br/><br/>Select another location<br/>LMB<br/><br/>Or increase distance between enemy bases<br/>Shift+LMB"]; AOcreated = 0;};

//respawn positions
#include "V2aoRespawn.sqf";

_out=false;
{
	if
	(
		(_x select 0 < 200) ||
		(_x select 0 > (worldSize - 200)) ||
		(_x select 1 < 200) ||
		(_x select 1 > (worldSize - 200))
	) then 
	{_out=true;};
} forEach [posArti,posCas,posAA,posBaseW1,posBaseW2,posBaseE1,posBaseE2];
if(_out)exitWith{hint parseText format ["ERROR<br/>Area of operation is OUT of the map<br/><br/>Select another location<br/>LMB<br/><br/>Or change position of the objectives / bases<br/>Shift+LMB"]; AOcreated = 0;};

hint parseText format 
["
	AO CREATED SUCCESFULY <br/><br/>
	Press M or ESC<br/>
	To return to the Mission Generator menu<br/><br/>
	Press LMB<br/>
	If you want to create a new layout<br/><br/>
	Press Shift+LMB<br/>
	To select any sector and change its location
"];
AOcreated = 1;
//end 
//if(DBG)then{_p=posBaseW1; if(side player==sideE)then{_p=posBaseE1;};player setPos [_p select 0,(_p select 1)-20];};
