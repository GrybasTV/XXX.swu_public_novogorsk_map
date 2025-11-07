# Warmachine Misija - Modifikacija Ukrainos ir Rusijos Konfliktui

## Nuorodos ir Sąsajos

- **Originali misija**: `Original/mission/` - IvosH Warmachine misijos originalas
- **Modifikacijos failai**: Pagrindiniai failai projekto šaknyje
- **Originalios frakcijos**: `Original/frakcijos/` - MSV_south ir ua_azov frakcijų loadoutai

## Apžvalga

Tai yra **Warmachine Conquest** misijos modifikacija, pritaikyta moderniam Rusijos ir Ukrainos konfliktui. Misija naudoja RHS modus (RHS AFRF ir RHS USAF) su specialiai sukurtomis "Ukraine 2025" ir "Russia 2025" frakcijomis.

### Pagrindinės funkcijos
- Dinamiškai generuojamos misijos (AO - Area of Operation)
- Conquest režimas su sektorių kontroliu
- 1-48 žaidėjų palaikymas (SP/Coop/PvP)
- Autonominis AI, kuris dalyvauja kautynėse
- Transporto priemonių respawn sistema
- FOB/BASE statybos
- Artilerijos ir CAS palaikymas

## Modifikacijos Struktūra

### Pridėti Failai

#### Frakcijų failai (Vehicles)
- `factions/UA2025_RHS_W_V.hpp` - Ukrainos 2025 transporto priemonių konfigūracija
- `factions/RU2025_RHS_W_V.hpp` - Rusijos 2025 transporto priemonių konfigūracija

#### Loadout failai
- `loadouts/UA2025_RHS_W_L.hpp` - Ukrainos 2025 loadoutai (WEST 800-818)
- `loadouts/RU2025_RHS_W_L.hpp` - Rusijos 2025 loadoutai (EAST 500-518)

### Modifikuoti Failai

#### 1. `V2factionsSetup.sqf`
**Pridėta nauja frakcijų sekcija:**

```sqf
//RHS: Ukraine 2025 vs. Russia 2025
if("param1" call BIS_fnc_getParamValue == 16)exitWith //16
{
	modA = "RHS";
	sideW = west;
	sideE = east;
	factionW = "Ukraine 2025";
	factionE = "Russia 2025";

	//Ensure base names are defined for this faction
	nameBW1 = "Ukraine 2025 Transport base"; publicvariable "nameBW1";
	nameBW2 = "Ukraine 2025 Armor base"; publicvariable "nameBW2";
	nameBE1 = "Russia 2025 Transport base"; publicvariable "nameBE1";
	nameBE2 = "Russia 2025 Armor base"; publicvariable "nameBE2";
};
```

**Vieta**: Po `//IFA3: Wehrmacht vs. UK Army` sekcijos (apie 310 eilutę)

#### 2. `init.sqf`
**Frakcijų įkėlimas (Vehicles sekcija):**

```sqf
if(factionW=="Ukraine 2025")then
{
	#include "factions\UA2025_RHS_W_V.hpp";
};

if(factionE=="Russia 2025")then
{
	#include "factions\RU2025_RHS_W_V.hpp";
};
```

**Vieta**: RHS sekcijoje, po AFRF frakcijos (apie 397-404 eilutės)

**Loadout'ų registracija:**

```sqf
if(factionW=="Ukraine 2025")exitWith{_Load="WEST%1";_n1=800;_n2=818;};
```

```sqf
if(factionE=="Russia 2025")exitWith{_Load="EAST%1";_n1=200;_n2=218;};
```

**Vieta**: RHS loadout sekcijoje (apie 689 ir 699 eilutės)

#### 3. `description.ext`
**Lobby parametrų pridėjimas:**

```cpp
"RHS: Ukraine 2025 vs. Russia 2025" //16
```

**Vieta**: `textsParam1[]` masyve (86 eilutė)

**Parametrų masyvo išplėtimas:**

```cpp
valuesParam1[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
```

**Vieta**: 66 eilutė (pridėtas 16 į masyvą)

## Originali Misijos Struktūra

### Pagrindiniai Failai (Original/mission/)

- **init.sqf** - Pagrindinė inicializacija, struktūrų ir transporto priemonių nustatymas
- **initServer.sqf** - Serverio kintamieji ir inicializacija
- **initPlayerLocal.sqf** - Kliento inicializacija
- **description.ext** - Misijos parametrai, respawn nustatymai, loadoutai
- **V2factionsSetup.sqf** - Frakcijų pasirinkimas pagal lobby parametrus

### Warmachine Sistema (warmachine/)

- **V2dialog.sqf / V2dialog.hpp** - Misijos generatoriaus dialogas
- **V2aoCreate.sqf** - AO (Area of Operation) sukūrimas
- **V2aoSelect.sqf** - AO pasirinkimas
- **V2startServer.sqf** - Serverio starto logika
- **V2startClient.sqf** - Kliento starto logika
- **V2aiStart.sqf** - AI inicializacija
- **baseDefense.sqf** - Bazės gynybos sistema

### Funkcijos (functions/)

- **client/** - 22 kliento funkcijų failai
- **server/** - 31 serverio funkcijų failai
- **cfgFunctions.hpp** - Funkcijų konfigūracija

### Originalios Frakcijos (Original/frakcijos/)

- **MSV_south/** - Rusijos MSV frakcijos loadout failai (30+ failų)
- **ua_azov/** - Ukrainos Azov frakcijos konfigūracija

## Frakcijų Konfigūracija

### Ukraine 2025 (WEST)

**Konfigūracijos failas:** `factions/UA2025_RHS_W_V.hpp`

**Struktūra:**
- Transporto priemonių masyvai: `BikeW`, `CarW`, `CarArW`, `TruckW`, `ArmorW1`, `ArmorW2`
- Aviacijos masyvai: `HeliTrW`, `HeliArW`, `PlaneW`
- Specialūs masyvai: `aaW` (priešlėktuvinė gynyba), `artiW` (artilerija)
- Jūrų transportas: `boatTrW`, `boatArW`
- UAV/UGV: `uavsW`, `ugvsW`
- Vienetų masyvas: `unitsW` (19 vienetų tipų)
- Tiekimo konteineris: `supplyW`
- Vėliava: `flgW`
- Ending klasė: `endW`

**Loadout diapazonas:** WEST 800-818 (19 loadout'ų)

**Loadout failas:** `loadouts/UA2025_RHS_W_L.hpp`

### Russia 2025 (EAST)

**Konfigūracijos failas:** `factions/RU2025_RHS_W_V.hpp`

**Struktūra:**
- Transporto priemonių masyvai: `BikeE`, `CarE`, `CarArE`, `TruckE`, `ArmorE1`, `ArmorE2`
- Aviacijos masyvai: `HeliTrE`, `HeliArE`, `PlaneE`
- Specialūs masyvai: `aaE` (priešlėktuvinė gynyba), `artiE` (artilerija)
- Jūrų transportas: `boatTrE`, `boatArE`
- UAV/UGV: `uavsE`, `ugvsE`
- Vienetų masyvas: `unitsE` (19 vienetų tipų)
- Tiekimo konteineris: `supplyE`
- Vėliava: `flgE`
- Ending klasė: `endE`

**Loadout diapazonas:** EAST 500-518 (19 loadout'ų)

**Loadout failas:** `loadouts/RU2025_RHS_W_L.hpp`

### Konfigūracijos Redagavimas

**Transporto priemonės ir vienetai redaguojami tiesiogiai atitinkamuose `.hpp` failuose:**
- `factions/UA2025_RHS_W_V.hpp` - Ukrainos transporto priemonės ir vienetų klasės
- `factions/RU2025_RHS_W_V.hpp` - Rusijos transporto priemonės ir vienetų klasės
- `loadouts/UA2025_RHS_W_L.hpp` - Ukrainos loadout'ai
- `loadouts/RU2025_RHS_W_L.hpp` - Rusijos loadout'ai

**Pastaba:** Konkretūs transporto priemonių ir vienetų klasės pavadinimai yra failuose ir gali būti keičiami pagal poreikį. Dokumentacijoje jie nėra išvardinti, nes laikui bėgant keisis.

## Kaip Naudoti

### Lobby Parametrai

1. Paleiskite misiją
2. Lobby meniu pasirinkite **FACTIONS** parametrą
3. Pasirinkite **"RHS: Ukraine 2025 vs. Russia 2025"** (16)
4. Nustatykite kitus parametrus (Arsenal, AI, respawn ir kt.)
5. Paleiskite misiją

### Automatinis Pasirinkimas

Jei RHS modai yra įkelti ir nustatytas AUTO SELECT (0), sistema automatiškai pasirinks RHS: USAF vs AFRF frakcijas.

## Reikalingi Modai

- **RHS USAF** - United States Armed Forces mod
- **RHS AFRF** - Armed Forces of the Russian Federation mod

## Pastabos

1. **Ending'ų klasės**: Frakcijų failuose nurodomi `endW = "EndUkraine"` ir `endE = "EndRussia"`, bet `description.ext` neturi šių ending'ų klasių. Reikės pridėti, jei reikia custom ending'ų.

2. **Base pavadinimai**: Base pavadinimai nustatomi `V2factionsSetup.sqf` faile, kad būtų teisingai rodomi misijos generatoriuje.

3. **Loadout numeracija**:
   - Ukraine 2025: WEST 800-818 (19 loadout'ų) - redaguojama `init.sqf` ir `loadouts/UA2025_RHS_W_L.hpp`
   - Russia 2025: EAST 500-518 (19 loadout'ų) - redaguojama `init.sqf` ir `loadouts/RU2025_RHS_W_L.hpp`

4. **Transporto priemonių ir vienetų atnaujinimas**: Visi konkretūs pavadinimai yra frakcijų failuose ir gali būti lengvai keičiami be dokumentacijos pakeitimo.

## Tolesnė Plėtra

### Galimi Pagerinimai

1. Pridėti ending'ų klases `description.ext` faile
2. Išplėsti loadout'ų pasiūlymą (redaguoti loadout failus)
3. Atnaujinti transporto priemonių sąrašus (redaguoti factions failus)
4. Atnaujinti vienetų klasės pavadinimus (redaguoti `unitsW`/`unitsE` masyvus)
5. Sukurti custom vėliavas ir simbolius
6. Pridėti custom veidus ir balsus (redaguoti `faceW`/`faceE`, `voiceW`/`voiceE`, `nameW`/`nameE`)

### Failų Tvarkymas

- Visi modifikuoti failai turėtų būti saugomi su Original backup
- Dokumentuokite visus pakeitimus
- Testuokite po kiekvieno pakeitimo

## Changelog

### Versija 1.0 (Pradinė modifikacija)
- Pridėtos Ukraine 2025 ir Russia 2025 frakcijos
- Integruotas RHS modų palaikymas
- Sukurti loadout failai
- Modifikuoti pagrindiniai inicializacijos failai

---

**Autorius**: Modifikacija sukūrė [Vartotojas]  
**Bazė**: Warmachine misija (IvosH)  
**Licencija**: Remiantis originalios misijos licencija

