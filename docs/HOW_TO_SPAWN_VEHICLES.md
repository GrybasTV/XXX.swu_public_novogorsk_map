# Kaip Turi Keistis Scenarijus, Kad Pradėtų Spawnintis Transportai ir Tankai

## I. Pagrindinės Sąlygos

### ✅ **Būtinos Sąlygos Spawninimui**:

1. **Mission Type (missType)** turi būti **> 1**:
   - `missType = 1` → **INFANTRY MISSION** - tik pėstininkai, **NĖRA transportų ir tankų**
   - `missType = 2` → **COMBINED GROUND FORCES** - pėstininkai, lengvi transportai, šarvuočiai, transporto sraigtasparniai ✅
   - `missType = 3` → **FULL SPECTRUM WARFARE** - visi tipai, įskaitant tankus, sraigtasparnius, lėktuvus ✅

2. **Autonomous AI (AIon)** turi būti **> 0**:
   - `AIon = 0` → **Disabled** - AI transportai **NĖRA spawninami**
   - `AIon = 1` → **Balanced** - AI transportai spawninami abiejose pusėse ✅
   - `AIon = 2` → **Challenging** - AI transportai spawninami priešo pusėje (SP/COOP) ✅
   - `AIon = 3` → **Overwhelming** - daugiau AI transportų priešo pusėje (SP/COOP) ✅

### 📋 **Sąlyga Spawninimui**:
```sqf
if(missType > 1 && AIon > 0) then {
    // Spawninami AI transportai ir tankai
}
```

---

## II. Kaip Nustatyti Parametrus

### **Lobby Parametrai (Žaidimo Pradžioje)**:

1. **MISSION TYPE** (`asp1`):
   - Pasirinkite **"Combined ground forces"** (2) arba **"Full spectrum warfare"** (3)
   - **NE** pasirinkite **"Infantry mission"** (1) - jame nėra transportų

2. **AUTONOMOUS AI** (`asp5`):
   - Pasirinkite **"Balanced"** (1), **"Challenging"** (2) arba **"Overwhelming"** (3)
   - **NE** pasirinkite **"Disabled"** (0) - jame AI transportai neveikia

### **Auto Start Parametrai** (Dedikuotiems serveriams):

Jei naudojate Auto Start, parametrai nustatomi `autoStart.sqf`:
```sqf
missType = ("asp1" call BIS_fnc_getParamValue); // Mission type
AIon = ("asp5" call BIS_fnc_getParamValue); // Autonomous AI
```

---

## III. Spawninimo Procesas

### **Kaip Veikia Spawninimas**:

1. **fn_V2aiVehUpdate.sqf** tikrina sąlygas kas 45 sekundes
2. Jei transportas/tankas:
   - Sunaikintas (`!alive`)
   - Negali judėti (įstrigęs)
   - Neturi įgulos (`crew count == 0`)
   - Turi sugadintą ginklą/turret
3. Tada spawninamas naujas transportas/tankas

### **Spawninimo Tipai**:

| Parametras | Funkcija | Ką Spawnina |
|------------|----------|-------------|
| `_par = 1` | `aiVehW` / `aiVehE` | Transportai (CarArW, CarArE) |
| `_par = 2` | `aiArmW` / `aiArmE` | Tankai (ArmorW1, ArmorE1) |
| `_par = 3` | `aiCasW` | Artilerija (West) |
| `_par = 6` | `aiCasE` | Artilerija (East) |
| `_par = 4` | `aiArmW2` | Antras tankas (West) - tik jei `AIon > 2` |
| `_par = 5` | `aiArmE2` | Antras tankas (East) - tik jei `AIon > 2` |

---

## IV. Papildomos Sąlygos

### **Transportų Spawninimas (aiVehW/aiVehE)**:

1. **Base Attack Check**: Jei priešas yra < 250m nuo bazės, laukiama 30 sekundžių
2. **Coop Mode**: Spawninama tik jei `coop == 0` arba `coop == 2` (ne SP/COOP)
3. **Respawn Time**: `trTime` (default 3 minutės = 180 sekundžių)
4. **FOB Check**: Jei FOB marker'is egzistuoja, spawninimas sustabdomas

### **Tankų Spawninimas (aiArmW/aiArmE)**:

1. **Base Check**: Tikrinama ar bazės marker'is egzistuoja
2. **Respawn Time**: `arTime` (default gali būti skirtingas)
3. **Spawninama iš**: `ArmorW1` / `ArmorE1` masyvų (tankai)

---

## V. Troubleshooting

### **Problema: Transportai/Tankai Nespawinami**

**Patikrinkite**:

1. ✅ **Mission Type**:
   ```sqf
   // Patikrinkite konsolėje:
   hint format ["missType: %1", missType];
   // Turi būti > 1 (2 arba 3)
   ```

2. ✅ **AIon Parametras**:
   ```sqf
   // Patikrinkite konsolėje:
   hint format ["AIon: %1", AIon];
   // Turi būti > 0 (1, 2 arba 3)
   ```

3. ✅ **Flag'ai**:
   ```sqf
   // Patikrinkite ar flag'ai nėra true:
   hint format ["aiVehWr: %1, aiArmWr: %1", aiVehWr, aiArmWr];
   // Jei true, reikia laukti kol transportas bus sunaikintas
   ```

4. ✅ **Faction Config**:
   - Patikrinkite ar `CarArW`, `ArmorW1` masyvai nėra tušti
   - Patikrinkite ar `posW1`, `posW2` pozicijos yra nustatytos

### **Problema: Spawninasi Tik Vienas Transportas**

**Priežastys**:
- `aiVehWr = true` - flag'as užblokuoja spawninimą
- Transportas dar gyvas ir veikia
- Laukite kol transportas bus sunaikintas arba negalės judėti

---

## VI. Rekomenduojami Nustatymai

### **Maksimaliam Spawninimui**:

1. **Mission Type**: `3` (Full Spectrum Warfare)
2. **Autonomous AI**: `3` (Overwhelming)
3. **Vehicle Respawn Time**: `1` arba `2` (greitesnis respawn)

### **Balansuotam Spawninimui**:

1. **Mission Type**: `2` (Combined Ground Forces)
2. **Autonomous AI**: `1` (Balanced)
3. **Vehicle Respawn Time**: `3` (default)

---

## VII. Testavimo Patarimai

### **Kaip Testuoti**:

1. **Paleiskite misiją** su teisingais parametrais
2. **Laukite** 3-5 minučių (respawn time)
3. **Patikrinkite** ar transportai/tankai atsiranda bazėse
4. **Sunaikinkite** transportą/tanką ir laukite respawn

### **Debug Komandos**:

```sqf
// Patikrinti parametrus
hint format ["missType: %1, AIon: %1", missType, AIon];

// Patikrinti flag'us
hint format ["aiVehWr: %1, aiArmWr: %1", aiVehWr, aiArmWr];

// Patikrinti ar transportai egzistuoja
hint format ["aiVehW: %1, aiArmW: %1", aiVehW, aiArmW];

// Priverstinai sunaikinti transportą (testavimui)
if (!isNull aiVehW) then { aiVehW setDamage 1; };
```

---

## VIII. Išvados

### ✅ **Kad Pradėtų Spawnintis Transportai ir Tankai**:

1. **Mission Type** turi būti **2** arba **3** (NE 1)
2. **Autonomous AI** turi būti **1, 2** arba **3** (NE 0)
3. **Faction Config** turi turėti transportų/tankų masyvus
4. **Spawn Pozicijos** turi būti nustatytos (`posW1`, `posW2`, `posE1`, `posE2`)

### 📝 **Svarbu**:

- Spawninimas vyksta **automatiškai** kas `trTime`/`arTime` sekundes
- Jei transportas/tankas dar gyvas, naujas **NESPawinamas**
- Reikia **laukti** kol senas transportas/tankas bus sunaikintas arba negalės judėti

---

**Data**: 2025-01-XX  
**Versija**: 1.0

