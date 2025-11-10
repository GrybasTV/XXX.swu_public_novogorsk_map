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

## 2. If-Then Sintaksė (KRITIŠKA!)

### Problema: Parserio Klaidos su Neteisinga Sintakse

**Arma 3 parseris kartais neteisingai interpretuoja `if(...)then{...}` sintaksę be tarpų**, ypač kai po `if` bloko eina kitos komandos. Tai gali sukelti "Missing ;" klaidas net tada, kai kabliataškiai yra teisingi.

### Blogai (Gali Sukelti Klaidas):

```sqf
// NETIKSLU - be tarpų, vienoje eilutėje
if(DBG)then{diag_log "[DS] Dynamic Simulation enabled";};
if(DBG)then{diag_log format ["[MODULE] Action: %1", _action]};
```

### Gerai (Standartinė Forma):

```sqf
// TEISINGA - su tarpais, daugiau eilučių
if (DBG) then {
	diag_log "[DS] Dynamic Simulation enabled";
};

if (DBG) then {
	diag_log format ["[MODULE] Action: %1", _action];
};
```

### Kodėl Tai Svarbu?

1. **Parserio Suderinamumas**: Standartinė forma su tarpais yra labiau suderinama su Arma 3 parseriu
2. **Klaidų Prevencija**: Sumažina "Missing ;" klaidų tikimybę net tada, kai sintaksė atrodo teisinga
3. **Skaitymas**: Daugiau eilučių pagerina kodo skaitymą ir priežiūrą
4. **Nuoseklumas**: Standartinė forma visur užtikrina nuoseklų kodavimo stilių

### Taisyklė:

**Visada naudok standartinę `if (...) then { ... }` formą su tarpais ir daugiau eilučių**, ypač kai:
- Po `if` bloko eina kitos komandos
- `if` blokas yra format bloke arba init string'e
- Reikia debug log'ų arba kompleksinės logikos

---

## 3. Dynamic Simulation Sintaksė

### Teisinga Sintaksė:

```sqf
//Enable Dynamic Simulation system
enableDynamicSimulationSystem true;
if (DBG) then {
	diag_log "[DS] Dynamic Simulation enabled";
};

//Distances by type
setDynamicSimulationDistance "Group", 1200;
setDynamicSimulationDistance "Vehicle", 1800;
setDynamicSimulationDistance "EmptyVehicle", 1500;
setDynamicSimulationDistance "Prop", 600;
```

### Svarbu:
- **Kiekviena komanda turi kabliataškį** `;` pabaigoje
- **`if` blokas turi kabliataškį** po `}`: `if (...) then { ... };`
- **Naudok standartinę `if-then` sintaksę** su tarpais (žr. sekciją 2)
- **Nėra `setDynamicSimulationEnabledGlobal`** komandos - tai ne standartinė Arma 3 komanda

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
- **Visada patikrink `isNull`** prieš naudojant objektą

---

## 5. createUnit Init String Sintaksė

### Problema: Init String'as format bloke

Kai naudoji `createUnit` su `format` bloku init string'ui, reikia teisingai escape'inti kabutes.

### Teisingas Pavyzdys:

```sqf
"ModuleSector_F" createUnit [
    _position,
    createGroup sideLogic,
    format ["
        sectorBE1=this;
        this setVariable ['name','%1'];
        this setVariable ['OnOwnerChange', ''['BE1', _this] execVM ''sectors\OnOwnerChange.sqf'';''];
    ", _name, _desc]
];
```

**Taisyklė**: Format bloke, visos viengubos kabutės `'` turi būti dvigubintos `''`.

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
    if(DBG)then{diag_log "[ERROR] Timeout reached"};
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
// Server → All Clients
[_params] remoteExec ["functionName", 0, false]; // jip = false, nes state push per serverį

// Server → Server Only
[_params] remoteExec ["functionName", 2, false];

// Client → Server
[_params] remoteExec ["functionName", 2, false];
```

### Svarbu:
- **`jip = false`** jei state push per serverį (`fn_V2jipRestoration`)
- **`jip = true`** tik jei reikia JIP replay (retai)

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
        jip = 0; // Disable JIP replay
        
        class wrm_fnc_functionName { allowedTargets = 2; }; // Server only
    };
};
```

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

### "No alive in 10000 ms"
- **Priežastis**: `waitUntil` ciklas be timeout'o
- **Sprendimas**: Pridėk timeout'ą: `waitUntil {_condition || time > _timeout}`

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
**Versija**: 2.0  
**Pakeitimai v2.0**:
- Pridėta sekcija apie `if-then` sintaksę ir kodėl reikia tarpų
- Atnaujinta Dynamic Simulation sekcija su teisinga sintakse
- Pridėta instrukcija visada pirmiausia patikrinti dokumentaciją
- Atnaujinta "Missing ;" klaidos sprendimas su `if-then` informacija

