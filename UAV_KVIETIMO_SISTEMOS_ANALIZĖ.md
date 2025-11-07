# UAV Kvietimo Sistemos Analizė

## Nuorodos

- **Pagrindinis failas**: `functions/client/fn_V2uavRequest.sqf` (143 eilutės)
- **Cooldown sistema**: `functions/server/fn_V2coolDown.sqf`
- **Terminalo prijungimas**: `functions/client/fn_V2uavTerminal.sqf`
- **Serverio inicializacija**: `initServer.sqf` (uavW, uavE, uavSquadW, uavSquadE)
- **Action meniu**: `functions/client/fn_leaderActions.sqf`
- **Pranešimai**: `functions/client/fn_V2hints.sqf`
- **Cooldown laikas**: `warmachine/V2startServer.sqf` (droneCooldownTime)

## Sistemos Architektūra

### 1. Dviejų Tipų Sistema

Sistema palaiko du skirtingus UAV kvietimo režimus:

#### A. Originali sistema (A3 modas)

**Aprašymas**: Vienas dronas per pusę, visi squad leaderiai dalijasi tą patį droną.

**Kintamieji**:
- `uavW` - WEST pusės UAV objektas
- `uavE` - EAST pusės UAV objektas
- `uavWr` - WEST pusės cooldown laikas (sekundėmis)
- `uavEr` - EAST pusės cooldown laikas (sekundėmis)

**Cooldown**: 180 sekundžių (3 minutės) po kiekvieno drono sunaikinimo.

**Veikimas**:
1. Squad leaderis spaudžia "UAV request" action meniu
2. Sistema tikrina:
   - Ar bazė nėra prarasta (`getMarkerColor resFobW/resFobE`)
   - Ar dronas jau nėra sukurtas (`alive uavW/uavE`)
   - Ar nėra aktyvaus cooldown (`uavWr/uavEr > 0`)
3. Jei visi patikrinimai praeina, sukuria droną virš žaidėjo (50-100m aukštyje)
4. Sukuria AI crew dronui
5. Nustato droną judėti link `posCenter`
6. Prideda MPKilled event handler'į, kuris paleidžia cooldown
7. Praneša visiems žaidėjams apie drono sukūrimą
8. Prideda droną Zeus redagavimui

**Kodas**:
```33:55:functions/client/fn_V2uavRequest.sqf
if(_sde==sideW)exitWith
{
	if(getMarkerColor resFobW=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBW1];};
	if(alive uavW)exitWith{hint "UAV is already deployed";};
	if(uavWr>0)exitWith
	{ 
		_t=uavWr; _s="sec"; if(uavWr>60)then{_t=floor (uavWr/60); _s="min";};
		hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
	};
	
	//Sukurti UAV virš kviečiančio žaidėjo (50-100m aukštyje)
	_playerPos = getPosATL player;
	_spawnPos = [_playerPos select 0, _playerPos select 1, (_playerPos select 2) + 50 + random 50];
	uavW = createVehicle [(selectRandom uavsW), _spawnPos, [], 0, "FLY"];
	createVehicleCrew uavW;
	publicvariable "uavW";
	(group driver uavW) move posCenter;
	
	uavW addMPEventHandler ["MPKilled",{[5] spawn wrm_fnc_V2coolDown;}];
	[5] remoteExec ["wrm_fnc_V2hints", 0, false];
	sleep 1;
	[z1,[[uavW],true]] remoteExec ["addCuratorEditableObjects", 2, false];
};
```

#### B. Per-squad sistema (Ukraine 2025 / Russia 2025)

**Aprašymas**: Atskiras dronas kiekvienam žaidėjui, individualus cooldown.

**Kintamieji**:
- `uavSquadW` - WEST pusės masyvas: `[[playerUID, uavObject, cooldownTime], ...]`
- `uavSquadE` - EAST pusės masyvas: `[[playerUID, uavObject, cooldownTime], ...]`
- `droneCooldownTime` - Cooldown laikas (nustatomas kaip `arTime / 4`)

**Cooldown**: Dinamiškas, priklauso nuo `arTime` (4x greičiau nei transporto priemonių respawn).

**Statusas**: 
- ✅ Cooldown sistema implementuota (`fn_V2coolDown.sqf` eilutės 123-202)
- ✅ Masyvai inicializuoti (`initServer.sqf` eilutės 112-113)
- ❌ Pagrindinė kvietimo logika **NĖRA** implementuota `fn_V2uavRequest.sqf` faile
- ❌ Dronų sukūrimas per-squad sistemai **NĖRA** implementuotas

**Pastaba**: Per-squad sistema yra dalinai implementuota - yra cooldown logika, bet nėra pagrindinio kvietimo mechanizmo.

## Veikimo Eiga (Originali Sistema)

### 1. Action Meniu Sukūrimas

**Failas**: `functions/client/fn_leaderActions.sqf`

**Sąlygos**:
- Žaidėjas turi būti squad leaderis
- Misijos tipas turi būti > 1 (ne infantry)
- Modas turi būti "A3" arba RHS su Ukraine/Russia 2025 frakcijomis
- Turi būti dronų masyve (`count uavsW/uavsE > 0`)

**Kodas**:
```173:192:functions/client/fn_leaderActions.sqf
//UAV request - prieinamas A3 modui arba RHS su Ukraine/Russia frakcijomis (visuose režimuose)
if((modA=="A3" || (modA=="RHS" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) && _hasUAV)then
{
	uavAction = player addAction
	[
		"UAV request", //title
		{
			[0,(side player)] spawn wrm_fnc_V2uavRequest; //0=uav, 1=ugv
		}, //script
		nil, //arguments (Optional)
		1, //priority (Optional)
		false, //showWindow (Optional)
		true, //hideOnUse (Optional)
		"", //shortcut, (Optional)
		"", //condition,  (Optional)
		0, //radius, (Optional) -1disable, 15max
		false, //unconscious, (Optional)
		"" //selection]; (Optional)
	];
};
```

### 2. UAV Kvietimas

**Failas**: `functions/client/fn_V2uavRequest.sqf`

**Procesas**:

1. **Validacija**:
   - Tikrina, ar bazė nėra prarasta
   - Tikrina, ar dronas jau nėra sukurtas
   - Tikrina, ar nėra aktyvaus cooldown

2. **Drono Sukūrimas**:
   - Apskaičiuoja spawn poziciją virš žaidėjo (50-100m aukštyje)
   - Sukuria droną iš `uavsW/uavsE` masyvo (atsitiktinis pasirinkimas)
   - Sukuria AI crew dronui
   - Nustato droną judėti link `posCenter`

3. **Event Handler'is**:
   - Prideda `MPKilled` event handler'į
   - Kai dronas sunaikinamas, paleidžia cooldown funkciją

4. **Pranešimai**:
   - Praneša visiems žaidėjams apie drono sukūrimą (`fn_V2hints.sqf`)

5. **Zeus Integracija**:
   - Prideda droną Zeus redagavimui

### 3. Cooldown Sistema

**Failas**: `functions/server/fn_V2coolDown.sqf`

**Originali Sistema (A3 modas)**:

- **WEST**: `_tpe==5` - 180 sekundžių cooldown
- **EAST**: `_tpe==6` - 180 sekundžių cooldown

**Veikimas**:
1. Nustato cooldown laiką (180 sekundžių)
2. Kiekvieną sekundę mažina cooldown laiką
3. Sinchronizuoja su visais klientais per `publicVariable`
4. Kai cooldown pasiekia 0, praneša visiems

**Kodas**:
```69:81:functions/server/fn_V2coolDown.sqf
if(_tpe==5)exitWith
{
	uavWr=180; //3 minutės cooldown
	publicvariable "uavWr";
	while {uavWr>0} do 
	{
		sleep 1;
		uavWr=uavWr-1;
		publicvariable "uavWr";
	};
	uavWr=0;
	publicvariable "uavWr";	
};
```

**Per-Squad Sistema (Ukraine/Russia 2025)**:

- **WEST**: `_tpe==11` - dinamiškas cooldown (`droneCooldownTime`)
- **EAST**: `_tpe==12` - dinamiškas cooldown (`droneCooldownTime`)

**Veikimas**:
1. Gauna `playerUID` ir `side` parametrus
2. Randa žaidėjo įrašą masyve (`uavSquadW` arba `uavSquadE`)
3. Nustato cooldown laiką (`droneCooldownTime`)
4. Kiekvieną 10 sekundžių mažina cooldown laiką
5. Sinchronizuoja su visais klientais per `publicVariable`
6. Kai cooldown pasiekia 0, praneša visiems

**Kodas**:
```125:163:functions/server/fn_V2coolDown.sqf
if(_tpe==11)exitWith //UAV WEST per-squad
{
	//Patikrinti, ar yra antrasis parametras (playerUID)
	if (count _this < 2) exitWith {};
	_playerUID = _this select 1;
	if (isNil "_playerUID" || {typeName _playerUID != "STRING"}) exitWith {};
	_cooldownTime = droneCooldownTime;

	[format ["[UAV COOLDOWN] Starting cooldown for WEST player %1: %2 seconds", _playerUID, _cooldownTime]] remoteExec ["systemChat", 0, false];

	//Rasti žaidėjo droną masyve
	_index = -1;
	{
		if((_x select 0) == _playerUID)exitWith{_index = _forEachIndex;};
	}forEach uavSquadW;

	if(_index >= 0)then
	{
		_uavData = uavSquadW select _index;
		uavSquadW set [_index, [_playerUID, objNull, _cooldownTime]];
		publicvariable "uavSquadW";

		//Cooldown loop
		while {(uavSquadW select _index) select 2 > 0} do
		{
			sleep 10;
			_currentCooldown = (uavSquadW select _index) select 2;
			uavSquadW set [_index, [_playerUID, objNull, _currentCooldown - 10]];
			publicvariable "uavSquadW";
		};

		//Cooldown baigtas
		uavSquadW set [_index, [_playerUID, objNull, 0]];
		publicvariable "uavSquadW";
		[format ["[UAV COOLDOWN] Cooldown finished for WEST player %1", _playerUID]] remoteExec ["systemChat", 0, false];
	} else {
		["[UAV COOLDOWN] ERROR: Could not find WEST player entry for cooldown"] remoteExec ["systemChat", 0, false];
	};
};
```

### 4. Terminalo Prijungimas

**Failas**: `functions/client/fn_V2uavTerminal.sqf`

**Aprašymas**: Atskiras failas terminalo prijungimui, bet **NĖRA** naudojamas `fn_V2uavRequest.sqf` faile.

**Veikimas**:
1. Validuoja droną ir žaidėją
2. Tikrina, ar dronas yra gyvas
3. Tikrina, ar dronas palaiko terminalą
4. Palaukia 2 sekundes, kol UAV sistema inicializuosis
5. Bando prijungti terminalą (maksimaliai 3 bandymai)
6. Tikrina, ar terminalas sėkmingai prijungtas

**Pastaba**: Ši funkcija yra sukūrta, bet nėra integruota į pagrindinę sistemą. Dabar žaidėjai turi rankiniu būdu prijungti terminalą.

## Dronų Tipai

### Ukraine 2025 (`factions/UA2025_RHS_W_V.hpp`)

```44:46:factions/UA2025_RHS_W_V.hpp
uavsW=["B_Crocus_AP","B_Crocus_AT"]; //UAV - FPV kamikadze dronai
uavsDlcW=[]; //UAV apex dlc - not used for Ukraine 2025
uavsDlc2W=[]; //UAV jets dlc - not used for Ukraine 2025
```

**Dronai**:
- `B_Crocus_AP` - FPV kamikadze dronas (Anti-Personnel)
- `B_Crocus_AT` - FPV kamikadze dronas (Anti-Tank)

### Russia 2025 (`factions/RU2025_RHS_W_V.hpp`)

```44:46:factions/RU2025_RHS_W_V.hpp
uavsE=["O_Crocus_AP","O_Crocus_AT"]; //UAV - FPV kamikadze dronai
uavsDlcE=[]; //UAV apex dlc - not used for Russia 2025
ugvsE=[]; //UGV - not used for Russia 2025
```

**Dronai**:
- `O_Crocus_AP` - FPV kamikadze dronas (Anti-Personnel)
- `O_Crocus_AT` - FPV kamikadze dronas (Anti-Tank)

## Identifikuotos Problemos

### 1. Per-Squad Sistema Neimplementuota

**Problema**: Per-squad sistema yra dalinai implementuota:
- ✅ Cooldown sistema veikia
- ✅ Masyvai inicializuoti
- ❌ Pagrindinė kvietimo logika nėra implementuota

**Pasekmė**: Ukraine ir Russia 2025 frakcijos naudoja originalią sistemą (vienas dronas per pusę), o ne per-squad sistemą.

**Sprendimas**: Reikia pridėti per-squad logiką į `fn_V2uavRequest.sqf` failą.

### 2. Terminalo Prijungimas Nėra Integruotas

**Problema**: `fn_V2uavTerminal.sqf` funkcija yra sukūrta, bet nėra naudojama.

**Pasekmė**: Žaidėjai turi rankiniu būdu prijungti terminalą prie drono.

**Sprendimas**: Integruoti `fn_V2uavTerminal.sqf` į `fn_V2uavRequest.sqf` po drono sukūrimo.

### 3. Nėra Cleanup Mechanizmo

**Problema**: Nėra mechanizmo, kuris:
- Šalina dronus, kai žaidėjas atsijungia
- Šalina dronus, kai žaidėjas miršta
- Atnaujina cooldown, kai dronas sunaikintas kitu būdu (ne per MPKilled)

**Pasekmė**: 
- Memory leak (dronai lieka masyvuose)
- Cooldown gali likti amžinamai, jei dronas sunaikintas ne per MPKilled

**Sprendimas**: Pridėti cleanup mechanizmą į `onPlayerKilled.sqf` ir `initServer.sqf`.

### 4. PublicVariable Per Dažnai

**Problema**: `publicVariable` kviečiamas per dažnai:
- Originali sistema: kiekvieną sekundę (cooldown loop)
- Per-squad sistema: kiekvieną 10 sekundžių (cooldown loop)

**Pasekmė**: Network overhead

**Sprendimas**: Optimizuoti `publicVariable` naudojimą - siųsti tik kai reikia.

### 5. Nėra Validacijos

**Problema**: 
- Nėra patikrinimo, ar `uavsW/uavsE` masyvai nėra tuščių
- Nėra patikrinimo, ar dronas sėkmingai sukurtas prieš bandant prijungti terminalą
- Nėra patikrinimo, ar `droneCooldownTime` yra nustatytas

**Pasekmė**: Klaidos gali būti neaiškios

**Sprendimas**: Pridėti validaciją visose kritinėse vietose.

## Rekomendacijos

### 1. Implementuoti Per-Squad Sistemą

**Prioritetas**: Aukštas

**Veiksmai**:
1. Pridėti per-squad logiką į `fn_V2uavRequest.sqf`
2. Patikrinti, ar frakcija yra Ukraine/Russia 2025
3. Jei taip, naudoti per-squad sistemą
4. Jei ne, naudoti originalią sistemą

### 2. Integruoti Terminalo Prijungimą

**Prioritetas**: Vidutinis

**Veiksmai**:
1. Iškviesti `fn_V2uavTerminal.sqf` po drono sukūrimo
2. Pridėti error handling, jei terminalas nepavyko prijungti

### 3. Pridėti Cleanup Mechanizmą

**Prioritetas**: Vidutinis

**Veiksmai**:
1. Pridėti cleanup į `onPlayerKilled.sqf`
2. Pridėti cleanup į `initServer.sqf` (player disconnect event)

### 4. Optimizuoti PublicVariable

**Prioritetas**: Žemas

**Veiksmai**:
1. Siųsti `publicVariable` tik kai reikia (ne kiekvieną sekundę)
2. Naudoti `publicVariableServer` vietoj `publicVariable`, jei reikia tik serverio

### 5. Pridėti Validaciją

**Prioritetas**: Vidutinis

**Veiksmai**:
1. Patikrinti, ar masyvai nėra tuščių
2. Patikrinti, ar dronas sėkmingai sukurtas
3. Patikrinti, ar `droneCooldownTime` yra nustatytas

## Testavimo Planas

### 1. Originali Sistema (A3 modas)

1. Squad leaderis spaudžia "UAV request"
2. Dronas sukurtas virš žaidėjo
3. Dronas sunaikinamas
4. Cooldown veikia teisingai (180 sekundžių)
5. Po cooldown dronas gali būti sukurtas vėl

### 2. Per-Squad Sistema (Ukraine/Russia 2025)

**Pastaba**: Reikia pirmiausia implementuoti sistemą.

1. Keli squad leaderiai spaudžia "UAV request"
2. Kiekvienas gauna savo droną
3. Kiekvienas turi savo cooldown
4. Dronai sunaikinami
5. Cooldown veikia teisingai kiekvienam žaidėjui

### 3. Terminalo Prijungimas

1. Dronas sukurtas
2. Terminalas automatiškai prijungiamas
3. Žaidėjas gali valdyti droną

### 4. Cleanup

1. Žaidėjas atsijungia su aktyviu dronu
2. Dronas šalinamas iš masyvo
3. Cooldown atnaujinamas

## Išvados

UAV kvietimo sistema yra funkcionali originaliai sistemai (A3 modas), bet per-squad sistema yra dalinai implementuota. Reikia:

1. **Implementuoti per-squad sistemą** - pridėti logiką į `fn_V2uavRequest.sqf`
2. **Integruoti terminalo prijungimą** - naudoti `fn_V2uavTerminal.sqf` funkciją
3. **Pridėti cleanup mechanizmą** - valyti dronus, kai žaidėjai atsijungia/miršta
4. **Optimizuoti network komunikaciją** - mažinti `publicVariable` naudojimą
5. **Pridėti validaciją** - patikrinti visus kritinius kintamuosius

## Atvejai, Kai Sistema Gali Būti Neprieinama

### 1. Action Meniu Neprieinamas (UAV Request Neatsiranda)

#### A. Misija Dar Neprasidėjo
**Sąlyga**: `progress <= 1`

**Aprašymas**: UAV request action meniu atsiranda tik kai `progress > 1`, t.y. misija jau prasidėjo.

**Kodas**:
```151:155:functions/client/fn_leaderActions.sqf
if(progress>1)then
{			

	if(version==2)then
	{
```

**Pasekmė**: Jei misija dar neprasidėjo (`progress == 0` arba `progress == 1`), UAV request action meniu neatsiranda.

#### B. Neteisingas Misijos Versija
**Sąlyga**: `version != 2`

**Aprašymas**: UAV sistema veikia tik su `version == 2`.

**Kodas**:
```154:155:functions/client/fn_leaderActions.sqf
if(version==2)then
{
```

**Pasekmė**: Jei misija naudoja kitą versiją, UAV request action meniu neatsiranda.

#### C. Neteisingas Modas Arba Frakcija
**Sąlyga**: 
- `modA != "A3"` IR
- `modA != "RHS"` ARBA (`factionW != "Ukraine 2025"` IR `factionE != "Russia 2025"`)

**Aprašymas**: UAV sistema veikia tik su:
- A3 modu (bet kokia frakcija)
- RHS modu su Ukraine 2025 arba Russia 2025 frakcijomis

**Kodas**:
```173:174:functions/client/fn_leaderActions.sqf
//UAV request - prieinamas A3 modui arba RHS su Ukraine/Russia frakcijomis (visuose režimuose)
if((modA=="A3" || (modA=="RHS" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) && _hasUAV)then
```

**Pasekmė**: Jei naudojamas kitas modas (pvz., GM, VN, CSLA, SPE, IFA3) arba RHS su kitomis frakcijomis, UAV request action meniu neatsiranda.

#### D. Dronų Masyvas Tuščias
**Sąlyga**: `count uavsW == 0` (WEST) arba `count uavsE == 0` (EAST)

**Aprašymas**: Jei frakcijos dronų masyvas tuščias, UAV request action meniu neatsiranda.

**Kodas**:
```157:171:functions/client/fn_leaderActions.sqf
//Dronai prieinami tik jei misijos tipas >1 (ne infantry) ir yra dronų masyvuose
_hasUAV = false;
_hasUGV = false;
call
{
	if(side player == sideW)exitWith
	{
		_hasUAV = (count uavsW > 0);
		_hasUGV = (count ugvsW > 0);
	};
	if(side player == sideE)exitWith
	{
		_hasUAV = (count uavsE > 0);
		_hasUGV = (count ugvsE > 0);
	};
};
```

**Pasekmė**: Jei `_hasUAV == false`, UAV request action meniu neatsiranda.

**Galimos Priežastys**:
- Frakcijos konfigūracijoje nėra dronų (`uavsW` arba `uavsE` masyvai tušči)
- DLC dronai nepridėti (jei reikia)

#### E. Žaidėjas Nėra Squad Leaderis
**Sąlyga**: `player != leader (group player)`

**Aprašymas**: UAV request action meniu prieinamas tik squad leaderiams.

**Pastaba**: Ši sąlyga nėra aiškiai patikrinama kode, bet `fn_leaderActions.sqf` funkcija kviečiama tik squad leaderiams.

**Pasekmė**: Jei žaidėjas nėra squad leaderis, UAV request action meniu neatsiranda.

### 2. UAV Kvietimas Blokuojamas (Action Meniu Yra, Bet Kvietimas Nepavyko)

#### A. Bazė Prarasta
**Sąlyga**: `getMarkerColor resFobW == ""` (WEST) arba `getMarkerColor resFobE == ""` (EAST)

**Aprašymas**: Jei bazė prarasta (marker'is pašalintas), UAV sistema tampa neprieinama.

**Kodas**:
```35:35:functions/client/fn_V2uavRequest.sqf
if(getMarkerColor resFobW=="")exitWith{hint parseText format ["UAV service is unavailable<br/>You lost %1 base",nameBW1];};
```

**Pranešimas**: "UAV service is unavailable<br/>You lost [base name] base"

**Pasekmė**: Negalima kviesti drono, kol bazė nebus atgauta.

#### B. Dronas Jau Sukurtas
**Sąlyga**: `alive uavW == true` (WEST) arba `alive uavE == true` (EAST)

**Aprašymas**: Originalioje sistemoje gali būti tik vienas dronas per pusę vienu metu.

**Kodas**:
```36:36:functions/client/fn_V2uavRequest.sqf
if(alive uavW)exitWith{hint "UAV is already deployed";};
```

**Pranešimas**: "UAV is already deployed"

**Pasekmė**: Negalima kviesti naujo drono, kol esamas dronas yra gyvas.

**Pastaba**: Per-squad sistemoje ši problema neturėtų egzistuoti, nes kiekvienas žaidėjas turi savo droną.

#### C. Aktyvus Cooldown
**Sąlyga**: `uavWr > 0` (WEST) arba `uavEr > 0` (EAST)

**Aprašymas**: Po drono sunaikinimo yra cooldown laikotarpis (180 sekundžių originalioje sistemoje).

**Kodas**:
```37:41:functions/client/fn_V2uavRequest.sqf
if(uavWr>0)exitWith
{ 
	_t=uavWr; _s="sec"; if(uavWr>60)then{_t=floor (uavWr/60); _s="min";};
	hint parseText format ["UAV service is unavailable<br/>UAV will be ready in %1 %2",_t,_s];
};
```

**Pranešimas**: "UAV service is unavailable<br/>UAV will be ready in [time] [sec/min]"

**Cooldown Laikas**:
- **Originali sistema**: 180 sekundžių (3 minutės)
- **Per-squad sistema**: `droneCooldownTime` (dinamiškas, priklauso nuo `arTime / 4`)

**Pasekmė**: Negalima kviesti drono, kol cooldown nesibaigė.

### 3. Techninės Problemos (Gali Sprogti Klaidos)

#### A. Dronų Masyvas Tuščias Kvietimo Metu
**Sąlyga**: `count uavsW == 0` arba `count uavsE == 0` kvietimo metu

**Problema**: `selectRandom uavsW/uavsE` gali sugesti, jei masyvas tuščias.

**Kodas**:
```46:46:functions/client/fn_V2uavRequest.sqf
uavW = createVehicle [(selectRandom uavsW), _spawnPos, [], 0, "FLY"];
```

**Pasekmė**: Klaida kvietimo metu, dronas nesukuriamas.

**Sprendimas**: Reikia pridėti validaciją prieš `selectRandom`.

#### B. Dronas Nepavyko Sukurti
**Sąlyga**: `createVehicle` grąžina `objNull`

**Problema**: `createVehicle` gali nepavykti dėl:
- Neteisingas klasės pavadinimas
- Netinkama pozicija
- Serverio problemos

**Kodas**:
```46:46:functions/client/fn_V2uavRequest.sqf
uavW = createVehicle [(selectRandom uavsW), _spawnPos, [], 0, "FLY"];
```

**Pasekmė**: Dronas nesukuriamas, bet sistema galvoja, kad sukurtas.

**Sprendimas**: Reikia patikrinti, ar dronas sėkmingai sukurtas prieš tęsiant.

#### C. AI Crew Nepavyko Sukurti
**Sąlyga**: `createVehicleCrew` nepavyko

**Problema**: `createVehicleCrew` gali nepavykti, jei dronas neturi crew pozicijų.

**Kodas**:
```47:47:functions/client/fn_V2uavRequest.sqf
createVehicleCrew uavW;
```

**Pasekmė**: Dronas sukurtas, bet be crew, negali judėti.

**Sprendimas**: Reikia patikrinti, ar crew sėkmingai sukurtas.

### 4. Per-Squad Sistemos Problemos (Jei Būtų Implementuota)

#### A. Žaidėjas Jau Turi Droną
**Sąlyga**: Žaidėjo `playerUID` jau yra `uavSquadW/uavSquadE` masyve su gyvu dronu

**Problema**: Per-squad sistemoje kiekvienas žaidėjas turėtų turėti tik vieną droną.

**Pasekmė**: Negalima kviesti naujo drono, kol esamas dronas yra gyvas.

#### B. Cooldown Aktyvus
**Sąlyga**: Žaidėjo cooldown laikas > 0

**Problema**: Per-squad sistemoje kiekvienas žaidėjas turi savo cooldown.

**Pasekmė**: Negalima kviesti drono, kol cooldown nesibaigė.

#### C. Masyvas Pilnas (Teoriškai)
**Sąlyga**: `count uavSquadW/uavSquadE` pasiekė maksimalų dydį

**Problema**: Masyvas gali tapti per didelis, jei nėra cleanup mechanizmo.

**Pasekmė**: Sistema gali sugesti arba veikti lėtai.

## Sąrašas Visų Blokavimo Sąlygų

### Action Meniu Neprieinamas:
1. ✅ `progress <= 1` - Misija dar neprasidėjo
2. ✅ `version != 2` - Neteisingas misijos versija
3. ✅ `modA != "A3"` IR (`modA != "RHS"` ARBA (`factionW != "Ukraine 2025"` IR `factionE != "Russia 2025"`)) - Neteisingas modas/frakcija
4. ✅ `count uavsW == 0` arba `count uavsE == 0` - Dronų masyvas tuščias
5. ✅ Žaidėjas nėra squad leaderis - Tik squad leaderiai gali kviesti

### UAV Kvietimas Blokuojamas:
6. ✅ `getMarkerColor resFobW == ""` arba `getMarkerColor resFobE == ""` - Bazė prarasta
7. ✅ `alive uavW == true` arba `alive uavE == true` - Dronas jau sukurtas
8. ✅ `uavWr > 0` arba `uavEr > 0` - Aktyvus cooldown

### Techninės Problemos:
9. ⚠️ `count uavsW == 0` arba `count uavsE == 0` kvietimo metu - Masyvas tuščias
10. ⚠️ `createVehicle` grąžina `objNull` - Dronas nepavyko sukurti
11. ⚠️ `createVehicleCrew` nepavyko - AI crew nepavyko sukurti

## Rekomendacijos

### 1. Pridėti Validaciją

**Prioritetas**: Aukštas

**Veiksmai**:
1. Patikrinti, ar `uavsW/uavsE` masyvai nėra tuščių prieš `selectRandom`
2. Patikrinti, ar dronas sėkmingai sukurtas prieš tęsiant
3. Patikrinti, ar crew sėkmingai sukurtas

**Kodas**:
```sqf
//Patikrinti, ar masyvas nėra tuščias
if (count uavsW == 0) exitWith {
	hint "UAV service is unavailable<br/>No UAVs available for this faction";
	systemChat "[UAV ERROR] uavsW array is empty";
};

//Sukurti droną
uavW = createVehicle [(selectRandom uavsW), _spawnPos, [], 0, "FLY"];

//Patikrinti, ar dronas sėkmingai sukurtas
if (isNull uavW) exitWith {
	hint "UAV service is unavailable<br/>Failed to create UAV";
	systemChat "[UAV ERROR] Failed to create UAV";
};

//Sukurti crew
createVehicleCrew uavW;

//Patikrinti, ar crew sukurtas
if (isNull driver uavW) exitWith {
	hint "UAV service is unavailable<br/>Failed to create UAV crew";
	systemChat "[UAV ERROR] Failed to create UAV crew";
};
```

### 2. Pagerinti Error Messages

**Prioritetas**: Vidutinis

**Veiksmai**:
1. Pridėti aiškesnius error messages
2. Pridėti debug informaciją serverio pusėje

### 3. Pridėti Cleanup Mechanizmą

**Prioritetas**: Vidutinis

**Veiksmai**:
1. Valyti dronus, kai žaidėjai atsijungia
2. Valyti dronus, kai žaidėjai miršta
3. Valyti dronus, kai bazė prarasta

## Kitas Žingsnis

Jei norite, galiu:
1. Implementuoti per-squad sistemą
2. Integruoti terminalo prijungimą
3. Pridėti cleanup mechanizmą
4. Optimizuoti sistemą
5. Pridėti validaciją ir geresnius error messages

**Klausimas**: Ar norite, kad pradėčiau implementuoti šiuos pakeitimus?

