/*
	Author: IvosH change line (118,125)
	
	Description: FACTIONS SETUP
		For Mods and Factions see "factions\README.sqf"

	Parameter(s):
		NONE
		
	Returns:
		NA
		
	Dependencies:
		init.sqf

	Execution:
		#include "factionsSetup.sqf";
*/

//NATO vs. CSAT (default setup)
modA = "A3"; //mod used for units and vehicles (Deppends on the lobby parameters)
sideW = west; //sides > west, east, independent
sideE = east; 
factionW = "NATO"; publicVariable "factionW"; //factions
factionE = "CSAT"; publicVariable "factionE";
call
{
	//AUTO SELECT
	if("param1" call BIS_fnc_getParamValue == 0)exitWith //0
	{
		//Stratis
		if(island=="STRATIS")then
		{
			sideE = independent; 
			factionE = "AAF";	
		};
		
		//Livonia
		if(island=="LIVONIA")then
		{
			sideE = independent; 
			factionE = "LDF";
		};
		
		//Global Mobilization 80
		if(island=="WEFERLINGEN")then
		{			
			modA = "GM";
			factionW = "West Germany";
			factionE = "East Germany";
			planes = 0;
		};
		
		//S.O.G. Prairie Fire
		if(island=="CAM LAO NAM"||island=="KHE SANH"||island=="THE BRA")then
		{			
			modA = "VN";
			factionW = "US Army";
			factionE = "PAVN";
		};
		
		//CSLA Iron Curtain
		if(island=="Gabreta"||island=="Polanek")then
		{			
			modA = "CSLA";
			factionW = "US Army";
			factionE = "CSLA";
		};

		//Western Sahara
		if(island=="SEFROU RAMAL")then
		{			
			modA = "WS";
			factionE = "SFIA";
		};
		
		//SPE
		if(island=="NORMANDY"||island=="MORTAIN")then
		{			
			modA = "SPE";
			sideE = independent;
			factionW = "Wehrmacht";
			factionE = "US Army";
		};

		if(isClass(configfile >> "CfgMods" >> "SPE"))then
		{
			if(island=="UTAH BEACH"||island=="OMAHA BEACH")then
			{			
				modA = "SPE";
				sideE = independent;
				factionW = "Wehrmacht";
				factionE = "US Army";
			};
		};

		//RHS
		if((isClass(configfile >> "CfgMods" >> "RHS_AFRF"))&&(isClass(configfile >> "CfgMods" >> "RHS_USAF")))then
		{			
			sideE = east; 
			modA = "RHS";
			factionW = "USAF";
			factionE = "AFRF";
		};

		//IFA3
		if((isClass(configfile >> "CfgMods" >> "IF"))||(isClass(configfile >> "CfgMods" >> "WW2")))then
		{
			call
			{
				if((island=="BARANOW")||(island=="PANOVO")||(island=="STASZOW")||(island=="ODERBRUCH"))exitWith
				{
					modA = "IFA3";
					factionW = "Wehrmacht";
					factionE = "Red army";	
				};
				if((island=="CROSSING POINT")||(island=="NEAVILLE")||(island=="OMAHA")||(island=="MERDERET")||(island=="COLLEVILLE")||(island=="BENOUVILLE"))exitWith
				{
					modA = "IFA3";
					sideE = independent; 
					factionW = "Wehrmacht";
					factionE = "US Army";	
				};
				if((island=="BRAY DUNES"))exitWith
				{
					modA = "IFA3";
					sideE = independent; 
					factionW = "Wehrmacht";
					factionE = "UK Army";
				};
				if((island=="EL ALAMEIN")||(island=="TOBRUK"))exitWith
				{
					modA = "IFA3";
					sideE = independent; 
					factionW = "Afrikakorps";
					factionE = "Desert rats";
				};
			};	
		};
	};

	//RHS: Ukraine 2025 vs. Russia 2025
	if("param1" call BIS_fnc_getParamValue == 16)exitWith //16
	{
		modA = "RHS";
		sideW = west;
		sideE = east;
		factionW = "Ukraine 2025"; publicVariable "factionW";
		factionE = "Russia 2025"; publicVariable "factionE";
		systemChat "[FACTION] Ukraine 2025 vs Russia 2025 selected";
		systemChat format ["[FACTION] factionW: %1, factionE: %2", factionW, factionE];

		//Ensure base names are defined for this faction
		nameBW1 = "Ukraine 2025 Transport base"; publicvariable "nameBW1";
		nameBW2 = "Ukraine 2025 Armor base"; publicvariable "nameBW2";
		nameBE1 = "Russia 2025 Transport base"; publicvariable "nameBE1";
		nameBE2 = "Russia 2025 Armor base"; publicvariable "nameBE2";
	};

	//NATO vs. CSAT
	if("param1" call BIS_fnc_getParamValue == 1)exitWith //1
	{
		modA = "A3";
		sideW = west;
		sideE = east; 
		factionW = "NATO";
		factionE = "CSAT";	
	};
	
	//NATO vs. AAF
	if("param1" call BIS_fnc_getParamValue == 2)exitWith //2
	{
		sideE = independent; 
		factionE = "AAF";	
	};
	
	//AAF vs. CSAT
	if("param1" call BIS_fnc_getParamValue == 3)exitWith //3
	{
		sideW = independent; 
		factionW = "AAF";	
	};
	
	//NATO vs. LDF
	if("param1" call BIS_fnc_getParamValue == 4)exitWith
	{
		sideE = independent; 
		factionE = "LDF";
	};
	
	//LDF vs. CSAT
	if("param1" call BIS_fnc_getParamValue == 5)exitWith
	{
		sideW = independent; 
		factionW = "LDF";
	};
	
	//Global Mobilization: West Germany 80s vs. East Germany
	if("param1" call BIS_fnc_getParamValue == 6)exitWith
	{
		if(!isClass(configfile >> "CfgMods" >> "gm"))
		exitWith{hint "Global Mobilization DLC not found. Default factions selected";};
		modA = "GM"; 
		factionW = "West Germany";
		factionE = "East Germany";
		planes = 0;
	};
	
	//Global Mobilization: West Germany 90s vs. East Germany
	if("param1" call BIS_fnc_getParamValue == 7)exitWith
	{
		if(!isClass(configfile >> "CfgMods" >> "gm"))
		exitWith{hint "Global Mobilization DLC not found. Default factions selected";};
		modA = "GM"; 
		factionW = "West Germany 90";
		factionE = "East Germany";
		planes = 0;
	};
	
	//S.O.G. Prairie Fire: US Army vs. PAVN
	if("param1" call BIS_fnc_getParamValue == 8)exitWith
	{			
		if(!isClass(configfile >> "CfgMods" >> "vn"))
		exitWith{hint "S.O.G. Prairie Fire DLC not found. Default factions selected";};
		modA = "VN";
		factionW = "US Army";
		factionE = "PAVN";
	};

	//CSLA Iron Curtain: US Army vs. CSLA
	if("param1" call BIS_fnc_getParamValue == 9)exitWith
	{			
		if(!isClass(configfile >> "CfgMods" >> "CSLA"))
		exitWith{hint "CSLA Iron Curtain DLC not found. Default factions selected";};
		modA = "CSLA";
		factionW = "US Army";
		factionE = "CSLA";
	};

	//Western Sahara: NATO vs SFIA
	if("param1" call BIS_fnc_getParamValue == 10)exitWith
	{			
		if(!isClass(configfile >> "CfgMods" >> "ws"))
		exitWith{hint "Western Sahara DLC not found. Default factions selected";};
		modA = "WS";
		factionE = "SFIA";
	};
	
	//SPE: Wehrmacht vs. US Army
	if("param1" call BIS_fnc_getParamValue == 11)exitWith
	{			
		if(!isClass(configfile >> "CfgMods" >> "SPE"))
		exitWith{hint "Spearhead 1944 DLC not found. Default factions selected";};
		modA = "SPE";
		sideE = independent;
		factionW = "Wehrmacht";
		factionE = "US Army";
	};
	
	//RHS: USA vs. RUS
	if("param1" call BIS_fnc_getParamValue == 12)exitWith
	{
		if((!isClass(configfile >> "CfgMods" >> "RHS_USAF"))&&(!isClass(configfile >> "CfgMods" >> "RHS_AFRF")))
		exitWith{hint "RHS-USAF and RHS-AFRF MOD not found. Default factions selected";};
		if(!isClass(configfile >> "CfgMods" >> "RHS_USAF"))
		exitWith{hint "RHS-USAF MOD not found. Default factions selected";};		
		if(!isClass(configfile >> "CfgMods" >> "RHS_AFRF"))
		exitWith{hint "RHS-AFRF MOD not found. Default factions selected";};
		modA = "RHS";
		factionW = "USAF"; publicVariable "factionW";
		factionE = "AFRF"; publicVariable "factionE";
	};
	
	//IFA3: Wehrmacht vs. Red army
	if("param1" call BIS_fnc_getParamValue == 13)exitWith
	{
		if((!isClass(configfile >> "CfgMods" >> "IF"))&&(!isClass(configfile >> "CfgMods" >> "WW2")))
		exitWith{hint "IFA3 MOD not found. Default factions selected";};
		modA = "IFA3";
		factionW = "Wehrmacht";
		factionE = "Red army";	
	};
	
	//IFA3: Wehrmacht vs. US Army
	if("param1" call BIS_fnc_getParamValue == 14)exitWith
	{
		if((!isClass(configfile >> "CfgMods" >> "IF"))&&(!isClass(configfile >> "CfgMods" >> "WW2")))
		exitWith{hint "IFA3 MOD not found. Default factions selected";};
		modA = "IFA3";
		sideE = independent; 
		factionW = "Wehrmacht";
		factionE = "US Army";
	};
	
	//"IFA3: Wehrmacht vs. UK Army
	if("param1" call BIS_fnc_getParamValue == 15)exitWith
	{
		if((!isClass(configfile >> "CfgMods" >> "IF"))&&(!isClass(configfile >> "CfgMods" >> "WW2")))
		exitWith{hint "IFA3 MOD not found. Default factions selected";};
		modA = "IFA3";
		sideE = independent; 		
		if(env=="desert")then
		{
			factionW = "Afrikakorps";
			factionE = "Desert rats";
		}else
		{
			factionW = "Wehrmacht";
			factionE = "UK Army";
		};
	};
};
