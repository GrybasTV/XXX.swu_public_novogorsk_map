/*
	Author: IvosH
	
	Description:
		Create defense group at captured objective, (don't attack another objectives) 
		
	Parameter(s):
		0: [] position
		1: side
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf
		fn_V2secBE1.sqf
		fn_V2secBE2.sqf
		fn_V2secBW1.sqf
		fn_V2secBW2.sqf

	Execution:
		[_sec,_side] call wrm_fnc_V2secDefense;
*/

if(AIon==0)exitWith{};
_sec = _this select 0;
_side =  _this select 1;

//WEST
if (_side == sideW) then
{
	if(
		false //delete if you add custom units for sideW
		//if custom units then add condition here ||()
	)then 
	{
		_unitsW=["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F","B_engineer_F","B_soldier_M_F","B_soldier_AT_F","B_Soldier_GL_F","B_soldier_AA_F","B_recon_TL_F","B_recon_LAT_F","B_recon_M_F","B_recon_medic_F","B_recon_JTAC_F","B_recon_F","B_recon_exp_F","B_sniper_F"];

		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom _unitsW);
		};
		_grp = [_sec, sideW, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		{
			[_x] call wrm_fnc_V2loadoutChange;
			[_x] call wrm_fnc_V2nationChange;
		}forEach units _grp;
		defW pushBackUnique _grp;
		{ _x addMPEventHandler
			["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
		} forEach (units _grp);
		z1 addCuratorEditableObjects [(units _grp),true];
		[_sec,_grp] spawn wrm_fnc_V2defBase;
	}else
	{
		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom unitsW);
		};
		//Patikrinti, ar custom klasės (Ukraine 2025 / Russia 2025)
		_isCustomClass = false;
		if (count _toSpawn > 0) then {
			_firstUnit = _toSpawn select 0;
			if ((str _firstUnit find "UA_Azov_" >= 0) || (str _firstUnit find "UA_" >= 0) || (str _firstUnit find "RUS_MSV_" >= 0) || (str _firstUnit find "RUS_spn_" >= 0) || (str _firstUnit find "RUS_" >= 0)) then {
				_isCustomClass = true;
			};
		};
		
		private "_grp";
		if (_isCustomClass) then {
			//Custom klasės - naudoti createUnit (veikia taip pat kaip RHS su BIS_fnc_spawnGroup)
			_grp = createGroup [sideW, true];
			{
				_unit = _grp createUnit [_x, _sec, [], 0, "NONE"];
				[_unit] call wrm_fnc_V2loadoutChange;
				[_unit] call wrm_fnc_V2nationChange;
			} forEach _toSpawn;
			_grp deleteGroupWhenEmpty true;
		} else {
			//Vanilla/RHS klasės - naudoti BIS_fnc_spawnGroup
			_grp = [_sec, sideW, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
			_grp deleteGroupWhenEmpty true;
			{
				[_x] call wrm_fnc_V2loadoutChange;
				[_x] call wrm_fnc_V2nationChange;
			}forEach units _grp;
		};
		defW pushBackUnique _grp;
		{ _x addMPEventHandler
			["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
		} forEach (units _grp);
		z1 addCuratorEditableObjects [(units _grp),true];
		if (!isNil "_grp" && !isNull _grp) then {
			[_sec,_grp] spawn wrm_fnc_V2defBase;
		};
	};
};

//EAST
if (_side == sideE) then
{
	if(
		(factionE=="CSAT" && env=="woodland")
		//if custom units then add condition here ||()
	)then 
	{
		_unitsE=["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F","O_engineer_F","O_soldier_M_F","O_soldier_AT_F","O_Soldier_GL_F","O_soldier_AA_F","O_recon_TL_F","O_recon_LAT_F","O_recon_M_F","O_recon_medic_F","O_recon_JTAC_F","O_recon_F","O_recon_exp_F","O_sniper_F"];

		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom _unitsE);
		};
		_grp = [_sec, sideE, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		{
			[_x] call wrm_fnc_V2loadoutChange;
			[_x] call wrm_fnc_V2nationChange;
		}forEach units _grp;
		defE pushBackUnique _grp;
		{ _x addMPEventHandler
			["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
		} forEach (units _grp);
		z1 addCuratorEditableObjects [(units _grp),true];
		if (!isNil "_grp" && !isNull _grp) then {
			[_sec,_grp] spawn wrm_fnc_V2defBase;
		};
	}else
	{
		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom unitsE);
		};
		//Patikrinti, ar custom klasės (Ukraine 2025 / Russia 2025)
		_isCustomClass = false;
		if (count _toSpawn > 0) then {
			_firstUnit = _toSpawn select 0;
			if ((str _firstUnit find "UA_Azov_" >= 0) || (str _firstUnit find "UA_" >= 0) || (str _firstUnit find "RUS_MSV_" >= 0) || (str _firstUnit find "RUS_spn_" >= 0) || (str _firstUnit find "RUS_" >= 0)) then {
				_isCustomClass = true;
			};
		};
		
		private "_grp";
		if (_isCustomClass) then {
			//Custom klasės - naudoti createUnit (veikia taip pat kaip RHS su BIS_fnc_spawnGroup)
			_grp = createGroup [sideE, true];
			{
				_unit = _grp createUnit [_x, _sec, [], 0, "NONE"];
				[_unit] call wrm_fnc_V2loadoutChange;
				[_unit] call wrm_fnc_V2nationChange;
			} forEach _toSpawn;
			_grp deleteGroupWhenEmpty true;
		} else {
			//Vanilla/RHS klasės - naudoti BIS_fnc_spawnGroup
			_grp = [_sec, sideE, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
			_grp deleteGroupWhenEmpty true;
			{
				[_x] call wrm_fnc_V2loadoutChange;
				[_x] call wrm_fnc_V2nationChange;
			}forEach units _grp;
		};
		defE pushBackUnique _grp;
		{ _x addMPEventHandler
			["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
		} forEach (units _grp);
		z1 addCuratorEditableObjects [(units _grp),true];
		if (!isNil "_grp" && !isNull _grp) then {
			[_sec,_grp] spawn wrm_fnc_V2defBase;
		};
	};
};

if(DBG)then{["Objective defense spawned"] remoteExec ["systemChat", 0, false];};