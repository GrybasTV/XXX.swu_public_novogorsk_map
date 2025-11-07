# Respawn ir Loadout Sistema - Paaiškinimas

## Problema

**Klausimas**: Ar lobbyje nebus vanilla aprangos prieš pasirenkant game mode?

## Kaip Veikia Sistema

### 1. `respawnOnStart = 1`

**Vieta**: `description.ext` (32 eilutė)

**Kas vyksta**:
- Žaidėjai automatiškai respawn'ina misijos pradžioje
- Tai vyksta **prieš** game mode pasirinkimą

**Problema**:
- Jei loadout'ai dar nėra sukurti, žaidėjai gali matyti vanilla aprangą
- Arba žaidėjai turi pasirinkti loadout iš respawn meniu

---

### 2. Loadout'ų Sukūrimas

**Vieta**: `init.sqf` (606-937 eilutės)

**Kada vyksta**:
- Serverio pusėje (`if(isServer)then`)
- **Prieš** game mode pasirinkimą
- **Prieš** žaidėjų respawn'ą

**Kaip veikia**:
```sqf
//RHS modui
if(modA=="RHS")exitWith
{
	//sideW
	if(factionW=="Ukraine 2025")exitWith{_Load="WEST%1";_n1=800;_n2=818;};
	for "_i" from _n1 to _n2 step 1 do 
	{
		[sideW, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;
	};
	
	//sideE
	if(factionE=="Russia 2025")exitWith{_Load="EAST%1";_n1=200;_n2=218;};
	for "_i" from _n1 to _n2 step 1 do 
	{
		[sideE, [format [_Load, _i],4,-1]] call BIS_fnc_addRespawnInventory;
	};
};
```

**Rezultatas**:
- Loadout'ai (WEST800-WEST818, EAST500-EAST518) pridedami į respawn meniu
- Bet žaidėjai **turi pasirinkti** loadout iš respawn meniu

---

### 3. Arma 3 Respawn Sistema

**Kaip veikia**:
- `respawnTemplates[] = {"Revive","MenuPosition","MenuInventory","Tickets"}`
- `MenuInventory` leidžia žaidėjui pasirinkti loadout iš respawn meniu
- **Nėra automatinio loadout priskirimo** - žaidėjas turi pasirinkti

**Problema**:
- Jei žaidėjas respawn'ina su `respawnOnStart = 1`, jis gali matyti vanilla aprangą
- Žaidėjas turi atidaryti respawn meniu ir pasirinkti loadout
- Arba Arma 3 automatiškai priskiria pirmą loadout'ą (pagal prioritetą)

---

## Galimos Problemos

### 1. Vanilla Apranga Prieš Game Mode Pasirinkimą

**Problema**:
- Žaidėjai respawn'ina su `respawnOnStart = 1`
- Loadout'ai gali būti sukurti tik po game mode pasirinkimo
- Arba žaidėjai turi pasirinkti loadout iš respawn meniu

**Sprendimas**:
- Loadout'ai **jau sukurti** `init.sqf` prieš game mode pasirinkimą
- Bet žaidėjai **turi pasirinkti** loadout iš respawn meniu
- Arba Arma 3 automatiškai priskiria pirmą loadout'ą

### 2. Default Loadout'ai

**Problema**:
- Nėra default loadout'ų nustatytų
- Žaidėjai turi pasirinkti loadout iš respawn meniu
- Jei nepasirenka, gali matyti vanilla aprangą

**Sprendimas**:
- Arma 3 automatiškai priskiria pirmą loadout'ą iš respawn meniu
- Bet jei loadout'ai dar nėra sukurti, žaidėjai matys vanilla aprangą

---

## Išvada

**Atsakymas**: **GALBŪT** bus vanilla apranga, bet tik trumpam laikui.

**Kodėl**:
1. `init.sqf` sukuria loadout'us **prieš** game mode pasirinkimą
2. Loadout'ai (EAST500-EAST518, WEST800-WEST818) pridedami į respawn meniu
3. Arma 3 automatiškai priskiria pirmą loadout'ą iš respawn meniu
4. Bet jei loadout'ai dar nėra sukurti arba nėra pasirinkti, žaidėjai gali matyti vanilla aprangą

**Sprendimas**:
- Loadout'ai **jau sukurti** `init.sqf` prieš game mode pasirinkimą
- Arma 3 automatiškai priskiria pirmą loadout'ą
- Bet jei norite, galite pridėti automatinį loadout priskirimą `onPlayerRespawn.sqf`

---

## Rekomendacija

Jei norite, kad žaidėjai automatiškai gautų tinkamą loadout'ą pirmą kartą respawn'inant, galite pridėti automatinį loadout priskirimą `onPlayerRespawn.sqf`:

```sqf
//Pridėti į onPlayerRespawn.sqf
if (progress <= 1) then 
{
	//Pirmas respawn - automatiškai priskirti loadout
	call
	{
		if(side player == sideW && factionW == "Ukraine 2025")exitWith
		{
			[player, ["WEST800", 4, -1]] call BIS_fnc_setRespawnInventory;
			player setUnitLoadout (missionconfigfile >> "CfgRespawnInventory" >> "WEST800");
		};
		if(side player == sideE && factionE == "Russia 2025")exitWith
		{
			[player, ["EAST500", 4, -1]] call BIS_fnc_setRespawnInventory;
			player setUnitLoadout (missionconfigfile >> "CfgRespawnInventory" >> "EAST500");
		};
	};
};
```

**Bet tai nėra būtina**, nes Arma 3 automatiškai priskiria pirmą loadout'ą iš respawn meniu.

