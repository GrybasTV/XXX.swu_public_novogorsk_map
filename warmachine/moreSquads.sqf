/*
	Author: IvosH
	
	Description:
		Create aditional groups at each base, (attack objectives) 
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		
	Execution:
		#include "moreSquads.sqf";
*/

if(AIon<3)exitWith{};

//check if the game is SP or COOP
_plw={side _x==sideW} count allplayers;
_ple={side _x==sideE} count allplayers;
call
{
	if((_plw>0)&&(_ple>0))exitWith{coop=0; publicvariable "coop";};
	if((_plw==0)&&(_ple==0))exitWith{coop=0; publicvariable "coop";};
	if(_plw>0)exitWith{coop=1; publicvariable "coop";};
	if(_ple>0)exitWith{coop=2; publicvariable "coop";};
};

//WEST
if(coop==0 || coop==2) then
{
	if(
		false //delete if you add custom units for sideW
		//if custom units then add condition here ||()
	)then 
	{
		_unitsW=["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F","B_engineer_F","B_soldier_M_F","B_soldier_AT_F","B_Soldier_GL_F","B_soldier_AA_F","B_recon_TL_F","B_recon_LAT_F","B_recon_M_F","B_recon_medic_F","B_recon_JTAC_F","B_recon_F","B_recon_exp_F","B_sniper_F"];

		{
			_toSpawn=[];
			while{(count _toSpawn<6)}do
			{
				_toSpawn pushBackUnique (selectRandom _unitsW);
			};
			_grp = [_x, sideW, _toSpawn,[],[],[],[],[-1,1]] call BIS_fnc_spawnGroup;
			_grp deleteGroupWhenEmpty true;
			{
				[_x] call wrm_fnc_V2loadoutChange;
				[_x] call wrm_fnc_V2nationChange;
			}forEach units _grp;
			{ 
				_x addMPEventHandler ["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
				_x addMPEventHandler ["MPKilled", {params ["_corpse", "_killer", "_instigator", "_useEffects"];[_corpse] spawn wrm_fnc_V2entityKilled;}];
			} forEach (units _grp);
			z1 addCuratorEditableObjects [(units _grp),true];
		}forEach [posBaseW1, posBaseW2];

	}else
	{
		{
			_pos = _x; //Pozicija iš forEach [posBaseW1, posBaseW2]
			private "_grp"; //FIX: Apibrėžti _grp iš anksto prieš naudojimą
			_toSpawn=[];
			//Filtruoti tuščius stringus iš unitsW masyvo prieš naudojant
			_availableUnits = unitsW select {_x != "" && _x isEqualType ""};
			if (count _availableUnits == 0) then {
				//Jei nėra galimų unitų, naudoti default'ines klasės
				_availableUnits = ["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F"];
			};
			while{(count _toSpawn<6)}do
			{
				_selectedUnit = selectRandom _availableUnits;
				if (_selectedUnit != "" && _selectedUnit isEqualType "") then {
					_toSpawn pushBackUnique _selectedUnit;
				};
			};
			//Patikrinti, ar custom klasės (Ukraine 2025 / Russia 2025)
			_isCustomClass = false;
			if (count _toSpawn > 0) then {
				_firstUnit = _toSpawn select 0;
				if ((str _firstUnit find "UA_Azov_" >= 0) || (str _firstUnit find "UA_" >= 0) || (str _firstUnit find "RUS_MSV_" >= 0) || (str _firstUnit find "RUS_spn_" >= 0) || (str _firstUnit find "RUS_" >= 0)) then {
					_isCustomClass = true;
				};
			};
			
			if (_isCustomClass) then {
				//Custom klasės - naudoti createUnit (veikia taip pat kaip RHS su BIS_fnc_spawnGroup)
				_grp = createGroup [sideW, true];
				//FIX: Patikrinti, ar grupė sukurta sėkmingai
				if (isNil "_grp" || isNull _grp) then {
					_grp = grpNull; //Nustatyti kaip null, kad vėliau būtų galima patikrinti
				} else {
					{
						if (_x != "" && _x isEqualType "") then {
							_unit = _grp createUnit [_x, _pos, [], 0, "NONE"];
							if (!isNull _unit) then {
								[_unit] call wrm_fnc_V2loadoutChange;
								[_unit] call wrm_fnc_V2nationChange;
							};
						};
					} forEach _toSpawn;
					//FIX: Patikrinti, ar grupė egzistuoja IR turi unitų prieš naudojant
					if (!isNil "_grp" && !isNull _grp && count units _grp > 0) then {
						_grp deleteGroupWhenEmpty true;
					} else {
						//Jei grupė tuščia arba neegzistuoja, pašalinti ją ir nustatyti kaip null
						if (!isNil "_grp" && !isNull _grp) then {
							deleteGroup _grp;
						};
						_grp = grpNull;
					};
				};
			} else {
				//Vanilla/RHS klasės - naudoti BIS_fnc_spawnGroup
				_grp = [_pos, sideW, _toSpawn,[],[],[],[],[-1,1]] call BIS_fnc_spawnGroup;
				//SVARBU: patikrinti, ar grupė sukurta sėkmingai
				if (isNil "_grp" || isNull _grp) then {
					_grp = grpNull; //Nustatyti kaip null, kad vėliau būtų galima patikrinti
				} else {
					_grp deleteGroupWhenEmpty true;
					{
						[_x] call wrm_fnc_V2loadoutChange;
						[_x] call wrm_fnc_V2nationChange;
					}forEach units _grp;
				};
			};
			//Patikrinti ar grupė sukurta ir turi unitų prieš pridedant event handler'ius
			//SVARBU: patikrinti, ar _grp yra apibrėžtas (isNil) prieš naudojant
			if (!isNil "_grp" && !isNull _grp && count units _grp > 0) then {
				{
					_x addMPEventHandler ["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
					_x addMPEventHandler ["MPKilled", {params ["_corpse", "_killer", "_instigator", "_useEffects"];[_corpse] spawn wrm_fnc_V2entityKilled;}];
				} forEach (units _grp);
				z1 addCuratorEditableObjects [(units _grp),true];
			};
		}forEach [posBaseW1, posBaseW2];
	};
};

//EAST
//defE=[];
if(coop==0 || coop==1) then
{
	if(
		(factionE=="CSAT" && env=="woodland")
		//if custom units then add condition here ||()
	)then 
	{
		_unitsE=["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F","O_engineer_F","O_soldier_M_F","O_soldier_AT_F","O_Soldier_GL_F","O_soldier_AA_F","O_recon_TL_F","O_recon_LAT_F","O_recon_M_F","O_recon_medic_F","O_recon_JTAC_F","O_recon_F","O_recon_exp_F","O_sniper_F"];

		{
			_toSpawn=[];
			while{(count _toSpawn<6)}do
			{
				_toSpawn pushBackUnique (selectRandom _unitsE);
			};
			_grp = [_x, sideE, _toSpawn,[],[],[],[],[-1,1]] call BIS_fnc_spawnGroup;
			_grp deleteGroupWhenEmpty true;
			{
				[_x] call wrm_fnc_V2loadoutChange;
				[_x] call wrm_fnc_V2nationChange;
			}forEach units _grp;
			{ 
				_x addMPEventHandler ["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
				_x addMPEventHandler ["MPKilled", {params ["_corpse", "_killer", "_instigator", "_useEffects"];[_corpse] spawn wrm_fnc_V2entityKilled;}];
			} forEach (units _grp);
			z1 addCuratorEditableObjects [(units _grp),true];
		}forEach [posBaseE1, posBaseE2];

	}else
	{
		{
			_pos = _x; //Pozicija iš forEach [posBaseE1, posBaseE2]
			private "_grp"; //FIX: Apibrėžti _grp iš anksto prieš naudojimą
			_toSpawn=[];
			//Filtruoti tuščius stringus iš unitsE masyvo prieš naudojant
			_availableUnits = unitsE select {_x != "" && _x isEqualType ""};
			if (count _availableUnits == 0) then {
				//Jei nėra galimų unitų, naudoti default'ines klasės
				_availableUnits = ["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F"];
			};
			while{(count _toSpawn<6)}do
			{
				_selectedUnit = selectRandom _availableUnits;
				if (_selectedUnit != "" && _selectedUnit isEqualType "") then {
					_toSpawn pushBackUnique _selectedUnit;
				};
			};
			//Patikrinti, ar custom klasės (Ukraine 2025 / Russia 2025)
			_isCustomClass = false;
			if (count _toSpawn > 0) then {
				_firstUnit = _toSpawn select 0;
				if ((str _firstUnit find "UA_Azov_" >= 0) || (str _firstUnit find "UA_" >= 0) || (str _firstUnit find "RUS_MSV_" >= 0) || (str _firstUnit find "RUS_spn_" >= 0) || (str _firstUnit find "RUS_" >= 0)) then {
					_isCustomClass = true;
				};
			};
			
			if (_isCustomClass) then {
				//Custom klasės - naudoti createUnit (veikia taip pat kaip RHS su BIS_fnc_spawnGroup)
				_grp = createGroup [sideE, true];
				//FIX: Patikrinti, ar grupė sukurta sėkmingai
				if (isNil "_grp" || isNull _grp) then {
					_grp = grpNull; //Nustatyti kaip null, kad vėliau būtų galima patikrinti
				} else {
					{
						if (_x != "" && _x isEqualType "") then {
							_unit = _grp createUnit [_x, _pos, [], 0, "NONE"];
							if (!isNull _unit) then {
								[_unit] call wrm_fnc_V2loadoutChange;
								[_unit] call wrm_fnc_V2nationChange;
							};
						};
					} forEach _toSpawn;
					//FIX: Patikrinti, ar grupė egzistuoja IR turi unitų prieš naudojant
					if (!isNil "_grp" && !isNull _grp && count units _grp > 0) then {
						_grp deleteGroupWhenEmpty true;
					} else {
						//Jei grupė tuščia arba neegzistuoja, pašalinti ją ir nustatyti kaip null
						if (!isNil "_grp" && !isNull _grp) then {
							deleteGroup _grp;
						};
						_grp = grpNull;
					};
				};
			} else {
				//Vanilla/RHS klasės - naudoti BIS_fnc_spawnGroup
				_grp = [_pos, sideE, _toSpawn,[],[],[],[],[-1,1]] call BIS_fnc_spawnGroup;
				//SVARBU: patikrinti, ar grupė sukurta sėkmingai
				if (isNil "_grp" || isNull _grp) then {
					_grp = grpNull; //Nustatyti kaip null, kad vėliau būtų galima patikrinti
				} else {
					_grp deleteGroupWhenEmpty true;
					{
						[_x] call wrm_fnc_V2loadoutChange;
						[_x] call wrm_fnc_V2nationChange;
					}forEach units _grp;
				};
			};
			//Patikrinti ar grupė sukurta ir turi unitų prieš pridedant event handler'ius
			//SVARBU: patikrinti, ar _grp yra apibrėžtas (isNil) prieš naudojant
			if (!isNil "_grp" && !isNull _grp && count units _grp > 0) then {
				{
					_x addMPEventHandler ["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
					_x addMPEventHandler ["MPKilled", {params ["_corpse", "_killer", "_instigator", "_useEffects"];[_corpse] spawn wrm_fnc_V2entityKilled;}];
				} forEach (units _grp);
				z1 addCuratorEditableObjects [(units _grp),true];
			};
		}forEach [posBaseE1, posBaseE2];
	};
};
	
if(DBG)then{["More AI squads spawned"] remoteExec ["systemChat", 0, false];};