/*
	Author: IvosH
	
	Description:
		Runs loop for AI to attack objectives.
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		V2startServer.sqf (BIS_fnc_addScriptedEventHandler, sectors "OnOwnerChange")
		fn_V2aiMove.sqf
		
	Execution:
		[] spawn wrm_fnc_V2aiUpdate;
*/

if !( isServer ) exitWith {}; //run on the dedicated server or server host
sleep 10;
for "_i" from 0 to 1 step 0 do 
{
	[] call wrm_fnc_V2aiMove;
	sleep 181;
};