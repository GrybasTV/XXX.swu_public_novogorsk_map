# Arsenal Sistema - Kokius Ginklus ir Aprangas Matys Naujos Frakcijos

## Apžvalga

Arsenal sistema veikia pagal mod'ą (`modA`) ir pusę (`sideW`/`sideE`), o **ne** pagal specifinę frakciją (`factionW`/`factionE`).

---

## Kaip Veikia Arsenal Sistema

### 1. Ginkliai (`fn_arsenal.sqf`)

**Vieta**: `functions/client/fn_arsenal.sqf`

**RHS modui** (139-198 eilutės):
```sqf
if(modA=="RHS")exitWith
{
	//Pistolai, SMG, Shotguns, Assault Rifles, Machineguns, Sniper Rifles, Missile Launchers
	//Iš visų RHS_USAF ir RHS_AFRF DLC
	_cfgWp= "((getText (_x >> 'cursor') == 'hgun')&&((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF')))" configClasses (configFile>>"cfgWeapons");
	// ... kiti ginklų tipai
};
```

**Rezultatas**:
- **Ukraine 2025 (West)**: Matys **visus** RHS ginklus iš `RHS_USAF` ir `RHS_AFRF` DLC
- **Russia 2025 (East)**: Matys **visus** RHS ginklus iš `RHS_USAF` ir `RHS_AFRF` DLC

**Problema**: Nėra specifinių apribojimų pagal frakciją - abi frakcijos matys **visus** RHS ginklus.

**Role-based restrictions**:
- Jei žaidėjas turi machinegunner role → matys tik machineguns
- Jei žaidėjas turi sniper role → matys tik sniper rifles
- Jei žaidėjas turi AT specialist role → matys arifles + smg + AT launchers
- Jei žaidėjas neturi specialios role → matys arifles + smg

---

### 2. Aprangos/Items (`fn_arsInit.sqf`)

**Vieta**: `functions/client/fn_arsInit.sqf`

**RHS modui** (157-249 eilutės):
```sqf
if(modA=="RHS")exitWith
{
	//check player's side
	call
	{
		if (_sde==west) exitWith 
		{
			_dlc='RHS_USAF'; //West pusė naudoja RHS_USAF DLC
		};
		if (_sde==east) exitWith 
		{
			_dlc='RHS_AFRF'; //East pusė naudoja RHS_AFRF DLC
		};
	};
	
	//Uniforms
	_cfgUn= "((str _x find 'rhs_uniform' >= 0)&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgWeapons");
	
	//Helmets, Vests
	_cfgIt= "((getText (_x >> '_generalMacro') find _cr >= 0)&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgWeapons");
	
	//Backpacks
	_cfgBp= "((getText (_x >> 'vehicleClass') == 'Backpacks')&&(getText(_x >> 'dlc')==_dlc))" configClasses (configFile>>"cfgVehicles");
	
	//Magazines, ammo
	_cfgAm= "((str _x find 'rhs_' >= 0)||(getText(_x >> 'author')=='Red Hammer Studios'))" configClasses (configFile>>"CfgMagazines");
};
```

**Rezultatas**:
- **Ukraine 2025 (West)**: Matys **visas** RHS USAF aprangas, šalmus, vests, backpacks
- **Russia 2025 (East)**: Matys **visas** RHS AFRF aprangas, šalmus, vests, backpacks

**Items** (visi RHS items, nepriklausomai nuo DLC):
- Optikos, priedai, NVG, Laserdesignator, Rangefinder, Binocular
- Visi items su `str _x find 'rhs' >= 0`

**Magazines/Ammo**:
- **Visos** RHS ammo (su `rhs_` prefix arba `author == 'Red Hammer Studios'`)
- Abi frakcijos matys **visas** RHS ammo

---

## Kokius Ginklus Matys Naujos Frakcijos?

### Ukraine 2025 (West)

**Ginkliai**:
- ✅ Visi RHS USAF ginkliai (M4, M16, M249, M240, M24, ir kt.)
- ✅ Visi RHS AFRF ginkliai (AK-74, AKM, PKM, SVD, ir kt.)
- ⚠️ **Abi frakcijos matys abu DLC ginklus!**

**Role-based**:
- **Machinegunner**: Tik machineguns (M249, M240, PKM, ir kt.)
- **Sniper**: Tik sniper rifles (M24, SVD, ir kt.)
- **AT Specialist**: Arifles + SMG + AT launchers
- **Default**: Arifles + SMG

### Russia 2025 (East)

**Ginkliai**:
- ✅ Visi RHS AFRF ginkliai (AK-74, AKM, PKM, SVD, ir kt.)
- ✅ Visi RHS USAF ginkliai (M4, M16, M249, M240, M24, ir kt.)
- ⚠️ **Abi frakcijos matys abu DLC ginklus!**

**Role-based**: Tas pats kaip Ukraine 2025

---

## Kokias Aprangas Matys Naujos Frakcijos?

### Ukraine 2025 (West)

**Aprangos**:
- ✅ Visos RHS USAF aprangos (`rhs_uniform_*` su `dlc == 'RHS_USAF'`)
- ✅ Visi RHS USAF šalmai (`H_HelmetB` su `dlc == 'RHS_USAF'`)
- ✅ Visi RHS USAF vests (`Vest_Camo_Base` su `dlc == 'RHS_USAF'`)
- ✅ Visi RHS USAF backpacks (`Backpacks` su `dlc == 'RHS_USAF'`)

**Items**:
- ✅ Visi RHS items (optikos, priedai, NVG, ir kt.)
- ✅ Visi RHS ammo (visos RHS ammo nepriklausomai nuo DLC)

### Russia 2025 (East)

**Aprangos**:
- ✅ Visos RHS AFRF aprangos (`rhs_uniform_*` su `dlc == 'RHS_AFRF'`)
- ✅ Visi RHS AFRF šalmai (`H_HelmetB` su `dlc == 'RHS_AFRF'`)
- ✅ Visi RHS AFRF vests (`Vest_Camo_Base` su `dlc == 'RHS_AFRF'`)
- ✅ Visi RHS AFRF backpacks (`Backpacks` su `dlc == 'RHS_AFRF'`)

**Items**:
- ✅ Visi RHS items (optikos, priedai, NVG, ir kt.)
- ✅ Visi RHS ammo (visos RHS ammo nepriklausomai nuo DLC)

---

## Problema

**Abi frakcijos matys abu DLC ginklus!**

- Ukraine 2025 matys ir RHS USAF, ir RHS AFRF ginklus
- Russia 2025 matys ir RHS AFRF, ir RHS USAF ginklus

**Kodėl**:
- `fn_arsenal.sqf` tikrina `((getText(_x >> 'dlc')=='RHS_USAF')||(getText(_x >> 'dlc')=='RHS_AFRF'))`
- Tai reiškia, kad **visi** ginklai iš **abu** DLC pridedami

**Aprangos**:
- ✅ Aprangos yra filtruojamos pagal pusę (west = RHS_USAF, east = RHS_AFRF)
- ✅ Taigi Ukraine 2025 matys tik RHS USAF aprangas
- ✅ Russia 2025 matys tik RHS AFRF aprangas

---

## Pakeitimai (2025-01-XX)

**Pridėta**: Naujų modų ginklių ir aprangų palaikymas Ukraine 2025 ir Russia 2025 frakcijoms.

**Failai**:
- `functions/client/fn_arsenal.sqf` - pridėti naujų modų ginklai (RUS_, UA_, UKR_ prefix'ai)
- `functions/client/fn_arsInit.sqf` - pridėtos naujų modų aprangos, items, backpacks, ammo

**Kaip veikia**:
- Jei frakcija yra "Ukraine 2025" arba "Russia 2025", pridedami ginklai/aprangos su prefix'ais:
  - `RUS_` - Rusijos modai
  - `UA_` - Ukrainos modai
  - `UKR_` - Ukrainos modai (alternatyvus prefix)
- Kitos RHS frakcijos (USAF, AFRF) matys tik RHS ginklus/aprangas

**Rezultatas**:
- Ukraine 2025 matys: RHS USAF + naujų modų ginklai/aprangos (UA_, UKR_)
- Russia 2025 matys: RHS AFRF + naujų modų ginklai/aprangos (RUS_)

---

## Išvados

### Ukraine 2025 (West)

**Ginkliai**:
- ✅ Visi RHS USAF ginkliai
- ⚠️ Visi RHS AFRF ginkliai (galima pakeisti, jei norite)

**Aprangos**:
- ✅ Tik RHS USAF aprangos, šalmai, vests, backpacks

**Items**:
- ✅ Visi RHS items ir ammo

### Russia 2025 (East)

**Ginkliai**:
- ✅ Visi RHS AFRF ginkliai
- ⚠️ Visi RHS USAF ginkliai (galima pakeisti, jei norite)

**Aprangos**:
- ✅ Tik RHS AFRF aprangos, šalmai, vests, backpacks

**Items**:
- ✅ Visi RHS items ir ammo

---

**Klausimas**: Ar norite, kad pakeisčiau `fn_arsenal.sqf`, kad frakcijos matytų tik savo DLC ginklus?

