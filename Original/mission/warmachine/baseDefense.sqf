/*
	Author: IvosH
	
	Description:
		Create defense group at each base, (don't attack objectives) 
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2aiStart.sqf
		
	Execution:
		#include "baseDefense.sqf";
*/

if(AIon==0)exitWith{};

//WEST
if(
	false //delete if you add custom units for sideW
	//if custom units then add condition here ||()
)then 
{
	_unitsW=["B_Soldier_SL_F","B_soldier_LAT_F","B_soldier_AR_F","B_medic_F","B_Soldier_TL_F","B_Soldier_F","B_engineer_F","B_soldier_M_F","B_soldier_AT_F","B_Soldier_GL_F","B_soldier_AA_F","B_recon_TL_F","B_recon_LAT_F","B_recon_M_F","B_recon_medic_F","B_recon_JTAC_F","B_recon_F","B_recon_exp_F","B_sniper_F"];

	{
		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom _unitsW);
		};
		_grp = [_x, sideW, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
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
		[_x,_grp] spawn wrm_fnc_V2defBase;
	}forEach [posBaseW1, posBaseW2];

}else
{
	{
		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom unitsW);
		};
		_grp = [_x, sideW, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		defW pushBackUnique _grp;
		{ _x addMPEventHandler
			["MPKilled",{[(_this select 0),sideW] spawn wrm_fnc_killedEH;}];
		} forEach (units _grp);
		z1 addCuratorEditableObjects [(units _grp),true];
		[_x,_grp] spawn wrm_fnc_V2defBase;
	}forEach [posBaseW1, posBaseW2];
};

//EAST
if(
	(factionE=="CSAT" && env=="woodland")
	//if custom units then add condition here ||()
)then 
{
	_unitsE=["O_Soldier_SL_F","O_soldier_LAT_F","O_soldier_AR_F","O_medic_F","O_Soldier_TL_F","O_Soldier_F","O_engineer_F","O_soldier_M_F","O_soldier_AT_F","O_Soldier_GL_F","O_soldier_AA_F","O_recon_TL_F","O_recon_LAT_F","O_recon_M_F","O_recon_medic_F","O_recon_JTAC_F","O_recon_F","O_recon_exp_F","O_sniper_F"];

	{
		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom _unitsE);
		};
		_grp = [_x, sideE, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
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
		[_x,_grp] spawn wrm_fnc_V2defBase;
	}forEach [posBaseE1, posBaseE2];

}else
{
	{
		_toSpawn=[];
		while{(count _toSpawn<8)}do
		{
			_toSpawn pushBackUnique (selectRandom unitsE);
		};
		_grp = [_x, sideE, _toSpawn,[],[],[],[],[6,0.5]] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		defE pushBackUnique _grp;
		{ _x addMPEventHandler
			["MPKilled",{[(_this select 0),sideE] spawn wrm_fnc_killedEH;}];
		} forEach (units _grp);
		z1 addCuratorEditableObjects [(units _grp),true];
		[_x,_grp] spawn wrm_fnc_V2defBase;
	}forEach [posBaseE1, posBaseE2];
};

if(DBG)then{["Base defense spawned"] remoteExec ["systemChat", 0, false];};