/*
	Author: IvosH

	Description:
		AI use CAS

	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		
	Execution:
		[] spawn wrm_fnc_V2aiCAS;
*/
//loop
for "_i" from 0 to 1 step 0 do 
{
	//random timer
	sleep (random[(arTime/2),arTime,(arTime*2)]);
	//sleep 40;
	// Patikriname, ar yra žaidėjų su tinkama šalimi
	// Pašalintas timeout, nes jei nėra žaidėjų su tinkama šalimi, tai yra normalus scenarijus
	// (pvz., visi žaidėjai yra independent arba misija dar neprasidėjusi)
	if(count allPlayers>0)then
	{
		_t=true;
		// Tikriname tik vieną kartą, o ne cikle su timeout
		{if((side _x==sideW)||(side _x==sideE)) exitWith {_t=false;};} forEach allPlayers;
	};
	_plw={side _x==sideW} count allplayers;
	_ple={side _x==sideE} count allplayers;
	_nlW=true;
	{if((side _x==sideW)&&(_x==leader _x)) then {_nlW=false;};} forEach allPlayers;
	_nlE=true;
	{if((side _x==sideE)&&(_x==leader _x)) then {_nlE=false;};} forEach allPlayers;
	
	//call
	//{	
		if((_plw==0)||((_plw>0)&&_nlW))then
		{
			if(getMarkerColor resCW!="")then
			{
				_tar=[];
				
				// Optimizuota: gauname allUnits vieną kartą ir filtruojame pagal šalis
				_allUnits = allUnits;
				_friendlyUnitsW = [];
				{
					if (side _x == sideW) then {
						_friendlyUnitsW pushBack _x;
					};
				} forEach _allUnits;

				//Artillery
				if(alive objArtiE)then
				{
					_fr=[];
					{if((_x distance posArti)<75)then{_fr pushBackUnique _x;};} forEach _friendlyUnitsW;
					if(count _fr==0)then{_tar pushBackUnique (getPos objArtiE);};
				};
				
				//Base 1
				if((secBE1)&&(getMarkerColor resFobE!=""))then
				{
					_fr=[];
					{if((_x distance posBaseE1)<75)then{_fr pushBackUnique _x;};} forEach _friendlyUnitsW;
					if(count _fr==0)then{_tar pushBackUnique posBaseE1;};
				};

				//Base 2
				if((secBE2)&&(getMarkerColor resBaseE!=""))then
				{
					_fr=[];
					{if((_x distance posBaseE2)<75)then{_fr pushBackUnique _x;};} forEach _friendlyUnitsW;
					if(count _fr==0)then{_tar pushBackUnique posBaseE2;};
				};
				
				if(count _tar==0)exitWith{};
				_t = selectRandom _tar;
				
				_vSel = selectRandom PlaneW;
				_typ="";
				// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
				if (_vSel isEqualType [])then{_typ=_vSel param [0, ""];}else{_typ=_vSel;};
				
				_logic = "logic" createVehicleLocal _t;
				// Patikriname, ar plHW yra apibrėžtas prieš jį naudojant
				if(!isNil "plHW") then {
					_logic setDir (plHW getDir posCenter);
				};
				_logic setVariable ["vehicle",_typ];
				_logic setVariable ["type",(selectRandom [2,3])];

				[_logic,nil,true] spawn BIS_fnc_moduleCAS;
				if(DBG)then{["West AI call CAS"] remoteExec ["systemChat", 0, false];};
			};
		};
	
		if((_plE==0)||((_plE>0)&&_nlE))then
		{
			if(getMarkerColor resCE!="")then
			{
				_tar=[];
				// Optimizuota: gauname allUnits vieną kartą ir filtruojame pagal šalis
				_allUnits = allUnits;
				_friendlyUnitsE = [];
				{
					if (side _x == sideE) then {
						_friendlyUnitsE pushBack _x;
					};
				} forEach _allUnits;

				//Artillery
				if(alive objArtiW)then
				{
					_fr=[];
					{if((_x distance posArti)<75)then{_fr pushBackUnique _x;};} forEach _friendlyUnitsE;
					if(count _fr==0)then{_tar pushBackUnique (getPos objArtiW);};
				};
				
				//Base 1
				if((secBW1)&&(getMarkerColor resFobW!=""))then
				{
					_fr=[];
					{if((_x distance posBaseW1)<75)then{_fr pushBackUnique _x;};} forEach _friendlyUnitsE;
					if(count _fr==0)then{_tar pushBackUnique posBaseW1;};
				};

				//Base 2
				if(count _tar==0)then
				{
					if((secBW2)&&(getMarkerColor resBaseW!=""))then
					{
						_fr=[];
						{if((_x distance posBaseW2)<75)then{_fr pushBackUnique _x;};} forEach _friendlyUnitsE;
						if(count _fr==0)then{_tar pushBackUnique posBaseW2;};
					};
				};
				
				if(count _tar==0)exitWith{};
				_t = selectRandom _tar;
				
				_vSel = selectRandom PlaneE;
				_typ="";
				// Naudojame param vietoj select saugumui pagal SQF_SYNTAX_BEST_PRACTICES.md
				if (_vSel isEqualType [])then{_typ=_vSel param [0, ""];}else{_typ=_vSel;};	
				
				_logic = "logic" createVehicleLocal _t;
				// Patikriname, ar plHE yra apibrėžtas prieš jį naudojant
				if(!isNil "plHE") then {
					_logic setDir (plHE getDir posCenter);
				};
				_logic setVariable ["vehicle",_typ];
				_logic setVariable ["type",(selectRandom [2,3])];

				[_logic,nil,true] spawn BIS_fnc_moduleCAS;
				if(DBG)then{["East AI call CAS"] remoteExec ["systemChat", 0, false];};
			};
		};
	//};
};
