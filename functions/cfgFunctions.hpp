class wrm
{
	tag = "wrm";
	class server
	{
		file = "functions\server";
		
		class equipment {}; //V1,V2
		class killedEH {}; //V1,V2
		class parachute {}; //V1,V2
		class resGrpsUpdate {}; //V1,V2
		class timer {}; //V1,V2

		class V2aiArtillery {};
		class V2aiCAS {};
		class V2aiMove {};
		class V2aiUpdate {};
		class V2aiVehicle {};
		class V2aiVehUpdate {};
		class V2baseSideCheck {};
		class V2cleanup {}; //Cleanup mechanizmas mirusiems objektams - VALIDUOTA SU ARMA 3 BEST PRACTICES
		class V2dynamicSimulation {}; //Dynamic Simulation sistema - įjungia DS ir prižiūri naujas grupes/transportą
		class V2clearArea {};
		class V2coolDown {};
		class V2createVehicleWithCrew {};
		class V2defBase {};
		class V2endGame {};
		class V2loadoutChange {};
		class V2mortarE {};
		class V2mortarW {};
		class V2nationChange {};
		class V2rearmVeh {};
		class V2respawnEH {};
		class V2secBE1 {};
		class V2secBE2 {};
		class V2secBW1 {};
		class V2secBW2 {};
		class V2secDefense {};
		class V2sectorLight {};
		class V2sectorSmoke {};
		class V2ticketBleed {};
		class V2unhideVeh {};
		class V2syncSupportProviders {}; //Sinhronizuoja CAS support provider'ius su teisingais lėktuvais visiems klientams (JIP)
		class V2strategicAiBalance {}; //Prestige Strategic AI Balance sistema - dinaminis AI boost pagal strateginius sektorius
		class V2prestigeSquadManager {}; //Dinaminis squad management Prestige AI sistemai
		class V2uavCleanup {}; //UAV cleanup funkcija - išvalo žaidėjo dronus iš masyvų
		class V2uavRequest_srv {}; //Serverinė UAV/UGV kūrimo funkcija
		class V2registerCrewEH {}; //Centralizuota crew event handler registracija - VALIDUOTA SU ARMA 3 BEST PRACTICES
		class V2jipRestoration {}; //JIP state restoration - užtikrina, kad JIP žaidėjai gautų teisingą misijos būseną
		class V2eventHandlerCleanup {}; //Event handler cleanup sistema - pašalina MPKilled handler'ius ir stebi memory leak'us
	};
	class client
	{
		file = "functions\client";
		
		class airDrop {}; //V1,V2
		class aiRevive {}; //V1,V2
		class arsenal {}; //V1,V2
		class arsInit {}; //V1,V2
		class flipVeh {}; //V1,V2
		class fortification {}; //V1,V2
		class leaderActions {}; //V1,V2
		class leaderHint {}; //V1,V2
		class leaderUpdate {}; //V1,V2
		class plRevive {}; //V1,V2
		class pushVeh {}; //V1,V2
		class removeDrop {}; //V1,V2
		class safeZoneVeh {}; //V1, V2(planes only)
		class supplyBox {}; //V1,V2
		
		class V2flagActions {};
		class V2hints {};
		class V2suppMrk {};
		class V2uavRequest {};
		class V2uavHover {}; //Refactored: Auto-hover logika
		class V2uavTerminal {}; //Refactored: Terminal connection logika
		class V2vehMrkE {};
		class V2vehMrkW {};
		class V2entityKilled {};
		class V2entityPlaced {};
		class extractFactionItems {}; //Automatiškai ištraukia itemus iš karių loadout'ų
		class V2syncSupportProvidersClient {}; //Kliento funkcija, kuri patikrina ir atnaujina support provider'ius prisijungiant (JIP)
		class V2createSupportMarker {}; //Kurti support marker'ius žemėlapyje (artillery, CAS, anti-air)
	};
};