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

//MODIFICATION: Pridėtas error handling ir timeout'ai, kad sistema neužstrigtų
for "_i" from 0 to 1 step 0 do 
{
	//Error handling: patikrinti, ar funkcija gali būti iškviesta
	private _startTime = time;
	private _errorOccurred = false;
	
	//Patikrinti, ar visi reikalingi kintamieji yra apibrėžti
	if(isNil "progress" || isNil "AIon")then{
		if(DBG)then{["ERROR: fn_V2aiUpdate - progress arba AIon neapibrėžti"] remoteExec ["systemChat", 0, false];};
		sleep 60; //Palaukti ilgiau, jei yra problemų
		_errorOccurred = true;
	};
	
	//Vykdyti funkciją su error handling
	if(!_errorOccurred)then{
		//Patikrinti, ar funkcija egzistuoja
		if(!isNil "wrm_fnc_V2aiMove")then{
			[] call wrm_fnc_V2aiMove;
		}else{
			if(DBG)then{["ERROR: fn_V2aiUpdate - wrm_fnc_V2aiMove neapibrėžta"] remoteExec ["systemChat", 0, false];};
			sleep 60; //Palaukti ilgiau, jei yra problemų
		};
	};
	
	//Timeout'as: jei funkcija užtrunka per ilgai, pranešti
	private _executionTime = time - _startTime;
	if(_executionTime > 10)then{
		if(DBG)then{[(format ["WARNING: fn_V2aiUpdate - wrm_fnc_V2aiMove užtruko %1 sekundžių", _executionTime])] remoteExec ["systemChat", 0, false];};
	};
	
	sleep 181;
};