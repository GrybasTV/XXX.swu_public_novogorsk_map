# ANALIZĖ: Ukraine 2025 vs Russia 2025 Frakcijos

## DATA: 2025-01-04

## TIKSLAS
Patikrinti, ar Ukraine 2025 ir Russia 2025 frakcijos yra tinkamai sukonfigūruotos ir ar neatsiras vanilla unitai dėl klaidų.

---

## KRITINĖS PROBLEMOS

### 1. ❌ KRITINĖ KLAIDA: Neteisingi Loadout Numeriai Russia 2025

**Vieta:** `init.sqf` eilutė 702

**Problema:**
```702:702:init.sqf
if(factionE=="Russia 2025")exitWith{_Load="EAST%1";_n1=200;_n2=218;};
```

**Kas neteisinga:**
- Naudojami numeriai `200-218`, bet pagal `RU2025_RHS_W_L.hpp` turėtų būti `500-518`
- Tai gali sukelti situaciją, kai respawn sistema bandys rasti loadout'us su neteisingais numeriais
- Jei loadout'ų nėra, Arma 3 gali naudoti vanilla unitus kaip fallback

**Taisymas:**
```sqf
if(factionE=="Russia 2025")exitWith{_Load="EAST%1";_n1=500;_n2=518;};
```

**Poveikis:**
- Žaidėjai negali respawn'inti su teisingais Russia 2025 loadout'ais
- Gali atsirasti vanilla unitai, jei sistema naudoja fallback

---

## PATIKRINIMAS: Unitų Klasės

### Ukraine 2025 (WEST) - ✅ TINKAMAI

**Frakcijos failas:** `factions/UA2025_RHS_W_V.hpp`

**Unitų klasės masyvas (unitsW):**
```54:75:factions/UA2025_RHS_W_V.hpp
unitsW=
[
	"UA_Azov_lieutenant", //0 - Squad leader
	"UA_Azov_operatormanpad", //1 - Rifleman AT
	"UA_Azov_machinegunner", //2 - Autorifleman
	"UA_Azov_riflemancombatlifesaver", //3 - Combat life saver
	"UA_Azov_sergeant", //4 - Team leader
	"UA_Azov_rifleman", //5 - Rifleman
	"UA_Azov_sapper", //6 - Engineer
	"UA_Azov_sniper", //7 - Marksman
	"UA_Azov_operatoratgm", //8 - Missile specialist AT
	"UA_Azov_grenadier", //9 - Grenadier
	"UA_Azov_operatormanpad", //10 - Missile specialist AA
	"UA_Azov_squadcommander", //11 - Recon team leader
	"UA_Azov_reconoperator", //12 - Recon scout AT (Rifleman AT)
	"UA_Azov_reconmachinegunner", //13 - Recon Marksman (Autorifleman)
	"UA_Azov_riflemancombatlifesaver", //14 - Recon Paramedic (Medic)
	"UA_Azov_jtac", //15 - Recon JTAC (Grenadier)
	"UA_Azov_reconoperator", //16 - Recon Scout (Rifleman)
	"UA_Azov_sapper", //17 - Recon demo specialist (Engineer)
	"UA_Azov_reconsniper" //18 - Sniper (Marksman)
];
```

**Loadout failas:** `loadouts/UA2025_RHS_W_L.hpp`
- Loadout numeriai: `WEST800` - `WEST818` ✅
- Korektiškai sukonfigūruoti

**Init.sqf integracija:**
```692:692:init.sqf
if(factionW=="Ukraine 2025")exitWith{_Load="WEST%1";_n1=800;_n2=818;};
```
✅ **TINKAMAI** - numeriai atitinka loadout failą

---

### Russia 2025 (EAST) - ❌ PROBLEMA

**Frakcijos failas:** `factions/RU2025_RHS_W_V.hpp`

**Unitų klasės masyvas (unitsE):**
```53:74:factions/RU2025_RHS_W_V.hpp
unitsE=
[
	"RUS_MSV_east_lieutenant", //0 - Squad leader
	"RUS_MSV_east_operatormanpad", //1 - Rifleman AT
	"RUS_MSV_east_machinegunner", //2 - Autorifleman
	"RUS_MSV_east_riflemancombatlifesaver", //3 - Combat life saver
	"RUS_MSV_east_sergeant", //4 - Team leader
	"RUS_MSV_east_private", //5 - Rifleman
	"RUS_MSV_east_sapper", //6 - Engineer
	"RUS_MSV_east_sniper", //7 - Marksman
	"RUS_MSV_east_operatormanpad", //8 - Missile specialist AT
	"RUS_MSV_east_grenadier", //9 - Grenadier
	"RUS_MSV_east_operatormanpad", //10 - Missile specialist AA
	"RUS_gru_seniorrecon", //11 - Recon team leader
	"RUS_spn_reconoperator", //12 - Recon scout AT (Rifleman AT)
	"RUS_spn_reconmachinegunner", //13 - Recon Marksman (Autorifleman)
	"RUS_spn_reconsanitar", //14 - Recon Paramedic (Medic)
	"RUS_spn_reconoperatoruav", //15 - Recon JTAC (Grenadier)
	"RUS_spn_recon", //16 - Recon Scout (Rifleman)
	"RUS_spn_reconsapper", //17 - Recon demo specialist (Engineer)
	"RUS_spn_reconsniper" //18 - Sniper (Marksman)
];
```

**Loadout failas:** `loadouts/RU2025_RHS_W_L.hpp`
- Loadout numeriai: `EAST500` - `EAST518` ✅
- Korektiškai sukonfigūruoti

**Init.sqf integracija:**
```702:702:init.sqf
if(factionE=="Russia 2025")exitWith{_Load="EAST%1";_n1=200;_n2=218;};
```
❌ **NETEISINGAI** - numeriai `200-218` neegzistuoja, turėtų būti `500-518`

---

## PATIKRINIMAS: Loadout Change Funkcija

### `fn_V2loadoutChange.sqf` Analizė

**Custom Klasės Aptikimas:**
```46:50:functions/server/fn_V2loadoutChange.sqf
if((str _typeOf find "UA_Azov_" >= 0) || (str _typeOf find "UA_" >= 0))then
{
//Custom klasė - naudoti tiesiogiai klasę kaip loadout
_gr = _typeOf;
_useCustomClass = true;
```

**Ukraine 2025:** ✅ Tinkamai aptinkamos `UA_Azov_*` klasės

**Russia 2025:**
```83:87:functions/server/fn_V2loadoutChange.sqf
if((str _typeOf find "RUS_MSV_" >= 0) || (str _typeOf find "RUS_spn_" >= 0) || (str _typeOf find "RUS_" >= 0))then
{
//Custom klasė - naudoti tiesiogiai klasę kaip loadout
_gr = _typeOf;
_useCustomClass = true;
```

✅ **Tinkamai aptinkamos** `RUS_MSV_*` ir `RUS_spn_*` klasės

**Vanilla Unitų Fallback:**
- Jei unit klasė nėra custom, naudojama vanilla klasė ir pritaikomas loadout iš `unitsW`/`unitsE` masyvų
- Tai yra saugu, nes `unitsW` ir `unitsE` masyvai yra tinkamai užpildyti su custom unitais

---

## PATIKRINIMAS: Base Defense

### `baseDefense.sqf` Analizė

**Vanilla Unitų Naudojimas:**
```24:28:warmachine/baseDefense.sqf
if(
	false //delete if you add custom units for sideW
	//if custom units then add condition here ||()
)then 
{
	_unitsW=["B_Soldier_SL_F","B_soldier_LAT_F",...];
```

**Ukraine 2025:** ✅ Sąlyga yra `false`, todėl vanilla unitai **NE** naudojami
- Naudojami `unitsW` masyvo elementai (custom klasės)

**Russia 2025:**
```105:110:warmachine/baseDefense.sqf
if(
	(factionE=="CSAT" && env=="woodland")
	//if custom units then add condition here ||()
)then 
{
	_unitsE=["O_Soldier_SL_F","O_soldier_LAT_F",...];
```

✅ **Saugu** - vanilla unitai naudojami tik jei `factionE=="CSAT" && env=="woodland"`
- Russia 2025 frakcija netenkina šios sąlygos, todėl naudojami custom unitai iš `unitsE` masyvo

---

## PATIKRINIMAS: Crew Unitai

### Ukraine 2025
```35:35:factions/UA2025_RHS_W_V.hpp
crewW="rhsusf_army_ucp_crewman"; //crew
```
✅ **RHS klasė** - ne vanilla

### Russia 2025
```35:35:factions/RU2025_RHS_W_V.hpp
crewE="rhs_vmf_flora_armoredcrew"; //crew
```
✅ **RHS klasė** - ne vanilla

---

## PATIKRINIMAS: Init.sqf Frakcijų Įkėlimas

### Ukraine 2025 Įkėlimas
```397:401:init.sqf
if(factionW=="Ukraine 2025")then
{
	#include "factions\UA2025_RHS_W_V.hpp";
	systemChat format ["[INIT] Ukraine 2025 loaded, unitsW count: %1, first unit: %2", count unitsW, unitsW select 0];
};
```
✅ **Tinkamai** - frakcijos failas įkeliamas teisingai

### Russia 2025 Įkėlimas
```403:407:init.sqf
if(factionE=="Russia 2025")then
{
	#include "factions\RU2025_RHS_W_V.hpp";
	systemChat format ["[INIT] Russia 2025 loaded, unitsE count: %1, first unit: %2", count unitsE, unitsE select 0];
};
```
✅ **Tinkamai** - frakcijos failas įkeliamas teisingai

---

## GALIMOS PROBLEMOS

### 1. ⚠️ Unitų Klasės Egzistavimas

**Problema:** Jei custom unitų klasės (`UA_Azov_*`, `RUS_MSV_*`, `RUS_spn_*`) neegzistuoja config'e, Arma 3 gali naudoti fallback vanilla unitus.

**Patikrinimas Reikalingas:**
- Patikrinti, ar visos klasės egzistuoja mod config'e
- Patikrinti RPT log'ą, ar nėra klaidų apie trūkstamas klases

### 2. ⚠️ Loadout Klasės Egzistavimas

**Problema:** Jei loadout klasės (`WEST800-818`, `EAST500-518`) neegzistuoja `description.ext`, respawn sistema gali naudoti fallback.

**Patikrinimas:**
- ✅ `WEST800-818` apibrėžti `description.ext` per `UA2025_RHS_W_L.hpp`
- ✅ `EAST500-518` apibrėžti `description.ext` per `RU2025_RHS_W_L.hpp`

**Bet:** `init.sqf` naudoja neteisingus numerius Russia 2025, todėl loadout'ai nebus užregistruoti!

---

## IŠVADOS

### ✅ TINKAMAI KONFIGŪRUOTA

1. **Ukraine 2025 frakcijos konfigūracija** - visi failai tinkamai sukonfigūruoti
2. **Russia 2025 frakcijos failai** - unitų klasės ir loadout failai tinkamai sukonfigūruoti
3. **Loadout change funkcija** - tinkamai aptinka custom klasės
4. **Base defense** - ne naudoja vanilla unitų custom frakcijoms

### ❌ REIKIA TAISYTI

1. **KRITINĖ KLAIDA:** `init.sqf` eilutė 702 - neteisingi loadout numeriai Russia 2025
   - Dabar: `_n1=200;_n2=218`
   - Turėtų būti: `_n1=500;_n2=518`

---

## REKOMENDACIJOS

### 1. Ištaisyti Loadout Numerius

**Pakeisti `init.sqf` eilutę 702:**
```sqf
//BUVO (NETEISINGAI):
if(factionE=="Russia 2025")exitWith{_Load="EAST%1";_n1=200;_n2=218;};

//TURI BŪTI:
if(factionE=="Russia 2025")exitWith{_Load="EAST%1";_n1=500;_n2=518;};
```

### 2. Patikrinti Unitų Klasės Egzistavimą

**Patikrinti RPT log'ą:**
- Užkrauti misiją su Ukraine 2025 vs Russia 2025
- Patikrinti, ar nėra klaidų apie trūkstamas klases
- Patikrinti, ar visi unitai yra su tinkamomis klasėmis (ne vanilla)

### 3. Testavimas

**Patikrinti:**
1. Respawning su Russia 2025 frakcija - ar loadout'ai tinkami?
2. AI unitų spawn'inimas - ar naudojami custom unitai?
3. Crew unitai transporto priemonėse - ar naudojami RHS, ne vanilla?

---

## RIZIKOS ĮVERTINIMAS

### Aukšta Rizika (Dėl Loadout Numerių Klaidos)

**Poveikis:**
- Russia 2025 žaidėjai negali respawn'inti su teisingais loadout'ais
- Sistema gali naudoti fallback vanilla unitus, jei loadout'ų nėra
- Žaidimas gali būti neveikia su Russia 2025 frakcija

**Prioritetas:** 🔴 **KRITINIS** - reikia ištaisyti nedelsiant

### Vidutinė Rizika (Unitų Klasės Egzistavimas)

**Poveikis:**
- Jei custom klasės neegzistuoja, gali atsirasti vanilla unitai
- Reikia patikrinti, ar visos klasės egzistuoja mod config'e

**Prioritetas:** 🟡 **VIDUTINIS** - reikia patikrinti

---

## SUMA

### Problemos Rastos: 1 Kritinė

1. ❌ **KRITINĖ:** `init.sqf` eilutė 702 - neteisingi loadout numeriai Russia 2025

### Visos Kitos Konfigūracijos: ✅ TINKAMOS

- Ukraine 2025 frakcija - visiškai tinkamai sukonfigūruota
- Russia 2025 frakcijos failai - tinkamai sukonfigūruoti (išskyrus init.sqf klaidą)
- Loadout change funkcija - tinkamai veikia su custom klasėmis
- Base defense - ne naudoja vanilla unitų custom frakcijoms

---

## AUTORIUS
Analizė atlikta: 2025-01-04
Rebvizija: V1.0

