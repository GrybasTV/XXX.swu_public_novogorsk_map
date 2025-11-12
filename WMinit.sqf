/*
Author: IvosH

Description:
	MISSION SETUP here you set variables for a new terrain
	
	General atributes > mission name: WARMACHINE Altis
	
Dependencies:
	init.sqf

Execution:
	#include "WMinit.sqf";
*/

//MISSION SETUP (init.sqf)
island = "ALTIS"; //map name ALTIS
env = "arid"; //environment = "desert","arid","woodland","jungle","winter" (examples: Takistan="desert", Altis="arid", Livonia="woodland", Tanoa="jungle", Chernarus winter="winter")
dawn=["3:30h",3.5]; //dawn time (1 hour before daytime)
dusk=["19:30h",19.5]; //dusk time (1 hour before night)
fogs=[[0,0,0],[0.1,0.05,90],[0,0,0]]; //fog parameters (change only fog height "90")
planes = 1; //0=No (no planes are used), 1=Yes (all "plH"s are at airfields), 2=Yes (only 2 airfields available, "plH1", "plH2", rest of the "PLH"s aren't at the airfield)
plH = 4; //number of AIRPORT MARKERS "plH1 - plH5" (3min - 5max) > Deppends on the placed invisible heliports "plH1 - plH5" in the 3DEN editor
