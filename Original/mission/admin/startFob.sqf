//Reset tickets. EventHandler will be activated
closeDialog 0;
call
{
	if (progress<2) exitWith {hint "Hey buddy, start the mission first";};
	if (progress==2) exitWith
	{
		_restW = [sideW] call BIS_fnc_respawnTickets; 
		_restE = [sideE] call BIS_fnc_respawnTickets;
		call
		{
			if (_restW == _restE) exitWith
			{
				hint "The tickets for both sides are equal, try again later";
			};
			if (_restW > _restE) exitWith 
			{
				[sideW,(_restE*-1)] call BIS_fnc_respawnTickets; 
				[sideE,(_restE*-1)] call BIS_fnc_respawnTickets;
			};
			if (_restE > _restW) exitWith 
			{
				[sideW,(_restW*-1)] call BIS_fnc_respawnTickets; 
				[sideE,(_restW*-1)] call BIS_fnc_respawnTickets;
			};
		};
	};
	if (progress>2) exitWith {hint "2nd phase is already running";};
};