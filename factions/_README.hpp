/*
	Author: IvosH
	
	Description: How to add new factions
	
		MODS and FACTIONS
		
		default ARMA 3
		modA=="A3" 
			factionW	"NATO"
						"AAF"
			factionE	"CSAT"
						"AAF"
						"LDF"
						
		Global Mobilization CDLC
		modA=="GM"
			factionW	"West Germany"
						"West Germany 90"
			factionE	"East Germany"
		
		S.O.G. Prairie CDLC	
		modA=="VN"
			factionW	"US Army"
			factionE	"PAVN"

		CSLA Iron Curtain CDLC
		modA=="CSLA"
			factionW	"US Army"
			factionE	"CSLA"
		
		Western Sahara CDLC
		modA=="WS"
			factionW	"NATO"
			factionE	"SFIA"
		
		RHS mod (USAF, AFRF)
		modA=="RHS"
			factionW	"USAF"
			factionE	"AFRF"

		IFA3 mod
		modA=="IFA3"
			factionW	"Wehrmacht"
						"Afrikakorps"	
			factionE	"Red army"
						"UK Army"
						"Desert rats"
						"US Army"
		SPE CDLC
		modA=="SPE"
			factionW	"Wehrmacht"	
			factionE	"US Army"

		ENVIRONMENTS 
		
		"desert" - D
		"arid" - A
		"woodland" - W
		"jungle" - J
		"winter" - S (snow)
		(examples: Takistan="desert", Altis="arid", Livonia="woodland", Tanoa="jungle", Chernarus winter="winter")
		
	Files add:
		loadouts\Mod_Faction_environment_L.hpp (loadouts, description.ext)
		factions\Mod_Faction_environment_V.hpp (vehicles, units, init.sqf)
	
	Files to modify:
		description.ext (add new loadouts, lobby params)
		init.sqf (rules to select vehicles, loadouts)
		V2factionsSetup.sqf (faction selection, auto/lobby)
		warmachine\V2startServer.sqf + V2aoCreate.sqf(If you want to hide 2nd artillery range marker)
		warmachine\clearFences.sqf (If you want to make holes in he border fence on the map)
		
		
		functions\server\fn_V2nationChange.sqf
		functions\server\fn_V2loadoutChange.sqf
		
		functions\client\fn_arsenal.sqf
		functions\client\fn_arsInit.sqf
		
		if you add custom units (example: loadouts\A3_CSAT_J_L.hpp) then add condition to warmachine\baseDefense.sqf
*/