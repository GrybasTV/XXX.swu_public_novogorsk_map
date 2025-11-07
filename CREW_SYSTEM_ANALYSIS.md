# Arma 3 Crew Sistema - Analizė ir Tyrimas

## Apžvalga

Šis dokumentas analizuoja, kaip veikia crew sistema Arma 3, kokie skirtumai tarp `createVehicleCrew` ir `createUnit` su crew klasėmis, ir kodėl tai svarbu.

---

## Dabartinė Būklė

### Kaip Dabar Veikia

#### 1. Transporto Priemonės (Car, Truck, Armor, Helicopter, Plane)

**Vieta**: `warmachine/V2startServer.sqf` (apie 624-684 eilutės)

**Kodas**:
```sqf
_veh = createVehicle [_typ, [_res select 0, _res select 1, 50], [], 0, "NONE"];
// ... kiti nustatymai ...
// Crew nėra sukurtas - tik transporto priemonė
```

**Rezultatas**:
- Transporto priemonė sukuriama BE crew
- Crew sukuriamas tik kai žaidėjas įsėda arba AI naudoja
- Jei naudojamas `createVehicleCrew`, jis naudoja **predefined crew iš transporto priemonės config'o**

#### 2. Specialūs Veiksmai (AA, Artillery, Mortar)

**Vieta**: `functions/server/fn_V2aiVehicle.sqf`, `warmachine/V2startServer.sqf`

**Kodas**:
```sqf
//Pašalinti seną crew
{ objAAW deleteVehicleCrew _x } forEach crew objAAW;

//Sukurti naują crew su config'e nustatytu crewW
_grpAAW = createGroup [sideW, true];
for "_i" from 1 to (objAAW emptyPositions "Gunner") step 1 do
{
	_unit = _grpAAW createUnit [crewW, posAA, [], 0, "NONE"];
	_unit moveInGunner objAAW;
};
```

**Rezultatas**:
- Crew sukuriamas naudojant `crewW` / `crewE` iš frakcijų failų
- Crew turi teisingus loadout'us pagal frakciją

#### 3. Dronai (UAV/UGV)

**Vieta**: `functions/client/fn_V2uavRequest.sqf`

**Kodas**:
```sqf
_uav = createVehicle [(selectRandom _uavs), _plh, [], 0, "FLY"];
createVehicleCrew _uav; // Naudoja predefined crew iš drono config'o
```

**Rezultatas**:
- Crew sukuriamas naudojant `createVehicleCrew`
- Naudoja **predefined crew iš drono config'o** (ne iš frakcijų failų)

---

## Skirtumai: createVehicleCrew vs createUnit + crewW/crewE

### 1. `createVehicleCrew`

**Kas vyksta**:
- Arma 3 pats automatiškai sukuria crew
- Naudoja crew klasę, kuri yra **predefined transporto priemonės config'e**
- Pavyzdys: `rhsusf_m1a1aimwd_usarmy` config'e turi `crew = "rhsusf_army_ucp_crewman"`

**Problema**:
- Jei transporto priemonė yra iš RHS modų, crew klasė gali būti **fiksuota** mod'o config'e
- Ne visada atitinka mūsų frakcijos `crewW` / `crewE` nustatymus
- Crew gali turėti **netinkamus loadout'us** (pvz. senesnius RHS stilius)

**Pavyzdys**:
```sqf
//Sukuriamas tankas
_tank = createVehicle ["rhsusf_m1a1aimwd_usarmy", _pos, [], 0, "NONE"];

//Crew sukuriamas automatiškai
createVehicleCrew _tank;

//Crew klasė: "rhsusf_army_ucp_crewman" (iš tanko config'o)
//Bet mūsų frakcija naudoja: "rhsusf_army_ucp_crewman" (laimė - atsitiktinai sutampa)
```

### 2. `createUnit [crewW/crewE, ...] + moveIn...`

**Kas vyksta**:
- Mes patys sukuriame crew naudojant mūsų nustatytą klasę
- Naudoja `crewW` / `crewE` iš frakcijų failų
- Crew turi **teisingus loadout'us** pagal mūsų frakciją

**Pavyzdys**:
```sqf
//Sukuriamas tankas
_tank = createVehicle ["rhsusf_m1a1aimwd_usarmy", _pos, [], 0, "NONE"];

//Pašaliname seną crew (jei yra)
{ _tank deleteVehicleCrew _x } forEach crew _tank;

//Sukuriamas crew su mūsų nustatytu crewW
_grp = createGroup [sideW, true];
_unit = _grp createUnit [crewW, _pos, [], 0, "NONE"];
_unit moveInDriver _tank;
_unit = _grp createUnit [crewW, _pos, [], 0, "NONE"];
_unit moveInGunner _tank;
_unit = _grp createUnit [crewW, _pos, [], 0, "NONE"];
_unit moveInCommander _tank;
```

**Pranašumas**:
- ✅ Crew turi teisingus loadout'us pagal frakciją
- ✅ Galima kontroliuoti crew klasę
- ✅ Konsistentiškumas su kitomis sistemomis (AA, Artillery)

---

## Kodėl Tai Svarbu?

### 1. Loadout'ų Konsistentiškumas

**Problema**:
- Jei naudojamas `createVehicleCrew`, crew gali turėti **netinkamus loadout'us**
- Pavyzdys: Tankas turi crew su senesniais RHS loadout'ais, bet žaidėjai naudoja naujausius

**Sprendimas**:
- Naudoti `crewW` / `crewE` iš frakcijų failų
- Crew turės **tokius pačius loadout'us** kaip ir žaidėjai

### 2. Frakcijų Konsistentiškumas

**Problema**:
- Skirtingos transporto priemonės gali turėti **skirtingus crew** config'e
- Pavyzdys: `rhsusf_m1a1aimwd_usarmy` turi `rhsusf_army_ucp_crewman`, bet `rhsusf_m998_w_s_2dr` gali neturėti crew config'o

**Sprendimas**:
- Naudoti vieną `crewW` / `crewE` visoms transporto priemonėms
- Visi crew turės **tokius pačius loadout'us** ir **tą pačią frakciją**

### 3. Balance

**Problema**:
- Jei crew turi netinkamus loadout'us, tai gali turėti **netinkamus ginklus arba aprangą**
- Pavyzdys: Crew turi senesnius ginklus, bet žaidėjai turi naujausius

**Sprendimas**:
- Naudoti `crewW` / `crewE` iš frakcijų failų
- Crew turės **tokius pačius ginklus** kaip ir žaidėjai

### 4. Modų Kompatibiliškumas

**Problema**:
- Skirtingi modai gali turėti **skirtingus crew** config'e
- Pavyzdys: RHS modai turi savo crew klasės, bet mes norime naudoti mūsų nustatytas

**Sprendimas**:
- Naudoti `crewW` / `crewE` iš frakcijų failų
- Neatsiranda priklausomybių nuo modų config'ų

---

## Arma 3 Config Sistema

### Kaip Veikia Crew Config

**Transporto priemonės config'e**:
```cpp
class rhsusf_m1a1aimwd_usarmy : rhsusf_m1a1aim_base
{
	crew = "rhsusf_army_ucp_crewman"; // Predefined crew klasė
	// ... kiti parametrai ...
};
```

**Kai naudojamas `createVehicleCrew`**:
- Arma 3 automatiškai naudoja `crew = "rhsusf_army_ucp_crewman"` iš config'o
- Crew sukuriamas su **tokia pačia klasė**, kaip nurodyta config'e

**Problema**:
- Jei transporto priemonė yra iš kitos frakcijos arba mod'o, crew klasė gali **nesutapti** su mūsų frakcijos `crewW` / `crewE`

---

## Dabartinė Misijos Sistema

### Kas Naudoja `createVehicleCrew`

1. **Dronai** (`fn_V2uavRequest.sqf`):
   ```sqf
   createVehicleCrew _uav;
   ```
   - Naudoja predefined crew iš drono config'o
   - ⚠️ **Problema**: Crew gali turėti netinkamus loadout'us

2. **AI Transporto Priemonės** (`fn_V2aiVehicle.sqf`):
   ```sqf
   createVehicleCrew aiVehW;
   createVehicleCrew aiArmW;
   ```
   - Naudoja predefined crew iš transporto priemonės config'o
   - ⚠️ **Problema**: Crew gali turėti netinkamus loadout'us

### Kas Naudoja `createUnit [crewW/crewE, ...]`

1. **AA (Anti-Air)** (`fn_V2aiVehicle.sqf`, `V2startServer.sqf`):
   ```sqf
   _unit = _grpAAW createUnit [crewW, posAA, [], 0, "NONE"];
   _unit moveInGunner objAAW;
   ```
   - ✅ Naudoja `crewW` / `crewE` iš frakcijų failų
   - ✅ Crew turi teisingus loadout'us

2. **Artillery** (`fn_V2aiVehicle.sqf`, `V2startServer.sqf`):
   ```sqf
   _unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
   _unit moveInGunner objArtiW;
   ```
   - ✅ Naudoja `crewW` / `crewE` iš frakcijų failų
   - ✅ Crew turi teisingus loadout'us

3. **Mortar** (`fn_V2mortarW.sqf`, `fn_V2mortarE.sqf`):
   ```sqf
   _unit = _grpArtiW createUnit [crewW, posArti, [], 0, "NONE"];
   _unit moveInGunner objMortW;
   ```
   - ✅ Naudoja `crewW` / `crewE` iš frakcijų failų
   - ✅ Crew turi teisingus loadout'us

---

## Ar Įmanoma Pakeisti?

### ✅ Taip, Įmanoma

**Galima pakeisti transporto priemonėms**:
1. Pašalinti seną crew (jei yra)
2. Sukurti naują crew naudojant `crewW` / `crewE`
3. Įsodinti crew į transporto priemonę

**Pavyzdys**:
```sqf
//Sukuriamas transporto priemonė
_veh = createVehicle [_typ, _pos, [], 0, "NONE"];

//Pašaliname seną crew (jei yra)
{ _veh deleteVehicleCrew _x } forEach crew _veh;

//Sukuriamas crew su mūsų nustatytu crewW
_grp = createGroup [sideW, true];

//Driver
if (_veh emptyPositions "Driver" > 0) then
{
	_unit = _grp createUnit [crewW, _pos, [], 0, "NONE"];
	_unit moveInDriver _veh;
};

//Gunner (jei yra)
if (_veh emptyPositions "Gunner" > 0) then
{
	_unit = _grp createUnit [crewW, _pos, [], 0, "NONE"];
	_unit moveInGunner _veh;
};

//Commander (jei yra)
if (_veh emptyPositions "Commander" > 0) then
{
	_unit = _grp createUnit [crewW, _pos, [], 0, "NONE"];
	_unit moveInCommander _veh;
};

//Cargo (jei yra)
for "_i" from 1 to (_veh emptyPositions "Cargo") step 1 do
{
	_unit = _grp createUnit [crewW, _pos, [], 0, "NONE"];
	_unit moveInCargo [_veh, _i - 1];
};
```

---

## Rekomendacijos

### 1. Pakeisti Transporto Priemonėms

**Kur pakeisti**:
- `warmachine/V2startServer.sqf` - transporto priemonių spawn'inimas
- `functions/server/fn_V2aiVehicle.sqf` - AI transporto priemonės

**Kaip pakeisti**:
- Vietoj `createVehicleCrew`, naudoti `createUnit [crewW/crewE, ...]` + `moveIn...`
- Patikrinti `emptyPositions` kiekvienam pozicijai (Driver, Gunner, Commander, Cargo)

### 2. Pakeisti Dronams

**Kur pakeisti**:
- `functions/client/fn_V2uavRequest.sqf` - dronų spawn'inimas

**Kaip pakeisti**:
- Vietoj `createVehicleCrew`, naudoti `createUnit [crewW/crewE, ...]` + `moveIn...`
- Dronams paprastai reikia tik Driver pozicijos

### 3. Pritaikyti Loadout'ams

**Svarbu**:
- Crew turės teisingus loadout'us pagal frakciją
- Loadout'ai bus pritaikyti automatiškai per `wrm_fnc_V2loadoutChange`

---

## Išvados

### ✅ Tai Svarbu, Nes:

1. **Loadout'ų Konsistentiškumas**: Crew turės tokius pačius loadout'us kaip žaidėjai
2. **Frakcijų Konsistentiškumas**: Visi crew turės tokią pačią frakciją
3. **Balance**: Crew turės tokius pačius ginklus kaip žaidėjai
4. **Modų Kompatibiliškumas**: Neatsiranda priklausomybių nuo modų config'ų

### ✅ Įmanoma Pakeisti:

- Galima pakeisti visoms transporto priemonėms
- Galima pakeisti dronams
- Reikia pakeisti `createVehicleCrew` į `createUnit [crewW/crewE, ...]` + `moveIn...`

### ⚠️ Reikia Patikrinti:

- Ar visos transporto priemonės turi crew pozicijas (Driver, Gunner, Commander, Cargo)
- Ar `crewW` / `crewE` klasės yra teisingos
- Ar loadout'ai bus pritaikyti automatiškai

---

## Kitas Žingsnis

Jei norite, galiu:
1. Pakeisti `createVehicleCrew` į `createUnit [crewW/crewE, ...]` + `moveIn...` visoms transporto priemonėms
2. Pakeisti dronams
3. Patikrinti, ar viskas veikia teisingai

**Klausimas**: Ar norite, kad pradėčiau implementuoti šiuos pakeitimus?

