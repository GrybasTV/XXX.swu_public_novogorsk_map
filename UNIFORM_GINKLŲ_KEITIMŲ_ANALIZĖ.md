# Uniformų ir Ginklų Keitimų Analizė

## Problemos Aprašymas

Ukraine frakcija praranda uniformas, ginklus ir kitus dalykus respawn arba misijos metu. Klausimas: ar apibrėžus Ukraine kaip East side `mission.sqm` faile, nereiktų keitimų?

## Dabartinė Sistemos Architektūra

### 1. Mission.sqm Struktūra

`mission.sqm` faile apibrėžti žaidėjai:
- **West side**: `B_Soldier_SL_F`, `B_soldier_LAT_F`, `B_soldier_AR_F`, etc. (vanilla NATO klases)
- **East side**: `O_Soldier_SL_F`, `O_soldier_LAT_F`, `O_soldier_AR_F`, etc. (vanilla CSAT klases)

**Svarbu**: `mission.sqm` naudoja **vanilla Arma 3 klases**, ne custom frakcijų klases.

### 2. Frakcijų Nustatymas

`V2factionsSetup.sqf` (linija 142-158):
```sqf
//RHS: Ukraine 2025 vs. Russia 2025
if("param1" call BIS_fnc_getParamValue == 16)exitWith //16
{
    modA = "RHS";
    sideW = west;      // Ukraine = WEST
    sideE = east;      // Russia = EAST
    factionW = "Ukraine 2025";
    factionE = "Russia 2025";
};
```

**Dabartinė konfigūracija**:
- Ukraine 2025 = **West side**
- Russia 2025 = **East side**

### 3. Loadout Keitimų Sistema

`fn_V2loadoutChange.sqf` logika:

#### A. Custom Klasės (Ukraine/Russia 2025)
```sqf
//Jei custom klasė (UA_Azov_*, RUS_MSV_*), naudoja typeOf kaip loadout
if((str _typeOf find "UA_Azov_" >= 0) || (str _typeOf find "UA_" >= 0))then
{
    _gr = _typeOf;  // Naudoja klasės config loadout'ą
}
```

#### B. Vanilla Klasės (mission.sqm)
```sqf
//Jei vanilla klasė (B_Soldier_SL_F, O_Soldier_SL_F), naudoja unitsW/unitsE array
if(typeOf _un=="B_Soldier_SL_F")exitWith{_gr= unitsW select 0;};
//unitsW[0] = "WEST800" (iš UA2025_RHS_W_L.hpp)
```

**Svarbu**: Vanilla klasės **PRIVERSTINAI** paverčiamos į custom loadout'us per `unitsW`/`unitsE` array.

### 4. Side Keitimų Sistema

`V2factionChange.sqf`:
- Jei `sideE==independent` arba `sideW==independent`, keičia vanilla unit'us į **independent side**
- Naudoja `joinAsSilent` ir `waitUntil{side _x==independent}`
- Po side keitimo kviečia `wrm_fnc_V2loadoutChange` ir `wrm_fnc_V2nationChange`

### 5. Loadout Failai

- `loadouts/UA2025_RHS_W_L.hpp` - Ukraine 2025 loadout'ai (WEST800-WEST818)
- `loadouts/RU2025_RHS_W_L.hpp` - Russia 2025 loadout'ai (EAST500-EAST518)

**Svarbu**: Loadout failai apibrėžia **custom klases** (`UA_Azov_lieutenant`, `RUS_MSV_east_lieutenant`), ne vanilla klases.

## Problemos Analizė

### Problema Nr. 1: Side Keitimas

**Dabartinė situacija**:
- Ukraine = West side `mission.sqm`
- Jei sistema keičia side į independent (kai `sideE==independent`), tai:
  1. West unit'ai (B_Soldier_*) keičiami į independent
  2. Loadout'as keičiamas per `fn_V2loadoutChange`
  3. Per side keitimą gali prarasti uniformas/ginklus

**Jei Ukraine būtų East side `mission.sqm`**:
- Ukraine = East side `mission.sqm`
- Jei `sideE==independent`, tai East unit'ai (O_Soldier_*) keičiami į independent
- **Vis tiek reikėtų loadout keitimų**, nes vanilla klases neturi teisingų uniformų/ginklų

### Problema Nr. 2: Loadout Keitimas

**Dabartinė situacija**:
1. `mission.sqm` sukuria `B_Soldier_SL_F` (vanilla NATO)
2. `fn_V2loadoutChange` paverčia į `WEST800` (UA_Azov_lieutenant)
3. `setUnitLoadout` pritaiko custom loadout'ą

**Jei Ukraine būtų East side `mission.sqm`**:
1. `mission.sqm` sukuria `O_Soldier_SL_F` (vanilla CSAT)
2. `fn_V2loadoutChange` paverčia į `EAST500` (RUS_MSV_east_lieutenant)
3. **PROBLEMA**: `unitsE[0]` turėtų būti Ukraine loadout'as, ne Russia!

**Išvada**: Jei Ukraine būtų East side, reikėtų **perdaryti visą loadout sistemą**, nes:
- `unitsE` array yra skirtas Russia/East frakcijoms
- `unitsW` array yra skirtas Ukraine/West frakcijoms

### Problema Nr. 3: Respawn Loadout

`onPlayerRespawn.sqf`:
- Respawne žaidėjas **NEKVESTA** `wrm_fnc_V2loadoutChange` automatiškai
- Loadout'as turėtų būti išsaugotas respawn metu, bet jei yra problemų su side keitimu, gali prarasti

`fn_V2respawnEH.sqf` (AI):
- AI unit'ams kviečia `wrm_fnc_V2loadoutChange` respawn metu
- Žaidėjams **NEKVESTA** (linija 24: `if (isPlayer _unit) exitWith {};`)

## Galimi Sprendimai

### Sprendimas 1: Palikti Ukraine kaip West Side

**Privalumai**:
- Nereikia keisti `mission.sqm` (visi unit'ai jau West)
- `unitsW` array jau sukonfigūruotas Ukraine loadout'ams
- Mažiau side keitimų (jei `sideE==independent`, tik Russia keičiasi)

**Trūkumai**:
- Jei sistema keičia West į independent, vis tiek gali prarasti loadout'us
- Reikia užtikrinti, kad `fn_V2loadoutChange` visada veiktų respawn metu

### Sprendimas 2: Pakeisti Ukraine į East Side

**Reikėtų pakeisti**:
1. `mission.sqm` - visus West unit'us (`B_Soldier_*`) pakeisti į East (`O_Soldier_*`)
2. `V2factionsSetup.sqf` - `sideW = east` (Ukraine = East)
3. `fn_V2loadoutChange.sqf` - `unitsE` array turėtų būti Ukraine loadout'ams
4. `loadouts/UA2025_RHS_W_L.hpp` - pakeisti į `EAST500-EAST518` (dabar `WEST800-WEST818`)
5. Visus kitus failus, kurie naudoja `sideW`/`sideE` logiką

**Privalumai**:
- Jei Ukraine = East, o Russia = independent, tai nereiktų side keitimų Ukraine
- Logiškiau (Ukraine kovojasi su Russia, bet abi gali būti skirtingi side)

**Trūkumai**:
- **DIDELIS DARBAS**: Reikia perrašyti daug failų
- Gali sugadyti kitas frakcijas (NATO vs CSAT)
- `unitsE` array dabar yra Russia loadout'ams - reikėtų perkonfigūruoti

### Sprendimas 3: Patobulinti Loadout Keitimų Sistemą (REKOMENDUOJAMAS)

**Ką reikia padaryti**:
1. **Užtikrinti, kad respawn metu visada keičiamas loadout'as**
   - Pridėti `wrm_fnc_V2loadoutChange` kvietimą `onPlayerRespawn.sqf`
   - Patikrinti, ar loadout'as tikrai pritaikytas po respawn

2. **Pagerinti side keitimų sistemą**
   - Užtikrinti, kad loadout'as keičiamas **PO** side keitimo
   - Pridėti timeout'us ir patikrinimus

3. **Pridėti debug pranešimus**
   - Loginti, kai loadout'as keičiamas
   - Loginti, kai uniforma/ginklas prarandamas

4. **Patikrinti V2clearLoadouts.sqf**
   - Šis failas ištrina respawn inventory
   - Galbūt jis per anksti ištrina loadout'us?

## Rekomendacijos

### Rekomenduojamas Sprendimas: Patobulinti Loadout Sistemą (Sprendimas 3)

**Kodėl**:
1. **Nereikia keisti `mission.sqm`** - visi unit'ai jau teisingai apibrėžti
2. **Nereikia keisti frakcijų konfigūracijos** - Ukraine = West jau veikia
3. **Fokusuotis į problemą**: Kodėl prarandami loadout'ai respawn metu?

**Ką reikia patikrinti**:
1. Ar `onPlayerRespawn.sqf` kviečia `wrm_fnc_V2loadoutChange`?
2. Ar `V2clearLoadouts.sqf` per anksti ištrina loadout'us?
3. Ar yra race condition tarp side keitimo ir loadout keitimo?

### Jei Vis Tik Keisti į East Side

**Reikėtų**:
1. Sukurti atsarginę kopiją `mission.sqm`
2. Pakeisti visus West unit'us į East
3. Perkonfigūruoti `unitsE` array Ukraine loadout'ams
4. Patikrinti, ar visi kiti failai veikia su nauja konfigūracija

**Bet tai NESPRĘS problemos**, jei problema yra su respawn loadout keitimu, ne su side keitimu.

## Išvados

1. **Apibrėžus Ukraine kaip East side `mission.sqm` NESPRĘSTŲ problemos**, jei problema yra su respawn loadout keitimu
2. **Reikia patikrinti**, kodėl prarandami loadout'ai respawn metu
3. **Rekomenduojama patobulinti loadout keitimų sistemą**, ne keisti side konfigūracijos
4. **Jei vis tik keisti**, reikėtų atsarginių kopijų ir kruopštaus testavimo

## Testavimo Planas

1. **Patikrinti respawn loadout keitimą**:
   - Prisijungti kaip žaidėjas
   - Mirti ir respawn'inti
   - Patikrinti, ar loadout'as teisingas

2. **Patikrinti side keitimą**:
   - Jei `sideE==independent`, patikrinti, ar Ukraine (West) netenka loadout'ų

3. **Patikrinti V2clearLoadouts.sqf**:
   - Patikrinti, ar jis per anksti ištrina loadout'us
   - Patikrinti, ar respawn inventory yra teisingas

## Kitas Žingsnis

Rekomenduojama **sukurti debug versiją**, kuri:
1. Logina visus loadout keitimus
2. Patikrina, ar uniforma/ginklas egzistuoja po keitimo
3. Praneša apie problemas realiu laiku

Tai padės nustatyti tikslų problemos šaltinį.

---

## KRITINĖ PROBLEMA: Respawn Loadout Keitimas

### Aptikta Problema

**`onPlayerRespawn.sqf` NEKVESTA `wrm_fnc_V2loadoutChange` funkcijos!**

**Palyginimas**:

#### AI Unit'ams (veikia):
```sqf
// fn_V2respawnEH.sqf (linija 31)
if(_unit in playableUnits)then
{
    [_unit] call wrm_fnc_V2loadoutChange;  // ✅ KVESTA
    [_unit] spawn wrm_fnc_equipment;
};
```

#### Žaidėjams (NEVEIKIA):
```sqf
// onPlayerRespawn.sqf
// ❌ NĖRA wrm_fnc_V2loadoutChange kvietimo!
// Tik:
player setSpeaker (speaker _corpse);
[player] spawn wrm_fnc_equipment;
```

### Ką Tai Reiškia?

1. **Misijos pradžioje**: `V2factionChange.sqf` kviečia `wrm_fnc_V2loadoutChange` - veikia ✅
2. **Respawn metu**: `onPlayerRespawn.sqf` **NEKVESTA** `wrm_fnc_V2loadoutChange` - **NEVEIKIA** ❌
3. **Rezultatas**: Respawne žaidėjai negauna naujo loadout'o, todėl praranda uniformas/ginklus

### Sprendimas

**Reikia pridėti `wrm_fnc_V2loadoutChange` kvietimą `onPlayerRespawn.sqf`:**

```sqf
//onPlayerRespawn.sqf
_corpse=_this select 1;
player setSpeaker (speaker _corpse);
[player, (speaker _corpse)] remoteExec ["setSpeaker",0,false];
[player, (face _corpse)] remoteExec ["setFace",0,false];

// ✅ PRIDĖTI:
[player] call wrm_fnc_V2loadoutChange;  // Pritaikyti loadout'ą respawn metu

[z1,[[player],true]] remoteExec ["addCuratorEditableObjects", 2, false];
```

### Kodėl Tai Svarbu?

1. **Respawn metu** žaidėjas gali būti su vanilla klasė (`B_Soldier_SL_F`), bet reikia custom loadout'o (`WEST800`)
2. **Be loadout keitimo** žaidėjas lieka su vanilla NATO uniforma/ginklais, ne Ukraine 2025
3. **Tai paaiškina**, kodėl prarandami loadout'ai respawn metu

### Ar Keičiant į East Side Išspręstų Problemą?

**NE!** Problema yra su **respawn loadout keitimu**, ne su side konfigūracija. Net jei Ukraine būtų East side, vis tiek reikėtų pridėti `wrm_fnc_V2loadoutChange` kvietimą `onPlayerRespawn.sqf`.

### Rekomendacija

**PRIORITETAS**: Pridėti `wrm_fnc_V2loadoutChange` kvietimą `onPlayerRespawn.sqf` **PRIEŠ** keičiant side konfigūraciją.

Tai turėtų išspręsti pagrindinę problemą su prarastais loadout'ais respawn metu.

---

## ORIGINALO SISTEMOS ANALIZĖ

### Kodėl Yra Tokia Sistema?

Originalo sistema buvo sukurta **palaikyti DAUGYBEI FRAKCIJŲ** per vieną misiją. Tai leidžia žaidėjams pasirinkti skirtingas frakcijas per lobby parametrus.

### Palaikomos Frakcijos

Sistema palaiko **daugiau nei 20 skirtingų frakcijų**:

#### Arma 3 (A3):
- NATO vs CSAT
- NATO vs AAF
- AAF vs CSAT
- NATO vs LDF

#### Global Mobilization (GM):
- West Germany vs East Germany
- West Germany 90 vs East Germany

#### S.O.G. Prairie Fire (VN):
- US Army vs PAVN

#### CSLA Iron Curtain:
- US Army vs CSLA

#### Western Sahara (WS):
- NATO vs SFIA

#### Spearhead 1944 (SPE):
- Wehrmacht vs US Army

#### RHS Mod:
- USAF vs AFRF
- **Ukraine 2025 vs Russia 2025** (mūsų pridėta)

#### IFA3 Mod:
- Wehrmacht vs Red Army
- Wehrmacht vs US Army
- Wehrmacht vs UK Army
- Afrikakorps vs Desert Rats

### Originalo Sistemos Logika

#### Originalus `fn_V2loadoutChange.sqf`:

```sqf
if (isPlayer _un) exitWith {}; //unit is player script stops here
```

**Svarbu**: Originalo sistema **NEKEITĖ ŽAIDĖJŲ LOADOUT'Ų**!

**Kodėl?**
- Sistema buvo skirta **TIK AI unit'ams**
- Žaidėjai turėjo **Virtual Arsenal** arba **respawn inventory** sistemą
- Žaidėjai gavo loadout'us iš `mission.sqm` arba `description.ext` config

#### Kaip Veikė Originalo Sistema?

1. **Misijos pradžioje**:
   - `V2factionChange.sqf` kviečia `wrm_fnc_V2loadoutChange` tik **AI unit'ams**
   - Žaidėjai **NEKEITĖ** loadout'ų

2. **Respawn metu**:
   - `onPlayerRespawn.sqf` **NEKVESTA** `wrm_fnc_V2loadoutChange`
   - Žaidėjai naudoja **respawn inventory** sistemą (Virtual Arsenal)

3. **AI respawn**:
   - `fn_V2respawnEH.sqf` kviečia `wrm_fnc_V2loadoutChange` **AI unit'ams**

### Mūsų Modifikacijos

#### Kas Pakeista?

1. **Pridėta custom klasės palaikymas žaidėjams**:
```sqf
// Dabar palaikome custom klases (Ukraine 2025 / Russia 2025)
if (isPlayer _un) then
{
    _hasCustomClass = ((str _typeOf find "UA_Azov_" >= 0) || ...);
    if (!_hasCustomClass) exitWith {};
};
```

2. **Problema**: Respawne žaidėjams **VIS TIEK NEKEITIAMA** loadout'as!

### Ar Sistema Per Sudėtinga?

#### Dabar: Daug Frakcijų = Sudėtinga Sistema

**Dabartinė sistema**:
- Palaiko 20+ frakcijų
- Dinaminis loadout keitimas per `unitsW`/`unitsE` array
- Side keitimas (west/east/independent)
- Faction keitimas per lobby parametrus

**Trūkumai**:
- Sudėtinga logika
- Daug sąlygų (`if(modA=="A3")`, `if(sideW==independent)`, etc.)
- Sunku atsekti, kai kažkas neveikia

#### Jei Supaprastintume: Tik Viena Frakcija

**Supaprastinta sistema**:
```sqf
// Tik Ukraine 2025 vs Russia 2025
if (isPlayer _un) then
{
    // Tiesiogiai pritaikyti loadout'ą
    if (typeOf _un == "B_Soldier_SL_F") then
    {
        _un setUnitLoadout "UA_Azov_lieutenant";
    };
    // ... kiti klasės
};
```

**Privalumai**:
- ✅ **Paprasčiau** - nereikia `unitsW`/`unitsE` array
- ✅ **Greičiau** - mažiau sąlygų
- ✅ **Lengviau suprasti** - tiesioginis loadout keitimas
- ✅ **Mažiau bug'ų** - mažiau logikos = mažiau problemų

**Trūkumai**:
- ❌ **Neveiktų kitos frakcijos** - NATO, CSAT, RHS USAF, etc.
- ❌ **Nereikėtų** - jei tik Ukraine vs Russia reikia

### Rekomendacijos

#### Jei Naudojate TIK Ukraine 2025 vs Russia 2025:

**SUPAPRASTINKITE SISTEMĄ!**

1. **Pašalinti** `unitsW`/`unitsE` array logiką
2. **Tiesiogiai** pritaikyti loadout'us:
```sqf
if (typeOf _un == "B_Soldier_SL_F") then
{
    _un setUnitLoadout "UA_Azov_lieutenant";
};
```

3. **Pašalinti** visus `modA`, `factionW`, `factionE` patikrinimus
4. **Pridėti** `wrm_fnc_V2loadoutChange` kvietimą `onPlayerRespawn.sqf`

**Rezultatas**:
- Paprasčiau
- Greičiau
- Mažiau bug'ų
- Lengviau priežiūrėti

#### Jei Naudojate KELIAS FRAKCIJAS:

**PALIKITE SISTEMĄ, BET PATOBULINKITE!**

1. **Pridėti** `wrm_fnc_V2loadoutChange` kvietimą `onPlayerRespawn.sqf`
2. **Patobulinti** custom klasės palaikymą
3. **Pridėti** debug pranešimus

**Rezultatas**:
- Vis dar palaikoma daug frakcijų
- Bet veikia su žaidėjais respawn metu

### Išvados

1. **Originalo sistema** buvo skirta **TIK AI unit'ams**
2. **Mūsų modifikacija** pridėjo custom klasės palaikymą žaidėjams, bet **pamiršome respawn**!
3. **Jei naudojate tik Ukraine vs Russia**, supaprastinti sistemą būtų **geriau**
4. **Jei naudojate kelias frakcijas**, palikti sistemą, bet **patobulinti** respawn logiką

### Kitas Žingsnis

**Klausimas**: Ar naudojate tik Ukraine 2025 vs Russia 2025, ar reikia palaikyti kitas frakcijas?

- **Jei tik Ukraine vs Russia**: Supaprastinti sistemą
- **Jei reikia kitų frakcijų**: Patobulinti dabartinę sistemą

