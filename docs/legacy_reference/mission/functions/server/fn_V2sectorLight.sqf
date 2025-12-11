/*
	Author: IvosH
	
	Description:
		Create chemlight at the sectors when is night
		smoke 1min
		chem light 15min
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf

	Execution:
		[] spawn wrm_fnc_V2sectorLight;
*/

for "_i" from 0 to 1 step 0 do 
{
	"Chemlight_blue" createVehicle posAA;
	"Chemlight_yellow" createVehicle posArti;
	"Chemlight_red" createVehicle posCas;
	sleep 900;
};