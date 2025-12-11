/*
	Author: IvosH
	
	Description:
		Preloads virtual arsenal, applies side restrictions
	
	Parameter(s):
		0: OBJECT ammobox
		1: SIDE	
		
	Returns:
		nothing
		
	Dependencies:
		init.sqf
		
	Execution:
		[] call wrm_fnc_arsInit;
*/
if (!hasInterface) exitWith {}; //run on the players only
_box=_this select 0;
_sde=_this select 1;

[_box,([_box] call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo; //remove items - side switch
[_box,([_box] call BIS_fnc_getVirtualBackpackCargo)] call BIS_fnc_removeVirtualBackpackCargo;
call
{
	//default (no mods)
	if(modA=="A3"||modA=="WS")exitWith
	{
		//check player's side
		_uav=""; _unif=[]; _hlm=[]; _s0=''; _s1='';_s2='';_s3='';_s4='';
		call
		{
			if (_sde==west) exitWith 
			{
				_uav="B_UavTerminal";
				//uniforms
				_cfgUn= "(
				((str _x find 'U_B_' >= 0)||(str _x find 'U_lxWS_B_' >= 0))&&
				(getText (_x >> 'displayName') find 'Ghillie' == -1)&&(str _x find 'Parade' == -1)
				)" configClasses (configFile>>"cfgWeapons");
				{
					_wp = configName (_x);
					_unif pushBack _wp;
				} forEach _cfgUn;
				_hlm=['HelmetB','Crew_B','Heli_B','Fighter_B','SpecB','Watchcap','Booniehat','MilCap','Shemag']; _s0='[NATO]';
				_s1='[CSAT]';_s2='[AAF]';_s3='[IDAP]';_s4='[LDF]';
			};
			if (_sde==east) exitWith 
			{
				_uav="O_UavTerminal";
				//uniforms
				_u='U_O_'; if(factionE=="SFIA")then{_u='U_lxWS_SFIA_';};
				_cfgUn= "((str _x find _u >= 0)&&(getText (_x >> 'displayName') find 'Ghillie' == -1)&&(str _x find 'Parade' == -1))" configClasses (configFile>>"cfgWeapons");
				{
					_wp = configName (_x);
					_unif pushBack _wp;
				} forEach _cfgUn;
				_hlm=['HelmetO','Crew_O','Heli_O','Fighter_O','SpecO','LeaderO','Watchcap','Booniehat','MilCap','Shemag']; _s0='[CSAT]';
				_s1='[NATO]';_s2='[AAF]';_s3='[IDAP]';_s4='[LDF]';
				if (factionE=="SFIA")then {_hlm=['ssh40','turban_03_green','turban_04_green','turban_03_black','turban_04_black','Crew_O','Heli_O','Fighter_O','Watchcap','Booniehat','MilCap','Shemag']; _s0='[SFIA]';};
			};
			if (_sde==independent) exitWith 
			{
				if ((factionW=="AAF")||(factionE=="AAF")) then
				{
					_uav="I_UavTerminal";
					_cfgUn= "((str _x find 'U_I_' >= 0)&&(str _x find '_C_' == -1)&&(str _x find '_G_' == -1)&&(getText (_x >> 'displayName') find 'Ghillie' == -1)&&(getText (_x >> 'displayName') find 'AAF' >= 0)&&(str _x find 'Parade' == -1))" configClasses (configFile>>"cfgWeapons");
					{
						_wp = configName (_x);
						_unif pushBack _wp;
					} forEach _cfgUn;
					_hlm=['HelmetI','Crew_I','Heli_I','Fighter_I','Watchcap','Booniehat','MilCap','Shemag']; _s0='[AAF]';
					_s1='[CSAT]';_s2='[NATO]';_s3='[IDAP]';_s4='[LDF]';	
				};
				if ((factionW=="LDF")||(factionE=="LDF"))then
				{
					_uav="I_E_UavTerminal";
					_cfgUn= "((str _x find 'U_I_E_' >= 0)&&(str _x find 'Parade' == -1))" configClasses (configFile>>"cfgWeapons");
					{
						_wp = configName (_x);
						_unif pushBack _wp;
					} forEach _cfgUn;
					_hlm=['HelmetHBK','Crew_I_E','Heli_I_E','Fighter_I_E','Watchcap','Booniehat','MilCap','Shemag']; _s0='[LDF]';
					_s1='[CSAT]';_s2='[NATO]';_s3='[IDAP]';_s4='[AAF]';
				};
				
			};
		};
		//items
		_itms=["Binocular","Medikit","FirstAidKit","ToolKit","MineDetector","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch","Rangefinder",_uav];
		{
			_cr=_x;
			_cfgIt= "(
			((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
			((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))&&
			(getText (_x >> '_generalMacro') find _cr >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['optic_','acc_','muzzle_','bipod_','NVGoggles','Laserdesignator','V_','Vest'];
		_ggl=[]; //googles
		_cfgGl= "(
		((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
		((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))
		)" configClasses (configFile>>"cfgGlasses");
		{
			_wp = configName (_x);
			_ggl pushBack _wp;
		} forEach _cfgGl;
		_helm=[]; //helmets
		{
			_tp=_x;
			_cfgHl= "(
				(str _x find 'H_' >= 0)&&
				((str _x find _tp >= 0)||(getText (_x >> 'displayName') find _s0 >=0 ))&&
				((getText (_x >> 'displayName') find _s1 ==-1)&&(getText (_x >> 'displayName') find _s2 ==-1)&&(getText (_x >> 'displayName') find _s3 ==-1)&&(getText (_x >> 'displayName') find _s4 ==-1))
			)" configClasses (configFile>>"cfgWeapons");
			{
				_wp = configName (_x);
				_helm pushBack _wp;
			} forEach _cfgHl;
		} forEach _hlm;
		_itms=_itms+_ggl+_unif+_helm;
		[_box,_itms,false,false] call BIS_fnc_addVirtualItemCargo; //add Items to the arsenal
		//backpacks
		_back=[];
		_cfgBp= "(
		((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
		((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0)||(getText(_x >> 'picture') find 'lxws' >= 0))&&
		(getText (_x >> 'vehicleClass') == 'Backpacks')&&
		((getText (_x >> 'displayName') find _s1 ==-1)&&(getText (_x >> 'displayName') find _s2 ==-1)&&(getText (_x >> 'displayName') find _s3 ==-1)&&(getText (_x >> 'displayName') find _s4 ==-1))
		)" configClasses (configFile>>"cfgVehicles");
		{
			_wp = configName (_x);
			_back pushBack _wp;
		} forEach _cfgBp;
		[_box,_back,false,false] call BIS_fnc_addVirtualBackpackCargo; //add Backpacks to the arsenal
		
		//Magazines, ammo
		[_box,([_box] call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
		_ammo=[];
		_cfgAm= "(
		((getText(_x >> 'author')=='Bohemia Interactive')||(getText(_x >> 'author')=='Rotators Collective'))&&
		((getText(_x >> 'picture') find 'A3\' >= 0)||(getText(_x >> 'picture') find 'a3\' >= 0)||(getText(_x >> 'picture') find 'lxWS' >= 0))
		)" configClasses (configFile>>"CfgMagazines");
		{
			_wp = configName (_x);
			_ammo pushBack _wp;
		} forEach _cfgAm;
		[_box,_ammo,false,false] call BIS_fnc_addVirtualMagazineCargo; //add Magazines to the arsenal
	};
	
	//RHS mod
	if(modA=="RHS")exitWith
	{
		//check player's side
		_uav=""; _dlc='';
		call
		{
			if (_sde==west) exitWith 
			{
				_uav="B_UavTerminal";
				_dlc='RHS_USAF';
			};
			if (_sde==east) exitWith 
			{
				_uav="O_UavTerminal";
				_dlc='RHS_AFRF';
			};
			if (_sde==independent) exitWith 
			{
				_uav="I_UavTerminal";
				_dlc='RHS_GREF';
			};
		};

		//items ALL
		_itms=["Binocular","Medikit","FirstAidKit","ToolKit","MineDetector","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch","Rangefinder",_uav];
		{
			_cr=_x;
			_cfgIt= "((str _x find 'rhs' >= 0)&&(getText (_x >> '_generalMacro') find _cr >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['optic_','acc_','muzzle_','bipod_','NVGoggles','Laserdesignator','Rangefinder','Binocular'];

		//Laserdesignators
		{
			_cr=_x;
			_cfgIt= "(getText (_x >> '_generalMacro') find _cr >= 0)" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['Laserdesignator'];

		//uniforms
		_unif=[]; 
		_cfgUn= "((str _x find 'rhs_uniform' >= 0)&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_unif pushBack _wp;
		} forEach _cfgUn;

		//googles
		_ggl=[]; 
		_cfgGl= "true" configClasses (configFile>>"cfgGlasses");
		{
			_wp = configName (_x);
			_ggl pushBack _wp;
		} forEach _cfgGl;

		//helmets, vests
		_helm=[]; 
		{
			_cr=_x;
			_cfgIt= "((getText (_x >> '_generalMacro') find _cr >= 0)&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_helm pushBack _it;
			} forEach _cfgIt;
		} forEach ['H_HelmetB','Vest_Camo_Base'];
		_itms=_itms+_ggl+_unif+_helm;
		[_box,_itms,false,false] call BIS_fnc_addVirtualItemCargo; //add Items to the arsenal

		//backpacks
		_back=[];
		_cfgBp= "((getText (_x >> 'vehicleClass') == 'Backpacks')&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgVehicles");
		{
			_wp = configName (_x);
			_back pushBack _wp;
		} forEach _cfgBp;
		[_box,_back,false,false] call BIS_fnc_addVirtualBackpackCargo; //add Backpacks to the arsenal
		
		//Magazines, ammo
		[_box,([_box] call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
		_ammo=["Laserbatteries"];
		_cfgAm= "((str _x find 'rhs_' >= 0)||(getText(_x >> 'author')=='Red Hammer Studios'))" configClasses (configFile>>"CfgMagazines");
		{
			_wp = configName (_x);
			_ammo pushBack _wp;
		} forEach _cfgAm;
		[_box,_ammo,false,false] call BIS_fnc_addVirtualMagazineCargo; //add Magazines to the arsenal
	};
	
	//IFA3 mod
	if(modA=="IFA3")exitWith
	{
		//check player's side
		_uav=""; _fac1='xxx'; _fac2='xxx'; _fac3='xxx'; _fac4='xxx';
		call
		{
			if (_sde==west) exitWith 
			{
				//_uav="B_UavTerminal";
				_fac1='_DAK_';
				_fac2='_FSJ_';
				_fac3='_GER_';
				_fac4='_ST_';
			};
			if (_sde==east) exitWith 
			{
				//_uav="O_UavTerminal";
				_fac1='_NKVD_';
				_fac2='_SOV_';
				_fac3='_NKVD_';
			};
			if (_sde==independent) exitWith 
			{
				//_uav="I_UavTerminal";
				_fac1='_UK_';
				_fac2='_US_';
				_fac3='_WP_';
			};
		};

		//items ALL
		_itms=["Medikit","FirstAidKit","LIB_ToolKit","ItemCompass","ItemMap","ItemWatch","LIB_M1918A2_BAR_Bipod"]; //"Binocular","ToolKit","MineDetector","ItemGPS","ItemRadio","Rangefinder",_uav
		{
			_cr=_x;
			_cfgIt= "((str _x find 'LIB' >= 0)&&(getText (_x >> '_generalMacro') find _cr >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['optic_','acc_','muzzle_','bipod_','Binocular','NVGoggles']; //'Laserdesignator','Rangefinder',

		//uniforms
		_unif=[]; 
		_cfgUn= "((str _x find 'U_LIB' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_unif pushBack _wp;
		} forEach _cfgUn;

		//googles
		_ggl=[]; 
		_cfgGl= "(str _x find 'G_LIB' >= 0)" configClasses (configFile>>"cfgGlasses");
		{
			_wp = configName (_x);
			_ggl pushBack _wp;
		} forEach _cfgGl;

		//helmets
		_helm=[]; 
		_cfgHl= "((str _x find 'H_LIB' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_helm pushBack _wp;
		} forEach _cfgHl;

		//vests
		_vest=[]; 
		_cfgVs= "((str _x find 'V_LIB' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_vest pushBack _wp;
		} forEach _cfgVs;

		_itms=_itms+_unif+_ggl+_helm+_vest;
		[_box,_itms,false,false] call BIS_fnc_addVirtualItemCargo; //add Items to the arsenal

		//backpacks
		_back=[];
		_cfgBp= "((str _x find 'B_LIB' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)||(str _x find 'Flamethrower' >= 0)))" configClasses (configFile>>"cfgVehicles");
		{
			_wp = configName (_x);
			_back pushBack _wp;
		} forEach _cfgBp;
		[_box,_back,false,false] call BIS_fnc_addVirtualBackpackCargo; //add Backpacks to the arsenal
		
		//Magazines, ammo
		[_box,([_box] call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
		_ammo=[];
		_cfgAm= "(str _x find 'LIB_' >= 0)" configClasses (configFile>>"CfgMagazines");
		{
			_wp = configName (_x);
			_ammo pushBack _wp;
		} forEach _cfgAm;
		[_box,_ammo,false,false] call BIS_fnc_addVirtualMagazineCargo; //add Magazines to the arsenal
	};
	
	//GM cdlc
	if(modA=="GM")exitWith
	{
		//check player's side
		_fac=''; _dlc='gm';
		call
		{
			if (_sde==west) exitWith 
			{
				//_uav="B_UavTerminal";
				_fac='gm_ge_';
			};
			if (_sde==east) exitWith 
			{
				//_uav="O_UavTerminal";
				_fac='gm_gc_';
			};
			if (_sde==independent) exitWith 
			{
			
			};
		};

		//items ALL
		_itms=["MineDetector","ItemMap","ItemRadio","ItemWatch","gm_ge_army_burnBandage","gm_ge_army_gauzeBandage","gm_ge_army_gauzeCompress","gm_ge_army_medkit_80","gm_gc_army_gauzeBandage","gm_gc_army_medkit","gm_gc_compass_f73","gm_ge_army_conat2","gm_repairkit_01","gm_watch_kosei_80"]; //"Binocular","Medikit","FirstAidKit","ToolKit","ItemCompass","ItemGPS","Rangefinder"
		{
			_cr=_x;
			_cfgIt= "((str _x find 'gm_' >= 0)&&(getText (_x >> '_generalMacro') find _cr >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['optic_','acc_','muzzle_','bipod_','Binocular','ToolKit','Medikit','NVGoggles','Laserdesignator','Rangefinder']; //funguje pouze Binocular (ostatní ponecháno pro pøípad updatu DLC)
		{
			_cr=_x;
			_cfgIt= "((str _x find 'gm_' >= 0)&&(getText (_x >> 'descriptionShort') find _cr >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['Scope','Sight','Bayonet','Suppressor'];
		
		//uniforms
		_unif=[]; 
		_cfgUn= "((str _x find _fac >= 0)&&(str _x find '_uniform' >= 0)&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_unif pushBack _wp;
		} forEach _cfgUn;

		//googles
		_ggl=[]; 
		_cfgGl= "(getText(_x >> 'dlc')==_dlc)" configClasses (configFile>>"cfgGlasses");
		{
			_wp = configName (_x);
			_ggl pushBack _wp;
		} forEach _cfgGl;

		//helmets, vests
		_helm=[]; 
		{
			_cr=_x;
			_cfgIt= "((str _x find _fac >= 0)&&(getText (_x >> '_generalMacro') find _cr >= 0)&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_helm pushBack _it;
			} forEach _cfgIt;
		} forEach ['H_HelmetB','Vest_Camo_Base'];
		_itms=_itms+_ggl+_unif+_helm;
		[_box,_itms,false,false] call BIS_fnc_addVirtualItemCargo; //add Items to the arsenal

		//backpacks
		_back=[];
		_cfgBp= "((str _x find _fac >= 0)&&(getText (_x >> 'vehicleClass') == 'Backpacks')&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgVehicles");
		{
			_wp = configName (_x);
			_back pushBack _wp;
		} forEach _cfgBp;
		[_box,_back,false,false] call BIS_fnc_addVirtualBackpackCargo; //add Backpacks to the arsenal
		
		//Magazines, ammo
		[_box,([_box] call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
		_ammo=[];
		_cfgAm= "((getText(_x >> 'dlc')==_dlc)||(getText(_x >> 'author')=='Global Mobilization'))" configClasses (configFile>>"CfgMagazines");
		{
			_wp = configName (_x);
			_ammo pushBack _wp;
		} forEach _cfgAm;
		[_box,_ammo,false,false] call BIS_fnc_addVirtualMagazineCargo; //add Magazines to the arsenal
	};
	
	//VN cdlc
	if(modA=="VN")exitWith
	{
		//check player's side
		_fac=''; _dlc='vn';
		call
		{
			if (_sde==west) exitWith 
			{
				//_uav="B_UavTerminal";
				_fac='vn_b_';
			};
			if (_sde==east) exitWith 
			{
				//_uav="O_UavTerminal";
				_fac='vn_o_';
			};
			if (_sde==independent) exitWith 
			{
				_fac='vn_i_';
			};
		};

		//items ALL
		_itms=["vn_b_item_trapkit","vn_b_item_wiretap","vn_b_item_toolkit","vn_b_item_radio_urc10","vn_o_item_radio_m252"]; //"Binocular","Medikit","FirstAidKit","ToolKit","ItemCompass","ItemGPS","Rangefinder","MineDetector","ItemMap","ItemRadio","ItemWatch" 
		{
			_cr=_x;
			_cfgIt= "((str _x find 'vn_' >= 0)&&(getText (_x >> '_generalMacro') find _cr >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['optic_','acc_','muzzle_','bipod_','Binocular','ToolKit','medikit','NVGoggles','Laserdesignator','Rangefinder','itemmap','ItemRadio','ItemWatch','minedetector','itemcompass','firstaidkit']; //funguje pouze Binocular (ostatní ponecháno pro pøípad updatu DLC)
		{
			_cr=_x;
			_cfgIt= "((str _x find 'vn_' >= 0)&&((getText (_x >> 'descriptionShort') find _cr >= 0)||(getText (_x >> 'descriptionUse') find _cr >= 0)))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['Scope','Sight','Bayonet','Suppressor'];
		
		//uniforms
		_unif=[]; 
		_cfgUn= "((str _x find _fac >= 0)&&(str _x find '_uniform' >= 0))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_unif pushBack _wp;
		} forEach _cfgUn;

		//googles
		_ggl=[]; 
		_cfgGl= "(str _x find 'vn_' >= 0)" configClasses (configFile>>"cfgGlasses");
		{
			_wp = configName (_x);
			_ggl pushBack _wp;
		} forEach _cfgGl;

		//helmets, vests
		_helm=[]; 
		{
			_cr=_x;
			_cfgIt= "((str _x find _fac >= 0)&&(str _x find _cr >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_helm pushBack _it;
			} forEach _cfgIt;
		} forEach ['_bandana','_beret','_boonie','_conehat','_headband','_helmet','_vest'];
		_itms=_itms+_ggl+_unif+_helm;
		[_box,_itms,false,false] call BIS_fnc_addVirtualItemCargo; //add Items to the arsenal

		//backpacks
		_back=[];
		_cfgBp= "((str _x find _fac >= 0)&&(str _x find '_pack' >= 0))" configClasses (configFile>>"cfgVehicles");
		{
			_wp = configName (_x);
			_back pushBack _wp;
		} forEach _cfgBp;
		[_box,_back,false,false] call BIS_fnc_addVirtualBackpackCargo; //add Backpacks to the arsenal
		
		//Magazines, ammo
		[_box,([_box] call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
		_ammo=[];
		_cfgAm= "((getText(_x >> 'dlc')==_dlc)||(getText(_x >> 'author')=='Savage Game Design'))" configClasses (configFile>>"CfgMagazines");
		{
			_wp = configName (_x);
			_ammo pushBack _wp;
		} forEach _cfgAm;
		[_box,_ammo,false,false] call BIS_fnc_addVirtualMagazineCargo; //add Magazines to the arsenal
	};
	
	//CSLA cdlc
	if(modA=="CSLA")exitWith
	{
		//check player's side
		_fac=''; //_dlc='CSLA';
		call
		{
			if (_sde==west) exitWith 
			{
				_fac='US85_';
			};
			if (_sde==east) exitWith 
			{
				_fac='CSLA_';
			};
			if (_sde==independent) exitWith 
			{
			
			};
		};

		//items ALL
		_itms=["CSLA_Documents_item","ItemMap","ItemRadio","US85_Watch","CSLA_Prim_enl","US85_FAK","US85_PRC77_item"]; //"Binocular","Medikit","FirstAidKit","ToolKit","ItemCompass","ItemGPS","Rangefinder"
		{
			_cr=_x;
			_cfgIt= "(
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))&&
			(getText (_x >> '_generalMacro') find _cr >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['optic_','acc_','muzzle_','bipod_','Binocular','toolkit','medikit','NVGoggles','_Goggles','ItemRadio','R129',
		'Laserdesignator','Rangefinder']; //funguje pouze Binocular (ostatní ponecháno pro pøípad updatu DLC)
		{
			_cr=_x;
			_cfgIt= "(
			((str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0))&&
			(getText (_x >> 'descriptionShort') find _cr >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['Scope','Sight','Bayonet','Suppressor'];
		
		//uniforms
		_unif=[]; 
		_cfgUn= "(
		(str _x find _fac >= 0)&&
		(str _x find '_uni' >= 0)&&
		(str _x find 'Ghillie' == -1)
		)" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_unif pushBack _wp;
		} forEach _cfgUn;

		//googles
		_ggl=[]; 
		_cfgGl= "(
		(str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0)
		)" configClasses (configFile>>"cfgGlasses");
		{
			_wp = configName (_x);
			_ggl pushBack _wp;
		} forEach _cfgGl;

		//helmets, vests
		_helm=[]; 
		{
			_cr=_x;
			_cfgIt= "(
			(str _x find _fac >= 0)&&
			(str _x find _cr >= 0)
			)" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_helm pushBack _it;
			} forEach _cfgIt;
		} forEach ['_helmet','_beret','cap','Cap','_hat','_gr'];
		_itms=_itms+_ggl+_unif+_helm;
		[_box,_itms,false,false] call BIS_fnc_addVirtualItemCargo; //add Items to the arsenal

		//backpacks
		_back=[];
		_cfgBp= "(
		(str _x find _fac >= 0)&&
		(str _x find '_bp' >= 0)
		)" configClasses (configFile>>"cfgVehicles");
		{
			_wp = configName (_x);
			_back pushBack _wp;
		} forEach _cfgBp;
		[_box,_back,false,false] call BIS_fnc_addVirtualBackpackCargo; //add Backpacks to the arsenal
		
		//Magazines, ammo
		[_box,([_box] call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
		_ammo=[];
		_cfgAm= "(
		(str _x find 'US85_' >= 0)||(str _x find 'CSLA_' >= 0)
		)" configClasses (configFile>>"CfgMagazines");
		{
			_wp = configName (_x);
			_ammo pushBack _wp;
		} forEach _cfgAm;
		[_box,_ammo,false,false] call BIS_fnc_addVirtualMagazineCargo; //add Magazines to the arsenal
	};	

	//SPE cdlc
	if(modA=="SPE")exitWith
	{
		//check player's side
		_uav=""; _fac1='xxx'; _fac2='xxx'; _fac3='xxx'; _fac4='xxx';
		call
		{
			if (_sde==west) exitWith 
			{
				//_uav="B_UavTerminal";
				_fac1='_GER_';
				_fac2='_ST_'
			};
			if (_sde==east) exitWith 
			{
				//_uav="O_UavTerminal";
				//_fac1='_SOV_';
			};
			if (_sde==independent) exitWith 
			{
				//_uav="I_UavTerminal";
				_fac1='_US_';

			};
		};

		//items ALL
		_itms=["SPE_M1918A2_BAR_Bipod","SPE_M1918A2_BAR_Handle"]; //"Binocular","ToolKit","MineDetector","ItemGPS","ItemRadio","Rangefinder",_uav,"Medikit","FirstAidKit","ItemCompass","ItemMap","ItemWatch"
		{
			_cr=_x;
			_cfgIt= "((str _x find 'SPE_' >= 0)&&(getText (_x >> '_generalMacro') find _cr >= 0))" configClasses (configFile>>"cfgWeapons");
			{
				_it = configName (_x);
				_itms pushBack _it;
			} forEach _cfgIt;
		} forEach ['optic_','acc_','muzzle_','bipod_','Binocular','NVGoggles','FirstAidKit','Medikit','ToolKit','ItemCompass','ItemMap','ItemWatch']; //'Laserdesignator','Rangefinder',


		//uniforms
		_unif=[]; 
		_cfgUn= "((str _x find 'U_SPE' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_unif pushBack _wp;
		} forEach _cfgUn;

		//googles
		_ggl=[]; 
		_cfgGl= "(str _x find 'G_SPE' >= 0)" configClasses (configFile>>"cfgGlasses");
		{
			_wp = configName (_x);
			_ggl pushBack _wp;
		} forEach _cfgGl;

		//helmets
		_helm=[]; 
		_cfgHl= "((str _x find 'H_SPE' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_helm pushBack _wp;
		} forEach _cfgHl;

		//vests
		_vest=[]; 
		_cfgVs= "((str _x find 'V_SPE' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)))" configClasses (configFile>>"cfgWeapons");
		{
			_wp = configName (_x);
			_vest pushBack _wp;
		} forEach _cfgVs;

		_itms=_itms+_unif+_ggl+_helm+_vest;
		[_box,_itms,false,false] call BIS_fnc_addVirtualItemCargo; //add Items to the arsenal

		//backpacks
		_back=[];
		_cfgBp= "((str _x find 'B_SPE' >= 0)&&((str _x find _fac1 >= 0)||(str _x find _fac2 >= 0)||(str _x find _fac3 >= 0)||(str _x find _fac4 >= 0)||(str _x find 'Flam' >= 0)))" configClasses (configFile>>"cfgVehicles");
		{
			_wp = configName (_x);
			_back pushBack _wp;
		} forEach _cfgBp;
		[_box,_back,false,false] call BIS_fnc_addVirtualBackpackCargo; //add Backpacks to the arsenal
		
		//Magazines, ammo
		[_box,([_box] call BIS_fnc_getVirtualMagazineCargo)] call BIS_fnc_removeVirtualMagazineCargo;
		_ammo=[];
		_cfgAm= "(str _x find 'SPE_' >= 0)" configClasses (configFile>>"CfgMagazines");
		{
			_wp = configName (_x);
			_ammo pushBack _wp;
		} forEach _cfgAm;
		[_box,_ammo,false,false] call BIS_fnc_addVirtualMagazineCargo; //add Magazines to the arsenal
	};
};