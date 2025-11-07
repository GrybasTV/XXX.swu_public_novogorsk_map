/*
	Author: IvosH
	
	Description:
		- add night vision goggles on the helmet, player, AI (A3, RHS)
		- add gps to the player (A3, RHS)
		- add ammo for the rocket launcher, player (RHS)	
		
	Parameter(s):
		0: VARIABLE respawned unit or allUnits
		
	Returns:
		nothing
		
	Dependencies:
		onPlayerRespawn.sqf (line 63)
		start.sqf (line 186)
		cfgFunctions.hpp
		fn_respawnEH (line 22)

	Execution:
		[_unit] spawn wrm_fnc_equipment;
*/
_unit = _this select 0;

call
{
	//default (no mods)
	if(modA=="A3"||modA=="WS")exitWith
	{
		_nvg = ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP","NVGoggles_tna_F"];
		_nvgs = _nvg + ["O_NVGoggles_hex_F","O_NVGoggles_urb_F","O_NVGoggles_ghex_F","O_NVGoggles_grn_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F"];
		_hlm = ["H_HelmetO_ViperSP_ghex_F","H_HelmetO_ViperSP_hex_F"];
		//NVgoggles
		if(sunOrMoon<1)then //0
		{
			_nv=0;
			{if(headgear _unit==_x)then{_nv=1;};} forEach _hlm;
			if(_nv==1)exitWith{};
			{
				_it=_x;
				{
					if(_it==_x)then{_nv=1;};
				} forEach _nvgs;
			} forEach (assignedItems _unit);
			if(_nv==1)exitWith{};
			{
				_it=_x;
				{	
					if(_it==_x)then{_unit assignItem _it;_nv=1;};
				} forEach _nvgs;
			} forEach (items _unit);
			if(_nv==0)then
			{
				_n = selectRandom _nvg;
				_unit addItem _n;
				_unit assignItem _n;
			};
		};
	};

	//RHS mod
	if(modA=="RHS")exitWith
	{
		//NVgoggles	
		if(sunOrMoon<1)then //0 night, 1 day
		{
			_nvgs = ["rhsusf_ANPVS_15","rhsusf_ANPVS_14","rhs_1PN138"];
			_nv=0;
			//has NVG on helmet?
			{
				_it=_x;
				{
					if(_it==_x)then{_nv=1;};
				} forEach _nvgs;
			} forEach (assignedItems _unit);
			if(_nv==1)exitWith{};
			//has NVG in the inventory? put it on the helmet
			{
				_it=_x;
				{	
					if(_it==_x)then{_unit assignItem _it;_nv=1;};
				} forEach _nvgs;
			} forEach (items _unit);
			//add NVG
			if(_nv==0)then
			{
				_n = selectRandom _nvgs;
				_unit addItem _n;
				_unit assignItem _n;
			};
		};
		//add ammo for the rocket launcher
		sleep 0.2;
		call
		{
			//Javelin (US)
			if((secondaryWeapon _unit=="rhs_weap_fgm148")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_fgm148_magazine_AT";};
			//Stinger (US)
			if((secondaryWeapon _unit=="rhs_weap_fim92")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_fim92_mag";};
			//Igla (RU)
			if((secondaryWeapon _unit=="rhs_weap_igla")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_mag_9k38_rocket";};
			//RPG-7 (RU/UA)
			if((secondaryWeapon _unit=="rhs_weap_rpg7")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_rpg7_PG7VL_mag";};
			//RPG-26 (RU/UA)
			if((secondaryWeapon _unit=="rhs_weap_rpg26")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_rpg26_mag";};
			//RPG-18 (RU/UA)
			if((secondaryWeapon _unit=="rhs_weap_rshg2")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_rshg2_mag";};
			//M72A7 (US/UA)
			if((secondaryWeapon _unit=="rhs_weap_m72a7")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_m72a7_mag";};
			//M136 (US/UA)
			if((secondaryWeapon _unit=="rhs_weap_M136")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_m136_mag";};
			//M136 HP (US/UA)
			if((secondaryWeapon _unit=="rhs_weap_M136_hp")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_m136_hp_mag";};
			//M136 HEAT (US/UA)
			if((secondaryWeapon _unit=="rhs_weap_M136_hedp")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_m136_hedp_mag";};
			//SMAW (US/UA)
			if((secondaryWeapon _unit=="rhs_weap_smaw")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_mag_smaw_HEAA";};
			//Metis (RU)
			if((secondaryWeapon _unit=="rhs_weap_9k115")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_mag_9k115_2";};
			//Kornet (RU)
			if((secondaryWeapon _unit=="rhs_weap_9k133")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_mag_9k133_2";};
			//Strela (RU)
			if((secondaryWeapon _unit=="rhs_weap_strela")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "rhs_mag_9k32_rocket";};
		};
	};
	
	//GM mod
	if(modA=="GM")exitWith
	{
		//add ammo for the rocket launcher
		sleep 0.2;
		call
		{
			if((secondaryWeapon _unit=="gm_fim43_oli")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "gm_1Rnd_70mm_he_m585_fim43";};
			if((secondaryWeapon _unit=="gm_pzf3_blk")&&(count secondaryWeaponMagazine _unit==0))
			exitWith{_unit addSecondaryWeaponItem "gm_1Rnd_60mm_heat_dm12_pzf3";};
		};
	};
	
	//CSLA mod
	if(modA=="CSLA")exitWith
	{
		//NVgoggles	
		if(sunOrMoon<1)then //0 night, 1 day
		{
			_nvgs = ["CSLA_nokto","US85_ANPVS5_Goggles"];
			_nv=0;
			//has NVG on helmet?
			{
				_it=_x;
				{
					if(_it==_x)then{_nv=1;};
				} forEach _nvgs;
			} forEach (assignedItems _unit);
			if(_nv==1)exitWith{};
			//has NVG in the inventory? put it on the helmet
			{
				_it=_x;
				{	
					if(_it==_x)then{_unit assignItem _it;_nv=1;};
				} forEach _nvgs;
			} forEach (items _unit);
			//add NVG
			if(_nv==0)then
			{
				_n = selectRandom _nvgs;
				_unit addItem _n;
				_unit assignItem _n;
			};
		};
	};
	
	//Spearhead 1944 mod
	if(modA=="SPE")exitWith
	{
		//NVgoggles	
		if(sunOrMoon<1)then //0 night, 1 day
		{
			_nvgs = ["SPE_GER_FL_Signal_Flashlight"];
			if(side _unit == sideE)then{_nvgs = ["SPE_US_FL_TL122"];};
			_nv=0;
			//has NVG on helmet?
			{
				_it=_x;
				{
					if(_it==_x)then{_nv=1;};
				} forEach _nvgs;
			} forEach (assignedItems _unit);
			if(_nv==1)exitWith{};
			//has NVG in the inventory? put it on the helmet
			{
				_it=_x;
				{	
					if(_it==_x)then{_unit assignItem _it;_nv=1;};
				} forEach _nvgs;
			} forEach (items _unit);
			//add NVG
			if(_nv==0)then
			{
				_n = selectRandom _nvgs;
				_unit addItem _n;
				_unit assignItem _n;
			};
		};
	};
};

//GPS
if(isPlayer _unit&&(modA=="A3"||modA=="WS"||modA=="RHS"))then
{
	_gps = ["ItemGPS","B_UavTerminal","O_UavTerminal","I_UavTerminal","C_UavTerminal","I_E_UavTerminal"];
	_gp=0;
	{
		_it=_x;
		{
			if(_it==_x)then{_gp=1;};
		} forEach _gps;
	} forEach (assignedItems _unit);
	
	if(_gp==0)then
	{
		_unit addItem "ItemGPS";
		_unit assignItem "ItemGPS";
	};
	
	//Laserbatteries
	if(binocular _unit find "Laserdesignator" >=0)then{if(count binocularMagazine _unit == 0)then{_unit addBinocularItem "Laserbatteries";};};
};