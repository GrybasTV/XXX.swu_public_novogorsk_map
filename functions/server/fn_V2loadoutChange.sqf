/*
	Author: IvosH
		MODIFIKUOTA VERSIJA: Pridėti Ukraine 2025 ir Russia 2025 mapping
	
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

//Visiems vienetams (žaidėjams ir AI): priskirti loadout'ą pagal jų klasę (typeOf) jei jie jo neturi
// Custom vienetai turi loadout'us iš config.cpp arba CfgRespawnInventory, kiti gauna iš čia
private _currentLoadout = getUnitLoadout _un;
private _hasLoadout = count _currentLoadout > 0 && {!((_currentLoadout select 0) isEqualTo [])};

// Jei vienetas neturi loadout'o - priskirti pagal klasę
if (!_hasLoadout) then {
    _un setUnitLoadout (typeOf _un);
};

//Custom vienetų apdorojimas - pašalintas dėl TFAR konfliktų
// Dabar naudojame tik bazinę logiką visiems vienetams
// Custom vienetai gauna loadout'us iš savo config.cpp arba CfgRespawnInventory

//Skip rest of script for players - they get loadouts from CfgRespawnInventory via RscDisplayRespawn menu
if (isPlayer _un) exitWith {};

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
			//A3 NATO vienetai (originalūs)
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

			//Ukraine 2025 vienetai (WEST) - handled above, skip here
		};
	};
	
	if((side _un==sideE))exitWith
	{
		call
		{
			//A3 CSAT vienetai (originalūs)
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

			//Russia 2025 vienetai (EAST) - handled above, skip here
		};
	};
};
						
//change to custom loadout
if(
	(side _un==east && factionE=="CSAT" && env=="woodland")
	//if custom then add condition here ||()
)exitWith{_un setUnitLoadout (missionconfigfile >> "CfgRespawnInventory" >>_gr);};

//Special handling removed - Ukraine 2025 and Russia 2025 units now use their class names directly

//or change to "typeOf" loadout
_un setUnitLoadout _gr;