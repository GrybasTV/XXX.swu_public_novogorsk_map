/*
	Author: IvosH
	
	Description:
		Runs loop to check if player is group leader. Update combat support and action menu available for the group leader.
		lUpdate: 0 = respawn, 1 = was leader in last update, 2 = wasn't leader last update
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		WarMachine scripts
		
	Execution:
		[] spawn wrm_fnc_leaderUpdate;
*/

if (!hasInterface) exitWith {}; //run on all players include server host

//infinite loop
for "_i" from 0 to 1 step 0 do 
{
	[] call wrm_fnc_leaderActions;
	sleep 61;
};