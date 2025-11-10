# Arma 3 SQF Sintaksės Geriausios Praktikos

## Dokumentacijos šaltiniai
- [Arma 3 Community Wiki - Scripting](https://community.bistudio.com/wiki/Category:Scripting_Commands_Arma_3)
- [Bohemia Interactive Forums - Scripting Guides](https://forums.bohemia.net/forums/topic/229245-scripting-guides-tutorials-compilation-list/)
- [Arma 3 Scripting Commands](https://community.bistudio.com/wiki/Category:Scripting_Commands_Arma_3)

---

## 1. Format Blokų Sintaksė

### Problema: Nested Quotes (Įdėtos Kabutės)

**Format bloke**, kai naudoji dvigubas kabutes `"..."`, viduje esančios **viengubos kabutės** turi būti **dvigubintos** `''`.

### Teisingi Pavyzdžiai:

#### Pavyzdys 1: Paprastas format blokas
```sqf
format ["
    this setVariable ['name','%1'];
    this setVariable ['description','%2'];
", _name, _desc]
```

#### Pavyzdys 2: Format bloke su string'u, kuris turi viengubas kabutes
```sqf
format ["
    this setVariable ['OnOwnerChange', ''['BE1', _this] execVM ''sectors\OnOwnerChange.sqf'';''];
    this setVariable [''CaptureCoef'',0.05];
", _nme, _des]
```

**Taisyklė**: Format bloke (`format ["..."`), visos viduje esančios viengubos kabutės `'` turi būti dvigubintos `''`.

---

## 2. If-Then Sintaksė (Rekomenduojama Stiliaus Taisyklė)

### Pastaba apie Sintaksę

**SQF parseris formaliai priima ir `if(...)then{...}` be tarpų**, bet dėl skaitomumo, diff'ų ir mažesnės klaidų rizikos **rekomenduojama** naudoti standartinę formą su tarpais.

### Rekomenduojama Forma:

```sqf
// REKOMENDUOJAMA - su tarpais, daugiau eilučių
if (DBG) then {
	diag_log "[DS] Dynamic Simulation enabled";
};

if (DBG) then {
	diag_log format ["[MODULE] Action: %1", _action];
};
```

### Kodėl Tai Rekomenduojama?

1. **Skaitomumas**: Daugiau eilučių pagerina kodo skaitymą ir priežiūrą
2. **Diff'ai**: Lengviau matyti pakeitimus Git diff'uose
3. **Klaidų Prevencija**: Sumažina "Missing ;" klaidų tikimybę, kai komandos jungiamos į vieną eilutę
4. **Nuoseklumas**: Standartinė forma visur užtikrina nuoseklų kodavimo stilių

### Svarbu:

**Jei RPT rodo "Missing ;", nors kabliataškiai yra teisingi, pirmiausia padalink monolitines eilutes į kelias ir pridėk tarpus** – tai padeda greitai atskirti realią klaidą nuo parserio interpretacijos problemos.

### Taisyklė:

**Rekomenduojama naudoti standartinę `if (...) then { ... }` formą su tarpais ir daugiau eilučių**, ypač kai:
- Po `if` bloko eina kitos komandos
- `if` blokas yra format bloke arba init string'e
- Reikia debug log'ų arba kompleksinės logikos

---

## 3. Dynamic Simulation Sintaksė

### Teisinga Sintaksė:

```sqf
// Enable Dynamic Simulation
enableDynamicSimulationSystem true;
setDynamicSimulationEnabledGlobal true;

if (DBG) then {
	diag_log "[DS] Dynamic Simulation enabled";
};

// Distances
setDynamicSimulationDistance "Group", 1200;
setDynamicSimulationDistance "Vehicle", 1500;
setDynamicSimulationDistance "Prop", 300;
setDynamicSimulationDistance "IsMoving", 50;

// Optional coefficients
setDynamicSimulationDistanceCoef "Group", 1.0;
setDynamicSimulationDistanceCoef "Vehicle", 1.0;
```

### Svarbu:
- **Kiekviena DS komanda turi užsibaigti `;`** - dažna klaida yra palikti komentaro/teksto likučius tarp `enableDynamicSimulationSystem` ir `setDynamicSimulationEnabledGlobal`
- **Abi įjungimo komandos turi būti viena po kitos** - pirmiausia `enableDynamicSimulationSystem`, tada `setDynamicSimulationEnabledGlobal`, tik tada distances
- **Teisingi tipai**: `"Group"`, `"Vehicle"`, `"Prop"`, `"IsMoving"` - **`"EmptyVehicle"` nėra DS tipo raktas**
- **`if` blokas turi kabliataškį** po `}`: `if (...) then { ... };`
- **Naudok standartinę `if-then` sintaksę** su tarpais (žr. sekciją 2)

---

## 4. HashMap Iteracija

### Teisingi Šablonai:

#### Variantas 1: Naudojant `keys`
```sqf
{
    private _key = _x;
    private _value = myHashMap get _key;
    // ... logika ...
} forEach (myHashMap keys);
```

#### Variantas 2: Naudojant `toArray false` (saugesnis)
```sqf
{
    _x params ["_key", "_value"];
    // ... logika ...
} forEach (myHashMap toArray false);
```

### Svarbu:
- **`keys` grąžina raktų masyvą** - reikšmę gauni su `get`
- **`toArray false` grąžina `[key, value]` poras** - naudok `params`
- **Po `forEach` visuomet turi būti uždaromas `)` ir `;`** - dažniausia "Missing )" priežastis yra pamirštas skliaustas po `keys` arba `toArray`
- **Visada patikrink `isNull`** prieš naudojant objektą

---

## 5. createUnit Init String Sintaksė

### Problema: Init String'as format bloke

Kai naudoji `createUnit` su `format` bloku init string'ui, reikia teisingai escape'inti kabutes. **Svarbu atskirti du scenarijus**: grynas SQF ir INIT STRING kontekstas.

### Scenarijus 1: Grynas SQF (be INIT STRING)

**Nenaudojamas dvigubinimas** - tiesioginis string'as:

```sqf
// Grynas .sqf failas - nenaudojamas dvigubinimas
this setVariable ['OnOwnerChange', "['BE1', _this] execVM 'sectors\OnOwnerChange.sqf';"];
```

### Scenarijus 2: INIT STRING arba format bloke

**Dvigubinti viengubas kabutes** - format bloke arba init string'e:

```sqf
"ModuleSector_F" createUnit [
    _position,
    createGroup sideLogic,
    format ["
        sectorBE1=this;
        this setVariable ['name','%1'];
        this setVariable [''OnOwnerChange'', ''[''BE1'', _this] execVM ''sectors\OnOwnerChange.sqf'';''];
    ", _name, _desc]
];
```

### Svarbu:

- **Jei kyla "Missing ]"**, stringas greičiausiai neescapintas arba neuždarytas format blokas
- **Format bloke**: visos viengubos kabutės `'` turi būti dvigubintos `''`
- **Gryname SQF**: nenaudojamas dvigubinimas - tiesioginis string'as

---

## 6. Event Handler Registracija

### Problema: Dublikatai

**Visada patikrink**, ar EH jau pridėtas prieš pridėdamas naują:

```sqf
if (!(_unit getVariable ["wrm_eh_mpkilled", false])) then {
    _unit setVariable ["wrm_eh_mpkilled", true, false];
    _unit addMPEventHandler ["MPKilled", { params ["_u"]; [(_this select 0), _side] spawn wrm_fnc_killedEH; }];
};
```

---

## 7. While/WaitUntil Ciklai

### Problema: Begaliniai Ciklai

**Visada pridėk timeout'ą**:

```sqf
private _timeout = time + 60; //60 sekundžių timeout
while {_condition && time < _timeout} do {
    // ... logika ...
    sleep 1;
};
if (time >= _timeout) then {
	if (DBG) then {
		diag_log "[ERROR] Timeout reached";
	};
};
```

---

## 8. Performance Optimizacijos

### `allUnits` → `entities`

**Blogai**:
```sqf
{/* logika */} forEach allUnits;
```

**Gerai**:
```sqf
{/* logika */} forEach (entities [["Man"], [], true, false] select {alive _x});
```

### `allPlayers` Caching

**Blogai**:
```sqf
{/* logika */} forEach allPlayers;
{/* logika */} forEach allPlayers; // vėl kviečiama
```

**Gerai**:
```sqf
private _cachedPlayers = allPlayers select {alive _x};
{/* logika */} forEach _cachedPlayers;
{/* logika */} forEach _cachedPlayers; // naudoja cache'ą
```

---

## 9. Klaidų Valdymas

### `diag_log` Debugging

**Visada naudok `diag_log`** su aiškiais prefix'ais:

```sqf
if (DBG) then {
	diag_log format ["[MODULE_NAME] Action: %1, Result: %2", _action, _result];
};
```

### `isNil` / `isNull` Patikrinimai

**Visada patikrink** prieš naudojant:

```sqf
if (!isNil "_variable") then {
    // naudok _variable
};

if (!isNull _object) then {
    // naudok _object
};
```

---

## 10. RemoteExec Sintaksė

### Teisinga Sintaksė:

```sqf
// Server → All Clients (allowedTargets = 0)
[_params] remoteExec ["functionName", 0, false]; // jip = false, nes state push per serverį

// Server → Server Only (allowedTargets = 2)
[_params] remoteExec ["functionName", 2, false];

// Client → Server (allowedTargets = 2)
[_params] remoteExec ["functionName", 2, false];
```

### Svarbu:
- **`allowedTargets` kryptys**:
  - `0` = Server → All Clients
  - `1` = Server → Client (vienas klientas)
  - `2` = Server → Server Only arba Client → Server
- **`jip = false`** jei state push per serverį (`fn_V2jipRestoration`) - neistoriškai replay
- **`jip = true`** tik jei reikia JIP replay (retai) - istoriškai replay

---

## 11. CfgRemoteExec Whitelist

### Teisinga Sintaksė (`CfgRemoteExec.hpp`):

```cpp
class CfgRemoteExec
{
    class Commands
    {
        mode = 1; // Whitelist mode
        jip = 0; // Disable JIP replay - state handled by server push
        
        class functionName { allowedTargets = 2; }; // Server only
    };
    
    class Functions
    {
        mode = 1; // Whitelist mode
        jip = 0; // Disable JIP replay - state handled by server push
        
        class wrm_fnc_functionName { allowedTargets = 2; }; // Server only
    };
};
```

### Svarbu:
- **`allowedTargets` kryptys**:
  - `0` = Server → All Clients
  - `1` = Server → Client (vienas klientas)
  - `2` = Server → Server Only arba Client → Server
- **`jip = 0`** kai JIP būseną stumia serveris (`fn_V2jipRestoration`), o ne istoriškai replay
- **`jip = 1`** tik jei reikia istorinio replay (retai)

---

## 12. Dažniausios Klaidos ir Sprendimai

### "Missing ;" (Su If-Then Sintakse)

**Problema**: RPT rodo "Missing ;" net tada, kai kabliataškiai atrodo teisingi.

**Priežastis**: `if(...)then{...}` sintaksė be tarpų kartais neteisingai interpretuojama parserio.

**Sprendimas**:
1. **Pakeisk į standartinę formą**: `if (...) then { ... }` su tarpais
2. **Naudok daugiau eilučių**: ne vienoje eilutėje
3. **Patikrink dokumentaciją**: žr. sekciją 2 apie `if-then` sintaksę

**Pavyzdys**:
```sqf
// Blogai (gali sukelti "Missing ;")
if(DBG)then{diag_log "[DS] enabled";};

// Gerai (standartinė forma)
if (DBG) then {
	diag_log "[DS] enabled";
};
```

### "Missing ;" (Bendrasis)

- **Priežastis**: Trūksta kabliataškio po komandos ar `if` bloko
- **Sprendimas**: Patikrink, ar visos komandos turi `;` pabaigoje
- **Papildoma patikra**: Jei visi kabliataškiai teisingi, patikrink `if-then` sintaksę (žr. aukščiau)

### "Missing ]"
- **Priežastis**: Format bloke neuždarytas blokas arba neteisingai escape'intos kabutės
- **Sprendimas**: Dvigubink viengubas kabutes format bloke: `'` → `''`

### "Missing )"
- **Priežastis**: Neteisinga HashMap iteracija arba neuždarytas skliaustas
- **Sprendimas**: Naudok `toArray false` arba `keys` su teisingais skliaustais
- **Dažniausia priežastis**: Pamirštas uždarantis `)` po `keys` arba `toArray` - patikrink, ar `forEach` turi `(myHashMap keys)` su skliaustais

### "No alive in 10000 ms"
- **Priežastis**: `waitUntil` ciklas be timeout'o
- **Sprendimas**: Pridėk timeout'ą: `waitUntil {_condition || time > _timeout}`

### Sektorių Tipiniai Gedimai

**Simptomai**: "Missing ]" su OnOwnerChange format bloke.

**Sprendimas**:
1. **Patikrink kontekstą**: ar tai grynas SQF ar INIT STRING?
2. **Grynas SQF**: naudok tiesioginį string'ą be dvigubinimo: `"['BE1', _this] execVM 'sectors\OnOwnerChange.sqf';"`
3. **INIT STRING arba format bloke**: dvigubink viengubas kabutes: `''[''BE1'', _this] execVM ''sectors\OnOwnerChange.sqf'';''`
4. **Patikrink format bloko uždarymą**: ar yra `", _params]` pabaigoje?

### Loadout Perspėjimai (Ne Kritiniai)

**Šie perspėjimai RPT loguose nėra kritiniai** - tai loadout/mod klasės problemos:
- `"item does not match weapon"` - neteisingas mod klasės pavadinimas
- `"Uniform not allowed"` - uniform klasė neegzistuoja arba neteisinga
- `"Backpack not found"` - backpack klasė neegzistuoja arba neteisinga
- `"Trying to add item with empty name"` - tuščias string'as loadout klasėje

**Sprendimas**: Patikrink `loadouts/` ir `factions/` failus dėl tuščių string'ų ir neteisingų klasės pavadinimų.

---

## 13. Validavimo Procesas

### ⚠️ SVARBU: Visada Pirmiausia Patikrink Dokumentaciją!

**Prieš bandant taisyti klaidas**:
1. **Patikrink šią dokumentaciją** - galbūt problema jau aprašyta
2. **Ieškok oficialių šaltinių** - Arma 3 Community Wiki, Forums
3. **Patikrink panašius pavyzdžius** - kaip kiti sprendžia panašias problemas

**Tik po to**:
4. **Patikrink sintaksę** su SQFLint arba Arma 3 editor
5. **Patikrink RPT logus** - neturėtų būti "Missing ;", "Missing ]", "Missing )"
6. **Patikrink `if-then` sintaksę** - naudok standartinę formą su tarpais (žr. sekciją 2)
7. **Patikrink performance** - naudok `entities` vietoj `allUnits`
8. **Patikrink timeout'us** - visi `while`/`waitUntil` turi timeout'us
9. **Patikrink EH dublikatus** - naudok vėliavėles

### Po Commit'o:

1. **Testuok misiją** - paleisk ir patikrink RPT logus
2. **Testuok JIP** - prisijunk po 10-15 min ir patikrink state
3. **Testuok performance** - patikrink FPS ir scheduler lag

---

## 14. Lint/Smoke Kontrolinis Sąrašas

### RPT Logų Patikra:

**RPT neturėtų turėti**:
- ❌ `"Missing ;"` - patikrink `if-then` sintaksę ir kabliataškius
- ❌ `"Missing ]"` - patikrink format blokus ir OnOwnerChange escapinimą
- ❌ `"Missing )"` - patikrink HashMap iteraciją ir skliaustus
- ❌ `"remoteExec restriction"` - patikrink `CfgRemoteExec.hpp` whitelist

**RPT turėtų turėti**:
- ✅ `"[DS] Dynamic Simulation enabled"` log matomas (jei DBG = true)
- ✅ Vienas sector flip per pusę valandos - be klaidų
- ✅ 1 JIP prisijungimas - pilnas state (markers, Zeus, UAV) be rankinių veiksmų

### Smoke Test Scenarijus:

1. **Paleisk misiją** - patikrink RPT logus dėl sintaksės klaidų
2. **Palauk 5-10 min** - patikrink, ar DS veikia (log'ai)
3. **Padaryk 1 sector flip** - patikrink, ar nėra "Missing ]" klaidų
4. **Prisijunk kaip JIP** - patikrink, ar visi markeriai, Zeus ir UAV state teisingi
5. **Patikrink performance** - FPS ir scheduler lag turėtų būti stabilūs

---

## Išvados

- **⚠️ VISADA PIRMIAUSIA PATIKRINK DOKUMENTACIJĄ** - šį failą ir oficialius šaltinius prieš bandant taisyti klaidas
- **Naudok standartinę `if-then` sintaksę** - `if (...) then { ... }` su tarpais, ne `if(...)then{...}`
- **Visada naudok oficialią dokumentaciją** prieš spėliojant
- **Testuok mažais žingsniais** - ne viską vienu kartu
- **Loguok viską** - `diag_log` su aiškiais prefix'ais
- **Timeout'ai visur** - begaliniai ciklai = serverio freeze
- **Performance optimizacijos** - `entities` vietoj `allUnits`, caching

---

## Dokumentacijos Atnaujinimo Procesas

**Kai randama nauja klaida arba sprendimas**:
1. **Iš karto atnaujink šią dokumentaciją** - pridėk naują sekciją arba atnaujink esamą
2. **Pridėk konkretų pavyzdį** - kaip buvo blogai ir kaip taisoma
3. **Pridėk priežastį** - kodėl problema atsiranda
4. **Atnaujink versiją** - padidink versijos numerį ir datą

**Tikslas**: Kitas kartas, kai susidursime su panašia problema, dokumentacija padės greitai ją išspręsti.

---

**Paskutinis Atnaujinimas**: 2025-11-10  
**Versija**: 2.1  
**Pakeitimai v2.1**:
- Atnaujinta Dynamic Simulation sekcija su abiem įjungimo komandomis ir teisingais tipais (Group, Vehicle, Prop, IsMoving)
- Pakeista If-Then sekcija iš "KRITIŠKA" į "Rekomenduojama stiliaus taisyklė" su aiškiu paaiškinimu
- Atnaujinta OnOwnerChange sekcija su aiškiu atskyrimu tarp gryno SQF ir INIT STRING konteksto
- Pridėta HashMap iteracijos pastaba apie skliaustų uždarymą
- Atnaujinta RemoteExec sekcija su `allowedTargets` kryptimis
- Pridėta sekcija apie sektorių tipinius gedimus
- Pridėta sekcija apie loadout perspėjimus (ne kritiniai)
- Pridėta Lint/Smoke kontrolinis sąrašas su smoke test scenarijumi

**Pakeitimai v2.0**:
- Pridėta sekcija apie `if-then` sintaksę ir kodėl reikia tarpų
- Atnaujinta Dynamic Simulation sekcija su teisinga sintakse
- Pridėta instrukcija visada pirmiausia patikrinti dokumentaciją
- Atnaujinta "Missing ;" klaidos sprendimas su `if-then` informacija

