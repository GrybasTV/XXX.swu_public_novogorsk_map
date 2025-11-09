/*
	Author: IvosH
	
	Description:
		Event handler for MPkilled. reduce respawn tickets when AI is killed
		
	Parameter(s):
		0: VARIABLE killed unit
		1: SIDE
		
	Returns:
		BOOL
		
	Dependencies:
		fn_resGrpsUpdate.sqf
		fn_aiMove.sqf

	Execution:
		[_unit,side] spawn wrm_fnc_killedEH;
	
	MODIFICATIONS:
		- Pašalintas sleep 1 prieš moveOut - gali sukelti blokavimą su daug AI
		- Pridėtas throttling remoteExec iškvietimams - queue sistema
		- Pridėti patikrinimai, kad _unit yra validus prieš moveOut
*/

if(progress<2)exitWith{};
params ["_unit", "_side"]; //Naudoti params vietoj select - saugiau ir aiškiau
if(isNil "_unit" || isNil "_side")exitWith{}; //Patikrinti ar parametrai yra apibrėžti
if(!local _unit)exitWith{};
if (isPlayer _unit) exitWith {}; //unit is player script stops here

//Throttling sistema: kaupia ticket'ų pakeitimus ir vykdo batch'ais
//Inicijuoti queue masyvą, jei dar neegzistuoja
if(isNil "wrm_killedEH_ticketQueue")then{
	wrm_killedEH_ticketQueue = [];
	wrm_killedEH_lastProcessTime = 0;
};

//Pridėti ticket'ų pakeitimą į queue
wrm_killedEH_ticketQueue pushBack _side;

//Vykdyti queue batch'ais (maksimaliai 10 iškvietimų per sekundę)
//Jei praėjo bent 0.1s nuo paskutinio batch'o, vykdyti queue
if(time - wrm_killedEH_lastProcessTime >= 0.1)then{
	//Susumuoti ticket'ų pakeitimus pagal side (naudojame masyvus suderinamumui)
	private _ticketChangesW = 0;
	private _ticketChangesE = 0;
	private _ticketChangesI = 0;
	
	{
		if(_x == sideW)then{
			_ticketChangesW = _ticketChangesW - 1;
		}else{
			if(_x == sideE)then{
				_ticketChangesE = _ticketChangesE - 1;
			}else{
				if(_x == independent)then{
					_ticketChangesI = _ticketChangesI - 1;
				};
			};
		};
	} forEach wrm_killedEH_ticketQueue;
	
	//Vykdyti ticket'ų pakeitimus batch'ais
	if(_ticketChangesW != 0)then{
		[sideW, _ticketChangesW] remoteExec ["BIS_fnc_respawnTickets", 2, false];
	};
	if(_ticketChangesE != 0)then{
		[sideE, _ticketChangesE] remoteExec ["BIS_fnc_respawnTickets", 2, false];
	};
	if(_ticketChangesI != 0)then{
		[independent, _ticketChangesI] remoteExec ["BIS_fnc_respawnTickets", 2, false];
	};
	
	//Išvalyti queue
	wrm_killedEH_ticketQueue = [];
	wrm_killedEH_lastProcessTime = time;
};

//Pašalinti sleep 1 - moveOut veikia be sleep
//Patikrinti, kad _unit vis dar egzistuoja ir yra vehicle'e prieš moveOut
//Naudojame !isNull vietoj alive, nes unit jau miręs
if(vehicle _unit != _unit && !isNull _unit && !isNull vehicle _unit)then{
	moveOut _unit;
};

//MODIFICATION: Pridėtas event handler cleanup - pašalinti handler'ius iš mirusio unit'o
//Tai padeda išvengti memory leak
[_unit, _side] call wrm_fnc_V2eventHandlerCleanup;