/*
	Author: IvosH
	
	Description:
		Load weapons to virtual arsenal, applies role restrictions
	
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		onPlayerRespawn.sqf
		
	Execution:
		[] call wrm_fnc_arsenal;
*/
if (!hasInterface) exitWith {}; //run on the players only

//SVARBU: Arsenal funkcija gali būti lėta, nes naudoja configClasses
//Patikrinti, ar arsenal'as jau yra užkrautas (cache)
//Jei taip ir pusė nepasikeitė, išeiti - nereikia krauti dar kartą
if (isNil "wrm_arsenalLoaded") then { wrm_arsenalLoaded = false; };
if (isNil "wrm_arsenalSide") then { wrm_arsenalSide = sideUnknown; };

//Jei arsenal'as jau yra užkrautas ir pusė nepasikeitė, išeiti
if (wrm_arsenalLoaded && wrm_arsenalSide == side player) exitWith
{
	if (DBG) then {
		systemChat format ["[ARSENAL] Arsenal already loaded for side %1, skipping", side player];
	};
};

//Pažymėti, kad arsenal'as yra užkrautas (arba perkraunamas)
if (DBG) then {
	systemChat format ["[ARSENAL] Loading arsenal for side %1 (previous: %2)", side player, wrm_arsenalSide];
};
wrm_arsenalLoaded = true;
wrm_arsenalSide = side player;

//weapons
_boxes=[];
call
{
	if(side player==sideW)exitWith
	{
		if(version==2&&progress>1)then{_boxes=[AmmoW1,AmmoW2];}else{_boxes=[AmmoW];};
	};
	if(side player==sideE)exitWith
	{
		if(version==2&&progress>1)then{_boxes=[AmmoE1,AmmoE2];}else{_boxes=[AmmoE];};
	};
};

{
	_box=_x;
	[_box,([_box] call BIS_fnc_getVirtualWeaponCargo)] call BIS_fnc_removeVirtualWeaponCargo; //clear previous weapons in the arsenal
	call
	{
		//default (no mods)
		if(modA=="A3"||modA=="WS")exitWith
		{
			_weap = []; //weapon array + pistols
			_cfgWp= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))&&
			(getText (_x >> 'cursor') == 'hgun')
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_weap pushBack _wp;
			} forEach _cfgWp;
			_sm = []; //submachineguns, shotguns
			_cfgSm= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))&&
			((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sm pushBack _wp;
			} forEach _cfgSm;
			_ar = []; //assault rifles
			_cfgAr= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))&&
			(getText (_x >> 'cursor') == 'arifle')
			)" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			{
				_wp = configName (_x);
				_ar pushBack _wp;
			} forEach _cfgAr;
			_mg = []; //machineguns
			_cfgMg= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))&&
			(getText (_x >> 'cursor') == 'mg')
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				
				_mg pushBack _wp;
			} forEach _cfgMg;
			_sn = []; //sniper rifles
			_cfgSn= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))&&
			(getText (_x >> 'cursor') == 'srifle')
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sn pushBack _wp;
			} forEach _cfgSn;
			_at = []; //missile launchers
			_cfgAt= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))&&
			((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_at pushBack _wp;
			} forEach _cfgAt;
			//uniforms
			_unif=[]; _unf='';
			call	
			{
				if (side player==west) exitWith {_unf='U_B_';};
				if (side player==east) exitWith {_unf='U_O_';};
				if (side player==independent) exitWith {_unf='U_I_';};
				//if (side player==independent) exitWith {if (factionE=="AAF") then {_unf='U_I_';} else {_unf='XXX';};};
			};
			_cfgUn= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS\' >= 0))&&
			((str _x find _unf >= 0)&&(str _x find 'Ghillie' >= 0))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_unif pushBack _wp;
			} forEach _cfgUn;
			//check player's role
			_rl = 0;
			call
			{
				if (primaryWeapon player in _mg) exitWith {_rl = 1;};
				if (primaryWeapon player in _sn) exitWith {_rl = 2;};
				if (secondaryWeapon player in _at) exitWith {_rl = 3;};
			};
			call 
			{
				if (_rl == 0) exitWith {_weap=_weap+_ar+_sm;[_box,_unif] call BIS_fnc_removeVirtualItemCargo;};
				if (_rl == 1) exitWith {_weap=_weap+_mg;[_box,_unif] call BIS_fnc_removeVirtualItemCargo;};
				if (_rl == 2) exitWith {_weap=_weap+_sn;[_box,_unif,false,false] call BIS_fnc_addVirtualItemCargo;};
				if (_rl == 3) exitWith {_weap=_weap+_ar+_sm+_at;[_box,_unif] call BIS_fnc_removeVirtualItemCargo;};
			};
			[_box,_weap,false,false] call BIS_fnc_addVirtualWeaponCargo; //add weapons to arsenal
		};
		
		//RHS mod
		if(modA=="RHS")exitWith
		{
			_weap = []; //weapon array + pistols
			//Ukraine 2025 / Russia 2025 - pridėti naujų modų ginklus
			//Inicijuojame visus cfg kintamuosius kaip tuščius masyvus (saugumas)
			_cfgWp = [];
			if(factionW=="Ukraine 2025" || factionE=="Russia 2025")then
			{
				//Ukraine 2025 / Russia 2025 - RHS ginklai + naujų modų ginklai (RUS_, UA_, ir kt.)
				_cfgWp= "((getText (_x >> 'cursor') == 'hgun')&&(((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))||(str _x find 'RUS_' >= 0)||(str _x find 'UA_' >= 0)||(str _x find 'UKR_' >= 0)))" configClasses (configFile>>"cfgWeapons");
			}else
			{
				_cfgWp= "((getText (_x >> 'cursor') == 'hgun')&&((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF')))" configClasses (configFile>>"cfgWeapons");
			};
			{
				_wp = configName (_x);
				_weap pushBack _wp;
			} forEach _cfgWp;
			_sm = []; //submachineguns, shotguns
			_cfgSm = []; //inicijuojame prieš if-else (saugumas)
			if(factionW=="Ukraine 2025" || factionE=="Russia 2025")then
			{
				_cfgSm= "(
				((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))&&
				(((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))||(str _x find 'RUS_' >= 0)||(str _x find 'UA_' >= 0)||(str _x find 'UKR_' >= 0))
				)" configClasses (configFile>>"cfgWeapons");
			}else
			{
				_cfgSm= "(
				((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))&&
				((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))
				)" configClasses (configFile>>"cfgWeapons");
			};
			{
				_wp = configName (_x);
				_sm pushBack _wp;
			} forEach _cfgSm;
			_ar = []; //assault rifles
			_cfgAr = []; //inicijuojame prieš if-else (saugumas)
			if(factionW=="Ukraine 2025" || factionE=="Russia 2025")then
			{
				_cfgAr= "((getText (_x >> 'cursor') == 'arifle')&&(((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))||(str _x find 'RUS_' >= 0)||(str _x find 'UA_' >= 0)||(str _x find 'UKR_' >= 0)))" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			}else
			{
				_cfgAr= "((getText (_x >> 'cursor') == 'arifle')&&((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF')))" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			};
			{
				_wp = configName (_x);
				_ar pushBack _wp;
			} forEach _cfgAr;
			_mg = []; //machineguns
			_cfgMg = []; //inicijuojame prieš if-else (saugumas)
			if(factionW=="Ukraine 2025" || factionE=="Russia 2025")then
			{
				_cfgMg= "((getText (_x >> 'cursor') == 'mg')&&(((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))||(str _x find 'RUS_' >= 0)||(str _x find 'UA_' >= 0)||(str _x find 'UKR_' >= 0)))" configClasses (configFile>>"cfgWeapons");
			}else
			{
				_cfgMg= "((getText (_x >> 'cursor') == 'mg')&&((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF')))" configClasses (configFile>>"cfgWeapons");
			};
			{
				_wp = configName (_x);
				
				_mg pushBack _wp;
			} forEach _cfgMg;
			_sn = []; //sniper rifles
			_cfgSn = []; //inicijuojame prieš if-else (saugumas)
			if(factionW=="Ukraine 2025" || factionE=="Russia 2025")then
			{
				_cfgSn= "((getText (_x >> 'cursor') == 'srifle')&&(((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))||(str _x find 'RUS_' >= 0)||(str _x find 'UA_' >= 0)||(str _x find 'UKR_' >= 0)))" configClasses (configFile>>"cfgWeapons");
			}else
			{
				_cfgSn= "((getText (_x >> 'cursor') == 'srifle')&&((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF')))" configClasses (configFile>>"cfgWeapons");
			};
			{
				_wp = configName (_x);
				_sn pushBack _wp;
			} forEach _cfgSn;
			_at = []; //missile launchers
			_cfgAt = []; //inicijuojame prieš if-else (saugumas) - TAIP PAT KAIP KITI
			if(factionW=="Ukraine 2025" || factionE=="Russia 2025")then
			{
				_cfgAt= "(((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))&&(((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))||(str _x find 'RUS_' >= 0)||(str _x find 'UA_' >= 0)||(str _x find 'UKR_' >= 0)))" configClasses (configFile>>"cfgWeapons");
			}else
			{
				_cfgAt= "(((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))&&((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF')))" configClasses (configFile>>"cfgWeapons");
			};
			{
				_wp = configName (_x);
				_at pushBack _wp;
			} forEach _cfgAt;

			//check player's role
			_rl = 0;
			call
			{
				if (primaryWeapon player in _mg) exitWith {_rl = 1;};
				if (primaryWeapon player in _sn) exitWith {_rl = 2;};
				if (secondaryWeapon player in _at) exitWith {_rl = 3;};
			};
			call 
			{
				if (_rl == 0) exitWith {_weap=_weap+_ar+_sm;};
				if (_rl == 1) exitWith {_weap=_weap+_mg;};
				if (_rl == 2) exitWith {_weap=_weap+_sn;};
				if (_rl == 3) exitWith {_weap=_weap+_ar+_sm+_at;};
			};
			[_box,_weap,false,false] call BIS_fnc_addVirtualWeaponCargo; //add weapons to arsenal
		};
		
		//IFA3 mod
		if(modA=="IFA3")exitWith
		{
			_weap = []; //weapon array + pistols
			_cfgWp= "((getText (_x >> 'cursor') == 'hgun')&&(str _x find 'LIB' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_weap pushBack _wp;
			} forEach _cfgWp;
			_sm = []; //submachineguns, shotguns
			_cfgSm= "(
			((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))&&
			(str _x find 'LIB' >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sm pushBack _wp;
			} forEach _cfgSm;
			_ar = []; //assault rifles
			_cfgAr= "((getText (_x >> 'cursor') == 'arifle')&&(str _x find 'LIB' >= 0))" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			{
				_wp = configName (_x);
				_ar pushBack _wp;
			} forEach _cfgAr;
			_mg = []; //machineguns
			_cfgMg= "((getText (_x >> 'cursor') == 'mg')&&(str _x find 'LIB' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				
				_mg pushBack _wp;
			} forEach _cfgMg;
			_sn = []; //sniper rifles
			_cfgSn= "((getText (_x >> 'cursor') == 'srifle')&&(str _x find 'LIB' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sn pushBack _wp;
			} forEach _cfgSn;
			_at = []; //missile launchers
			_cfgAt= "(((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))&&(str _x find 'LIB' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_at pushBack _wp;
			} forEach _cfgAt;

			//check player's role
			_rl = 0;
			call
			{
				if (primaryWeapon player in _mg) exitWith {_rl = 1;};
				if (primaryWeapon player in _sn) exitWith {_rl = 2;};
				if (secondaryWeapon player in _at) exitWith {_rl = 3;};
			};
			call 
			{
				if (_rl == 0) exitWith {_weap=_weap+_ar+_sm;};
				if (_rl == 1) exitWith {_weap=_weap+_mg;};
				if (_rl == 2) exitWith {_weap=_weap+_sn;};
				if (_rl == 3) exitWith {_weap=_weap+_ar+_sm+_at;};
			};
			[_box,_weap,false,false] call BIS_fnc_addVirtualWeaponCargo; //add weapons to arsenal
		};
		
		//GM dlc
		if(modA=="GM")exitWith
		{
			_weap = []; //weapon array + pistols
			_cfgWp= "((getText (_x >> 'cursor') == 'hgun')&&(getText(_x >> 'dlc')=='gm'))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_weap pushBack _wp;
			} forEach _cfgWp;
			_sm = []; //submachineguns, shotguns
			_cfgSm= "(
			((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))&&
			(getText(_x >> 'dlc')=='gm')
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sm pushBack _wp;
			} forEach _cfgSm;
			_ar = []; //assault rifles
			_cfgAr= "((getText (_x >> 'cursor') == 'arifle')&&(getText(_x >> 'dlc')=='gm'))" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			{
				_wp = configName (_x);
				_ar pushBack _wp;
			} forEach _cfgAr;
			_mg = []; //machineguns
			_cfgMg= "((getText (_x >> 'cursor') == 'mg')&&(getText(_x >> 'dlc')=='gm'))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				
				_mg pushBack _wp;
			} forEach _cfgMg;
			_sn = []; //sniper rifles
			_cfgSn= "((getText (_x >> 'cursor') == 'srifle')&&(getText(_x >> 'dlc')=='gm'))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sn pushBack _wp;
			} forEach _cfgSn;
			_at = []; //missile launchers
			_cfgAt= "(((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))&&(getText(_x >> 'dlc')=='gm'))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_at pushBack _wp;
			} forEach _cfgAt;

			//check player's role
			_rl = 0;
			call
			{
				if (primaryWeapon player in _mg) exitWith {_rl = 1;};
				if (primaryWeapon player in _sn) exitWith {_rl = 2;};
				if (secondaryWeapon player in _at) exitWith {_rl = 3;};
			};
			call 
			{
				if (_rl == 0) exitWith {_weap=_weap+_ar+_sm;};
				if (_rl == 1) exitWith {_weap=_weap+_mg;};
				if (_rl == 2) exitWith {_weap=_weap+_sn;};
				if (_rl == 3) exitWith {_weap=_weap+_ar+_sm+_at;};
			};
			[_box,_weap,false,false] call BIS_fnc_addVirtualWeaponCargo; //add weapons to arsenal
		};
		
		//VN dlc
		if(modA=="VN")exitWith
		{
			_weap = []; //weapon array + pistols
			_cfgWp= "((getText (_x >> 'cursor') == 'hgun')&&(str _x find 'vn_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_weap pushBack _wp;
			} forEach _cfgWp;
			_sm = []; //submachineguns, shotguns
			_cfgSm= "(
			((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))&&
			(str _x find 'vn_' >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sm pushBack _wp;
			} forEach _cfgSm;
			_ar = []; //assault rifles
			_cfgAr= "((getText (_x >> 'cursor') == 'arifle')&&(str _x find 'vn_' >= 0))" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			{
				_wp = configName (_x);
				_ar pushBack _wp;
			} forEach _cfgAr;
			_mg = []; //machineguns
			_cfgMg= "((getText (_x >> 'cursor') == 'mg')&&(str _x find 'vn_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				
				_mg pushBack _wp;
			} forEach _cfgMg;
			_sn = []; //sniper rifles
			_cfgSn= "((getText (_x >> 'cursor') == 'srifle')&&(str _x find 'vn_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sn pushBack _wp;
			} forEach _cfgSn;
			_at = []; //missile launchers
			_cfgAt= "(((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))&&(str _x find 'vn_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_at pushBack _wp;
			} forEach _cfgAt;

			//check player's role
			_rl = 0;
			call
			{
				if (primaryWeapon player in _mg) exitWith {_rl = 1;};
				if (primaryWeapon player in _sn) exitWith {_rl = 2;};
				if (secondaryWeapon player in _at) exitWith {_rl = 3;};
			};
			call 
			{
				if (_rl == 0) exitWith {_weap=_weap+_ar+_sm;};
				if (_rl == 1) exitWith {_weap=_weap+_mg;};
				if (_rl == 2) exitWith {_weap=_weap+_sn;};
				if (_rl == 3) exitWith {_weap=_weap+_ar+_sm+_at;};
			};
			[_box,_weap,false,false] call BIS_fnc_addVirtualWeaponCargo; //add weapons to arsenal
		};
		
		//CSLA dlc
		if(modA=="CSLA")exitWith
		{
			_weap = []; //weapon array + pistols
			_cfgWp= "(
			(getText (_x >> 'cursor') == 'hgun')&&
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_weap pushBack _wp;
			} forEach _cfgWp;
			_sm = []; //submachineguns, shotguns
			_cfgSm= "(
			((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))&&
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sm pushBack _wp;
			} forEach _cfgSm;
			_ar = []; //assault rifles
			_cfgAr= "(
			(getText (_x >> 'cursor') == 'arifle')&&
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))
			)" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			{
				_wp = configName (_x);
				_ar pushBack _wp;
			} forEach _cfgAr;
			_mg = []; //machineguns
			_cfgMg= "(
			(getText (_x >> 'cursor') == 'mg')&&
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				
				_mg pushBack _wp;
			} forEach _cfgMg;
			_sn = []; //sniper rifles
			_cfgSn= "(
			(getText (_x >> 'cursor') == 'srifle')&&
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sn pushBack _wp;
			} forEach _cfgSn;
			_at = []; //missile launchers
			_cfgAt= "(
			((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))&&
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_at pushBack _wp;
			} forEach _cfgAt;
			//uniforms
			_unif=[]; _fac='';
			call	
			{
				if (side player==west) exitWith {_fac='US85_';};
				if (side player==east) exitWith {_fac='CSLA_';};
				if (side player==independent) exitWith {};
			};
			_cfgUn= "(
			(str _x find _fac >= 0)&&
			(str _x find '_uni' >= 0)&&
			(str _x find 'Ghillie' >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_unif pushBack _wp;
			} forEach _cfgUn;
			//check player's role
			_rl = 0;
			call
			{
				if (primaryWeapon player in _mg) exitWith {_rl = 1;};
				if (primaryWeapon player in _sn) exitWith {_rl = 2;};
				if (secondaryWeapon player in _at) exitWith {_rl = 3;};
			};
			call 
			{
				if (_rl == 0) exitWith {_weap=_weap+_ar+_sm;[_box,_unif] call BIS_fnc_removeVirtualItemCargo;};
				if (_rl == 1) exitWith {_weap=_weap+_mg;[_box,_unif] call BIS_fnc_removeVirtualItemCargo;};
				if (_rl == 2) exitWith {_weap=_weap+_sn;[_box,_unif,false,false] call BIS_fnc_addVirtualItemCargo;};
				if (_rl == 3) exitWith {_weap=_weap+_ar+_sm+_at;[_box,_unif] call BIS_fnc_removeVirtualItemCargo;};
			};
			[_box,_weap,false,false] call BIS_fnc_addVirtualWeaponCargo; //add weapons to arsenal
		};
		
		//SPE cdlc
		if(modA=="SPE")exitWith
		{
			_weap = []; //weapon array + pistols
			_cfgWp= "((getText (_x >> 'cursor') == 'hgun')&&(str _x find 'SPE_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_weap pushBack _wp;
			} forEach _cfgWp;
			_sm = []; //submachineguns, shotguns
			_cfgSm= "(
			((getText (_x >> 'cursor') == 'smg')||(getText (_x >> 'cursor') == 'sgun'))&&
			(str _x find 'SPE_' >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sm pushBack _wp;
			} forEach _cfgSm;
			_ar = []; //assault rifles
			_cfgAr= "((getText (_x >> 'cursor') == 'arifle')&&(str _x find 'SPE_' >= 0))" configClasses (configFile>>"cfgWeapons"); //get array of all weapons
			{
				_wp = configName (_x);
				_ar pushBack _wp;
			} forEach _cfgAr;
			_mg = []; //machineguns
			_cfgMg= "((getText (_x >> 'cursor') == 'mg')&&(str _x find 'SPE_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				
				_mg pushBack _wp;
			} forEach _cfgMg;
			_sn = []; //sniper rifles
			_cfgSn= "((getText (_x >> 'cursor') == 'srifle')&&(str _x find 'SPE_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_sn pushBack _wp;
			} forEach _cfgSn;
			_at = []; //missile launchers
			//_cfgAt= "(((getText (_x >> 'cursor') == 'missile')||(getText (_x >> 'cursor') == 'rocket'))&&(str _x find 'SPE_' >= 0))" configClasses (configFile>>"cfgWeapons");
			_cfgAt= "((getText (_x >> 'picture') find 'Launchers' >= 0)&&(str _x find 'SPE_' >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_at pushBack _wp;
			} forEach _cfgAt;

			//check player's role
			_rl = 0;
			call
			{
				if (primaryWeapon player in _mg) exitWith {_rl = 1;};
				if (primaryWeapon player in _sn) exitWith {_rl = 2;};
				if (secondaryWeapon player in _at) exitWith {_rl = 3;};
			};
			call 
			{
				if (_rl == 0) exitWith {_weap=_weap+_ar+_sm;};
				if (_rl == 1) exitWith {_weap=_weap+_mg;};
				if (_rl == 2) exitWith {_weap=_weap+_sn;};
				if (_rl == 3) exitWith {_weap=_weap+_ar+_sm+_at;};
			};
			[_box,_weap,false,false] call BIS_fnc_addVirtualWeaponCargo; //add weapons to arsenal
		};
	};
} forEach _boxes;