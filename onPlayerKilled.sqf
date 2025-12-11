//Author: IvosH
// Patikriname, ar kintamieji yra apibrėžti prieš juos naudojant
if (isNil "fs") then { fs = 0; };
if (isNil "rTime") then { rTime = 60; }; // Default 60 sekundės, jei neapibrėžta

// VISUOMET naudoti rTime (iš misijos parametrų), nebent progress < 1 (misija neprasidėjo)
if(progress < 1) then {
	setPlayerRespawnTime 5; // Greitas respawn jei misija dar neprasidėjo
} else {
	setPlayerRespawnTime rTime; // Normalus respawn delay iš parametrų
};
removeAllActions player;