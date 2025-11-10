/*
[] execVM "warmachine\V2aoRespawn.sqf";
*/

//INFANTRY RESPAWN
hint "Searching for infantry respawn positions";

{deleteMarkerLocal _x;} forEach resMarkers; resMarkers = [];
resArtiW=[];resArtiE=[];resCasW=[];resCasE=[];resAAW=[];resAAE=[];resBaseW1W=[];resBaseW1E=[];resBaseW2W=[];resBaseW2E=[];resBaseE1W=[];resBaseE1E=[];resBaseE2W=[];resBaseE2E=[];

{
	_posS = _x;
	_resW = [];
	_resE = [];

	_objDir = "Land_HelipadEmpty_F" createVehicle _posS;

	//WEST
	_objDir setDir selectRandom [(posBaseE1 getDir posBaseW1),(posBaseE2 getDir posBaseW2)];
	//round 1 west
	{
		_p = (_objDir getRelPos [200,_x]) findEmptyPosition [0, 25, "B_soldier_F"];
		if(count _p != 0)then{if(_p isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])then{_resW pushBackUnique _p;};};
	} forEach [330,345,0,15,30];
	//2nd round
	if(count _resW<5)then
	{
		{
			_p = (_objDir getRelPos [200,_x]) findEmptyPosition [0, 25, "B_soldier_F"];
			if(count _p != 0)then{if(_p isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])then{_resW pushBackUnique _p;};};
		} forEach [45,60,75];
	};
	//3nd round
	if(count _resW<5)then
	{
		{
			_p = (_objDir getRelPos [200,_x]) findEmptyPosition [0, 25, "B_soldier_F"];
			if(count _p != 0)then{if(_p isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])then{_resW pushBackUnique _p;};};
		} forEach [315,300,285];
	};

	//EAST
	_objDir setDir ((getDir _objDir)+180);
	//round 1 west
	{
		_p = (_objDir getRelPos [200,_x]) findEmptyPosition [0, 25, "B_soldier_F"];
		if(count _p != 0)then{if(_p isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])then{_resE pushBackUnique _p;};};
	} forEach [330,345,0,15,30];
	//2nd round
	if(count _resE<5)then
	{
		{
			_p = (_objDir getRelPos [200,_x]) findEmptyPosition [0, 25, "B_soldier_F"];
			if(count _p != 0)then{if(_p isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])then{_resE pushBackUnique _p;};};
		} forEach [45,60,75];
	};
	//3nd round
	if(count _resE<5)then
	{
		{
			_p = (_objDir getRelPos [200,_x]) findEmptyPosition [0, 25, "B_soldier_F"];
			if(count _p != 0)then{if(_p isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo [])then{_resE pushBackUnique _p;};};
		} forEach [315,300,285];
	};

	deleteVehicle _objDir;

		{
			_n = format ["m%1",(floor(_x select 0))];
			_mrk = createMarkerLocal [_n, _x];
			_mrk setMarkerShapeLocal "ELLIPSE";
			_mrk setMarkerSizeLocal [5,5];
			_mrk setMarkerColorLocal colorW;
			resMarkers pushBackUnique _mrk;
		} forEach _resW;
		{
			_n = format ["m%1",(floor(_x select 0))];
			_mrk = createMarkerLocal [_n, _x];
			_mrk setMarkerShapeLocal "ELLIPSE";
			_mrk setMarkerSizeLocal [5,5];
			_mrk setMarkerColorLocal colorE;
			resMarkers pushBackUnique _mrk;
		} forEach _resE;

	call
	{
		if((_posS select 0)==(posArti select 0))exitWith{resArtiW=_resW; resArtiE=_resE;};
		if((_posS select 0)==(posCas select 0))exitWith{resCasW=_resW; resCasE=_resE;};
		if((_posS select 0)==(posAA select 0))exitWith{resAAW=_resW; resAAE=_resE;};
		if((_posS select 0)==(posBaseW1 select 0))exitWith{resBaseW1W=_resW; resBaseW1E=_resE;};
		if((_posS select 0)==(posBaseW2 select 0))exitWith{resBaseW2W=_resW; resBaseW2E=_resE;};
		if((_posS select 0)==(posBaseE1 select 0))exitWith{resBaseE1W=_resW; resBaseE1E=_resE;};
		if((_posS select 0)==(posBaseE2 select 0))exitWith{resBaseE2W=_resW; resBaseE2E=_resE;};
	};
} forEach [posArti,posCas,posAA,posBaseW1,posBaseW2,posBaseE1,posBaseE2];

//control
if ((count resArtiW == 0)||(count resArtiE == 0)) exitWith {hint parseText format ["ERROR<br/>No suitable respawn positions for<br/>ARTILLERY<br/>were found<br/><br/>Select another location<br/>Shift+LMB"]; AOcreated = 0;};
if ((count resCasW == 0)||(count resCasE == 0)) exitWith {hint parseText format ["ERROR<br/>No suitable respawn positions for<br/>CAS TOWER<br/>were found<br/><br/>Select another location<br/>Shift+LMB"]; AOcreated = 0;};
if ((count resAAW == 0)||(count resAAE == 0)) exitWith {hint parseText format ["ERROR<br/>No suitable respawn positions for<br/>ANTI AIR<br/>were found<br/><br/>Select another location<br/>Shift+LMB"]; AOcreated = 0;};
if ((count resBaseW1W == 0)||(count resBaseW1E == 0)) exitWith {hint parseText format ["No suitable respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBW1]; AOcreated = 0;};
if ((count resBaseW2W == 0)||(count resBaseW2E == 0)) exitWith {hint parseText format ["No suitable respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBW2]; AOcreated = 0;};
if ((count resBaseE1W == 0)||(count resBaseE1E == 0)) exitWith {hint parseText format ["No suitable respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBE1]; AOcreated = 0;};
if ((count resBaseE2W == 0)||(count resBaseE2E == 0)) exitWith {hint parseText format ["No suitable respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBE2]; AOcreated = 0;};

systemchat "Infantry respawn positions found";

//VEHICLES RESPAWN
//WEST BASE 1
rBikeW = []; rTruckW = []; rHeliTrW = []; rCarArW = []; rCarW = []; rArmorW1 = []; rHeliArW = []; rArmorW2 = [];

_objDir = "Land_HelipadEmpty_F" createVehicle posBaseW1;
aoObjs pushBackUnique _objDir;
_objDir setDir ((selectRandom [(posBaseE1 getDir posBaseW1),(posBaseE2 getDir posBaseW2)])-60);
dirBW = ((getDir _objDir)-120);
_i=0;
_markers = [];
{
	if (count _x>0) then
	{
		_vSel = _x select 0;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
		
		_res = [];
		while {(count _res < 2)&&(_i<12)} do
		{	
			_posT = _objDir getRelPos [50,(0+30*_i)];	
			_res = _posT findEmptyPosition [0, 25, _typ];
			_i=_i+1;
			hint parseText format ["Searching for vehicle respawn position at<br/>%1<br/>Round %2/12",nameBW1,_i];
			//control
			if(count _res != 0)then{if ((_res isFlatEmpty  [-1, -1, 0.45, 5, -1, false] isEqualTo [])||(!(_res isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))) then {_res = [];};};
		};
		if(count _res < 2)then
		{
			_posT = _objDir getRelPos [35,(0+10*_i)];
			_res = [posBaseW1, 25, 200, 0, 0, 0.5, 0, _markers, [_posT, _posT]] call BIS_fnc_findSafePos;
		};
		
		_Bike=""; _veh=BikeW select 0;  if (_veh isEqualType [])then{_Bike=_veh select 0;}else{_Bike=_veh;};
		_Car=""; _veh=CarW select 0;  if (_veh isEqualType [])then{_Car=_veh select 0;}else{_Car=_veh;};
		_CarAr=""; _veh=CarArW select 0;  if (_veh isEqualType [])then{_CarAr=_veh select 0;}else{_CarAr=_veh;};
		_Truck=""; _veh=TruckW select 0;  if (_veh isEqualType [])then{_Truck=_veh select 0;}else{_Truck=_veh;};
		_Armor1=""; _veh=ArmorW1 select 0;  if (_veh isEqualType [])then{_Armor1=_veh select 0;}else{_Armor1=_veh;};
		_Armor2=""; _veh=ArmorW2 select 0;  if (_veh isEqualType [])then{_Armor2=_veh select 0;}else{_Armor2=_veh;};
		_HeliTr=""; if (count HeliTrW>0) then {_veh=HeliTrW select 0;  if (_veh isEqualType [])then{_HeliTr=_veh select 0;}else{_HeliTr=_veh;};};
		_HeliAr=""; if (count HeliArW>0) then {_veh=HeliArW select 0;  if (_veh isEqualType [])then{_HeliAr=_veh select 0;}else{_HeliAr=_veh;};};
		
		call
		{
			if(_typ==_Bike)exitWith{rBikeW pushBackUnique _res;};
			if(_typ==_Car)exitWith{rCarW pushBackUnique _res;};
			if(_typ==_CarAr)exitWith{rCarArW pushBackUnique _res;};
			if(_typ==_Truck)exitWith{rTruckW pushBackUnique _res;};
			if(_typ==_Armor1)exitWith{rArmorW1 pushBackUnique _res;};
			if(_typ==_Armor2)exitWith{rArmorW2 pushBackUnique _res;};
			if(_typ==_HeliTr)exitWith{rHeliTrW pushBackUnique _res;};
			if(_typ==_HeliAr)exitWith{rHeliArW pushBackUnique _res;};
		};
		
		//blacklist marker(s) for findSafePos
		_n = format ["bw1%1%2",_typ,(round (_res select 0))];
		_mrk = createMarkerLocal [_n, _res];
		_mrk setMarkerShapeLocal "ELLIPSE";
		_mrk setMarkerSizeLocal [16,16];
		_mrk setMarkerColorLocal colorW;
		_markers pushBackUnique _mrk;
		resMarkers pushBackUnique _mrk;
		
		if(DBG)then
		{
			_vehicle = createVehicle [_typ,[_res select 0, _res select 1, 1], [], 0, "NONE"];
			[_vehicle,[_tex,1]] call bis_fnc_initVehicle;
			_vehicle setDir ((getDir _objDir)-120);
			dbgVehs pushBackUnique _vehicle;
		};
	};	
} forEach [BikeW,CarW,CarArW,TruckW];

//control
{
	_m=_x;
	{if (((getMarkerPos _m) distance (getMarkerPos _x) < 16)&&(_m!=_x)) then {AOcreated = 0;};} forEach _markers;
} forEach _markers;
{_x setMarkerSizeLocal [8,8];} forEach _markers;
if (AOcreated == 0) exitWith {hint parseText format ["ERROR<br/>No suitable vehicle respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBW1];};

systemchat format ["Vehicle respawn position for %1 found",nameBW1];
//WEST BASE 2
_objDir setPos posBaseW2;
_i=0;
_markers = [];
{
	if (count _x>0) then
	{
		_vSel = _x select 0;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
		
		_res = [];
		while {(count _res < 2)&&(_i<12)} do
		{	
			_posT = _objDir getRelPos [50,(0+30*_i)];	
			_res = _posT findEmptyPosition [0, 25, _typ];
			_i=_i+1;
			hint parseText format ["Searching for vehicle respawn position at<br/>%1<br/>Round %2/12",nameBW2,_i];
			//control
			if(count _res != 0)then{if ((_res isFlatEmpty  [-1, -1, 0.45, 5, -1, false] isEqualTo [])||(!(_res isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))) then {_res = [];};};
		};
		if(count _res < 2)then
		{
			_posT = _objDir getRelPos [35,(0+10*_i)];
			_res = [posBaseW2, 25, 200, 0, 0, 0.5, 0, _markers, [_posT, _posT]] call BIS_fnc_findSafePos;
		};
		
		_Bike=""; _veh=BikeW select 0;  if (_veh isEqualType [])then{_Bike=_veh select 0;}else{_Bike=_veh;};
		_Car=""; _veh=CarW select 0;  if (_veh isEqualType [])then{_Car=_veh select 0;}else{_Car=_veh;};
		_CarAr=""; _veh=CarArW select 0;  if (_veh isEqualType [])then{_CarAr=_veh select 0;}else{_CarAr=_veh;};
		_Truck=""; _veh=TruckW select 0;  if (_veh isEqualType [])then{_Truck=_veh select 0;}else{_Truck=_veh;};
		_Armor1=""; _veh=ArmorW1 select 0;  if (_veh isEqualType [])then{_Armor1=_veh select 0;}else{_Armor1=_veh;};
		_Armor2=""; _veh=ArmorW2 select 0;  if (_veh isEqualType [])then{_Armor2=_veh select 0;}else{_Armor2=_veh;};
		_HeliTr=""; if (count HeliTrW>0) then {_veh=HeliTrW select 0;  if (_veh isEqualType [])then{_HeliTr=_veh select 0;}else{_HeliTr=_veh;};};
		_HeliAr=""; if (count HeliArW>0) then {_veh=HeliArW select 0;  if (_veh isEqualType [])then{_HeliAr=_veh select 0;}else{_HeliAr=_veh;};};
		
		call
		{
			if(_typ==_Bike)exitWith{rBikeW pushBackUnique _res;};
			if(_typ==_Car)exitWith{rCarW pushBackUnique _res;};
			if(_typ==_CarAr)exitWith{rCarArW pushBackUnique _res;};
			if(_typ==_Truck)exitWith{rTruckW pushBackUnique _res;};
			if(_typ==_Armor1)exitWith{rArmorW1 pushBackUnique _res;};
			if(_typ==_Armor2)exitWith{rArmorW2 pushBackUnique _res;};
			if(_typ==_HeliTr)exitWith{rHeliTrW pushBackUnique _res;};
			if(_typ==_HeliAr)exitWith{rHeliArW pushBackUnique _res;};
		};
		
		//blacklist marker(s) for findSafePos
		_n = format ["bw2%1%2",_typ,(round (_res select 0))];
		_mrk = createMarkerLocal [_n, _res];
		_mrk setMarkerShapeLocal "ELLIPSE";
		_mrk setMarkerSizeLocal [16,16];
		_mrk setMarkerColorLocal colorW;
		_markers pushBackUnique _mrk;
		resMarkers pushBackUnique _mrk;
		
		if(DBG)then
		{
			_vehicle = createVehicle [_typ,[_res select 0, _res select 1, 1], [], 0, "NONE"];
			[_vehicle,[_tex,1]] call bis_fnc_initVehicle;
			_vehicle setDir ((getDir _objDir)-120);
			dbgVehs pushBackUnique _vehicle;
		};
	};
} forEach [HeliTrW,ArmorW1,ArmorW2,CarW];

//control
{
	_m=_x;
	{if (((getMarkerPos _m) distance (getMarkerPos _x) < 16)&&(_m!=_x)) then {AOcreated = 0;};} forEach _markers;
} forEach _markers;
{_x setMarkerSizeLocal [8,8];} forEach _markers;
if (AOcreated == 0) exitWith {hint parseText format ["ERROR<br/>No suitable vehicle respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBW2];};

systemchat format ["Vehicle respawn position for %1 found",nameBW2];

//EAST BASE 1
rBikeE = []; rTruckE = []; rHeliTrE = []; rCarArE = []; rCarE = []; rArmorE1 = []; rHeliArE = []; rArmorE2 = [];

_objDir setPos posBaseE1;
_objDir setDir ((selectRandom [(posBaseW1 getDir posBaseE1),(posBaseW2 getDir posBaseE2)])-60);
dirBE = ((getDir _objDir)-120);
_i=0;
_markers = [];
{
	if (count _x>0) then
	{
		_vSel = _x select 0;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
		
		_res = [];
		while {(count _res < 2)&&(_i<12)} do
		{	
			_posT = _objDir getRelPos [50,(0+30*_i)];	
			_res = _posT findEmptyPosition [0, 25, _typ];
			_i=_i+1;
			hint parseText format ["Searching for vehicle respawn position at<br/>%1<br/>Round %2/12",nameBE1,_i];
			//control
			if(count _res != 0)then{if ((_res isFlatEmpty  [-1, -1, 0.45, 5, -1, false] isEqualTo [])||(!(_res isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))) then {_res = [];};};
		};
		if(count _res < 2)then
		{
			_posT = _objDir getRelPos [35,(0+10*_i)];
			_res = [posBaseE1, 25, 200, 0, 0, 0.5, 0, _markers, [_posT, _posT]] call BIS_fnc_findSafePos;
		};
		
		_Bike=""; _veh=BikeE select 0;  if (_veh isEqualType [])then{_Bike=_veh select 0;}else{_Bike=_veh;};
		_Car=""; _veh=CarE select 0;  if (_veh isEqualType [])then{_Car=_veh select 0;}else{_Car=_veh;};
		_CarAr=""; _veh=CarArE select 0;  if (_veh isEqualType [])then{_CarAr=_veh select 0;}else{_CarAr=_veh;};
		_Truck=""; _veh=TruckE select 0;  if (_veh isEqualType [])then{_Truck=_veh select 0;}else{_Truck=_veh;};
		_Armor1=""; _veh=ArmorE1 select 0;  if (_veh isEqualType [])then{_Armor1=_veh select 0;}else{_Armor1=_veh;};
		_Armor2=""; _veh=ArmorE2 select 0;  if (_veh isEqualType [])then{_Armor2=_veh select 0;}else{_Armor2=_veh;};
		_HeliTr=""; if (count HeliTrE>0) then {_HeliTr=""; _veh=HeliTrE select 0;  if (_veh isEqualType [])then{_HeliTr=_veh select 0;}else{_HeliTr=_veh;};};
		_HeliAr=""; if (count HeliArE>0) then {_veh=HeliArE select 0;  if (_veh isEqualType [])then{_HeliAr=_veh select 0;}else{_HeliAr=_veh;};};

		call
		{
			if(_typ==_Bike)exitWith{rBikeE pushBackUnique _res;};
			if(_typ==_Car)exitWith{rCarE pushBackUnique _res;};
			if(_typ==_CarAr)exitWith{rCarArE pushBackUnique _res;};
			if(_typ==_Truck)exitWith{rTruckE pushBackUnique _res;};
			if(_typ==_Armor1)exitWith{rArmorE1 pushBackUnique _res;};
			if(_typ==_Armor2)exitWith{rArmorE2 pushBackUnique _res;};
			if(_typ==_HeliTr)exitWith{rHeliTrE pushBackUnique _res;};
			if(_typ==_HeliAr)exitWith{rHeliArE pushBackUnique _res;};	
		};
		
		//blacklist marker(s) for findSafePos
		_n = format ["be1%1%2",_typ,(round (_res select 0))];
		_mrk = createMarkerLocal [_n, _res];
		_mrk setMarkerShapeLocal "ELLIPSE";
		_mrk setMarkerSizeLocal [16,16];
		_mrk setMarkerColorLocal colorE;
		_markers pushBackUnique _mrk;
		resMarkers pushBackUnique _mrk;
		
		if(DBG)then
		{
			_vehicle = createVehicle [_typ,[_res select 0, _res select 1, 1], [], 0, "NONE"];
			[_vehicle,[_tex,1]] call bis_fnc_initVehicle;
			_vehicle setDir ((getDir _objDir)-120);
			dbgVehs pushBackUnique _vehicle;
		};
	};
} forEach [BikeE,CarE,CarArE,TruckE];

//control
{
	_m=_x;
	{if (((getMarkerPos _m) distance (getMarkerPos _x) < 16)&&(_m!=_x)) then {AOcreated = 0;};} forEach _markers;
} forEach _markers;
{_x setMarkerSizeLocal [8,8];} forEach _markers;
if (AOcreated == 0) exitWith {hint parseText format ["ERROR<br/>No suitable vehicle respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBE1];};

systemchat format ["Vehicle respawn position for %1 found",nameBE1];

//EAST BASE 2
_objDir setPos posBaseE2;
_i=0;
_markers = [];
{
	if (count _x>0) then
	{
		_vSel = _x select 0;
		_typ="";_tex="";
		if (_vSel isEqualType [])then{_typ=_vSel select 0;_tex=_vSel select 1;}else{_typ=_vSel;};
		
		_res = [];
		while {(count _res < 2)&&(_i<12)} do
		{	
			_posT = _objDir getRelPos [50,(0+30*_i)];	
			_res = _posT findEmptyPosition [0, 25, _typ];
			_i=_i+1;
			hint parseText format ["Searching for vehicle respawn position at<br/>%1<br/>Round %2/12",nameBE2,_i];
			//control
			if(count _res != 0)then{if ((_res isFlatEmpty  [-1, -1, 0.45, 5, -1, false] isEqualTo [])||(!(_res isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []))) then {_res = [];};};
		};
		if(count _res < 2)then
		{
			_posT = _objDir getRelPos [35,(0+10*_i)];
			_res = [posBaseE2, 25, 200, 0, 0, 0.5, 0, _markers, [_posT, _posT]] call BIS_fnc_findSafePos;
		};

		_Bike=""; _veh=BikeE select 0;  if (_veh isEqualType [])then{_Bike=_veh select 0;}else{_Bike=_veh;};
		_Car=""; _veh=CarE select 0;  if (_veh isEqualType [])then{_Car=_veh select 0;}else{_Car=_veh;};
		_CarAr=""; _veh=CarArE select 0;  if (_veh isEqualType [])then{_CarAr=_veh select 0;}else{_CarAr=_veh;};
		_Truck=""; _veh=TruckE select 0;  if (_veh isEqualType [])then{_Truck=_veh select 0;}else{_Truck=_veh;};
		_Armor1=""; _veh=ArmorE1 select 0;  if (_veh isEqualType [])then{_Armor1=_veh select 0;}else{_Armor1=_veh;};
		_Armor2=""; _veh=ArmorE2 select 0;  if (_veh isEqualType [])then{_Armor2=_veh select 0;}else{_Armor2=_veh;};
		_HeliTr=""; if (count HeliTrE>0) then {_HeliTr=""; _veh=HeliTrE select 0;  if (_veh isEqualType [])then{_HeliTr=_veh select 0;}else{_HeliTr=_veh;};};
		_HeliAr=""; if (count HeliArE>0) then {_veh=HeliArE select 0;  if (_veh isEqualType [])then{_HeliAr=_veh select 0;}else{_HeliAr=_veh;};};

		call
		{
			if(_typ==_Bike)exitWith{rBikeE pushBackUnique _res;};
			if(_typ==_Car)exitWith{rCarE pushBackUnique _res;};
			if(_typ==_CarAr)exitWith{rCarArE pushBackUnique _res;};
			if(_typ==_Truck)exitWith{rTruckE pushBackUnique _res;};
			if(_typ==_Armor1)exitWith{rArmorE1 pushBackUnique _res;};
			if(_typ==_Armor2)exitWith{rArmorE2 pushBackUnique _res;};
			if(_typ==_HeliTr)exitWith{rHeliTrE pushBackUnique _res;};
			if(_typ==_HeliAr)exitWith{rHeliArE pushBackUnique _res;};	
		};
		
		//blacklist marker(s) for findSafePos
		_n = format ["be2%1%2",_typ,(round (_res select 0))];
		_mrk = createMarkerLocal [_n, _res];
		_mrk setMarkerShapeLocal "ELLIPSE";
		_mrk setMarkerSizeLocal [16,16];
		_mrk setMarkerColorLocal colorE;
		_markers pushBackUnique _mrk;
		resMarkers pushBackUnique _mrk;
		
		if(DBG)then
		{
			_vehicle = createVehicle [_typ,[_res select 0, _res select 1, 1], [], 0, "NONE"];
			[_vehicle,[_tex,1]] call bis_fnc_initVehicle;
			_vehicle setDir ((getDir _objDir)-120);
			dbgVehs pushBackUnique _vehicle;
		};
	};
} forEach [HeliTrE,ArmorE1,ArmorE2,CarE];


//control
{
	_m=_x;
	{if (((getMarkerPos _m) distance (getMarkerPos _x) < 16)&&(_m!=_x)) then {AOcreated = 0;};} forEach _markers;
} forEach _markers;
{_x setMarkerSizeLocal [8,8];} forEach _markers;
if (AOcreated == 0) exitWith {hint parseText format ["ERROR<br/>No suitable vehicle respawn positions for<br/>%1<br/>were found<br/><br/>Select another location<br/>Shift+LMB",nameBE2];};

systemchat format ["Vehicle respawn position for %1 found",nameBE2];















