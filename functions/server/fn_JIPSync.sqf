/*
	Author: IvosH
	
	Description:
		Sinchronizuoja misijos būseną naujiems žaidėjams, kurie prisijungė prie vykstančios misijos (JIP)
		
	Parameter(s):
		0: OBJECT - žaidėjas, kuriam reikia sinchronizuoti misijos būseną
		
	Returns:
		nothing
		
	Dependencies:
		warmachine\V2startClient.sqf
		
	Execution:
		[player] remoteExec ["wrm_fnc_JIPSync", 2, false];
*/

if !(isServer) exitWith {}; // Tik serveris

params ["_player"];

// Patikriname ar žaidėjas egzistuoja ir ar misija jau pradėta
if(isNull _player) exitWith {};
if(progress <= 1) exitWith {
	["JIP synchronization: Mission not started yet"] remoteExec ["systemChat", _player, false];
};

// Sinchronizuojame misijos parametrus su nauju žaidėju
// Visi svarbūs kintamieji jau turėtų būti sinchronizuoti per publicVariable
// Tačiau reikia užtikrinti, kad klientas gautų visą reikalingą informaciją per V2startClient.sqf

// Patikriname ar visi reikalingi kintamieji yra apibrėžti
if(isNil "aoType" || isNil "missType" || isNil "posCenter") exitWith {
	["JIP synchronization: Mission parameters not available"] remoteExec ["systemChat", _player, false];
};

// Siunčiame misijos parametrus naujam žaidėjui
// Naudojame tą patį formatą kaip V2startButton.sqf
[
	[
		//mission parameters
		aoType, missType, day, resTickets, weather, ticBleed, fogLevel, timeLim, AIon, resType, revOn, resTime, viewType, vehTime, 
		//objectives position
		posArti, posCas, posAA, posBaseW1, posBaseW2, posBaseE1, posBaseE2, 
		//infantry respawn 
		resArtiW, resArtiE, resCasW, resCasE, resAAW, resAAE, resBaseW1W, resBaseW1E, resBaseW2W, resBaseW2E, resBaseE1W, resBaseE1E, resBaseE2W, resBaseE2E,  
		//vehicle respawn
		rBikeW, rTruckW, rHeliTrW, rCarArW, rCarW, rArmorW1, rHeliArW, rArmorW2, rBikeE, rTruckE, rHeliTrE, rCarArE, rCarE, rArmorE1, rHeliArE, rArmorE2,
		//directions
		dirBW, dirBE,
		//center
		posCenter, minDis,
		AOsize
	], 
	"warmachine\V2startClient.sqf"
] remoteExec ["execVM", _player, false];

["JIP synchronization: Mission state synchronized"] remoteExec ["systemChat", _player, false];

