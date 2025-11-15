# Artilerijos funkcionalumo analizė

## Apžvalga

Šiame dokumente analizuojamas artilerijos funkcionalumas projekte, palyginant su originaliu kodu.

## Pagrindiniai komponentai

### 1. Artilerijos transporto priemonės

Artilerijos transporto priemonės (`objArtiW`, `objArtiE`) ir minosvaidžiai (`objMortW`, `objMortE`) sukuriami sektoriaus užėmimo metu.

**Sukurimas:**
- Transporto priemonės sukuriamos su įgula (Gunner ir Commander pozicijos)
- Naudojamas `allowCrewInImmobile true` - įgula gali veikti net jei transporto priemonė negali judėti
- Transporto priemonės yra užrakintos vairuotojui (`lockDriver true`)
- Pridedamas support link žaidėjams (`BIS_fnc_addSupportLink`)

**Vietos:**
- `warmachine/V2startServer.sqf` - sektoriaus užėmimo metu (1330-1352 eilutės West, 1389-1411 eilutės East)
- `functions/server/fn_V2aiVehicle.sqf` - respawn logika (1134-1221 eilutės West, 1224-1311 eilutės East)

### 2. AI artilerijos naudojimas

AI naudoja artileriją per `fn_V2aiArtillery.sqf` funkciją, kuri vykdoma nuolatinėje cikle.

**Komanda:**
```sqf
_arti doArtilleryFire [_t, (getArtilleryAmmo [_arti] select 0), 8];
```

**Reikalavimai:**
- Transporto priemonė turi būti gyva (`alive objArtiW` arba `alive objMortW`)
- Transporto priemonė turi turėti įgulą (Gunner arba Commander pozicijas)
- Transporto priemonė turi turėti šaudmenų (`getArtilleryAmmo` grąžina ne tuščią masyvą)

## Skirtumai tarp originalaus ir dabartinio kodo

### Originaliame faile (`docs/original/mission/functions/server/fn_V2aiArtillery.sqf`)

**AI artilerijos aktyvacijos logika:**
```sqf
_plw={side _x==sideW} count allplayers;
_ple={side _x==sideE} count allplayers;
_nlW=true;
{if((side _x==sideW)&&(_x==leader _x)) then {_nlW=false;};} forEach allPlayers;
_nlE=true;
{if((side _x==sideE)&&(_x==leader _x)) then {_nlE=false;};} forEach allPlayers;

if((_plw==0)||((_plw>0)&&_nlW))then
{
    // West AI artilerija veikia
}

if((_plE==0)||((_plE>0)&&_nlE))then
{
    // East AI artilerija veikia
}
```

**Logika:**
- AI artilerija veikia tik jei:
  - Nėra žaidėjų (`_plw==0` arba `_ple==0`)
  - ARBA yra žaidėjų, bet nėra squad leader'ių (`(_plw>0)&&_nlW` arba `(_ple>0)&&_nlE`)
- Tai reiškia, kad jei yra squad leader'ių, AI artilerija neveikia (žaidėjai turi naudoti artileriją per support sistemą)

**Taikiniai:**
- Tik statiniai taikiniai: AA, CAS, Base 1, Base 2
- Nėra logikos, kuri tikrina priešo transporto priemones ar grupes

### Dabartiniame faile (`functions/server/fn_V2aiArtillery.sqf`)

**AI artilerijos aktyvacijos logika:**
```sqf
//AI veikia visada, nepriklausomai nuo žaidėjų buvimo (žaidėjai gali naudoti artileriją per support sistemą)
//AI artilerijos logika veikia nepriklausomai nuo žaidėjų - žaidėjai naudoja artileriją per BIS_fnc_addSupportLink
call
{
    // West pusės AI artilerija
    // Veikia visada, jei yra gyvų transporto priemonių
}
```

**Logika:**
- AI artilerija veikia visada, nepriklausomai nuo žaidėjų buvimo
- Komentaras nurodo, kad žaidėjai naudoja artileriją per `BIS_fnc_addSupportLink`, o AI veikia nepriklausomai

**Taikiniai:**
- Statiniai taikiniai: AA, CAS, Base 1, Base 2 (kaip originaliame)
- **Papildoma logika:** Priešo transporto priemonės ir didelės grupės (80-107 eilutės West, 162-189 eilutės East)
  - Tikrina priešo transporto priemones (tankai, BTR, BMP, sunkioji technika)
  - Tikrina dideles grupes (4 ar daugiau vienetų)
  - Saugumo spindulys - 100m (tikrina, ar netoli nėra savų vienetų)

## Išvados

### AI gali naudoti artileriją

**Taip, AI gali naudoti artileriją**, nes:
1. Artilerijos transporto priemonės sukuriamos su įgula (Gunner ir Commander pozicijos)
2. Naudojama `doArtilleryFire` komanda, kuri veikia su AI įgula
3. Transporto priemonės turi `allowCrewInImmobile true`, todėl įgula gali šaudyti net jei transporto priemonė negali judėti

### Skirtumai nuo originalaus

1. **Aktyvacijos logika:**
   - **Originaliame:** AI artilerija veikia tik jei nėra žaidėjų ARBA nėra squad leader'ių
   - **Dabartiniame:** AI artilerija veikia visada

2. **Taikinių logika:**
   - **Originaliame:** Tik statiniai taikiniai (AA, CAS, Base 1, Base 2)
   - **Dabartiniame:** Statiniai taikiniai + dinamiški taikiniai (priešo transporto priemonės ir didelės grupės)

3. **Papildoma funkcionalumas:**
   - **Dabartiniame:** Realistiškesnė artilerijos naudojimo logika, kuri tikrina priešo transporto priemones ir dideles grupes (inspiruota Ukrainos karo patirties)

## Rekomendacijos

### Jei norite grįžti prie originalios logikos:

1. **Pakeisti aktyvacijos logiką** - grąžinti tikrinimą, ar yra squad leader'ių:
```sqf
_plw={side _x==sideW} count allplayers;
_ple={side _x==sideE} count allplayers;
_nlW=true;
{if((side _x==sideW)&&(_x==leader _x)) then {_nlW=false;};} forEach allPlayers;
_nlE=true;
{if((side _x==sideE)&&(_x==leader _x)) then {_nlE=false;};} forEach allPlayers;

if((_plw==0)||((_plw>0)&&_nlW))then
{
    // West AI artilerija
}

if((_ple==0)||((_ple>0)&&_nlE))then
{
    // East AI artilerija
}
```

2. **Pašalinti dinamišką taikinių logiką** - palikti tik statinius taikinius (pašalinti 80-107 ir 162-189 eilutes)

### Jei norite palikti dabartinę logiką:

Dabartinė logika yra geresnė, nes:
- AI artilerija veikia visada, nepriklausomai nuo žaidėjų
- Realistiškesnė taikinių logika (priešo transporto priemonės ir didelės grupės)
- Žaidėjai vis tiek gali naudoti artileriją per support sistemą

## Testavimas

Norint patikrinti, ar AI artilerija veikia:

1. Užimti artilerijos sektorių
2. Patikrinti, ar transporto priemonė turi įgulą (Gunner ir Commander pozicijos)
3. Palaukti artilerijos šūvių (pagal `arTime` parametrą)
4. Patikrinti, ar artilerija šaudo į taikinius (AA, CAS, Base, priešo transporto priemones)

## Failai

- `functions/server/fn_V2aiArtillery.sqf` - AI artilerijos logika
- `warmachine/V2startServer.sqf` - Artilerijos sektoriaus sukūrimas
- `functions/server/fn_V2aiVehicle.sqf` - Artilerijos transporto priemonių respawn logika
- `docs/original/mission/functions/server/fn_V2aiArtillery.sqf` - Originali AI artilerijos logika

