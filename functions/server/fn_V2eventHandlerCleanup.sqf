/*
	Author: IvosH
	
	Description:
		Event handler cleanup sistema - pašalina MPKilled handler'ius iš mirusių AI
		ir stebi handler'ių skaičių debug režime
		
	Parameter(s):
		0: OBJECT - miręs unit
		1: SIDE - unit'o pusė (optional)
		
	Returns:
		nothing
		
	Dependencies:
		fn_killedEH.sqf
		
	Execution:
		[_unit, _side] call wrm_fnc_V2eventHandlerCleanup;
	
	MODIFICATIONS:
		- Sukurta nauja funkcija handler'ių cleanup'ui
		- Pridėtas debug logging handler'ių skaičiui
*/

params ["_unit", ["_side", sideUnknown]];

//Patikrinti, kad _unit yra validus
if(isNil "_unit" || isNull _unit)exitWith{};

//MP Event Handler'iai automatiškai pašalinami kai unit'as miršta
//MODIFICATION: Nebandome pašalinti MP event handler'ius rankiniu būdu,
//nes nėra tokio metodo ir tai sukelia klaidas
//MP event handler'iai bus automatiškai pašalinti Arma 3 engine

//Debug logging
if(DBG)then{
	[(format ["DEBUG: MP Event Handler'iai bus automatiškai pašalinti iš unit'o %1", typeOf _unit])] remoteExec ["systemChat", 0, false];
};
