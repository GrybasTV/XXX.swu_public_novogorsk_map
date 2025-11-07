# UAV Sistemos Analizė ir Refaktorinimo Planas

## Nuorodos

- **Pagrindinis failas**: `functions/client/fn_V2uavRequest.sqf` (533 eilutės)
- **Cooldown sistema**: `functions/server/fn_V2coolDown.sqf`
- **Serverio inicializacija**: `initServer.sqf` (uavSquadW, uavSquadE)
- **Cooldown laikas**: `warmachine/V2startServer.sqf` (droneCooldownTime)

## Esamos Sistemos Architektūra

### 1. Dviejų Tipų Sistema

**A. Originali sistema (A3 modas)**
- Vienas dronas per pusę: `uavW`, `uavE`
- Globalus cooldown: `uavWr`, `uavEr`
- Visi squad leaderiai dalijasi tą patį droną

**B. Per-squad sistema (Ukraine/Russia 2025)**
- Atskiras dronas kiekvienam žaidėjui: `uavSquadW`, `uavSquadE`
- Struktūra: `[[playerUID, uavObject, cooldownTime], ...]`
- Individualus cooldown kiekvienam žaidėjui

### 2. Dronų Tipai

**Ukraine 2025** (`factions/UA2025_RHS_W_V.hpp`):
- FPV kamikadze dronai: `B_Crocus_AP`, `B_Crocus_AT`, `B_UAFPV_IED_AP`, `B_UAFPV_OG7V_AP`, `B_UAFPV_PG7VL_AT`, `B_UAFPV_RKG_AP`

**Russia 2025** (`factions/RU2025_RHS_W_V.hpp`):
- Panašūs FPV dronai (tikslų sąrašą reikia patikrinti)

## Identifikuotos Problemos

### 1. Kodas Dubliuojasi (DRY Principas)

**Problema**: Hover logika pakartota 3 kartus:
- Eilutės 141-199: Per-squad sistema (Ukraine/Russia)
- Eilutės 289-347: Originali sistema WEST
- Eilutės 404-462: Originali sistema EAST

**Pasekmė**: 
- Sunku palaikyti
- Klaidas reikia taisyti 3 vietose
- Kodas per ilgas ir neaiškus

### 2. Event Handler Problema

**Problema** (`fn_V2uavRequest.sqf` eilutės 226-231):
```sqf
_uav addMPEventHandler ["MPKilled", {
    params ["_uav", "_killer", "_instigator", "_useEffects", "_args"];
    _args params ["_cooldownType", "_playerUID", "_sde"];
    [_cooldownType, _playerUID, _sde] spawn wrm_fnc_V2coolDown;
}, [_cooldownType, _playerUID, _sde]];
```

**Problema**: `addMPEventHandler` trečiasis parametras (`_args`) nėra standartinis Arma 3 funkcionalumas. Event handler'is gali negauti argumentų.

**Pasekmė**: Cooldown gali neveikti teisingai, kai dronas sužlugdomas.

### 3. Cleanup Problema

**Problema**: Nėra mechanizmo, kuris:
- Šalina dronus, kai žaidėjas atsijungia
- Šalina dronus, kai žaidėjas miršta
- Atnaujina cooldown, kai dronas sunaikintas kitu būdu (ne per MPKilled)

**Pasekmė**: 
- Memory leak (dronai lieka masyvuose)
- Cooldown gali likti amžinamai, jei dronas sunaikintas ne per MPKilled

### 4. Terminal Connection Problema

**Problema** (`fn_V2uavRequest.sqf` eilutės 86-110):
- Spawn'as laukia 2 sekundes prieš terminalo prijungimą
- 3 bandymai prijungti terminalą
- Nėra aiškaus error handling

**Pasekmė**: Terminalo prijungimas gali neveikti, jei dronas yra specialaus tipo (pvz. FPV kamikadze)

### 5. Auto-Hover Problema

**Problema**: Auto-hover script'as:
- Veikia per `setVelocity`, kas gali būti nestabilu
- Tikrina kiekvieną sekundę visus žaidėjus (`forEach allPlayers`)
- Nėra timeout'o, jei dronas nukrenta

**Pasekmė**: 
- Performance problema su daug žaidėjų
- Dronas gali kristi, jei auto-hover neveikia

### 6. Cooldown Atnaujinimas Problema

**Problema** (`fn_V2coolDown.sqf` eilutės 148-154):
```sqf
while {(uavSquadW select _index) select 2 > 0} do
{
    sleep 10;
    _currentCooldown = (uavSquadW select _index) select 2;
    uavSquadW set [_index, [_playerUID, objNull, _currentCooldown - 10]];
    publicvariable "uavSquadW";
};
```

**Problema**: 
- `_index` gali būti neteisingas, jei masyvas keičiasi per loop'ą
- Nėra patikrinimo, ar žaidėjas vis dar online

**Pasekmė**: Cooldown gali neveikti teisingai

### 7. PublicVariable Problema

**Problema**: `publicVariable` kviečiamas per dažnai:
- Kiekvieną kartą, kai atnaujinamas cooldown (kas 10 sekundžių)
- Kiekvieną kartą, kai atnaujinamas masyvas

**Pasekmė**: Network overhead

### 8. Nėra Validacijos

**Problema**: 
- Nėra patikrinimo, ar `_uavs` masyvas nėra tuščias
- Nėra patikrinimo, ar dronas sėkmingai sukurtas prieš bandant prijungti terminalą
- Nėra patikrinimo, ar `droneCooldownTime` yra nustatytas

**Pasekmė**: Klaidos gali būti neaiškios

## Refaktorinimo Pasiūlymas

### 1. Kodo Struktūra

**Pasiūlymas**: Išskirti funkcijas į atskirus failus:

```
functions/client/fn_V2uavRequest.sqf       - Pagrindinė logika (request)
functions/client/fn_V2uavHover.sqf          - Auto-hover logika
functions/client/fn_V2uavTerminal.sqf      - Terminal connection
functions/server/fn_V2uavCleanup.sqf       - Cleanup (disconnect, death)
functions/server/fn_V2uavCooldown.sqf      - Cooldown management
```

### 2. Event Handler Fix

**Pasiūlymas**: Naudoti `setVariable` vietoj `_args`:

```sqf
//Prieš event handler
_uav setVariable ["wrm_uav_cooldownType", _cooldownType, true];
_uav setVariable ["wrm_uav_playerUID", _playerUID, true];
_uav setVariable ["wrm_uav_side", _sde, true];

//Event handler
_uav addMPEventHandler ["MPKilled", {
    params ["_uav"];
    private _cooldownType = _uav getVariable ["wrm_uav_cooldownType", 0];
    private _playerUID = _uav getVariable ["wrm_uav_playerUID", ""];
    private _side = _uav getVariable ["wrm_uav_side", sideUnknown];
    
    if (_cooldownType > 0 && _playerUID != "") then {
        [_cooldownType, _playerUID, _side] spawn wrm_fnc_V2uavCooldown;
    };
}];
```

### 3. Cleanup Mechanizmas

**Pasiūlymas**: Pridėti cleanup:

```sqf
//initPlayerLocal.sqf arba onPlayerKilled.sqf
//Kai žaidėjas miršta arba atsijungia:
- Rasti visus jo dronus masyve
- Sunaikinti dronus (jei dar gyvi)
- Išvalyti masyvą
```

### 4. Auto-Hover Optimizacija

**Pasiūlymas**: 
- Naudoti `getConnectedUAV` tik vieną kartą per loop'ą
- Pridėti timeout'ą
- Naudoti `flyInHeight` vietoj `setVelocity`, jei turi driver

### 5. Cooldown Atnaujinimas

**Pasiūlymas**: 
- Naudoti `findIf` su `_playerUID` vietoj `_index`
- Validuoti, ar žaidėjas vis dar online
- Mažinti `publicVariable` skaičių (tik kai reikia)

### 6. Validacija

**Pasiūlymas**: Pridėti validaciją:

```sqf
//Patikrinti, ar uavs masyvas nėra tuščias
if (count _uavs == 0) exitWith {
    hint "No UAVs available for this faction";
    systemChat "[UAV ERROR] uavs array is empty";
};

//Patikrinti, ar droneCooldownTime yra nustatytas
if (isNil "droneCooldownTime") then {
    droneCooldownTime = 135; //Default value
    systemChat "[UAV WARNING] droneCooldownTime not set, using default";
};
```

### 7. Terminal Connection

**Pasiūlymas**: 
- Patikrinti, ar dronas palaiko terminalą prieš bandant prijungti
- Naudoti `waitUntil` su timeout'u
- Pridėti aiškų error message

### 8. Kodas Dubliavimas

**Pasiūlymas**: Išskirti hover logiką į atskirą funkciją:

```sqf
//functions/client/fn_V2uavHover.sqf
[_uav, _targetHeight] call wrm_fnc_V2uavHover;

//Naudoti tą pačią funkciją visoms sistemoms
```

## Detalus Refaktorinimo Planas

### Faza 1: Struktūros Refaktorinimas

1. **Sukurti naują funkciją hover logikai**
   - `functions/client/fn_V2uavHover.sqf`
   - Išskirti visą hover logiką iš `fn_V2uavRequest.sqf`

2. **Sukurti naują funkciją terminal connection**
   - `functions/client/fn_V2uavTerminal.sqf`
   - Išskirti terminal connection logiką

3. **Sukurti naują funkciją cleanup**
   - `functions/server/fn_V2uavCleanup.sqf`
   - Cleanup logika žaidėjų atsijungimui/mirčiai

### Faza 2: Event Handler Fix

1. **Pakeisti event handler'į**
   - Naudoti `setVariable` vietoj `_args`
   - Patikrinti, ar veikia teisingai

### Faza 3: Cleanup Mechanizmas

1. **Pridėti cleanup onPlayerKilled**
   - `onPlayerKilled.sqf` - iškviesti cleanup funkciją

2. **Pridėti cleanup onPlayerDisconnect**
   - `initServer.sqf` - pridėti event handler'į

### Faza 4: Optimizacija

1. **Optimizuoti auto-hover**
   - Mažinti `forEach allPlayers` skaičių
   - Pridėti timeout'ą

2. **Optimizuoti cooldown**
   - Mažinti `publicVariable` skaičių
   - Patobulinti cooldown loop'ą

### Faza 5: Validacija ir Error Handling

1. **Pridėti validaciją**
   - Patikrinti, ar masyvai nėra tuščių
   - Patikrinti, ar kintamieji yra nustatyti

2. **Pridėti error handling**
   - Aiškūs error message'ai
   - Debug informacija

## Testavimo Planas

1. **Bazinis testas**:
   - Vienas žaidėjas paleidžia droną
   - Dronas sužlugdomas
   - Cooldown veikia teisingai

2. **Multiplayer testas**:
   - Keli žaidėjai paleidžia dronus vienu metu
   - Kiekvienas turi savo cooldown

3. **Cleanup testas**:
   - Žaidėjas atsijungia su aktyviu dronu
   - Dronas šalinamas iš masyvo

4. **Performance testas**:
   - 10+ dronų vienu metu
   - Serverio performance

## Rekomendacijos

1. **Pradėti nuo Fazių 1-2**: Struktūros refaktorinimas ir event handler fix
2. **Tada Faza 3**: Cleanup mechanizmas
3. **Tada Fazių 4-5**: Optimizacija ir validacija

## Kitas Žingsnis

Jei sutinkate su šiuo planu, galiu:
1. Pradėti implementuoti Fazių 1-2 (struktūros refaktorinimas ir event handler fix)
2. Arba pirmiausia pasiūlyti detalių kodų pavyzdžių

**Klausimas**: Ar norite, kad pradėčiau implementuoti refaktorinimą?

