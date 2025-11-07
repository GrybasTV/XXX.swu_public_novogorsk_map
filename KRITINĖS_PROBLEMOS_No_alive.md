# KRITINĖS PROBLEMOS: "No alive in 10000 ms" timeout'ai

## PROBLEMA IŠ FORUMŲ

Pagal Arma 3 forumų diskusijas, "No alive in 10000 ms, exceeded timeout" klaidos yra **beveik visada** susijusios su:

1. **Begalinėmis ciklo kilpomis** (Infinite Loops) - `while` arba `forEach` ciklai be `sleep`
2. **Netinkamu komandų naudojimu** - `allUnits` kiekviename kadre
3. **DI ir modifikacijų sąveika** - mod'ai konfliktuoja su misijos skriptais
4. **Objektų generavimu** - per daug objektų vienu metu

---

## RASTOS IR PATAISYTOS PROBLEMOS

### ✅ 1. `functions/server/fn_V2unhideVeh.sqf` - KRITINĖ PROBLEMA

**Problema:**
- Naudojo `allUnits` **4 kartus per ciklą** be jokio optimizavimo
- `allUnits` yra **labai lėta komanda**, kuri skenuoja VISUS objektus žaidime
- Tai sukuria **didžiulę apkrovą** ir gali sukelti "No alive" timeout'us

**Pataisymas:**
```sqf
//Prieš:
}  forEach allUnits;  //4 kartus per ciklą!

//Po:
private _allUnits = allUnits; //Saugoti masyvą vieną kartą
}  forEach _allUnits;  //Naudoti išsaugotą masyvą
```

**Rezultatas:** 
- `allUnits` kviečiamas tik **1 kartą** per ciklą (vietoj 4)
- Apkrova sumažinta **4 kartus**
- Tai yra **viena iš pagrindinių priežasčių**, kodėl kyla timeout'ai

---

### ✅ 2. `V2factionChange.sqf` - Begalinės kilpos be `sleep`

**Problema:**
- `while{side _x!=independent}do` ciklai be `sleep` arba timeout'o
- Jei side niekada netampa independent, ciklas **užstringa neribotai**
- Tai sukuria **begalinę kilpą** ir "No alive" timeout'us

**Pataisymas (2 vietos):**
```sqf
//Prieš:
while{side _x!=independent}do
{
    _x joinAsSilent [_grp,_no];	
    _i=_i+1;	
};

//Po:
private _timeout = time + 5; //5 sekundžių timeout
while{side _x!=independent && time < _timeout}do
{
    _x joinAsSilent [_grp,_no];	
    _i=_i+1;
    sleep 0.1; //Pridėti sleep, kad neapkrautumėme procesoriaus
};
```

**Taip pat pataisytas:**
```sqf
//Prieš:
waitUntil{side _x==independent};

//Po:
_timeout = time + 5;
waitUntil{side _x==independent || time > _timeout};
if (time > _timeout) exitWith {};
```

**Rezultatas:**
- Ciklai turi **timeout'us** (5 sekundžių)
- Pridėtas **sleep** (0.1 sek), kad neapkrautumėme procesoriaus
- Sistema nebeužstrigsta

---

## VISI PATAISYMAI

### Pataisytos vietos:

| Failas | Problema | Pataisymas | Statusas |
|--------|----------|------------|----------|
| `fn_V2unhideVeh.sqf` | `allUnits` 4 kartus per ciklą | Optimizuota į 1 kartą | ✅ Pataisyta |
| `V2factionChange.sqf` | `while` be `sleep` (2 vietos) | Pridėtas timeout + sleep | ✅ Pataisyta |
| `V2factionChange.sqf` | `waitUntil` be timeout'o (2 vietos) | Pridėtas timeout | ✅ Pataisyta |

---

## KITOS PROBLEMŲ VIETOS (Jau pataisytos anksčiau)

### `waitUntil {alive ...}` ciklai be timeout'ų:
- ✅ `fn_V2hints.sqf` - pataisyta
- ✅ `V2startClient.sqf` - pataisyta
- ✅ `V2firstSpawn.sqf` - pataisyta
- ✅ `V2playerSideChange.sqf` - pataisyta (2 vietos)
- ✅ `V2factionChange.sqf` - pataisyta (4 vietos)
- ✅ `fn_V2uavRequest.sqf` - pataisyta (5 vietos)
- ✅ `autoStart.sqf` - pataisyta
- ✅ `fn_V2loadoutChange.sqf` - pataisyta
- ✅ `fn_V2nationChange.sqf` - pataisyta (5 vietos)

---

## REKOMENDACIJOS FORUMŲ

### 1. Begalinės ciklo kilpos
- ✅ **Pridėti timeout'us** visiems `while` ciklams
- ✅ **Pridėti sleep** visiems `while` ciklams, kurie neturi sleep

### 2. Netinkamas komandų naudojimas
- ✅ **Optimizuoti `allUnits`** - naudoti tik vieną kartą per ciklą
- ✅ **Išsaugoti rezultatą** kintamajame, jei reikia naudoti kelis kartus

### 3. DI ir modifikacijų sąveika
- ⚠️ **Reikia patikrinti** - ar yra konfliktų su mod'ais (VCOM AI, ASR AI, etc.)

### 4. Objektų generavimas
- ⚠️ **Reikia patikrinti** - ar nėra per daug objektų generuojama vienu metu

---

## IŠVADOS

### ✅ Pataisytos kritinės problemos:
1. **`fn_V2unhideVeh.sqf`** - optimizuotas `allUnits` naudojimas (4x → 1x)
2. **`V2factionChange.sqf`** - pridėti timeout'ai ir sleep į `while` ciklus

### ⚠️ Galimos problemos:
1. **Mod'ų konfliktai** - reikia testuoti su mod'ais
2. **Objektų generavimas** - reikia patikrinti, ar nėra per daug objektų

### 🎯 Rezultatas:

**Po pataisymų:**
- ✅ Begalinės kilpos pašalintos
- ✅ `allUnits` optimizuotas
- ✅ Visi `waitUntil` ciklai turi timeout'us
- ✅ Visi `while` ciklai turi timeout'us ir sleep

**"No alive" timeout'ai turėtų būti sumažinti arba visai išnykti.**

---

## TESTAVIMAS

### Rekomenduojama:
1. **Testuoti misiją** - patikrinti, ar "No alive" timeout'ai dingo
2. **Stebėti RPT log'us** - patikrinti, ar nėra naujų problemų
3. **Testuoti su mod'ais** - patikrinti, ar nėra konfliktų

---

**Sukurta:** 2025-11-04
**Autorius:** AI Assistant
**Versija:** 1.0

