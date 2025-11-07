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

//Sekti progress kintamąjį ir atnaujinti action meniu, kai progress tampa 2
//Tai reikalinga, kad UAV request action atsirastų iškart po misijos sukūrimo
private _lastProgress = progress;
//Palaukti, kol misija pilnai sukurta (maksimaliai 5 minutes timeout)
private _timeout = time + 300; //5 minutes timeout
waitUntil {progress >= 2 || time >= _timeout}; //Palaukti, kol misija pilnai sukurta arba timeout'as pasiektas
if(progress >= 2)then
{
	[] call wrm_fnc_leaderActions; //Atnaujinti action meniu iškart po misijos sukūrimo
};
_lastProgress = progress;

//infinite loop - atnaujina action meniu kas 61 sekundę
for "_i" from 0 to 1 step 0 do 
{
	//Tikrinti, ar progress pasikeitė nuo <= 1 į > 1
	//Jei taip, atnaujinti action meniu
	if (_lastProgress <= 1 && progress > 1) then
	{
		[] call wrm_fnc_leaderActions;
		_lastProgress = progress;
	};
	
	[] call wrm_fnc_leaderActions;
	sleep 61;
};