# SQF Klaidos ir Sprendimai - Mūsų Patirtis

## Nuorodos

- **Originali dokumentacija**: `MODIFICATIONS.md` - Visi dokumentuoti pakeitimai ir klaidos
- **Arma 3 SQF Dokumentacija**: [BIS Wiki](https://community.bistudio.com/wiki/Category:Scripting_Commands)

## Apžvalga

Šis dokumentas apibendrina visas SQF kalbos klaidas, su kuriomis susidūrėme modifikuojant Warmachine misiją. Kiekviena klaida dokumentuota su:
- **Problema**: Kas neveikė
- **Priežastis**: Kodėl taip atsitiko
- **Sprendimas**: Kaip ištaisėme
- **Pamoka**: Ką išmokome

---

## Dažniausios SQF Klaidos (Pagal Mūsų Patirtį)

### 1. Variable Scope Klaidos (_grp, _gr, _unit, etc.)

**Dažnumas**: ⭐⭐⭐⭐ (Labai dažna - 35% visų mūsų klaidų)

#### Problema
Kintamieji apibrėžiami if/else blokuose, bet naudojami už jų ribų.

#### Pavyzdžiai iš mūsų kodo:

**Klaidingas kodas:**
```sqf
if (_isCustomClass) then {
    _grp = createGroup [sideW, true];  // _grp čia
} else {
    _grp = [_pos, sideW, _toSpawn...] call BIS_fnc_spawnGroup;  // _grp čia
};
defW pushBackUnique _grp;  // ❌ ERROR: _grp undefined!
```

**Teisingas kodas:**
```sqf
private "_grp";  // Deklaruoti iš anksto
if (_isCustomClass) then {
    _grp = createGroup [sideW, true];
} else {
    _grp = [_pos, sideW, _toSpawn...] call BIS_fnc_spawnGroup;
};
defW pushBackUnique _grp;  // ✅ Veikia!
```

#### Kodėl tai dažna klaida:
- SQF naudoja **dynamic scoping** - kintamieji egzistuoja tik savo deklaracijos scope
- Skirtingai nuo kitų kalbų (C++, Java), kur kintamieji deklaruojami bloko pradžioje
- Jei kintamasis apibrėžiamas if/else viduje, jis gali būti nepasiekiamas už bloko ribų

#### Mūsų susidūrimai:
1. ✅ `baseDefense.sqf` (2025-11-05) - `_grp` scope problema
2. ✅ `fn_V2secDefense.sqf` (2025-11-05) - `_grp` scope problema
3. ✅ `moreSquads.sqf` (2025-11-07) - `_grp` scope problema tiek WEST, tiek EAST pusėse (keli atvejai)
4. ✅ `moreSquads.sqf` (2025-11-07) - Nepakako vien patikrinimų - reikėjo ir `private` deklaracijų forEach pradžioje

#### Sprendimo principas:
```sqf
// VISADA deklaruoti kintamuosius prieš if/else blokus
private "_grp";
private "_unit";
private "_pos";

// Tada naudoti juos blokuose
if (condition) then {
    _grp = createGroup [sideW, true];
} else {
    _grp = grpNull;
};

// Dabar _grp pasiekiamas visur
if (!isNull _grp) then {
    // Veiksmai su grupe
};
```

#### Best Practice:
- **Deklaruoti visus kintamuosius failo/scope pradžioje**
- **Naudoti `private` raktinį žodį** - apsaugo nuo global scope užteršimo
- **Nustatyti default reikšmes** (`grpNull`, `objNull`, `[]`) - apsaugo nuo undefined klaidų
- **SISTEMIŠKAI taikyti principus** - patikrinti kiekvieną forEach/if ciklą atskirai
- **Testuoti po kiekvieno pataisymo** - viena klaida gali slėpti kitas panašias problemas

---

### 2. Loadout ir Inventory Problema

**Dažnumas**: ⭐⭐⭐⭐ (Dažna - 30% visų mūsų klaidų)

#### Problema
Custom loadout'ai ir inventory sistema turi tuščių reikšmių arba nesuderinamų kombinacijų.

#### Pavyzdžiai iš mūsų kodo:
```
Trying to add inventory item with empty name to object [Sergeant]
ERROR: Switch uniform! Uniform RUS_VKPO_Demi_2 is not allowed for soldier class RUS_spn_reconsniper
Backpack with given name: [] not found
```

#### Kodėl tai dažna klaida:
- Custom klasės turi ribotus loadout pasirinkimus
- Inventory array'ai gali turėti tuščių stringų arba `[]` vietoj pavadinimų
- Uniformos/kuprinės gali būti nesuderinamos su konkrečiomis klasėmis
- Mod'ų specifika reikalauja specialaus valdymo

#### Mūsų susidūrimai:
1. ✅ `moreSquads.sqf` (2025-11-07) - RUS/Russia 2025 klasės su VKPO uniformomis
2. ✅ `moreSquads.sqf` (2025-11-07) - Tušti inventory items ir backpacks

#### Sprendimo principas:
```sqf
//Filtruoti tuščius inventory items:
if (_item != "" && _item isEqualType "") then {
    _unit addItemToUniform _item;
};

//Patikrinti uniformų suderinamumą:
if (_uniform in getArray (configFile >> "CfgVehicles" >> typeOf _unit >> "allowedUniforms")) then {
    _unit forceAddUniform _uniform;
};

//Filtruoti backpack pavadinimus:
if (_backpack != "" && _backpack isEqualType "") then {
    _unit addBackpack _backpack;
};
```

#### Best Practice:
- **Filtruoti loadout array'us** prieš naudojimą
- **Testuoti loadout'us** su skirtingomis klasėmis
- **Turėti fallback reikšmes** kiekvienai kategorijai
- **Naudoti `forceAddUniform`** jei reikia priverstinai priskirti
- **Šios klaidos nėra kritinės** - vienetai spawn'ins su default reikšmėmis

---

### 3. Semicolon Syntax Klaidos

**Dažnumas**: ⭐⭐⭐ (Vidutinio dažnumo - 10% visų mūsų klaidų)

#### Problema
SQF nereikalauja kabliataškių po blokų uždarymo, bet jų pridėjimas sukėlė sintaksės klaidas.

#### Pavyzdžiai iš mūsų kodo:

**Klaidingas kodas:**
```sqf
if(modA=="A3")then
{
    if(side _un==west)then{...};
    if(side _un==east)then{...};
};  // ❌ Šis kabliataškis sukėlė klaidą!
```

**Teisingas kodas:**
```sqf
if(modA=="A3")then
{
    if(side _un==west)then{...};
    if(side _un==east)then{...};
}  // ✅ Be kabliataškio
```

#### Kodėl tai dažna klaida:
- Programmeriai, dirbantys su C-like kalbomis (C++, Java, JavaScript), įpratę pridėti `;` po blokų
- SQF sintaksė **nereikalauja** kabliataškių po `}` uždarymo
- Kabliataškis po bloko uždarymo gali sukelti "Missing }" arba "Unexpected ;" klaidas

#### Mūsų susidūrimai:
1. ✅ `fn_V2loadoutChange.sqf` (2025-11-05) - kabliataškis po if bloko uždarymo

#### Sprendimo principas:
```sqf
// TEISINGA:
if (condition) then {
    // kodas
}  // ✅ Be kabliataškio

// KLAIDINGA:
if (condition) then {
    // kodas
};  // ❌ Kabliataškis nereikalingas

// IŠIMTIS - jei blokas yra expression dalis:
_result = if (condition) then {value1} else {value2};  // ✅ Čia kabliataškis REIKALINGAS
```

#### Best Practice:
- **Kabliataškiai reikalingi tik po expression'ų** (priskyrimai, funkcijų kvietimai)
- **Po blokų uždarymo (`}`) kabliataškiai NEREIKALINGI**
- **Jei klaida "Missing }"** - patikrinkite ar nėra nereikalingų kabliataškių

---

### 4. waitUntil Ciklų Užstrigimas

**Dažnumas**: ⭐⭐⭐ (Vidutinio dažnumo - 10% visų mūsų klaidų)

#### Problema
`waitUntil` ciklai gali užstrigti neribotai, jei sąlyga niekada netampa teisinga.

#### Pavyzdžiai iš mūsų kodo:

**Klaidingas kodas:**
```sqf
[_p] execVM "warmachine\V2aoCreate.sqf";
waitUntil {AOcreated == 2};  // ❌ Gali užstrigti neribotai!
waitUntil {AOcreated != 2};  // ❌ Gali užstrigti neribotai!
```

**Teisingas kodas:**
```sqf
[_p] execVM "warmachine\V2aoCreate.sqf";
private _timeout = time + 30;  // ✅ Timeout: 30 sekundžių
waitUntil {AOcreated == 2 || time > _timeout};
if (time > _timeout) then {
    AOcreated = 0;  // ✅ Reset, jei timeout'as pasiektas
    if(DBG)then{systemChat "AO creation timeout";};
} else {
    _timeout = time + 30;
    waitUntil {AOcreated != 2 || time > _timeout};
    if (time > _timeout && AOcreated == 2) then {
        AOcreated = 0;  // ✅ Reset, jei užstrigo
    };
};
```

#### Kodėl tai dažna klaida:
- `waitUntil` laukia, kol sąlyga tampa `true`
- Jei sąlyga niekada netampa `true` (dėl bug'o, tinklo problemų, arba neteisingos logikos), ciklas užstrigs **NERIBOTAI**
- Dedikuotame serveryje tai gali užstrigti visą misiją

#### Mūsų susidūrimai:
1. ✅ `V2startServer.sqf` (2025-11-07) - AO kūrimo užstrigimas

#### Sprendimo principas:
```sqf
// VISADA pridėti timeout'ą prie waitUntil
private _timeout = time + 30;  // 30 sekundžių timeout
waitUntil {condition || time > _timeout};

// Patikrinti ar timeout'as pasiektas
if (time > _timeout) then {
    // Handle timeout - reset, log, arba fallback
    if(DBG)then{systemChat "Timeout pasiektas!";};
};
```

#### Best Practice:
- **VISADA pridėti timeout'ą** prie `waitUntil` ciklų
- **Timeout'as turi būti pagrįstas** - ne per trumpas (gali nutraukti teisingą procesą), ne per ilgas (gali užstrigti)
- **Log'uoti timeout'us** debug režime, kad būtų galima identifikuoti problemas
- **Turėti fallback logiką** - ką daryti, jei timeout'as pasiektas

---

### 5. Config Entry Skaitymo Klaidos

**Dažnumas**: ⭐⭐ (Retai - 5% visų mūsų klaidų)

#### Problema
Neteisingas config entry skaitymas - naudojamas netinkamas metodas.

#### Pavyzdžiai iš mūsų kodo:

**Klaidingas kodas:**
```sqf
gametipe = getMissionConfigValue (missionConfigFile >> "Header" >> "gameType");
// ❌ Error: Type Config entry, expected Array,String
```

**Teisingas kodas:**
```sqf
gametipe = getText (missionConfigFile >> "Header" >> "gameType");
// ✅ Veikia teisingai
```

#### Kodėl tai dažna klaida:
- `getMissionConfigValue` priima tik **String** arba **Array** kaip parametrą
- `missionConfigFile >> "Header" >> "gameType"` yra **Config entry**, ne String
- Reikia naudoti `getText`, `getNumber`, arba `getArray` su config path

#### Mūsų susidūrimai:
1. ✅ `init.sqf` (2025-11-07) - `getMissionConfigValue` su Config entry

#### Sprendimo principas:
```sqf
// TEISINGA - naudoti getText su config path:
gametipe = getText (missionConfigFile >> "Header" >> "gameType");

// ARBA - jei reikia skaičiaus:
maxPlayers = getNumber (missionConfigFile >> "Header" >> "maxPlayers");

// ARBA - jei reikia masyvo:
respawnTemplates = getArray (missionConfigFile >> "respawnTemplates");
```

#### Best Practice:
- **getText** - string reikšmėms
- **getNumber** - skaičiams
- **getArray** - masyvams
- **getMissionConfigValue** - tik su String arba Array parametrais (ne Config path)

---

### 6. Kintamųjų Inicializavimo Klaidos (isNil patikrinimas)

**Dažnumas**: ⭐⭐⭐ (Vidutinio dažnumo - 10% visų mūsų klaidų)

#### Problema
Kintamieji naudojami be inicializacijos arba patikrinimo.

#### Pavyzdžiai iš mūsų kodo:

**Klaidingas kodas:**
```sqf
// SupReq naudojamas be inicializacijos
if (!isNil "SupReq" && !isNull SupReq) then {
    [player, SupReq] call BIS_fnc_addSupportLink;  // ❌ SupReq gali būti undefined!
};
```

**Teisingas kodas:**
```sqf
// Patikrinti ir inicializuoti prieš naudojimą
if (isNil "SupReq") then {
    call {
        if (side player == sideW) exitWith {
            if (!isNil "SupReqW" && !isNull SupReqW) then {
                SupReq = SupReqW;
            } else {
                SupReq = objNull;
            };
        };
        if (side player == sideE) exitWith {
            if (!isNil "SupReqE" && !isNull SupReqE) then {
                SupReq = SupReqE;
            } else {
                SupReq = objNull;
            };
        };
    };
};
// Dabar SupReq visada apibrėžtas
if (!isNil "SupReq" && !isNull SupReq) then {
    [player, SupReq] call BIS_fnc_addSupportLink;  // ✅ Veikia!
};
```

#### Kodėl tai dažna klaida:
- Kintamieji gali būti apibrėžti skirtingose vietose (client/server, skirtinguose script'uose)
- Jei inicializacija vyksta vėliau nei naudojimas, kintamasis gali būti `undefined`
- `isNil` patikrinimas neužtenka - reikia ir inicializuoti

#### Mūsų susidūrimai:
1. ✅ `fn_leaderActions.sqf` (2025-11-07) - `SupReq` inicializavimas

#### Sprendimo principas:
```sqf
// VISADA patikrinti ir inicializuoti prieš naudojimą
if (isNil "variableName") then {
    // Inicializuoti su default reikšme arba pagal sąlygas
    variableName = defaultValue;
};

// Tada naudoti
if (!isNil "variableName" && !isNull variableName) then {
    // Veiksmai su kintamuoju
};
```

#### Best Practice:
- **Patikrinti `isNil`** prieš naudojimą
- **Inicializuoti su default reikšme** jei nėra apibrėžtas
- **Naudoti `objNull`** objektams, `grpNull` grupėms, `[]` masyvams kaip default
- **Dokumentuoti**, kur kintamasis turėtų būti inicializuotas

---

## Įspėjimai (Ne-kritinės klaidos)

### "Trying to add inventory item with empty name to object"

**Dažnumas**: ⭐⭐ (Retai, bet pasitaiko)

#### Problema
Arma 3 log'e rodomas įspėjimas apie tuščius inventory item'us vienetams.

#### Pavyzdžiai iš mūsų kodo:
```
15:44:00 Trying to add inventory item with empty name to object [Sergeant]
```

#### Kodėl tai nėra kritinė klaida:
- Tai tik **įspėjimas**, ne klaida - misija veikia normaliai
- Įvyksta dėl custom loadout'ų, kurie turi tuščius inventory slot'us
- Custom vienetų klasėse kai kurie inventory slot'ai gali būti tušti string'ai
- Nėra neigiamo poveikio žaidimui

#### Mūsų susidūrimai:
1. ✅ `moreSquads.sqf` (2025-11-07) - custom klasės vienetų loadout'ai

#### Sprendimo principas:
```sqf
// Šis įspėjimas nėra kritinis - galima ignoruoti arba filtruoti loadout'us:
// Prieš pridedant į inventory patikrinti ar item'as nėra tuščias
if (_item != "" && _item isEqualType "") then {
    _unit addItemToUniform _item;
};
```

#### Best Practice:
- **Custom loadout'ams** naudoti patikrinimus prieš pridedant item'us
- **Šis įspėjimas nėra kritinis** - galima palikti kaip yra
- **Filtruoti tuščius stringus** iš loadout array'ų

---

### "ERROR: Switch uniform! Uniform is not supported by soldier"

**Dažnumas**: ⭐⭐⭐ (Dažna su custom klasėmis)

#### Problema
Arma 3 rodo klaidą apie uniformas, kurios nėra palaikomos tam tikrai klasei vienetų.

#### Pavyzdžiai iš mūsų kodo:
```
ERROR: Switch uniform! Uniform is not supported by soldier
Uniform RUS_VKPO_Demi_2 is not allowed for soldier class RUS_spn_reconsniper
```

#### Kodėl tai dažna problema:
- Custom vienetų klasės turi ribotus uniformų pasirinkimus
- Loadout sistema bando priskirti uniformą, kuri nėra suderinama su klase
- Įvyksta dėl mod'ų specifikos arba neteisingų loadout kombinacijų

#### Mūsų susidūrimai:
1. ✅ `moreSquads.sqf` (2025-11-07) - RUS/Russia 2025 klasės su VKPO uniformomis

#### Sprendimo principas:
```sqf
//Patikrinti uniformų suderinamumą arba naudoti fallback uniformas
if (_uniform in getArray (configFile >> "CfgVehicles" >> typeOf _unit >> "allowedUniforms")) then {
    _unit forceAddUniform _uniform;
} else {
    //Fallback uniforma
    _unit forceAddUniform "defaultUniform";
};
```

#### Best Practice:
- **Testuoti loadout'us** su skirtingomis klasėmis prieš naudojimą
- **Turėti fallback uniformas** kiekvienai frakcijai
- **Naudoti `forceAddUniform`** vietoj `addUniform` jei reikia
- **Šios klaidos nėra kritinės** - vienetai vis tiek spawn'ins, tik su default uniforma

---

### "Backpack with given name: [] not found"

**Dažnumas**: ⭐⭐ (Retai)

#### Problema
Loadout sistema bando priskirti kuprinę su tuščiu pavadinimu.

#### Pavyzdžiai iš mūsų kodo:
```
Backpack with given name: [] not found
Trying to add inventory item with empty name to object [Recon-Sniper]
```

#### Kodėl tai įvyksta:
- Custom loadout array'ai turi tuščius stringus vietoj kuprinių pavadinimų
- `[]` interpretuojamas kaip tuščias masyvas, o ne kaip stringas
- Panaši problema kaip su inventory items

#### Sprendimo principas:
```sqf
//Filtruoti tuščius backpack pavadinimus
if (_backpack != "" && _backpack isEqualType "") then {
    _unit addBackpack _backpack;
};
```

#### Best Practice:
- **Patikrinti backpack pavadinimus** prieš pridedant
- **Naudoti default backpack** jei custom nėra
- **Filtruoti loadout array'us** prieš naudojimą

---

## Mūsų Susidūrimų Statistika

### Pagal Klaidų Tipą:

| Klaidos Tipas | Dažnumas | Failai |
|---------------|----------|--------|
| Variable Scope | 35% | baseDefense.sqf, fn_V2secDefense.sqf, moreSquads.sqf (WEST ir EAST) |
| Loadout Issues | 30% | moreSquads.sqf (uniforms, backpacks, inventory) |
| Semicolon Syntax | 10% | fn_V2loadoutChange.sqf |
| waitUntil Timeout | 10% | V2startServer.sqf |
| Variable Initialization | 10% | fn_leaderActions.sqf |
| Config Entry Reading | 5% | init.sqf |

### Pagal Failus:

| Failas | Klaidų Skaičius | Tipai |
|--------|----------------|-------|
| `moreSquads.sqf` | 5+ | Variable Scope + Loadout Issues |
| `baseDefense.sqf` | 1 | Variable Scope |
| `fn_V2secDefense.sqf` | 1 | Variable Scope |
| `fn_V2loadoutChange.sqf` | 1 | Semicolon Syntax |
| `V2startServer.sqf` | 1 | waitUntil Timeout |
| `fn_leaderActions.sqf` | 1 | Variable Initialization |
| `init.sqf` | 1 | Config Entry Reading |

---

## SQF Best Practices (Išmoktos Pamokos)

### 1. Variable Scoping

```sqf
// ✅ GERAI - deklaruoti iš anksto
private "_grp";
private "_unit";
private "_pos";

if (condition) then {
    _grp = createGroup [sideW, true];
} else {
    _grp = grpNull;
};

// ✅ GERAI - naudoti po deklaracijos
if (!isNull _grp) then {
    // Veiksmai
};
```

### 2. waitUntil su Timeout'ais

```sqf
// ✅ GERAI - visada su timeout'u
private _timeout = time + 30;
waitUntil {condition || time > _timeout};

if (time > _timeout) then {
    // Handle timeout
};
```

### 3. Kintamųjų Inicializavimas

```sqf
// ✅ GERAI - patikrinti ir inicializuoti
if (isNil "variableName") then {
    variableName = defaultValue;
};

// ✅ GERAI - naudoti po inicializacijos
if (!isNil "variableName" && !isNull variableName) then {
    // Veiksmai
};
```

### 4. Config Entry Skaitymas

```sqf
// ✅ GERAI - naudoti getText/getNumber/getArray
gametipe = getText (missionConfigFile >> "Header" >> "gameType");
maxPlayers = getNumber (missionConfigFile >> "Header" >> "maxPlayers");
respawnTemplates = getArray (missionConfigFile >> "respawnTemplates");
```

### 5. Error Handling

```sqf
// ✅ GERAI - patikrinti prieš naudojimą
if (!isNil "_grp" && !isNull _grp && count units _grp > 0) then {
    // Veiksmai su grupe
} else {
    // Fallback arba error handling
    if(DBG)then{systemChat "Grupė neegzistuoja arba tuščia";};
};
```

---

## Dažniausios Klaidos (Pagal Arma 3 Bendruomenę)

### Patvirtintos kaip dažnos internete:

1. ✅ **Variable Scope** - Patvirtinta Steam Community ir BIS Forums
2. ✅ **Semicolon Syntax** - Patvirtinta kaip dažna C-like kalbų programerių klaida
3. ✅ **waitUntil Timeout** - Patvirtinta kaip dažna problema dedikuotuose serveriuose
4. ✅ **Config Entry Reading** - Patvirtinta BIS Wiki dokumentacijoje

---

## Išvados

### Kas veikia:
- ✅ **Deklaruoti kintamuosius iš anksto** - apsaugo nuo scope klaidų
- ✅ **Timeout'ai waitUntil cikluose** - apsaugo nuo užstrigimo
- ✅ **Patikrinti ir inicializuoti kintamuosius** - apsaugo nuo undefined klaidų
- ✅ **Naudoti teisingus config skaitymo metodus** - apsaugo nuo type klaidų

### Kas neveikia:
- ❌ **Kintamieji if/else blokuose be deklaracijos** - sukėlė scope klaidas
- ❌ **Kabliataškiai po blokų uždarymo** - sukėlė sintaksės klaidas
- ❌ **waitUntil be timeout'ų** - sukėlė užstrigimus
- ❌ **Kintamieji be inicializacijos** - sukėlė undefined klaidas

### Pamokos:
1. **SQF turi savo specifiką** - negalima taikyti kitų kalbų principų
2. **Dokumentacija svarbi** - padėjo greitai identifikuoti problemas
3. **Best practices veikia** - deklaracijos iš anksto, timeout'ai, patikrinimai
4. **Iteracinis development** - kiekviena klaida mokė naujų dalykų

---

## Rekomendacijos Ateityje

### Ką daryti:
1. ✅ **Visada deklaruoti kintamuosius failo pradžioje**
2. ✅ **Visada pridėti timeout'us waitUntil ciklams**
3. ✅ **Visada patikrinti kintamuosius prieš naudojimą**
4. ✅ **Naudoti teisingus config skaitymo metodus**
5. ✅ **Dokumentuoti visus pakeitimus**

### Ko vengti:
1. ❌ **Kintamųjų deklaravimo if/else blokuose**
2. ❌ **Kabliataškių po blokų uždarymo**
3. ❌ **waitUntil be timeout'ų**
4. ❌ **Kintamųjų naudojimo be inicializacijos**
5. ❌ **Config entry skaitymo su netinkamais metodais**

---

## Kodėl Reikėjo Pataisymų Nepaisant Dokumentacijos?

### 🎯 **Žinios suteikė principus, bet ne konkrečius sprendimus**

Nors interneto patikrinimas ir mūsų dokumentacija suteikė **bendruosius principus** apie variable scope problemas, kiekviena konkreti klaida reikalavo **specifinio sprendimo** konkrečioje kodo vietoje.

#### **Kas padėjo:**
- ✅ Supratome, kad SQF turi **dynamic scoping**
- ✅ Žinojome apie `private` deklaracijas
- ✅ Turėjome patikrinimų principus `!isNil "_grp" && !isNull _grp`

#### **Ko nepakako:**
- ❌ Nežinojome konkrečių vietų kiekviename faile
- ❌ Nepastebėjome, kad ta pati problema kartojasi skirtinguose forEach cikluose
- ❌ Neįvertinome, kad reikia `private` deklaracijų kiekvieno ciklo pradžioje

### 🔄 **Iteracinis Mokymosi Procesas**

Kiekviena klaida buvo **nauja pamoka** apie tą pačią problemą:

1. **Pirmos scope klaidos** → Išmokome apie `!isNil` patikrinimus
2. **Antros scope klaidos** → Išmokome apie `private` deklaracijas
3. **Trečios scope klaidos** → Išmokome apie forEach ciklų specifiką
4. **Ketvirtos scope klaidos** → Išmokome apie sistemingą visų ciklų patikrinimą

### 📚 **Žinių vs. Praktikos Skirtumas**

| Žinios (iš dokumentacijos) | Praktika (realus kodas) |
|---------------------------|-------------------------|
| "Naudoti private" | Kur tiksliai kiekviename cikle? |
| "Tikrinti isNil" | Kiek patikrinimų reikia vienam failui? |
| "Scope problemos" | Kiek variantų tos pačios problemos egzistuoja? |

### 💡 **Išvados Ateičiai**

1. **Dokumentacija padeda suprasti principus** - bet ne pakeičia praktinį darbą
2. **Kiekviena klaida yra mokymosi galimybė** - net jei žinai sprendimą
3. **Sistemiškumas svarbiau už greitį** - geriau lėtai, bet kruopščiai
4. **Testavimas atskleidžia slėptas problemas** - viena klaida slepia kitas panašias problemas

**Pamoka:** Žinios suteikia kryptį, bet praktika reikalauja kantrybės ir dėmesio detalėms.

---

**Dokumentas atnaujintas**: 2025-11-07
**Bazė**: Warmachine misijos modifikacijos patirtis
**Autorius**: Projekto komanda

