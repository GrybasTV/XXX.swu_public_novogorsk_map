# Dronų Sistemos Analizė ir Pasiūlymai

## Nuorodos

- **Esama dronų sistema**: `functions/client/fn_V2uavRequest.sqf`
- **Cooldown sistema**: `functions/server/fn_V2coolDown.sqf`
- **Action'ų pridėjimas**: `functions/client/fn_leaderActions.sqf`
- **Respawn laikas**: `warmachine/V2startServer.sqf` (arTime - 90-1800 sekundžių)

## Esama Sistemos Analizė

### Dabartinė Būklė

**Dronų tipai**:
- **Ukrainos 2025**: `B_UAV_01_F` (Darter), `B_UAV_06_F` (Pelican), `B_UAV_02_F` (Stomper)
- **Rusijos 2025**: `O_UAV_01_F` (Tayran), `O_UAV_06_F` (Pelican), `O_UAV_02_F` (K40 Ababil-3)

**Dabartinė sistema**:
- ✅ Tik vienas dronas per pusę (WEST/EAST)
- ✅ Visi squad leaderiai dalijasi tą patį droną
- ✅ Cooldown yra globalus per pusę (`arTime` - 90-1800 sekundžių)
- ✅ Cooldown priklauso nuo "Vehicles respawn time" parametro

**Problema**: 
- FPV kamikadze dronai yra mažesni, greitesni ir pigesni nei vanilla dronai
- Šiuolaikiškas karas naudoja daug dronų
- Vienas dronas per pusę yra per mažai

## Pasiūlymas: Per-Squad Dronų Sistema

### 1. FPV Kamikadze Dronai

**Galimi dronų variantai**:

#### Standartiniai Arma 3 mažieji dronai:
- `B_UAV_06_F` (Pelican) - mažas, greitas, gali būti naudojamas kaip FPV
- `O_UAV_06_F` (Pelican) - mažas, greitas, gali būti naudojamas kaip FPV

#### Arba specialūs modų dronai (jei yra):
- RHS modai gali turėti specialių dronų
- Reikės patikrinti, kokie dronai yra prieinami RHS moduose

**Rekomendacija**: 
- Naudoti `B_UAV_06_F` ir `O_UAV_06_F` (Pelican) - jie yra mažesni, greitesni ir tinkamesni FPV stiliui
- Arba pridėti daugiau mažų dronų variantų į masyvus

### 2. Per-Squad Dronų Sistema

**Sprendimas**: Atskiras dronų tracking'as kiekvienam squad leaderiui

**Struktūra**:
```sqf
//Vietoj vieno uavW/uavE, naudosime masyvą su player ID
uavSquadW = []; // [[playerUID, uavObject, cooldown], ...]
uavSquadE = []; // [[playerUID, uavObject, cooldown], ...]
```

**Pakeitimai**:
1. Kiekvienas squad leader gali turėti savo droną
2. Cooldown skaičiuojamas atskirai kiekvienam
3. Daugiau dronų vienu metu (realistiškiau)

### 3. Greitesnis Cooldown

**Dabartinis cooldown**:
- Priklauso nuo `arTime` (Vehicles respawn time)
- 0 = 90 sekundžių (1,5 min)
- 1 = 180 sekundžių (3 min)
- 2 = 540 sekundžių (9 min) - DEFAULT
- 3 = 900 sekundžių (15 min)
- 4 = 1800 sekundžių (30 min)

**Pasiūlymas**: Dronų cooldown = `arTime / 4` (4x greičiau)

**Pavyzdžiai**:
- Jei `arTime = 540` (9 min) → dronų cooldown = **135 sekundžių (2,25 min)**
- Jei `arTime = 180` (3 min) → dronų cooldown = **45 sekundžių**
- Jei `arTime = 90` (1,5 min) → dronų cooldown = **22,5 sekundžių**

**Alternatyva**: Dronų cooldown = `arTime / 2` (2x greičiau)
- Jei `arTime = 540` (9 min) → dronų cooldown = **270 sekundžių (4,5 min)**

**Rekomendacija**: Pradėti nuo `/4` (4x greičiau), nes FPV dronai yra pigesni ir greitesni.

## Detalus Pasiūlymas

### A. Failų Pakeitimai

#### 1. `initServer.sqf` - Pridėti naujus kintamuosius

**Vieta**: Po `uavW=objNull;` (apie 105 eilutė)

**Pridėti**:
```sqf
//Per-squad dronų sistema (Ukraine/Russia)
uavSquadW = []; publicvariable "uavSquadW"; // [[playerUID, uavObject, cooldownTime], ...]
uavSquadE = []; publicvariable "uavSquadE"; // [[playerUID, uavObject, cooldownTime], ...]
```

#### 2. `functions/client/fn_V2uavRequest.sqf` - Perrašyti logiką

**Keisti iš**: Vienas dronas per pusę  
**Keisti į**: Atskiras dronas kiekvienam squad leaderiui

**Nauja logika**:
```sqf
//Rasti ar žaidėjas jau turi droną
_playerUID = getPlayerUID player;
_side = side player;
_uavSquad = if(_side == sideW)then{uavSquadW}else{uavSquadE};
_index = -1;
{
    if((_x select 0) == _playerUID)exitWith{_index = _forEachIndex;};
}forEach _uavSquad;

//Patikrinti ar yra aktyvus dronas
if(_index >= 0)then
{
    _uavData = _uavSquad select _index;
    _uavObj = _uavData select 1;
    _cooldown = _uavData select 2;
    
    if(!isNull _uavObj && alive _uavObj)exitWith
    {
        hint "You already have an active drone";
    };
    
    if(_cooldown > 0)exitWith
    {
        _t=_cooldown; _s="sec"; 
        if(_cooldown>60)then{_t=floor (_cooldown/60); _s="min";};
        hint parseText format ["Drone cooldown<br/>Ready in %1 %2",_t,_s];
    };
};

//Sukurti naują droną
// ...
```

#### 3. `functions/server/fn_V2coolDown.sqf` - Pridėti per-squad cooldown

**Pridėti naują sekciją**:
```sqf
//Per-squad dronų cooldown (Ukraine/Russia)
if(_tpe==9)exitWith //UAV WEST per-squad
{
    //Rasti žaidėjo droną masyve ir atnaujinti cooldown
};
if(_tpe==10)exitWith //UAV EAST per-squad
{
    //Rasti žaidėjo droną masyve ir atnaujinti cooldown
};
```

#### 4. `factions/UA2025_RHS_W_V.hpp` - Pakeisti dronus į FPV

**Pakeisti**:
```sqf
//UAV - FPV kamikadze dronai (mažesni, greitesni)
uavsW=["B_UAV_06_F"]; //Pelican - mažas, greitas FPV dronas
//Galima pridėti daugiau variantų, jei yra
```

#### 5. `factions/RU2025_RHS_W_V.hpp` - Pakeisti dronus į FPV

**Pakeisti**:
```sqf
//UAV - FPV kamikadze dronai (mažesni, greitesni)
uavsE=["O_UAV_06_F"]; //Pelican - mažas, greitas FPV dronas
```

### B. Cooldown Laiko Skaičiavimas

**Nauja funkcija**: `warmachine/V2startServer.sqf`

**Pridėti po arTime nustatymo**:
```sqf
//Dronų cooldown (4x greičiau nei automobilių)
droneCooldownTime = floor (arTime / 4); 
publicvariable "droneCooldownTime";
systemChat format ["Drone cooldown set to %1 seconds", droneCooldownTime];
```

**Pavyzdžiai**:
- `arTime = 90` → `droneCooldownTime = 22` sekundžių
- `arTime = 180` → `droneCooldownTime = 45` sekundžių
- `arTime = 540` → `droneCooldownTime = 135` sekundžių (2,25 min)
- `arTime = 900` → `droneCooldownTime = 225` sekundžių (3,75 min)
- `arTime = 1800` → `droneCooldownTime = 450` sekundžių (7,5 min)

### C. Dronų Kiekis

**Dabartinis**: 1 dronas per pusę  
**Naujas**: N dronų (kur N = squad leaderių skaičius)

**Pavyzdys**:
- Jei yra 5 squad leaderiai West pusėje → 5 dronai gali būti aktyvūs vienu metu
- Jei yra 3 squad leaderiai East pusėje → 3 dronai gali būti aktyvūs vienu metu

## Prieš Naudojant / Trūkumai

### Prieš Naudojant

1. ✅ Realistiškiau - šiuolaikiškas karas naudoja daug dronų
2. ✅ Geriau gameplay - kiekvienas squad leader gali turėti savo droną
3. ✅ Greitesnis cooldown - dronai yra pigesni, greitesni
4. ✅ FPV dronai - mažesni, tinkamesni kamikadze stiliui

### Trūkumai / Problemos

1. ⚠️ **Performance**: Daugiau dronų = daugiau serverio apkrovos
2. ⚠️ **Balance**: Gali būti per daug dronų, jei yra daug squad leaderių
3. ⚠️ **Saugumas**: Reikia patikrinti, ar nebus exploit'ų (pvz. keisti squad leader)
4. ⚠️ **Cleanup**: Reikia šalinti dronus, kai squad leader palieka arba miršta

## Alternatyvūs Sprendimai

### Variantas 1: Greitesnis Cooldown, Bet Vienas Dronas

**Pasiūlymas**: Palikti vieną droną per pusę, bet padaryti cooldown 4x greitesnį

**Prieš**: 
- Lengviau implementuoti
- Mažiau performance problemų

**Prieš**:
- Vis dar tik vienas dronas per pusę

### Variantas 2: Per-Squad, Bet Ribotas Kiekis

**Pasiūlymas**: Leisti iki 3 dronų per pusę vienu metu

**Prieš**:
- Subalansuota
- Nelabai per daug dronų

**Prieš**:
- Vis dar ribojimas

### Variantas 3: Dronų Pool Sistema

**Pasiūlymas**: Dronų pool'as (pvz. 5 dronų), kuriuos dalijasi visi squad leaderiai

**Prieš**:
- Subalansuota
- Realistiškiau

**Prieš**:
- Sudėtingiau implementuoti

## Rekomendacija

**Rekomenduoju**: **Per-Squad Sistema + 4x Greitesnis Cooldown**

**Priežastys**:
1. Realistiškiau - šiuolaikiškas karas naudoja daug dronų
2. Geriau gameplay - kiekvienas squad leader gali turėti savo droną
3. Greitesnis cooldown - FPV dronai yra pigesni
4. FPV dronai - mažesni, tinkamesni

**Limitai**:
- Jei yra performance problemų, galima pridėti maksimalų dronų kiekį (pvz. 5 per pusę)
- Jei yra balance problemų, galima padidinti cooldown (pvz. `/2` vietoj `/4`)

## Testavimo Rekomendacijos

1. ✅ Patikrinti, ar veikia su 1 squad leader
2. ✅ Patikrinti, ar veikia su 5+ squad leaderiais
3. ✅ Patikrinti cooldown laiką skirtingais `arTime` reikšmėmis
4. ✅ Patikrinti, ar dronai teisingai šalinami, kai squad leader palieka
5. ✅ Patikrinti performance su daug dronų
6. ✅ Patikrinti, ar nėra exploit'ų

## Kitas Žingsnis

Jei sutinkate su šiuo pasiūlymu, galiu:
1. Sukurti detalių implementacijos planą
2. Pradėti implementuoti pakeitimus
3. Arba pirmiausia testuoti su mažesniais pakeitimais

**Klausimas**: Ar norite, kad pradėčiau implementuoti per-squad sistemą su 4x greičiu cooldown'u?

