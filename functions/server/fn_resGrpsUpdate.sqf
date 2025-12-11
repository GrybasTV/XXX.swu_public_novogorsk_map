/*
	Author: IvosH
	
	Description:
		Add MPrespawn event handler based on the respawn type. (squad or base) Runs loop to check number of groups and update group respawn positions.
		
	Parameter(s):
		none
		
	Returns:
		nothing
		
	Dependencies:
		start.sqf
		fn_respawnEH.sqf
		
	Execution:
		[] spawn wrm_fnc_resGrpsUpdate;
*/

if !(isServer) exitWith {}; //run on the dedicated server or server host

if ((version==1 && resType==2)||(version==2 && resType==1)) then
{
	//UPDATE OF THE GROUP RESPAWN POSITIONS
	// Optimizuota: gauname allGroups vieną kartą per ciklą, o ne du kartus
	for "_i" from 0 to 1 step 0 do //infinite loop
	{
		_allGroups = allGroups; // Gauname allGroups vieną kartą
		{
			_grp = _x; //defines variable, _x = group ID
			{
				[ _grp, _x ] call BIS_fnc_removeRespawnPosition; //remove group respawn position, _x = respawn position ID
			} forEach (( _grp getVariable "BIS_fnc_getRespawnPositions_list" ) select 1 ); //performed for every respawn position of the group (get ID of each respawn position)
		} forEach _allGroups; //performed for every group
		
		{
			[_x, _x, "Squad"] call BIS_fnc_addRespawnPosition; //add group respawn position on the group leader _x = group ID
		} forEach _allGroups; //performed for every group 
		sleep 73; //delay in sec between loops
	};
};