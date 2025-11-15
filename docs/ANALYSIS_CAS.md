# CAS (Close Air Support) funkcionalumo analizė

## Apžvalga

Šiame dokumente analizuojamas CAS (Close Air Support) funkcionalumas projekte, palyginant su originaliu kodu.

## Pagrindiniai komponentai

### 1. CAS sektorius

CAS sektorius (`sectorCas`) yra trečiasis pagrindinis sektorius (po Anti Air ir Artillery). Jis sukuriamas žaidimo pradžioje ir yra matomas nuo pradžių.

**Sektorius:**
- Pavadinimas: "C: CAS Tower"
- Pozicija: `posCas`
- Respawn markeriai: `resCW` (West), `resCE` (East)

**Sukurimas:**
- `warmachine/V2startServer.sqf` - sektoriaus sukūrimas (1434-1500 eilutės)
- Sektorius sukuriamas kaip `ModuleSector_F` objektas

### 2. AI CAS kviečiamas per `fn_V2aiCAS.sqf`

AI naudoja CAS per `fn_V2aiCAS.sqf` funkciją, kuri vykdoma nuolatinėje cikle.

**Komanda:**
```sqf
[_logic,nil,true] spawn BIS_fnc_moduleCAS;
```

**Reikalavimai:**
- CAS sektorius turi būti užimtas (`getMarkerColor resCW!=""` arba `getMarkerColor resCE!=""`)
- Turi būti apibrėžti lėktuvai (`PlaneW` arba `PlaneE` masyvai)
- Turi būti taikiniai (Artillery, Base 1, Base 2)

## AI CAS aktyvacijos logika

### Sąlygos, kada AI kviečia CAS:

1. **Timer:** Random laikas tarp `arTime/2` ir `arTime*2` (pagal `arTime` parametrą, default 9 min)
2. **Žaidėjų patikrinimas:** Jei yra žaidėjų, laukiama kol bus bent vienas žaidėjas
3. **Squad leader patikrinimas:** AI kviečia CAS tik jei:
   - Nėra žaidėjų (`_plw==0` arba `_ple==0`)
   - ARBA yra žaidėjų, bet nėra squad leader'ių (`(_plw>0)&&_nlW` arba `(_ple>0)&&_nlE`)
4. **CAS sektoriaus patikrinimas:** CAS sektorius turi būti užimtas (`getMarkerColor resCW!=""` arba `getMarkerColor resCE!=""`)
5. **Taikinių patikrinimas:** Turi būti bent vienas taikinys (Artillery, Base 1, Base 2)

### Taikiniai (prioritetas):

**West pusės AI CAS (prieš East):**
1. **Artillery** - jei `alive objArtiE` ir netoli nėra savų vienetų (75m spindulys)
2. **Base 1** - jei `secBE1` ir `getMarkerColor resFobE!=""` ir netoli nėra savų vienetų (75m spindulys)
3. **Base 2** - jei `secBE2` ir `getMarkerColor resBaseE!=""` ir netoli nėra savų vienetų (75m spindulys)

**East pusės AI CAS (prieš West):**
1. **Artillery** - jei `alive objArtiW` ir netoli nėra savų vienetų (75m spindulys)
2. **Base 1** - jei `secBW1` ir `getMarkerColor resFobW!=""` ir netoli nėra savų vienetų (75m spindulys)
3. **Base 2** - jei `secBW2` ir `getMarkerColor resBaseW!=""` ir netoli nėra savų vienetų (75m spindulys)

**Pastaba:** Base 2 tikrinamas tik jei nėra kitų taikinių (`if(count _tar==0)then`).

### CAS tipai:

- **Type 2:** Bombing (bombardavimas)
- **Type 3:** Strafe (šaudymas iš ginklų)

CAS tipas parenkamas atsitiktinai: `(selectRandom [2,3])`

## Skirtumai tarp originalaus ir dabartinio kodo

### Originaliame faile (`docs/original/mission/functions/server/fn_V2aiCAS.sqf`)

**Kodas:**
```sqf
_logic setDir (plHW getDir posCenter);
// ...
_logic setDir (plHE getDir posCenter);
```

**Problema:**
- Nėra patikrinimo, ar `plHW` ir `plHE` yra apibrėžti
- Jei aerodromai nėra apibrėžti, gali kilti klaida

### Dabartiniame faile (`functions/server/fn_V2aiCAS.sqf`)

**Kodas:**
```sqf
// Patikriname, ar plHW yra apibrėžtas prieš jį naudojant
if(!isNil "plHW") then {
    _logic setDir (plHW getDir posCenter);
};
// ...
// Patikriname, ar plHE yra apibrėžtas prieš jį naudojant
if(!isNil "plHE") then {
    _logic setDir (plHE getDir posCenter);
};
```

**Patobulinimas:**
- Pridėtas patikrinimas, ar aerodromai (`plHW`, `plHE`) yra apibrėžti prieš jų naudojimą
- Išvengiama klaidos, jei aerodromai nėra apibrėžti

## Išvados

### AI kviečia CAS

**Taip, AI kviečia CAS**, bet tik tam tikromis sąlygomis:

1. **Sąlygos:**
   - CAS sektorius turi būti užimtas
   - Turi būti apibrėžti lėktuvai (`PlaneW` arba `PlaneE`)
   - Turi būti taikiniai (Artillery, Base 1, Base 2)
   - Netoli taikinių nėra savų vienetų (75m spindulys)

2. **Kada AI kviečia:**
   - Jei nėra žaidėjų
   - ARBA jei yra žaidėjų, bet nėra squad leader'ių
   - **NEVEIKIA** jei yra squad leader'ių (žaidėjai turi naudoti CAS per support sistemą)

3. **Kaip veikia:**
   - Naudoja `BIS_fnc_moduleCAS` funkciją
   - Sukuria logic objektą taikinio pozicijoje
   - Nustato lėktuvo tipą iš `PlaneW` arba `PlaneE` masyvų
   - Nustato CAS tipą (2 - Bombing, 3 - Strafe)
   - Nustato kryptį iš aerodromo (`plHW` arba `plHE`) į žemės centro poziciją (`posCenter`)

### Skirtumai nuo originalaus

1. **Patikrinimas:**
   - **Originaliame:** Nėra patikrinimo, ar aerodromai yra apibrėžti
   - **Dabartiniame:** Pridėtas patikrinimas `if(!isNil "plHW")` ir `if(!isNil "plHE")`

2. **Logika:**
   - **Abu failai:** Identiška logika - AI kviečia CAS tik jei nėra squad leader'ių

## Rekomendacijos

### Dabartinė logika yra teisinga

Dabartinė logika veikia kaip originaliame faile:
- AI kviečia CAS tik jei nėra squad leader'ių
- Žaidėjai gali naudoti CAS per support sistemą (`BIS_fnc_addSupportLink`)
- Pridėtas saugesnis patikrinimas dėl aerodromų

### Galimi patobulinimai

1. **Pridėti patikrinimą, ar yra lėktuvų:**
```sqf
if(count PlaneW == 0) exitWith {};
```

2. **Pridėti patikrinimą, ar CAS sektorius yra užimtas:**
```sqf
if(getMarkerColor resCW == "") exitWith {};
```

3. **Pridėti debug pranešimus:**
```sqf
if(DBG)then{["West AI CAS: No targets found"] remoteExec ["systemChat", 0, false];};
```

## Testavimas

Norint patikrinti, ar AI CAS veikia:

1. Užimti CAS sektorių
2. Patikrinti, ar yra apibrėžti lėktuvai (`PlaneW` arba `PlaneE`)
3. Patikrinti, ar yra taikiniai (Artillery, Base 1, Base 2)
4. Patikrinti, ar nėra squad leader'ių (arba nėra žaidėjų)
5. Palaukti CAS kviečiamų (pagal `arTime` parametrą)
6. Patikrinti, ar CAS lėktuvai atsiranda ir atlieka misijas

## Failai

- `functions/server/fn_V2aiCAS.sqf` - AI CAS logika
- `warmachine/V2startServer.sqf` - CAS sektoriaus sukūrimas (1434-1500 eilutės)
- `warmachine/V2aiStart.sqf` - AI CAS funkcijos paleidimas (220 eilutė)
- `docs/original/mission/functions/server/fn_V2aiCAS.sqf` - Originali AI CAS logika

