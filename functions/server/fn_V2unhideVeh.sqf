/*
	Author: IvosH
	
	Description:
		LOOP, Unhide empty vehicles at the base, if base is not under attack
		
	Parameter(s):
		NONE
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		
	Execution:
		[] spawn wrm_fnc_V2unhideVeh;
*/

//infinite loop
// Optimizuota: allUnits gaunamas vieną kartą per ciklą, o ne 4 kartus
// Tai sumažina našumo apkrovą, ypač kai allUnits masyvas yra didelis
for "_i" from 0 to 1 step 0 do 
{
	sleep 30; //30 sec default

	// Gauname allUnits vieną kartą ir filtruojame pagal šalis
	// Tai efektyviau nei kiekvieną kartą eiti per visą allUnits masyvą
	_allUnits = allUnits;
	_enemyUnitsW = []; // Priešo vienetai prieš West bazę
	_enemyUnitsE = []; // Priešo vienetai prieš East bazę
	
	// Filtruojame vienetus pagal šalis vieną kartą
	{
		_unit = _x;
		if (side _unit == sideE) then {
			_enemyUnitsW pushBack _unit;
		};
		if (side _unit == sideW) then {
			_enemyUnitsE pushBack _unit;
		};
	} forEach _allUnits;

	// Tikriname Base West 1
	_eBW1 = true;
	{
		if (_x distance posBaseW1 < 250) then {
			_eBW1 = false;
		};
	} forEach _enemyUnitsW;
	if((getMarkerColor resFobW!="")&&(_eBW1))
	then{
		{_x hideObjectGlobal false;} forEach hideVehBW1;
		hideVehBW1=[];
	};
	
	// Tikriname Base West 2
	_eBW2 = true;
	{
		if (_x distance posBaseW2 < 250) then {
			_eBW2 = false;
		};
	} forEach _enemyUnitsW;
	if((getMarkerColor resBaseW!="")&&(_eBW2))
	then{
		{_x hideObjectGlobal false;} forEach hideVehBW2;
		hideVehBW2=[];
	};
	
	// Tikriname Base East 1
	_eBE1 = true;
	{
		if (_x distance posBaseE1 < 250) then {
			_eBE1 = false;
		};
	} forEach _enemyUnitsE;	
	if((getMarkerColor resFobE!="")&&(_eBE1))
	then{
		{_x hideObjectGlobal false;} forEach hideVehBE1;
		hideVehBE1=[];
	};	

	// Tikriname Base East 2
	_eBE2 = true;
	{
		if (_x distance posBaseE2 < 250) then {
			_eBE2 = false;
		};
	} forEach _enemyUnitsE;	
	if((getMarkerColor resBaseE!="")&&(_eBE2))
	then{
		{_x hideObjectGlobal false;} forEach hideVehBE2;
		hideVehBE2=[];
	};		
};