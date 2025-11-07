# unitsE vs Loadout Klasės (EAST500-EAST518) - Paaiškinimas

## Skirtumas

### 1. `unitsE` masyvas

**Kas tai**: Masyvas su 19 vienetų klasės pavadinimų (string masyvas)

**Kur apibrėžiama**: `factions/RU2025_RHS_W_V.hpp` (arba kitas frakcijos failas)

**Pavyzdys**:
```sqf
unitsE=
[
	"RUS_MSV_east_lieutenant", //0 - Squad leader
	"RUS_MSV_east_operatormanpad", //1 - Rifleman AT
	"RUS_MSV_east_machinegunner", //2 - Autorifleman
	// ... kiti kariai
];
```

**Kada naudojama**: 
- **AI vienetų loadout'ų keitimui dinamiškai**
- Kai AI vienetas respawn'ina arba keičiamas
- Kai AI vienetai spawn'inami bazės gynybai ar sektorių gynybai

**Kaip veikia**:
1. AI vienetas turi originalų klasės pavadinimą (pvz., `"O_Soldier_SL_F"`)
2. `fn_V2loadoutChange.sqf` patikrina originalų klasės pavadinimą
3. Pagal originalų klasės pavadinimą parenkamas indeksas iš `unitsE` masyvo
4. Naujas loadout priskiriamas iš `unitsE` masyvo

**Kodas** (`functions/server/fn_V2loadoutChange.sqf`):
```sqf
if(typeOf _un=="O_Soldier_SL_F")exitWith{_gr= unitsE select 0;};
// _gr dabar yra "RUS_MSV_east_lieutenant"
_un setUnitLoadout _gr;
```

**Kur naudojama**:
- `functions/server/fn_V2loadoutChange.sqf` - AI vienetų loadout'ų keitimas
- `warmachine/moreSquads.sqf` - Papildomų AI būrių spawn'inimas
- `warmachine/baseDefense.sqf` - Bazės gynybos AI spawn'inimas
- `functions/server/fn_V2secDefense.sqf` - Sektorių gynybos AI spawn'inimas

**Svarbu**: 
- `unitsE` naudojama **tik AI vienetams**
- Žaidėjai **NE** naudoja `unitsE` masyvą

---

### 2. Loadout klasės (EAST500-EAST518)

**Kas tai**: `description.ext` failo `CfgRespawnInventory` klasės

**Kur apibrėžiama**: `loadouts/RU2025_RHS_W_L.hpp` (arba kitas loadout failas)

**Pavyzdys**:
```cpp
class EAST500 {vehicle = "RUS_MSV_east_lieutenant";};
class EAST501 {vehicle = "RUS_MSV_east_operatormanpad";};
class EAST502 {vehicle = "RUS_MSV_east_machinegunner";};
// ... kiti loadout'ai
```

**Kada naudojama**: 
- **Žaidėjų respawn loadout'ams**
- Kai žaidėjas respawn'ina
- Kai žaidėjas pasirenka loadout iš respawn meniu

**Kaip veikia**:
1. Arma 3 respawn sistema automatiškai naudoja `CfgRespawnInventory` klasės
2. Žaidėjas gali pasirinkti loadout iš respawn meniu
3. Loadout priskiriamas pagal pasirinktą klasę (pvz., `EAST200`)

**Kodas** (`description.ext`):
```cpp
respawnTemplates[] = {"Revive","MenuPosition","MenuInventory","Tickets"};
// "MenuInventory" leidžia žaidėjui pasirinkti loadout iš respawn meniu

class CfgRespawnInventory 
{
	#include "loadouts\RU2025_RHS_W_L.hpp" //EAST 200 - 218
};
```

**Kur naudojama**:
- `description.ext` - `CfgRespawnInventory` klasės
- Arma 3 respawn sistema - automatiškai naudoja šias klasės
- Respawn meniu - žaidėjas gali pasirinkti loadout

**Svarbu**: 
- Loadout klasės naudojamos **tik žaidėjams**
- AI vienetai **NE** naudoja loadout klasių

---

## Santykis tarp jų

### Kodėl abu turi tuos pačius karius?

**Atsakymas**: Kad būtų konsistentiškumas

- **AI vienetai** naudoja `unitsE` masyvą, kad gautų tinkamus loadout'us
- **Žaidėjai** naudoja loadout klases (EAST500-EAST518), kad gautų tuos pačius loadout'us

**Pavyzdys**:
- AI vienetas su klasės `"O_Soldier_SL_F"` → `unitsE select 0` → `"RUS_MSV_east_lieutenant"`
- Žaidėjas pasirenka `EAST200` → `"RUS_MSV_east_lieutenant"`

**Abu gauna tą patį loadout'ą!**

---

## Pakeitimų atlikimas

### Pakeisti AI vienetų loadout'us:
- Redaguoti `factions/RU2025_RHS_W_V.hpp` → `unitsE` masyvas

### Pakeisti žaidėjų respawn loadout'us:
- Redaguoti `loadouts/RU2025_RHS_W_L.hpp` → `EAST250-EAST268` klasės

### Svarbu:
- **Abu turi sutapti!** Jei pakeisi `unitsE`, turi pakeisti ir loadout klases
- Jei pakeisi loadout klases, turi pakeisti ir `unitsE` masyvą

---

## Išvados

| Aspektas | `unitsE` masyvas | Loadout klasės (EAST500-EAST518) |
|----------|------------------|-----------------------------------|
| **Kam skirta** | AI vienetams | Žaidėjams |
| **Kur naudojama** | `fn_V2loadoutChange.sqf`, `baseDefense.sqf`, `moreSquads.sqf` | `description.ext`, respawn meniu |
| **Kaip veikia** | Dinamiškai keičia loadout'us pagal originalų klasės pavadinimą | Statinės klasės, kurias žaidėjas pasirenka |
| **Kada naudojama** | AI respawn, AI spawn, loadout keitimas | Žaidėjo respawn, loadout pasirinkimas |
| **Kur apibrėžiama** | `factions/RU2025_RHS_W_V.hpp` | `loadouts/RU2025_RHS_W_L.hpp` |

**Svarbu**: Abi sistemos turi būti sinchronizuotos, kad AI ir žaidėjai gautų tuos pačius loadout'us!

