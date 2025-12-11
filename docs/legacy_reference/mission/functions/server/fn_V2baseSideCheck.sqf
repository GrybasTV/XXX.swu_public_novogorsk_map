//hide vehicle if the base is captured by the enemy or base is revealed and enemy is closer then 250m
//init.sqf, V2startServer.sqf (vehicles init), V2sectorUpdate.sqf
_veh=_this select 0;

call
{
	_eBW1=false;
	{
		_unit=_x;
		if (side _unit==sideE) then
		{
			if (_unit distance posBaseW1 < 250) then {_eBW1=true;};
		};
	}  forEach allUnits;	
	if(
		(_veh distance posBaseW1<160)&&
		((getMarkerColor resFobW=="")||
		(secBW1 && _eBW1)) 
	) exitWith {_veh hideObjectGlobal  true, hideVehBW1 pushBackUnique _veh;};
	
	_eBW2=false;
	{
		_unit=_x;
		if (side _unit==sideE) then
		{
			if (_unit distance posBaseW2 < 250) then {_eBW2=true;};
		};
	}  forEach allUnits;
	if (
		(_veh distance posBaseW2<160)&&
		((getMarkerColor resBaseW=="")||
		(secBW2 && _eBW2))
	) exitWith {_veh hideObjectGlobal  true, hideVehBW2 pushBackUnique _veh;};
	
	_eBE1=false;
	{
		_unit=_x;
		if (side _unit==sideW) then
		{
			if (_unit distance posBaseE1 < 250) then {_eBE1=true;};
		};
	}  forEach allUnits;
	if (
	(_veh distance posBaseE1<160)&&
	((getMarkerColor resFobE=="")||
	(secBE1 && _eBE1)) 
	) exitWith {_veh hideObjectGlobal  true, hideVehBE1 pushBackUnique _veh;};
	
	_eBE2=false;
	{
		_unit=_x;
		if (side _unit==sideW) then
		{
			if (_unit distance posBaseE2 < 250) then {_eBE2=true;};
		};
	}  forEach allUnits;
	if (
		(_veh distance posBaseE2<160)&&
		((getMarkerColor resBaseE=="")||
		(secBE2 && _eBE2)) 
	) exitWith {_veh hideObjectGlobal  true, hideVehBE2 pushBackUnique _veh;};
};