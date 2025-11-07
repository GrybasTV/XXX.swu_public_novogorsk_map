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
for "_i" from 0 to 1 step 0 do 
{
	sleep 30; //30 sec default

	//OPTIMIZACIJA: Naudoti allUnits tik vieną kartą ir išsaugoti rezultatą
	//Tai yra labai svarbu, nes allUnits yra labai lėta komanda, kuri skenuoja VISUS objektus žaidime
	//Jei naudojame ją 4 kartus per ciklą, tai sukuria didžiulę apkrovą ir gali sukelti "No alive" timeout'us
	private _allUnits = allUnits; //Saugoti masyvą, kad nereikėtų kviesti allUnits kelis kartus
	
	_eBW1=true;
	{
		_unit=_x;
		if (side _unit==sideE) then
		{
			if (_unit distance posBaseW1 < 250) then {_eBW1=false;};
		};
	}  forEach _allUnits;
	if((getMarkerColor resFobW!="")&&(_eBW1))
	then{
		{_x hideObjectGlobal false,} forEach hideVehBW1;
		hideVehBW1=[];
	};
	
	_eBW2=true;
	{
		_unit=_x;
		if (side _unit==sideE) then
		{
			if (_unit distance posBaseW2 < 250) then {_eBW2=false;};
		};
	}  forEach _allUnits;
	if((getMarkerColor resBaseW!="")&&(_eBW2))
	then{
		{_x hideObjectGlobal false,} forEach hideVehBW2;
		hideVehBW2=[];
	};
	
	_eBE1=true;
	{
		_unit=_x;
		if (side _unit==sideW) then
		{
			if (_unit distance posBaseE1 < 250) then {_eBE1=false;};
		};
	}  forEach _allUnits;	
	if((getMarkerColor resFobE!="")&&(_eBE1))
	then{
		{_x hideObjectGlobal false,} forEach hideVehBE1;
		hideVehBE1=[];
	};	

	_eBE2=true;
	{
		_unit=_x;
		if (side _unit==sideW) then
		{
			if (_unit distance posBaseE2 < 250) then {_eBE2=false;};
		};
	}  forEach _allUnits;	
	if((getMarkerColor resBaseE!="")&&(_eBE2))
	then{
		{_x hideObjectGlobal false,} forEach hideVehBE2;
		hideVehBE2=[];
	};		
};