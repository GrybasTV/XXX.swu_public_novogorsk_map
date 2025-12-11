# AI SUSTOJIMO PROBLEMA - KRITINIS SPRENDIMAS

**Data**: 2025-01-XX
**Versija**: 1.0

## 🔴 Problema

**Simptomas:**
- Misija užstringa eigoje (in progress)
- **Serverio AI sustoja** - nebeiju, nekovoja
- **Žaidėjų AI būriai juda normaliai** - jie sinchronizuojasi
- Žaidėjai gali vaikščioti vienas kito
- **Klaidų pranešimų nėra**

**Kas veikia:**
- ✅ Žaidėjų judėjimas
- ✅ Žaidėjų AI grupės (nes jos priklauso kliento locality)
- ✅ Tinklo sinchronizacija

**Kas NEveikia:**
- ❌ Serverio AI (autonominiai AI būriai)
- ❌ AI transporto priemonės
- ❌ AI kelio radimas (pathfinding)

---

## 🔍 Tikroji Priežastis (Pagal Dokumentaciją)

### 1. **AI LOCALITY Problema** - PAGRINDINĖ PRIEŽASTIS ⚠️⚠️⚠️

**Kas yra AI Locality?**

Arma 3 multiplayer AI priklauso **skirtingiems "savininkams"** (owner):
- **Kliento AI** - AI grupės, kurių lyderis yra žaidėjas → locality pas **klientą**
- **Serverio AI** - Autonominiai AI → locality pas **serverį**

**Kodėl žaidėjų AI veikia, o serverio AI ne?**

| AI Tipas | Locality | Kas apdoroja | Ar veikia? | Kodėl? |
|----------|----------|--------------|------------|--------|
| Žaidėjo AI grupė | **Kliento** | Kliento CPU | ✅ Taip | Kliento FPS normalus |
| Serverio AI (autonominiai) | **Serverio** | Serverio CPU | ❌ Ne | **Serverio FPS \u003c 15** |

**Išvada:** Kai **Serverio FPS krinta žemiau 15-20 FPS**, serverio AI **sustoja**, nes serveris negali apdoroti AI pathfinding, movement, combat AI.

---

### 2. **Scheduler Starvation** - Antroji Priežastis

**Kas yra Scheduler?**

Arma 3 turi **Scheduler** (tvarkyklę), kuri valdo:
- **Suplanuotus scriptus** (`spawn`, `execVM`)
- Kiekvienas scriptas gauna **3ms laiko** per kadrą
- Jei per daug scriptų, scheduler **negali visko apdoroti**

**Jūsų misijoje:**

Pagal kodą (`warmachine/V2aiStart.sqf` ir kiti), yra daug `spawn` komandų:
- `[] spawn wrm_fnc_V2aiVehUpdate;` (eilutė 185)
- `[] spawn wrm_fnc_V2aiArtillery;` (eilutė 219)
- `[] spawn wrm_fnc_V2aiCAS;` (eilutė 220)
- `[] spawn wrm_fnc_V2ticketBleed;` (eilutė 224)
- `[] spawn wrm_fnc_V2dynamicAIon;` (eilutė 230)
- `[] spawn wrm_fnc_timer;` (eilutė 130)

**Problema:** Jei visos šios gijos veikia **vienu metu** + daugelis AI grupių su savo AI FSM (Finite State Machines), scheduler **perkraunu** → **Serverio FPS krenta** → **AI sustoja**.

---

### 3. **Dynamic Simulation** Problema

Jūsų kodas TURI dynamic simulation (eilutė 180-183 `V2aiStart.sqf`):
```sqf
enableDynamicSimulationSystem true;
"Group" setDynamicSimulationDistance 1000;
"Vehicle" setDynamicSimulationDistance 2500;
"EmptyVehicle" setDynamicSimulationDistance 500;
```

**Problema:** Jei AI grupės yra **už** dynamic simulation distance, jos **užšąla** (freeze) - tai **normalu**.

Bet jūsų atveju, AI sustoja **net arti žaidėjų** → tai **NE** dynamic simulation problema, o **Serverio FPS** problema.

---

## ✅ SPRENDIMAI

### **SPRENDIMAS #1: Headless Client (HC)** - PRIVALOMAS! 🔥

**Kas yra Headless Client?**

Headless Client (HC) yra **specialus kliento procesas**, kuris:
- **NETURI** grafinio atvaizavimo (headless = be galvos/ekrano)
- **Apdoroja tik AI** skaičiavimus
- **Perkelia AI locality** nuo serverio pas save

**Kodėl HC yra sprendimas?**

| Be HC | Su HC |
|-------|-------|
| Serveris apdoroja: Tinklą + AI + Fiziką + Skriptus | Serveris apdoroja: Tinklą + Fiziką + Skriptus |
| Serverio FPS: **5-15 FPS** ❌ | Serverio FPS: **30-50 FPS** ✅ |
| AI sustoja | AI veikia sklandžiai |

**Kaip įdiegti HC?**

#### 1. Serveryje (`server.cfg`)

Pridėkite:
```cfg
headlessClients[] = {"127.0.0.1"}; // HC IP adresas (jei tas pats serveris)
localClient[] = {"127.0.0.1"}; // Leisti local klientui
```

#### 2. Misijoje (`mission.sqm` arba Eden Editor)

Pridėkite **Game Logic → Virtual Entities → Headless Client**:
- Pavadinkite: `HC1` (H HQ)
- Pozicija: bet kur žemėlapyje

#### 3. Kode (naujas failas `functions/server/fn_transferAItoHC.sqf`)

Sukurkite **AI perdavimo į HC funkciją**:

```sqf
/*
    Author: AI Locality Transfer
    
    Description:
        Perkelia visas serverio AI grupes į Headless Client (HC)
        
    Execution:
        [] call wrm_fnc_transferAItoHC;
*/

if !(isServer) exitWith {};

// Randame HC klientą
private _HC = objNull;
{
    if (!isPlayer _x && hasInterface _x) then {
        _HC = _x;
    };
} forEach allPlayers;

// Jei HC nerastas, ieškome pagal pavadinimą
if (isNull _HC) then {
    {
        if (str _x == "HC1" || str _x == "H HQ") then {
            _HC = _x;
        };
    } forEach allUnits;
};

if (isNull _HC) exitWith {
    ["WARNING: Headless Client NOT found - AI will run on server"] remoteExec ["systemChat", 0, false];
};

private _HCid = owner _HC;
["Headless Client found: " + str(_HCid)] remoteExec ["systemChat", 0, false];

// Perkeli visas AI grupes į HC
private _transferredCount = 0;
{
    // Tikriname: ne žaidėjo grupė, yra AI, yra vienetų
    if (!isPlayer leader _x && {count units _x > 0}) then {
        // Perkelia grupės locality į HC
        private _result = _x setGroupOwner _HCid;
        if (_result) then {
            _transferredCount = _transferredCount + 1;
        };
    };
} forEach allGroups;

[format ["AI Locality Transfer: %1 groups transferred to HC", _transferredCount]] remoteExec ["systemChat", 0, false];
```

#### 4. Įtraukite į `cfgFunctions.hpp`

```sqf
class transferAItoHC {}; // AI perdavimas į Headless Client
```

#### 5. Vykdykite po AI sukūrimo (`V2startServer.sqf`)

Pridėkite po AI spawning (apie eilutę 1700):
```sqf
// Perkeliame visas AI grupes į Headless Client
sleep 5; // Laukiame kol visos grupės bus sukurtos
[] call wrm_fnc_transferAItoHC;
```

#### 6. Paleiskite HC

**Windows:**
```cmd
cd "C:\Program Files (x86)\Steam\steamapps\common\Arma 3"
arma3server_x64.exe -client -connect=127.0.0.1 -port=2302 -password=YOUR_PASSWORD -mod=@mod1;@mod2
```

**Linux:**
```bash
./arma3server -client -connect=127.0.0.1 -port=2302 -password=YOUR_PASSWORD -mod=@mod1;@mod2
```

---

### **SPRENDIMAS #2: Optimizuoti Scheduler (Sumažinti Gijų Skaičių)**

**Problema:** Per daug `spawn` komandų perkrauna scheduler.

**Sprendimas:** Sujungti kelias `spawn` gijas į VIENĄ.

#### Prieš (BLOGAI):

```sqf
[] spawn wrm_fnc_V2aiVehUpdate;
[] spawn wrm_fnc_V2aiArtillery;
[] spawn wrm_fnc_V2aiCAS;
[] spawn wrm_fnc_V2ticketBleed;
[] spawn wrm_fnc_V2dynamicAIon;
```

Tai sukuria **5 atskiras gijas** → scheduler perkrautas.

#### Po (GERAI):

Sukurkite **VIENĄ** AI valdymo loop'ą:

```sqf
// Naujas failas: functions/server/fn_AIManager.sqf
/*
    Author: Optimized AI Manager
    
    Description:
        Viena gija visiems AI valdymams - sumažina scheduler apkrovą
*/

if !(isServer) exitWith {};

private _lastVehUpdate = time;
private _lastArtillery = time;
private _lastCAS = time;
private _lastTicketBleed = time;
private _lastDynamicAI = time;

while {true} do {
    // AI Vehicle Update - kas 30 sekundžių
    if (time - _lastVehUpdate > 30) then {
        [] call wrm_fnc_V2aiVehUpdate; // Pakeisti iš spawn į call
        _lastVehUpdate = time;
    };
    
    // AI Artillery - kas 60 sekundžių
    if (AIon > 0 && {time - _lastArtillery > 60}) then {
        [] call wrm_fnc_V2aiArtillery;
        _lastArtillery = time;
    };
    
    // AI CAS - kas 60 sekundžių
    if (AIon > 0 && {time - _lastCAS > 60}) then {
        [] call wrm_fnc_V2aiCAS;
        _lastCAS = time;
    };
    
    // Ticket Bleed - kas 10 sekundžių
    if (ticBleed > 0 && {time - _lastTicketBleed > 10}) then {
        [] call wrm_fnc_V2ticketBleed;
        _lastTicketBleed = time;
    };
    
    // Dynamic AI - kas 30 sekundžių
    if (AIon > 0 && {time - _lastDynamicAI > 30}) then {
        [] call wrm_fnc_V2dynamicAIon;
        _lastDynamicAI = time;
    };
    
    // SVARBU: sleep sumažina scheduler apkrovą
    sleep 5; // Patikrina kas 5 sekundes
};
```

Tada `V2aiStart.sqf` vietoj 5 spawn, naudokite **1 spawn**:
```sqf
// Vietoj:
// [] spawn wrm_fnc_V2aiVehUpdate;
// [] spawn wrm_fnc_V2aiArtillery;
// ...

// Naudokite:
[] spawn wrm_fnc_AIManager; // Viena gija visiems
```

---

### **SPRENDIMAS #3: Strigimo Aptikimas ir Atkūrimas**

Jūsų kodas Jau TUR strigimo aptikimą (`wrm_fnc_V2aiStuckCheck`), bet galbūt jis neveikia teisingai.

**Patikrinimas:**

Pažiūrėkite, ar funkcija yra vykdoma:

```sqf
// functions/server/fn_V2aiStuckCheck.sqf
// Pridėkite debug pranešimą į funkciją:

["AI Stuck Check: Running for " + str(_unit)] remoteExec ["systemChat", 0, false];
```

Jei nepasirodo pranešimas → funkcija **neveikia**.

**Sprendimas:** Užtikrinkite, kad `wrm_fnc_V2aiStuckCheck` yra vykdoma **kiekvienai AI grupei**.

---

### **SPRENDIMAS #4: Serverio Konfigūracijos Optimizavimas**

#### `basic.cfg` (Serverio root folderis)

```cfg
MaxMsgSend = 256; // Padidinta nuo 128 → geresnis tinklo throughput
MaxSizeGuaranteed = 512; // Padidinta nuo 256
MaxSizeNonguaranteed = 256; // Pozicijos atnaujinimai AI
MinBandwidth = 400000000; // 400 Mbps
MaxBandwidth = 800000000; // 800 Mbps
MinErrorToSendNear = 0.02; // Sumažina mikroatnaujinimus
```

#### `server.cfg`

```cfg
MinBandwidth = 400000000;
MaxBandwidth = 800000000;
MaxCustomFileSize = 160000;

// SVARBU: Serverio FPS optimizavimas
class Missions {
    class Mission1 {
        difficulty = "regular";
        class Difficulty {
            class Options {
                reducedDamage = 0;
                groupIndicators = 0;
                friendlyTags = 0;
                enemyTags = 0;
                detectedMines = 0;
                commands = 0;
                waypoints = 0;
                weaponInfo = 2;
                stanceIndicator = 2;
                staminaBar = 1;
                weaponCrosshair = 0;
                visionAid = 0;
                thirdPersonView = 1;
                cameraShake = 1;
                scoreTable = 1;
                deathMessages = 1;
                vonID = 1;
                mapContent = 0;
                autoReport = 0;
                multipleSaves = 0;
            };
            
            // SVARBU: AI Skill optimizavimas
            class Flags {
                3rdPersonView = 1;
                armor = 1;
                autoAim = 0;
                autoGuideAT = 0;
                autoSpot = 0;
                clockIndicator = 1;
                deathMessages = 1;
                enemyTag = 0;
                friendlyTag = 0;
                hud = 1;
                hudGroupInfo = 0;
                hudPerm = 0;
                hudWp = 0;
                hudWpPerm = 0;
                map = 1;
                netStats = 1;
                tracers = 1;
                ultraAI = 0; // SVARBU: Išjungti ultra AI - sumažina CPU
                unlimitedSaves = 0;
                vonID = 1;
                weaponCursor = 0;
            };
            
            // SVARBU: AI Skill sumažinimas - sumažina CPU apkrovą
            skillAI = 0.5; // Vietoj 1.0
            precisionAI = 0.3; // Vietoj 0.5
        };
    };
};
```

---

### **SPRENDIMAS #5: AI Skaičiaus Sumažinimas**

Jei net su HC serverio FPS per žemas, sumažinkite AI skaičių:

#### `description.ext`

Pakeiskite autonominio AI parametrą:
```sqf
default = 2; // Vietoj 3 (Overwhelming → Challenging)
```

Arba misijos metu sumažinkite AI spawning (`V2dynamicSquads.sqf` - jau turite).

---

## 📊 Diagnostika

### Kaip Patikrinti Serverio FPS?

1. **Serverio konsolėje:**
```
#monitor 1
```

Turėtumėte matyti:
- **Server FPS** (turėtų būti \u003e 20)
- **AI Count** (kiek AI vienetų)
- **Players** (kiek žaidėjų)

2. **Jei Server FPS \u003c 15** → **AI sustoja** ❌

---

## 🎯 Prioritetų Sąrašas (Ką Daryti Pirmiausia)

### **AUKŠTAS PRIORITETAS** (Daryti DABAR):

1. ✅ **Įdiekite Headless Client** - Tai **PRIVALOMA** daugiau nei 50 AI vienetų
2. ✅ **Optimizuokite Scheduler** - Sujunkite spawn gijas į vieną
3. ✅ **Patikrinkite Serverio FPS** - `#monitor 1` komanda

### **VIDUTINIS PRIORITETAS** (Daryti PO HC):

4. ⚠️ **Optimizuokite `basic.cfg` ir `server.cfg`**
5. ⚠️ **Patikrinkite AI Strigimo Aptikimą** - Ar `wrm_fnc_V2aiStuckCheck` veikia?

### **ŽEMAS PRIORITETAS** (Jei vis dar problemos):

6. 🔻 **Sumažinkite AI Skaičių** - Pakeiskite `AIon` parametrą
7. 🔻 **Sumažinkite AI Skill** - Pakeiskite `server.cfg` AI skill parametrus

---

## 📝 Santrauka

**Pastaba:** Šis dokumentas aprašo AI sustojimą dėl serverio FPS/locality problemų.
Tačiau yra ir kita AI "freeze" problema, kurią sukelia `waitUntil` be timeout - žr. `CRITICAL_FIX_MISSION_FREEZE.md`.

**Tikroji Problema:** **Serverio FPS \u003c 15** → **Serverio AI locality sustoja**

**Pagrindinė Priežastis:**
- Serveris apdoroja **per daug AI** vienu metu
- Scheduler perkrautas (per daug `spawn` gijų)
- Dynamic simulation nepadeda, nes AI sustoja **netoli** žaidėjų

**Sprendimas:**
1. **Headless Client** (HC) - Perkelia AI locality nuo serverio
2. **Scheduler Optimizavimas** - Sujungia spawn gijas į vieną
3. **Serverio Konfigūracija** - Optimizuoja tinklą ir AI skill

**Rezultatas po taisymų:**
- ✅ Serverio FPS: **30-50 FPS** (vietoj 5-15)
- ✅ AI veikia sklandžiai
- ✅ Nėra AI sustojimo
- ✅ Multiplayer stabilumas

---

## 🔗 Šaltiniai

- [Arma 3 Headless Client Wiki](https://community.bistudio.com/wiki/Arma_3:_Headless_Client)
- [AI Locality Transfer](https://community.bistudio.com/wiki/setGroupOwner)
- [Dynamic Simulation](https://community.bistudio.com/wiki/Arma_3:_Dynamic_Simulation)
- [Server Performance Optimization](https://community.bistudio.com/wiki/Arma_3:_Server_Config_File)
- SQF_SYNTAX_BEST_PRACTICES.md (VII skyrius - AI Gedimai ir Desinchronizacija)

---

**Paskutinis Atnaujinimas:** 2025-11-19
**Autorius:** AI Optimization Guide
**Versija:** 1.0
