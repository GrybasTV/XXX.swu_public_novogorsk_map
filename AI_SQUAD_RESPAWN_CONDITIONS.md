# AI Squado Narių Respawinimo Sąlygos

## Apžvalga

AI squado nariai respawninasi per `fn_V2respawnEH.sqf` funkciją, kuri yra kviečiama automatiškai, kai AI miršta (per `MPRespawn` event handler).

## Pagrindinės Sąlygos

### 1. Progress Patikrinimas
```sqf
if(progress<2)exitWith{};
```
- **Sąlyga**: `progress` turi būti >= 2
- **Reikšmė**: AI respawn veikia tik po tam tikros žaidimo stadijos

### 2. Gyvų Narių Patikrinimas
```sqf
if(({alive _x} count units group _unit) > 1)then
```
- **Sąlyga**: Turi būti **bent 1 kitas gyvas narys** grupėje (t.y., ne mažiau nei 2 gyvi nariai iš viso, skaičiuojant respawninamąjį)
- **Reikšmė**: Jei visi kiti mirę, AI neatsiranda prie squado

## Respawinimo Tipai (Prioritetas)

### 1. VEHICLE RESPAWN (Aukščiausias prioritetas)
**Linijos**: 112-170

**Sąlygos**:
- ✅ Turi būti bent vienas kitas gyvas grupės narys
- ✅ Kitas narys turi būti **transporto priemonėje** (`vehicle _man != _man`)
- ✅ Jei `resType == 0`: transporto priemonė turi būti mažiau nei 200m nuo bazės
- ✅ Jei `resType > 0`: transporto priemonė gali būti bet kur
- ✅ Turi būti laisva pozicija transporto priemonėje (Driver, Gunner, Commander, arba Cargo)

**Rezultatas**: AI respawnina **transporto priemonėje** prie squado nario

### 2. BASE UNDER ATTACK (Armor Base)
**Linijos**: 172-185

**Sąlygos**:
- ✅ `secBW2` (armor base) turi būti užimta
- ✅ Bazės respawn marker'is turi egzistuoti (`getMarkerColor _resBaseW!=""`)
- ✅ Bazėje turi būti **mažiau gynėjų nei priešų** (gynėjų skaičius < priešų skaičius * 1.5)

**Rezultatas**: AI respawnina **bazės gynybos pozicijoje** (`resBaseW2W`)

### 3. BASE UNDER ATTACK (Transport Base)
**Linijos**: 187-199

**Sąlygos**:
- ✅ `secBW1` (transport base) turi būti užimta
- ✅ Bazės respawn marker'is turi egzistuoti (`getMarkerColor _resFobW!=""`)
- ✅ Bazėje turi būti **mažiau gynėjų nei priešų** (gynėjų skaičius < priešų skaičius * 1.5)

**Rezultatas**: AI respawnina **bazės gynybos pozicijoje** (`resBaseW1W`)

### 4. SQUAD RESPAWN (Tik jei `resType > 0`)
**Linijos**: 201-245

**Sąlygos**:
- ✅ `resType > 0` (t.y., respawn type yra "Base, Sectors, Squad")
- ✅ Turi būti bent vienas kitas gyvas grupės narys
- ✅ Narys **negali būti ore** (`vehicle _man isKindOf "air"`)
- ✅ Turi rasti tinkamą respawn poziciją (100m už squado nario, 135-225° kampu)
- ✅ Respawinimo pozicija negali būti vandenyje
- ✅ Respawinimo pozicija negali būti per arti sektorių ar bazių (< 75m)

**Rezultatas**: AI respawnina **100m už squado nario** (135-225° kampu)

### 5. SECTORS & BASES (Paskutinis prioritetas)
**Linijos**: 247-311

**Sąlygos**:
- ✅ Turi būti bent vienas kitas gyvas grupės narys (jei visi mirę, naudoja kitą logiką)
- ✅ Randa **artimiausią** sektorių arba bazę prie squado nario
- ✅ Respawinimo marker'iai turi egzistuoti

**Rezultatas**: AI respawnina **artimiausio sektoriaus/bazės** pozicijoje

## Svarbūs Patikrinimai

### Squad Respawinimo Patikrinimai (resType > 0)
```sqf
//Narys negali būti ore
if(vehicle _man isKindOf "air")exitWith{};

//Turi rasti tinkamą poziciją
if(count _res==0)exitWith{};

//Negali būti per arti sektorių/bazių
if((_res distance posAA)<75)then{_res=selectRandom _resAAW;};
if((_res distance _posBaseW1)<75)then{...};
```

## Kiti Svarbūs Faktoriai

### Respawn Type (`resType`)
- **`resType == 0`**: "Base, Sectors" - **NĖRA squad respawn**
- **`resType == 1`**: "Base, Sectors, Squad" - **YRA squad respawn**

### Progress
- **`progress < 2`**: AI **neatsiranda** visai
- **`progress >= 2`**: AI respawn veikia

### Playable Units
Jei AI yra `playableUnits` (t.y., žaidėjas gali perjungti į jį):
- Automatiškai gauna loadout'ą per `wrm_fnc_V2loadoutChange`
- Automatiškai gauna aprangą per `wrm_fnc_equipment`
- Pridedamas prie Zeus editoriaus

## Išvados

AI squado nariai respawninasi **TIK** jei:
1. ✅ `progress >= 2`
2. ✅ Yra bent **1 kitas gyvas narys** grupėje
3. ✅ (Squad respawn) `resType > 0` ir narys nėra ore
4. ✅ (Squad respawn) Randa tinkamą poziciją (nėra vandenyje, nėra per arti sektorių/bazių)

Jei visi kiti squado nariai mirę, AI respawnina prie artimiausio sektoriaus arba bazės (ne prie squado).

