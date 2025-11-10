/*
	Author: IvosH
	
	Description:
		Create holes in the fortification (Weferlingen border etc.)
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		start.sqf
		
	Execution:
		[] execVM "warmachine\clearFences.sqf";
*/

if(island == "WEFERLINGEN")then
{
	_dst=minDis;
	if(version==1)then
	{
		_dstW=posCenter distance posBaseWest;
		_dstE=posCenter distance posBaseEast;
		if (_dstW>_dstE) then {_dst=_dstW;} else {_dst=_dstE;};
	};
	
	_obj=nearestTerrainObjects [posCenter, [], _dst]; //all terrain objects
	
	_aoFnc=[]; //all fences in the AO
	{if 
	(
		typeof _x=="land_gm_fence_border_gz1_600" ||
		(format ["%1",_x]) find "gm_fence_border_gssz_70_600" >= 0
	) then {_aoFnc pushBackUnique _x;}} forEach _obj;

	_n=count _aoFnc;
	_hole=[]; //positons of holes in the fences

	for "_i" from 0 to _n step (ceil _n/100) do
	{
		_hole pushBackUnique (getPos (_aoFnc select _i));
	};

	{
		_p=_x;
		
		//ploty
		_objHole=nearestTerrainObjects [_p, [], 4];
		_fence=[]; //objects to delete
		{if 
		(
			typeof _x=="land_gm_fence_border_gz1_600" ||
			(format ["%1",_x]) find "gm_fence_border_gssz_70_600" >= 0
		) then {_fence pushBackUnique _x;}} forEach _objHole;
		
		//draty
		_objHole=nearestTerrainObjects [_p, [], 8];
		{if 
		(
			typeof _x=="land_gm_gc_g501_sm70_01"||
			typeof _x=="land_gm_gc_g501_sm70_02"||
			typeof _x=="land_gm_gc_g501_sm70_03"||
			typeof _x=="land_gm_gc_g501_sm70_04"
		) then {_fence pushBackUnique _x;}} forEach _objHole;	

		//valy
		_objHole=nearestTerrainObjects [_p, [], 100];
		{if 
		(
			typeof _x=="land_gm_wall_vehicleditch_700"||
			typeof _x=="land_gm_wall_vehicleditch_700_win"
		) then {_fence pushBackUnique _x;}} forEach _objHole;
		
		//smazat
		{_x hideObjectGlobal true;} forEach _fence;
		/*
		//DEBUG
		_mrk = createMarkerLocal [(format ["%1",_x]), _p];
		_mrk setMarkerShapeLocal "ELLIPSE";
		_mrk setMarkerSizeLocal [8,8];
		*/
	}forEach _hole;
};

if(island == "EL ALAMEIN")then
{
/*
ww2_wire_1
ww2_bet_bwire_2
ww2_s_bruno
ww2_swu_antitank_barrier
*/
	_dst=minDis;
	if(version==1)then
	{
		_dstW=posCenter distance posBaseWest;
		_dstE=posCenter distance posBaseEast;
		if (_dstW>_dstE) then {_dst=_dstW;} else {_dst=_dstE;};
	};
	
	_obj=nearestTerrainObjects [posCenter, [], _dst]; //all terrain objects

	_aoFnc=[]; //all fences in the AO
	{if 
	(
		(format ["%1",_x]) find "ww2_wire_1" >= 0 ||
		(format ["%1",_x]) find "ww2_bet_bwire_2" >= 0 ||
		(format ["%1",_x]) find "ww2_s_bruno" >= 0 ||
		(format ["%1",_x]) find "ww2_swu_antitank_barrier" >= 0
	) then {_aoFnc pushBackUnique _x;}} forEach _obj;
	
	_n=count _aoFnc;
	_hole=[]; //positons of holes in the fences
	for "_i" from 0 to _n step (ceil _n/100) do
	{
		_hole pushBackUnique (getPos (_aoFnc select _i));
	};
	
	{		
		_p=_x;
		_objHole=nearestTerrainObjects [_p, [], 50];
		_fence=[]; //objects to delete
		{if 
		(
			(format ["%1",_x]) find "ww2_wire_1" >= 0 ||
			(format ["%1",_x]) find "ww2_bet_bwire_2" >= 0 ||
			(format ["%1",_x]) find "ww2_s_bruno" >= 0 ||
			(format ["%1",_x]) find "ww2_swu_antitank_barrier" >= 0
		) then {_fence pushBackUnique _x;}} forEach _objHole;
		{_x hideObjectGlobal true;} forEach _fence;
	}forEach _hole;
};

if(island == "OMAHA")then
{
/*
i44_barbedwire
i44_barbedwire2
i44_bwf_6_mlod
i44_ct_straight_wire
i44_hrt1
*/
	_dst=minDis;
	if(version==1)then
	{
		_dstW=posCenter distance posBaseWest;
		_dstE=posCenter distance posBaseEast;
		if (_dstW>_dstE) then {_dst=_dstW;} else {_dst=_dstE;};
	};
	
	_obj=nearestTerrainObjects [posCenter, [], _dst]; //all terrain objects

	_aoFnc=[]; //all fences in the AO
	{if 
	(
		(format ["%1",_x]) find "i44_barbedwire" >= 0 ||
		(format ["%1",_x]) find "i44_barbedwire2" >= 0 ||
		(format ["%1",_x]) find "i44_bwf_6_mlod" >= 0 ||
		(format ["%1",_x]) find "i44_ct_straight_wire" >= 0 ||
		(format ["%1",_x]) find "i44_hrt1" >= 0
	) then {_aoFnc pushBackUnique _x;}} forEach _obj;
	
	_n=count _aoFnc;
	_hole=[]; //positons of holes in the fences
	for "_i" from 0 to _n step (ceil _n/150) do
	{
		_hole pushBackUnique (getPos (_aoFnc select _i));
	};
	
	{
		_p=_x;
		_objHole=nearestTerrainObjects [_p, [], 25];
		_fence=[]; //objects to delete
		{if 
		(
			(format ["%1",_x]) find "i44_barbedwire" >= 0 ||
			(format ["%1",_x]) find "i44_barbedwire2" >= 0 ||
			(format ["%1",_x]) find "i44_bwf_6_mlod" >= 0 ||
			(format ["%1",_x]) find "i44_ct_straight_wire" >= 0 ||
			(format ["%1",_x]) find "i44_hrt1" >= 0
		) then {_fence pushBackUnique _x;}} forEach _objHole;
		{_x hideObjectGlobal true;} forEach _fence;
	}forEach _hole;
};

if(island == "GABRETA")then
{
	_dst=minDis;
	_obj=nearestTerrainObjects [position player, [], _dst, true]; //all terrain objects

	_aoFnc=[]; //all fences in the AO
	{if 
	(
		(format ["%1",_x]) find "indfnc_9_f" >= 0 ||
		(format ["%1",_x]) find "csla_border_fence" >= 0
	) then {_aoFnc pushBackUnique _x;}} forEach _obj;
	
	_n=count _aoFnc;
	_hole=[]; //positons of holes in the fences
	for "_i" from 0 to _n step (ceil _n/25) do
	{
		_hole pushBackUnique (getPos (_aoFnc select _i));
	};
	
	{
		_p=_x;
		_objHole=nearestTerrainObjects [_p, [], 15];
		_fence=[]; //objects to delete
		{if 
		(
			(format ["%1",_x]) find "indfnc_9_f" >= 0 ||
			(format ["%1",_x]) find "csla_border_fence" >= 0
		) then {_fence pushBackUnique _x;}} forEach _objHole;
		{_x hideObjectGlobal true;} forEach _fence;
	}forEach _hole;
};