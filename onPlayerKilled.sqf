//Author: IvosH
//FIX: Visada naudoti rTime vietoj hardkodinto 5 sekundžių respawn laiko
//fs kintamasis nėra patikimai nustatomas JIP žaidėjams, todėl jie gavo 5 sekundžių respawn laiką vietoj teisingo rTime
//Dabar visi žaidėjai (įskaitant JIP) gaus teisingą respawn laiką pagal config parametrus
if (!isNil "rTime") then {
	setPlayerRespawnTime rTime;
} else {
	//Fallback - jei rTime nėra apibrėžtas, naudoti default reikšmę iš description.ext
	setPlayerRespawnTime 100;
};
removeAllActions player;

//UAV Cleanup - išvalyti žaidėjo dronus iš masyvų kai žaidėjas miršta
[getPlayerUID player, side player] call wrm_fnc_V2uavCleanup;