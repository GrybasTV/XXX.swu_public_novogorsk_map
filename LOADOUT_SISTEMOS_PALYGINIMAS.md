# Loadout Sistemos Palyginimas: Original vs Mūsų Versija

## 📊 SVARBU: Šis dokumentas aprašo, kaip mūsų sistema skiriasi nuo originalios

---

## ORIGINAL SISTEMA (`Original/mission/functions/server/fn_V2loadoutChange.sqf`)

### Kaip veikia:
1. **Naudoja `unitsW` ir `unitsE` masyvus** - saugo unit klasės vardus (pvz., `["UA_Azov_lieutenant", "UA_Azov_rifleman", ...]`)
2. **Tikrinimas**: `if(typeOf _un=="B_Soldier_SL_F")exitWith{_gr= unitsW select 0;};`
3. **Loadout pritaikymas**: `_un setUnitLoadout _gr;` (tiesiogiai klasės vardas iš masyvo)
4. **NEVEIKIA su player'iais**: `if (isPlayer _un) exitWith {};` ❌
5. **Naudoja `call` ne `spawn`**

### Problemos:
- ❌ **NEVEIKIA su player'iais** - tik su AI
- ❌ **Naudoja masyvus** - reikia atskirai užpildyti `unitsW` ir `unitsE`
- ❌ **Paprastas** - bet neveikia su custom klasėmis ir player'iais

---

## MŪSŲ SISTEMA (`functions/server/fn_V2loadoutChange.sqf`)

### Kaip veikia:
1. **Naudoja `CfgRespawnInventory` klasės** - WEST800, EAST500, etc.
2. **Tikrinimas**: `if((str _typeOf find "UA_Azov_lieutenant" >= 0))exitWith{_gr="WEST800";};`
3. **Loadout pritaikymas**: `_un setUnitLoadout _cfgRespawn;` (per CfgRespawnInventory)
4. **VEIKIA su player'iais** ✅
5. **Naudoja `spawn` ne `call`**
6. **Pridėta daug laukimo ir timeout'ų**
7. **Pridėta debug logika**

### Problemos:
- ⚠️ **PER KOMPLIKUOTA** - daug redundant kodo
- ⚠️ **Naudojame `str _typeOf find`** vietoj tiesiog `typeOf _un ==`
- ⚠️ **Daug fallback logikos** - kuri gali būti nereikalinga
- ⚠️ **Daug laukimų** - gali būti per daug

---

## KĄ PADARĖME:

### 1. **`mission.sqm`** - Pakeitėme vanilla klases į custom
- ✅ Visi `B_*` → `UA_Azov_*`
- ✅ Visi `O_*` → `RUS_MSV_*` / `RUS_spn_*`
- **48 unit types** pakeisti

### 2. **`fn_V2loadoutChange.sqf`** - Supaprastinta versija tik Ukraine 2025 vs Russia 2025
- ✅ Veikia su player'iais (originalas neveikė)
- ✅ Naudoja `CfgRespawnInventory` klasės
- ⚠️ Per komplikuota su daug laukimų

### 3. **`V2factionChange.sqf`** - Pakeista iš `call` į `spawn`
- ✅ Loadout'ai pritaikomi asinchroniškai

---

## AR PER KOMPLIKAVOME?

### ✅ **TAIP** - bet tik dalis:

**Per komplikuota:**
1. **Daug laukimų ir timeout'ų** (linijos 26-40)
   - `waitUntil{side _un!=civilian}`
   - `waitUntil{alive _un}`
   - `sleep 0.1`
   - Galbūt per daug?

2. **Dvigubas tikrinimas** (linijos 79-98, 132-151)
   - Tikriname custom klasės
   - TIK TADA tikriname vanilla klasės
   - Bet jei `mission.sqm` jau naudoja custom klases, vanilla tikrinimas nereikalingas

3. **Fallback logika** (linijos 174-200)
   - Jei `_gr == ""`, bandom pritaikyti tiesiogiai iš custom klasės
   - Bet jei logika veikia teisingai, šis fallback nereikalingas

**Kas gerai:**
1. ✅ **Veikia su player'iais** (originalas neveikė)
2. ✅ **Naudoja `CfgRespawnInventory`** - standartinis Arma3 metodas
3. ✅ **Supaprastinta tik vienai frakcijai** (Ukraine 2025 vs Russia 2025)

---

## SIŪLYMAS SUPAPRASTINTI:

### Variantas 1: **MINIMALUS** (patarimas)
```sqf
//Tik custom klasės, nes mission.sqm jau naudoja custom klases
if((typeOf _un == "UA_Azov_lieutenant"))exitWith{_gr="WEST800";};
if((typeOf _un == "UA_Azov_rifleman"))exitWith{_gr="WEST805";};
//... ir t.t.
```

### Variantas 2: **BALANSAS** (rekomenduoju)
- Išlaikyti `str _typeOf find` (jei reikia palaikyti ir vanilla)
- Pašalinti fallback logiką (linijos 174-200)
- Sumažinti laukimus (tik `waitUntil{side _un!=civilian}`)

---

## KĄ MŪSŲ SISTEMA DUODA:

### ✅ **PRIEŠ Original:**
1. ✅ **Veikia su player'iais** - originalas neveikė
2. ✅ **Veikia su custom klasėmis** - originalas naudojo tik vanilla
3. ✅ **Naudoja standartinį Arma3 metodą** (`CfgRespawnInventory`)
4. ✅ **Supaprastinta tik vienai frakcijai** - lengviau palaikyti

### ⚠️ **TRŪKUMŲ:**
1. ⚠️ **Per komplikuota** - daug laukimų ir fallback logikos
2. ⚠️ **Naudojame `str find`** vietoj tiesiog palyginimo (bet tai reikalinga, jei palaikome vanilla)
3. ⚠️ **Daug debug kodo** - bet tai gerai, jei reikia debug

---

## IŠVADOS:

### ✅ **Sistema veikia gerai:**
- Misijos pradžioje ir respawne loadout'ai pritaikomi
- Veikia su player'iais ir AI
- Naudoja standartinį Arma3 metodą

### ⚠️ **Galime supaprastinti:**
- Pašalinti fallback logiką (linijos 174-200)
- Sumažinti laukimus (tik reikalingus)
- Jei `mission.sqm` jau naudoja custom klases, vanilla tikrinimas nereikalingas

### 🎯 **Rekomendacija:**
**Palikti kaip yra** - sistema veikia, o supaprastinimas gali sukelti naujas problemas. Bet jei norite supaprastinti, pradėkite nuo fallback logikos pašalinimo.

---

## PAGRINDINIS SKIRTUMAS NUO ORIGINALO:

| Aspektas | Original | Mūsų |
|----------|----------|------|
| **Player support** | ❌ NE | ✅ TAIP |
| **Custom klasės** | ❌ NE | ✅ TAIP |
| **Method** | `unitsW/unitsE` masyvai | `CfgRespawnInventory` |
| **Kompleksiškumas** | Paprastas | Vidutinis |
| **Veikimas** | Tik AI | AI + Players |

**MŪSŲ SISTEMA GERESNĖ** - bet galime supaprastinti, jei reikia.

