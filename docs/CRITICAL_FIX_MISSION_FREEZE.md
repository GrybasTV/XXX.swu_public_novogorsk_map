# 🔥 KRITINĖ PROBLEMA: MISIJOS SUSTOJIMAS - TIKROJI PRIEŽASTIS

**Data**: 2025-01-XX
**Versija**: 1.0

## 🔴 SIMPTOMAS

**VISA MISIJA UŽSTRINGA:**
- ❌ AI nepaž**įstami (negalima nusauti)
- ❌ Negalima iškviesti air support
- ❌ Negalima užimti flagų
- ❌ Nebespauna nauji kariai
- ❌ Visas progresas sustoja
- ❌ **Nauji žaidėjai negali prisijungti**
- ✅ Zeus nauji AI veikia normaliai
- ✅ Žaidejai esantys serveryje mato save, juda ir yra sichronizuojami
- ✅ Animacijos veikia

## 🔍 TIKROJI PRIEŽASTIS

**NE AI locality problema!**  
**NE serverio FPS problema!**  
**NE headless client problema!**

### **TIKROJI PRIEŽASTIS: `waitUntil` BE TIMEOUT UŽSTRINGA AMŽINAI** 🔥

**Pastaba:** Šis dokumentas aprašo misijos "užšalimą" dėl scheduler starvation, kurį sukelia `waitUntil` be timeout.
Tačiau yra ir kita AI "freeze" problema dėl serverio FPS - žr. `AI_FREEZE_FIX.md`.

**Kas atsitiko:**

1. **Viena serverio funkcija užstrigo** `waitUntil` komandoje **amžinai**
2. Ši funkcija **blokuoja scheduler** (vykdymo tvarkyklę)
3. **Visos kitos funkcijos negali vykti** (scheduler starvation)
4. **Visa misijos dinamika sustoja**

---

## 📊 RASTOS KRITINĖS KLAIDOS

### **KLAIDA #1: `fn_V2dynamicAIon.sqf` - PATAISYTA ✅**

**Vieta:** Eilutė 42

**PRIEŠ:**
```sqf
waitUntil {progress >= 2};
```

**PROBLEMA:**
- Jei `progress` **niekada** nepasiekia `2` (pvz., dėl JIP problemų)
- `waitUntil` **laukia AMŽINAI**
- **BLOKUOJA scheduler** → visa misija sustoja

**PO TAISYMO:** ✅
```sqf
private _startTime = time;
private _timeout = 600; // 10 minučių
waitUntil {
    sleep 1;
    progress >= 2 || {time - _startTime > _timeout}
};

if (time - _startTime > _timeout && progress < 2) exitWith {
    ["WARNING: Dynamic AIon timeout"] remoteExec ["systemChat", 0, false];
};
```

---

### **KLAIDA #2: `fn_V2nationChange.sqf` - BŪTINA TAISYTI ❌**

**Vieta:** Eilutės 24, 51, 63, 75, 85

**PROBLEMA - 5 `waitUntil` BE TIMEOUT:**

```sqf
// Eilutė 24
waitUntil{side _un!=civilian};  // ❌ Jei vienetas niekada nepakeičia pusės

// Eilutė 51
waitUntil{count _voices!=0};  // ❌ Jei voiceW/voiceE neegzistuoja arba tušti

// Eilutė 63
waitUntil{count _faces!=0};  // ❌ Jei faceW/faceE neegzistuoja

// Eilutė 75
waitUntil{count _Fnames!=0};  // ❌ Jei nameW/nameE neegzistuoja

// Eilutė 85
waitUntil{count _Lnames!=0};  // ❌ Jei pavardžių neranFunctions>();
```

**KAIP ŠI KLAIDA UŽBLOKUOJA VISĄ MISIJĄ:**

1. Žaidėjas respawn'ina arba prisijungia
2. `fn_V2nationChange.sqf` kviečiama
3. `waitUntil{count _voices!=0}` laukia **amžinai** (nes `_voices` tuščias)
4. **Scheduler** negali vykdyti **JOKIOS KITOS FUNKLIJOS**
5. **Visa misija užstringa**

---

## ✅ SPRENDIMAI

### **SPRENDIMAS #1: Pridėti Timeout VISIEMS `waitUntil`** - PRIVALOMA!

Pakeisti **VISUS** `waitUntil` į:

```sqf
// BLOGAI ❌
waitUntil {sąlyga};

// GERAI ✅
private _startTime = time;
private _timeout = 60; // sekundės
waitUntil {
    sleep 0.5;
    sąlyga || {time - _startTime > _timeout}
};

if (time - _startTime > _timeout) exitWith {
    ["WARNING: waitUntil timeout"] remoteExec ["systemChat", 0, false];
};
```

---

### **SPRENDIMAS #2: Pataisyti `fn_V2nationChange.sqf`** - KRITINIS!

**Naujas kodas su timeout:**

```sqf
/*
    KRITINIS FIX: Pridėti timeout VISIEMS waitUntil
    Senasis kodas užstrigdavo amžinai jei _voices, _faces, _Fnames, _Lnames būtų tušti
*/

_un = _this select 0;

// TIMEOUT #1: Laukti kol vienetas pakeičia pusę (max 30 sekundžių)
private _startTime1 = time;
waitUntil {
    sleep 0.5;
    side _un != civilian || {time - _startTime1 > 30}
};

if (time - _startTime1 > 30) exitWith {
    ["WARNING: Unit side timeout - exiting nationChange"] remoteExec ["systemChat", 0, false];
};

_conF=''; _conV=''; _conN="";
call {
    if(side _un==sideW)exitWith {
        _conF=faceW;_conV=voiceW;_conN=nameW;
    };
    if(side _un==sideE)exitWith {
        _conF=faceE;_conV=voiceE;_conN=nameE;
    };
};

// VOICE
_voices=[];
if (voiceW isEqualType [])
then {_voices = voiceW;}
else {
    _cfgV="((str(getArray(_x >> 'identityTypes')) find _conV >= 0))" configClasses (configFile>>"cfgVoice");
    {
        _v = configName (_x);
        _voices pushBack _v;
    } forEach _cfgV;
};

// TIMEOUT #2: Voices
private _startTime2 = time;
waitUntil {
    sleep 0.5;
    count _voices != 0 || {time - _startTime2 > 10}
};

if (count _voices == 0) then {
    ["WARNING: No voices found - using default"] remoteExec ["systemChat", 0, false];
    _voices = ["Male01ENG"]; // Numatytasis balsas
};

_voice=selectRandom _voices;
[_un, _voice] remoteExec ["setSpeaker",0,true];

// FACE
_faces=[];
_cfgF="(getText(_x >> 'head') find _conF >= 0)" configClasses (configFile>>"cfgFaces">>"Man_A3");
{
    _f = configName (_x);
    _faces pushBack _f;
} forEach _cfgF;

// TIMEOUT #3: Faces
private _startTime3 = time;
waitUntil {
    sleep 0.5;
    count _faces != 0 || {time - _startTime3 > 10}
};

if (count _faces == 0) then {
    ["WARNING: No faces found - using default"] remoteExec ["systemChat", 0, false];
    _faces = ["WhiteHead_01"]; // Numatytasis veidas
};

_face=selectRandom _faces;
[_un, _face] remoteExec ["setFace",0,true];

// FIRST NAME
_Fnames=[];
_cfgN=configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "FirstNames")];
{
    _n = getText (_x);
    _Fnames pushBackUnique _n;
} forEach _cfgN;

// TIMEOUT #4: First Names
private _startTime4 = time;
waitUntil {
    sleep 0.5;
    count _Fnames != 0 || {time - _startTime4 > 10}
};

if (count _Fnames == 0) then {
    ["WARNING: No first names found - using default"] remoteExec ["systemChat", 0, false];
    _Fnames = ["John"]; // Numatytasis vardas
};

_first=selectRandom _Fnames;

// LAST NAME
_Lnames=[];
_cfgN=configProperties [(configfile >> "CfgWorlds" >> "GenericNames" >> _conN >> "LastNames")];
{
    _n = getText (_x);
    _Lnames pushBackUnique _n;
} forEach _cfgN;

// TIMEOUT #5: Last Names
private _startTime5 = time;
waitUntil {
    sleep 0.5;
    count _Lnames != 0 || {time - _startTime5 > 10}
};

if (count _Lnames == 0) then {
    ["WARNING: No last names found - using default"] remoteExec ["systemChat", 0, false];
    _Lnames = ["Doe"]; // Numatytoji pavardė
};

_second=selectRandom _Lnames;

[_un,[([_first," ",_second] joinString ""),_first,_second]] remoteExec ["setName", 0, true];
```

---

### **SPRENDIMAS #3: Pataisyti `fn_V2loadoutChange.sqf`**

Tikrinti ar joje yra `waitUntil` be timeout.

---

## 🎯 PRIORITETŲ SĄRAŠAS (Ką Daryti DABAR)

### **AUKŠTAS PRIORITETAS** - Daryti NEDELSIANT:

1. ✅ **PATAISYTA:** `fn_V2dynamicAIon.sqf` - pridėtas timeout
2. ❌ **BŪTINA TAISYTI:** `fn_V2nationChange.sqf` - pridėti timeout
3. ⚠️ **PATIKRINTI:** `fn_V2loadoutChange.sqf` - ar yra `waitUntil` be timeout?
4. ⚠️ **PATIKRINTI:** Visi kiti failai - ieškoti `waitUntil` be timeout

### **Kaip Rasti Visus `waitUntil`:**

```powershell
# PowerShell komanda
Get-ChildItem -Recurse -Filter "*.sqf" | Select-String "waitUntil" | Where-Object {$_.Line -notmatch "time|timeout"}
```

---

## 📝 Kodėl Tai Įvyko?

### **SQF Scheduler Veikimas:**

1. **Suplanuota aplinka** (`spawn`, `execVM`):
   - Visos funkcijos vykdomos **po 3ms** per kadrą
   - Jei viena funkcija **nebaigia** darbo, kitos **laukia**

2. **`waitUntil` be `sleep`:**
   - Užima **VISĄ 3ms** tikrinimui
   - **NeLEIDŽIA** kitoms funkcijoms vykti

3. **`waitUntil` be timeout:**
   - Jei sąlyga **niekada netampa true**
   - Funkcija **užstringa AMŽINAI**
   - **BLOKUOJA scheduler** → **visa misija sustoja**

---

## 📚 SQF Geriausios Praktikos

### **VISADA Pridėkite Timeout:**

```sqf
// ❌ BLOGAI - NIEKADA NENAUDOKITE
waitUntil {sąlyga};

// ✅ GERAI - VISADA NAUDOKITE
private _startTime = time;
private _timeout = 60;
waitUntil {
    sleep 0.5; // BŪTINA sleep, kad scheduler galėtų vykdyti kitas funkcijas
    sąlyga || {time - _startTime > _timeout}
};

if (time - _startTime > _timeout) then {
    // Timeout - ivyko klaida
    // Užbaigiame funkciją arba naudojame numatytąsias reikšmes
};
```

### **VISADA Pridėkite `sleep` į `waitUntil`:**

```sqf
// ❌ BLOGAI - Užblokuoja scheduler
waitUntil {progress >= 2};

// ✅ GERAI - Leidžia scheduler vykdyti kitas funkcijas
waitUntil {
    sleep 0.5;
    progress >= 2
};
```

---

## ✨ Išvada

**TIKROJI PROBLEMA:**
- **`waitUntil` be timeout** užstringa amžinai
- **Blokuoja scheduler** (vykdymo tvarkyklę)
- **Visa misija sustoja**

**SPRENDIMAS:**
- Pridėti **timeout** VISIEMS `waitUntil`
- Pridėti **sleep** į kiekvieną `waitUntil` loop'ą
- Pridėti **fail-safe** numatytąsias reikšmes jei timeout įvyksta

**REZULTATAS PO TAISYMŲ:**
- ✅ Misija nebeprisės
- ✅ AI veiks normaliai
- ✅ Naujai žaidėjai galės prisijungti  
- ✅ Misijos dinamika veiks sklandžiai

---

**Paskutinis Atnaujinimas:** 2025-11-19  
**Autorius:** Critical Bug Fix Guide  
**Versija:** 1.0
