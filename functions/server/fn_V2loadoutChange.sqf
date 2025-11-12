/*
	Author: IvosH
	
	Description:
		Change loadout of the unit/player (mission start and respawn) 
		
	Parameter(s):
		0: VARIABLE unit
		
	Returns:
		NA
		
	Dependencies:
		V2factionChange.sqf
		fn_respawnEH.sqf

	Execution:
		[_unit] call wrm_fnc_V2loadoutChange;
		[_x] execVM "V2loadoutChange.sqf";
*/
_un=_this select 0;

if (isPlayer _un) exitWith {}; //unit is player script stops here
_exit=false;
waitUntil{side _un!=civilian};

if(modA=="A3")then
{
	if(side _un==west)then{if((factionW=="NATO") && ((env=="desert")||(env=="arid")||(env=="winter")))then{_exit=true;};};
	if(side _un==east)then{if((factionE=="CSAT") && ((env=="desert")||(env=="arid")||(env=="winter")))then{_exit=true;};};
};
if(_exit)exitWith{};

_gr="";
call
{
	if((side _un==sideW))exitWith
	{
		call
		{
			if(typeOf _un=="B_Soldier_SL_F")exitWith{_gr= unitsW select 0;};
			if(typeOf _un=="B_soldier_LAT_F")exitWith{_gr= unitsW select 1;};
			if(typeOf _un=="B_soldier_AR_F")exitWith{_gr= unitsW select 2;};
			if(typeOf _un=="B_medic_F")exitWith{_gr= unitsW select 3;};
			if(typeOf _un=="B_Soldier_TL_F")exitWith{_gr= unitsW select 4;};
			if(typeOf _un=="B_Soldier_F")exitWith{_gr= unitsW select 5;};
			if(typeOf _un=="B_engineer_F")exitWith{_gr= unitsW select 6;};
			if(typeOf _un=="B_soldier_M_F")exitWith{_gr= unitsW select 7;};
			if(typeOf _un=="B_soldier_AT_F")exitWith{_gr= unitsW select 8;};
			if(typeOf _un=="B_Soldier_GL_F")exitWith{_gr= unitsW select 9;};
			if(typeOf _un=="B_soldier_AA_F")exitWith{_gr= unitsW select 10;};
			if(typeOf _un=="B_recon_TL_F")exitWith{_gr= unitsW select 11;};
			if(typeOf _un=="B_recon_LAT_F")exitWith{_gr= unitsW select 12;};
			if(typeOf _un=="B_recon_M_F")exitWith{_gr= unitsW select 13;};
			if(typeOf _un=="B_recon_medic_F")exitWith{_gr= unitsW select 14;};
			if(typeOf _un=="B_recon_JTAC_F")exitWith{_gr= unitsW select 15;};
			if(typeOf _un=="B_recon_F")exitWith{_gr= unitsW select 16;};
			if(typeOf _un=="B_recon_exp_F")exitWith{_gr= unitsW select 17;};
			if(typeOf _un=="B_sniper_F")exitWith{_gr= unitsW select 18;};
		};
	};
	
	if((side _un==sideE))exitWith
	{
		call
		{
			if(typeOf _un=="O_Soldier_SL_F")exitWith{_gr= unitsE select 0;};
			if(typeOf _un=="O_soldier_LAT_F")exitWith{_gr= unitsE select 1;};
			if(typeOf _un=="O_soldier_AR_F")exitWith{_gr= unitsE select 2;};
			if(typeOf _un=="O_medic_F")exitWith{_gr= unitsE select 3;};
			if(typeOf _un=="O_Soldier_TL_F")exitWith{_gr= unitsE select 4;};
			if(typeOf _un=="O_Soldier_F")exitWith{_gr= unitsE select 5;};
			if(typeOf _un=="O_engineer_F")exitWith{_gr= unitsE select 6;};
			if(typeOf _un=="O_soldier_M_F")exitWith{_gr= unitsE select 7;};
			if(typeOf _un=="O_soldier_AT_F")exitWith{_gr= unitsE select 8;};
			if(typeOf _un=="O_Soldier_GL_F")exitWith{_gr= unitsE select 9;};
			if(typeOf _un=="O_soldier_AA_F")exitWith{_gr= unitsE select 10;};
			if(typeOf _un=="O_recon_TL_F")exitWith{_gr= unitsE select 11;};
			if(typeOf _un=="O_recon_LAT_F")exitWith{_gr= unitsE select 12;};
			if(typeOf _un=="O_recon_M_F")exitWith{_gr= unitsE select 13;};
			if(typeOf _un=="O_recon_medic_F")exitWith{_gr= unitsE select 14;};
			if(typeOf _un=="O_recon_JTAC_F")exitWith{_gr= unitsE select 15;};
			if(typeOf _un=="O_recon_F")exitWith{_gr= unitsE select 16;};
			if(typeOf _un=="O_recon_exp_F")exitWith{_gr= unitsE select 17;};
			if(typeOf _un=="O_sniper_F")exitWith{_gr= unitsE select 18;};
		};
	};
};

//change to custom loadout
if(
	(side _un==east && factionE=="CSAT" && env=="woodland")
	//if custom then add condition here ||()
)exitWith{_un setUnitLoadout (missionconfigfile >> "CfgRespawnInventory" >>_gr);};

//or change to "typeOf" loadout
_un setUnitLoadout _gr;
