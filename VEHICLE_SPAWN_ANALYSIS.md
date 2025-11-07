# Transporto Priemonių Spawn'inimas - Analizė

## Apžvalga

Šis dokumentas analizuoja, kur transporto priemonės atspawn'inamos ne bazėje ir kur gali kilti problemų su crew atsiradimu.

---

## Atvejai, Kai Transporto Priemonės Spawn'inamos NE Bazėje

### 1. AI Transporto Priemonės (Autonomous Vehicles)

**Vieta**: `functions/server/fn_V2aiVehicle.sqf`

**Kurios transporto priemonės**:
- `aiVehW` - West automobiliai (CarArW)
- `aiArmW` - West šarvuotės (ArmorW2)
- `aiArmW2` - West šarvuotės 2 (jei AIon>2)
- `aiCasW` - West Close Air Support (HeliArW/PlaneW)
- `aiVehE` - East automobiliai (CarArE)
- `aiArmE` - East šarvuotės (ArmorE2)
- `aiArmE2` - East šarvuotės 2 (jei AIon>2)
- `aiCasE` - East Close Air Support (HeliArE/PlaneE)

**Kur spawn'inamos**:
- `posW1` - West base 1 sritis (iki 200m nuo bazės, arba net bazėje jei yra kelias)
- `posW2` - West base 2 sritis (iki 200m nuo bazės)
- `posE1` - East base 1 sritis (iki 200m nuo bazės)
- `posE2` - East base 2 sritis (iki 200m nuo bazės)
- `plHW` - West heliportas (bazėje)
- `plHE` - East heliportas (bazėje)

**Kaip randamos pozicijos** (`warmachine/V2aiStart.sqf`):
```sqf
//Pavyzdys: posW1
_roadW1 = [posBaseW1,200,(posBaseW1 nearRoads 30)] call BIS_fnc_nearestRoad;
if(isNull _roadW1)then
{
	//Jei nėra kelio, randama 100m nuo bazės
	_prW=objBaseW1 getRelPos [100,random 360];
	posW1 = _prW findEmptyPosition [0, 50, _vSel];
	if(count posW1==0)then{posW1=_prW;};
}else
{
	//Jei yra kelias, naudojamas kelio pozicija
	posW1= getPosATL _roadW1;
};
```

**Problema su crew**:
- ✅ Naudoja `createVehicleCrew` - **PROBLEMA!**
- ⚠️ Crew gali neturėti teisingų loadout'ų (naudojama predefined crew iš transporto priemonės config'o)
- ⚠️ Crew gali turėti netinkamus loadout'us (pvz. senesnius RHS stilius)

**Kodas**:
```sqf
//Pavyzdys: aiVehW spawn'inimas
aiVehW = createVehicle [_typ, posW1, [], 0, "NONE"];
[aiVehW,[_tex,1]] call bis_fnc_initVehicle;
createVehicleCrew aiVehW; // ⚠️ PROBLEMA - naudoja predefined crew
```

**Kada spawn'inamos**:
- Automatiškai, kai transporto priemonė sunaikinta arba nebegali judėti
- Cooldown laikas: `trTime` (default 3 min) arba `arTime` (default 9 min)

---

### 2. Sector Objektai (AA, Artillery, Mortar)

**Vieta**: `functions/server/fn_V2aiVehicle.sqf`, `warmachine/V2startServer.sqf`

**Kurios transporto priemonės**:
- `objAAW` - West Anti-Air
- `objAAE` - East Anti-Air
- `objArtiW` - West Artilerija
- `objArtiE` - East Artilerija
- `objMortW` - West Mortyras
- `objMortE` - East Mortyras

**Kur spawn'inamos**:
- `posAA` - Anti-Air sektorius (AO srityje, **NE bazėje**)
- `posArti` - Artilerijos sektorius (AO srityje, **NE bazėje**)

**Problema su crew**:
- ✅ Naudoja rankinį crew sukūrimą (`createUnit` + `moveIn...`)
- ✅ Crew turi teisingus loadout'us (naudojama `crewW` / `crewE`)

**Kodas**:
```sqf
//Pavyzdys: objAAW crew sukūrimas
_grpAAW=createGroup [sideW, true];
for "_i" from 1 to (objAAW emptyPositions "Gunner") step 1 do
{
	_unit = _grpAAW createUnit [crewW, posAA, [], 0, "NONE"];
	_unit moveInGunner objAAW;
};
```

**Kada spawn'inamos**:
- Pirmą kartą: kai sektorius užimamas (per `V2startServer.sqf`)
- Respawinimas: kai transporto priemonė sunaikinta arba crew miręs

---

## Problemų Analizė

### 1. AI Transporto Priemonės - `createVehicleCrew` Problema

**Problema**:
- `createVehicleCrew` naudoja **predefined crew** iš transporto priemonės config'o
- Crew gali turėti **netinkamus loadout'us** (pvz. senesnius RHS stilius)
- Crew gali turėti **netinkamą frakciją** (jei transporto priemonė yra iš kitos frakcijos)

**Pavyzdys**:
```sqf
//Sukuriamas tankas
_tank = createVehicle ["rhsusf_m1a1aimwd_usarmy", posW1, [], 0, "NONE"];

//Crew sukuriamas automatiškai
createVehicleCrew _tank;

//Crew klasė: "rhsusf_army_ucp_crewman" (iš tanko config'o)
//Bet mūsų frakcija naudoja: "rhsusf_army_ucp_crewman" (laimė - atsitiktinai sutampa)
//Jei tankas yra iš kitos frakcijos, crew klasė gali nesutapti
```

**Sprendimas**:
- Pakeisti `createVehicleCrew` į `createUnit [crewW/crewE, ...]` + `moveIn...`
- Pašalinti seną crew (jei yra)
- Sukurti naują crew naudojant `crewW` / `crewE` iš frakcijų failų

---

### 2. Sector Objektai - Jau Naudoja Teisingą Metodą

**Būklė**:
- ✅ Sector objektai jau naudoja rankinį crew sukūrimą
- ✅ Crew turi teisingus loadout'us
- ✅ Crew turi teisingą frakciją

**Išvada**:
- Sector objektai **NĖRA problema**
- Jie naudoja teisingą metodą

---

## Rekomendacijos

### 1. Pakeisti AI Transporto Priemonių Crew Sukūrimą

**Kur pakeisti**:
- `functions/server/fn_V2aiVehicle.sqf`

**Kaip pakeisti**:
- Vietoj `createVehicleCrew`, naudoti `createUnit [crewW/crewE, ...]` + `moveIn...`
- Patikrinti `emptyPositions` kiekvienam pozicijai (Driver, Gunner, Commander, Cargo)

**Pavyzdys**:
```sqf
//Sena versija (PROBLEMA)
aiVehW = createVehicle [_typ, posW1, [], 0, "NONE"];
[aiVehW,[_tex,1]] call bis_fnc_initVehicle;
createVehicleCrew aiVehW; // ⚠️ PROBLEMA

//Nauja versija (SPRENDIMAS)
aiVehW = createVehicle [_typ, posW1, [], 0, "NONE"];
[aiVehW,[_tex,1]] call bis_fnc_initVehicle;

//Pašalinti seną crew (jei yra)
{ aiVehW deleteVehicleCrew _x } forEach crew aiVehW;

//Sukurti naują crew su mūsų nustatytu crewW
_grp = createGroup [sideW, true];

//Driver
if (aiVehW emptyPositions "Driver" > 0) then
{
	_unit = _grp createUnit [crewW, posW1, [], 0, "NONE"];
	_unit moveInDriver aiVehW;
};

//Gunner (jei yra)
if (aiVehW emptyPositions "Gunner" > 0) then
{
	_unit = _grp createUnit [crewW, posW1, [], 0, "NONE"];
	_unit moveInGunner aiVehW;
};

//Commander (jei yra)
if (aiVehW emptyPositions "Commander" > 0) then
{
	_unit = _grp createUnit [crewW, posW1, [], 0, "NONE"];
	_unit moveInCommander aiVehW;
};
```

---

## Išvados

### ✅ Identifikuoti Atvejai

1. **AI Transporto Priemonės** (`aiVehW`, `aiArmW`, `aiCasW`, `aiVehE`, `aiArmE`, `aiCasE`):
   - Spawn'inamos bazės srityje (ne bazėje)
   - ⚠️ Naudoja `createVehicleCrew` - **PROBLEMA!**
   - Reikia pakeisti į `createUnit [crewW/crewE, ...]` + `moveIn...`

2. **Sector Objektai** (`objAAW`, `objAAE`, `objArtiW`, `objArtiE`, `objMortW`, `objMortE`):
   - Spawn'inami sektoriuose (AO srityje)
   - ✅ Jau naudoja teisingą metodą (rankinis crew sukūrimas)

### ⚠️ Problema

**AI transporto priemonės** naudoja `createVehicleCrew`, kuris:
- Naudoja predefined crew iš transporto priemonės config'o
- Crew gali turėti netinkamus loadout'us
- Crew gali turėti netinkamą frakciją

### ✅ Sprendimas

Pakeisti AI transporto priemonių crew sukūrimą:
- Pašalinti seną crew (jei yra)
- Sukurti naują crew naudojant `crewW` / `crewE` iš frakcijų failų
- Patikrinti `emptyPositions` kiekvienam pozicijai

---

## Kitas Žingsnis

Jei norite, galiu:
1. Pakeisti `createVehicleCrew` į `createUnit [crewW/crewE, ...]` + `moveIn...` visoms AI transporto priemonėms
2. Patikrinti, ar viskas veikia teisingai
3. Atnaujinti dokumentaciją

**Klausimas**: Ar norite, kad pradėčiau implementuoti šiuos pakeitimus?

