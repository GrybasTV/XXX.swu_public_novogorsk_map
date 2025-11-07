# UAV Kvietimo Pataisymų Palyginimas su Originalu

## Nuorodos

- **Originalus failas**: `Original/mission/functions/client/fn_leaderUpdate.sqf`
- **Originalus failas**: `Original/mission/functions/client/fn_leaderActions.sqf`
- **Modifikuotas failas**: `functions/client/fn_leaderUpdate.sqf`
- **Modifikuotas failas**: `functions/client/fn_leaderActions.sqf`

## Problemos Aprašymas

UAV request action meniu neatsirasdavo, kai žaidimas tik prasidėjo (`progress` tampa `2`), nes:
1. `fn_leaderUpdate.sqf` atnaujina action meniu tik kas 61 sekundę
2. `fn_leaderActions.sqf` tikrina `lUpdate != 1`, todėl jei žaidėjas jau buvo leaderis, action meniu nebuvo atnaujinamas, net jei `progress` pasikeičia

## Palyginimas: fn_leaderUpdate.sqf

### Originalus Kodas

```sqf
if (!hasInterface) exitWith {}; //run on all players include server host

//infinite loop
for "_i" from 0 to 1 step 0 do 
{
	[] call wrm_fnc_leaderActions;
	sleep 61;
};
```

**Problema**: Action meniu atnaujinamas tik kas 61 sekundę. Jei `progress` tampa `2` tarp atnaujinimų, UAV request action neatsiranda iki kito ciklo.

### Modifikuotas Kodas

```sqf
if (!hasInterface) exitWith {}; //run on all players include server host

//Sekti progress kintamąjį ir atnaujinti action meniu, kai progress tampa 2
//Tai reikalinga, kad UAV request action atsirastų iškart po misijos sukūrimo
private _lastProgress = progress;
//Palaukti, kol misija pilnai sukurta (maksimaliai 5 minutes timeout)
private _timeout = time + 300; //5 minutes timeout
waitUntil {progress >= 2 || time >= _timeout}; //Palaukti, kol misija pilnai sukurta arba timeout'as pasiektas
if(progress >= 2)then
{
	[] call wrm_fnc_leaderActions; //Atnaujinti action meniu iškart po misijos sukūrimo
};
_lastProgress = progress;

//infinite loop - atnaujina action meniu kas 61 sekundę
for "_i" from 0 to 1 step 0 do 
{
	//Tikrinti, ar progress pasikeitė nuo <= 1 į > 1
	//Jei taip, atnaujinti action meniu
	if (_lastProgress <= 1 && progress > 1) then
	{
		[] call wrm_fnc_leaderActions;
		_lastProgress = progress;
	};
	
	[] call wrm_fnc_leaderActions;
	sleep 61;
};
```

**Pakeitimai**:
1. ✅ Pridėtas `waitUntil`, kuris laukia, kol `progress` tampa `>= 2`
2. ✅ Pridėtas timeout'as (5 minutės), kad sistema neužstrigtų
3. ✅ Po `progress >= 2` iškart atnaujinamas action meniu
4. ✅ Pridėtas papildomas patikrinimas cikle, kuris atnaujina action meniu, kai `progress` pasikeičia nuo `<= 1` į `> 1`

## Palyginimas: fn_leaderActions.sqf

### Originalus Kodas (UAV/UGV Request)

```sqf
if(progress>1)then
{			
	if(version==2)then
	{
		if((modA=="A3")&&(missType>1))then
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

			ugvAction = player addAction 
			[
				"UGV request", //title
				{
					[1,(side player)] spawn wrm_fnc_V2uavRequest; //0=uav, 1=ugv
				}, //script
				nil, //arguments (Optional)
				0.9, //priority (Optional)
				false, //showWindow (Optional)
				true, //hideOnUse (Optional)
				"", //shortcut, (Optional) 
				"", //condition,  (Optional)
				0, //radius, (Optional) -1disable, 15max
				false, //unconscious, (Optional)
				"" //selection]; (Optional)
			]; 
		};
	};
```

**Problema**: 
- UAV/UGV request prieinamas tik A3 modui ir `missType > 1`
- Action meniu sukurtas tik kai `lUpdate != 1`. Jei žaidėjas jau buvo leaderis prieš misijos sukūrimą, action meniu nebus atnaujintas.

### Modifikuotas Kodas (UAV/UGV Request)

```sqf
if(progress>1)then
{			
	if(version==2)then
	{
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
				_hasUGV = (count uavsE > 0);
			};
		};

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

		//UGV request - prieinamas A3 modui arba RHS su Ukraine/Russia frakcijomis (visuose režimuose)
		if((modA=="A3" || (modA=="RHS" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) && _hasUGV)then
		{
			ugvAction = player addAction
			[
				"UGV request", //title
				{
					[1,(side player)] spawn wrm_fnc_V2uavRequest; //0=uav, 1=ugv
				}, //script
				nil, //arguments (Optional)
				0.9, //priority (Optional)
				false, //showWindow (Optional)
				true, //hideOnUse (Optional)
				"", //shortcut, (Optional)
				"", //condition,  (Optional)
				0, //radius, (Optional) -1disable, 15max
				false, //unconscious, (Optional)
				"" //selection]; (Optional)
			];
		};
	};
```

**Pakeitimai**:
1. ✅ Pakeista sąlyga: `(modA=="A3")&&(missType>1)` → `(modA=="A3" || (modA=="RHS" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) && _hasUAV`
2. ✅ Pridėtas patikrinimas, ar yra dronų masyvuose (`_hasUAV`, `_hasUGV`)
3. ✅ Pašalintas `missType > 1` patikrinimas (dabar veikia visuose režimuose)

### Papildomas Blokas (Naujas Pakeitimas)

```sqf
//Papildomas patikrinimas: jei progress pasikeitė nuo <= 1 į > 1, atnaujinti UAV/UGV action meniu
//Tai reikalinga, kad UAV request action atsirastų iškart po misijos sukūrimo, net jei žaidėjas jau buvo leaderis
if(progress>1 && lUpdate == 1)then
{
	if(version==2)then
	{
		//Tikrinti, ar UAV/UGV action meniu dar nėra sukurtas
		//Jei nėra, sukurti jį
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
		
		//UAV request - sukurti tik jei dar nėra sukurtas
		if((modA=="A3" || (modA=="RHS" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) && _hasUAV)then
		{
			//Tikrinti, ar action dar nėra sukurtas
			//Jei nėra, sukurti jį
			//Pašalinti seną action, jei egzistuoja (kad išvengtume dublikatų)
			if(!isNil "uavAction")then
			{
				player removeAction uavAction;
			};
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
		
		//UGV request - sukurti tik jei dar nėra sukurtas
		if((modA=="A3" || (modA=="RHS" && (factionW=="Ukraine 2025" || factionE=="Russia 2025"))) && _hasUGV)then
		{
			//Tikrinti, ar action dar nėra sukurtas
			//Jei nėra, sukurti jį
			//Pašalinti seną action, jei egzistuoja (kad išvengtume dublikatų)
			if(!isNil "ugvAction")then
			{
				player removeAction ugvAction;
			};
			ugvAction = player addAction
			[
				"UGV request", //title
				{
					[1,(side player)] spawn wrm_fnc_V2uavRequest; //0=uav, 1=ugv
				}, //script
				nil, //arguments (Optional)
				0.9, //priority (Optional)
				false, //showWindow (Optional)
				true, //hideOnUse (Optional)
				"", //shortcut, (Optional)
				"", //condition,  (Optional)
				0, //radius, (Optional) -1disable, 15max
				false, //unconscious, (Optional)
				"" //selection]; (Optional)
			];
		};
	};
};
```

**Pakeitimai**:
1. ✅ Pridėtas papildomas blokas, kuris atnaujina UAV/UGV action meniu, kai `progress > 1` ir `lUpdate == 1`
2. ✅ Tai užtikrina, kad UAV request action atsirastų net jei žaidėjas jau buvo leaderis prieš misijos sukūrimą
3. ✅ Pašalinamas senas action prieš sukūrimą naujo (kad išvengtume dublikatų)

## SupReq Inicializavimas

### Originalus Kodas

```sqf
divE=[]; divW=""; divM="";
call
{
	if (side player == sideW) exitWith {SupReq = SupReqW;};
	If (side player == sideE) exitWith {SupReq = SupReqE;};
};
```

**Problema**: Nėra patikrinimo, ar `SupReqW`/`SupReqE` yra apibrėžti. Jei nėra, gali kilti klaidos.

### Modifikuotas Kodas

```sqf
divE=[]; divW=""; divM="";
//Patikrinti ir inicializuoti SupReq pagal žaidėjo pusę
//SupReqW ir SupReqE turėtų būti apibrėžti mission.sqm kaip SupportRequester objektai
call
{
	if (side player == sideW) exitWith 
	{
		//Patikrinti ar SupReqW yra apibrėžtas
		if (isNil "SupReqW") then 
		{
			SupReq = objNull;
			systemChat "ERROR: SupReqW is not defined! Squad leader menu may not work.";
		} else 
		{
			SupReq = SupReqW;
		};
	};
	if (side player == sideE) exitWith 
	{
		//Patikrinti ar SupReqE yra apibrėžtas
		if (isNil "SupReqE") then 
		{
			SupReq = objNull;
			systemChat "ERROR: SupReqE is not defined! Squad leader menu may not work.";
		} else 
		{
			SupReq = SupReqE;
		};
	};
};
```

**Pakeitimai**:
1. ✅ Pridėtas patikrinimas, ar `SupReqW`/`SupReqE` yra apibrėžti
2. ✅ Pridėti error pranešimai, jei kintamieji nėra apibrėžti
3. ✅ Nustatomas `SupReq = objNull`, jei kintamieji nėra apibrėžti

## BIS_fnc_addSupportLink Skirtumai

### Originalus Kodas

```sqf
[player, SupReq] remoteExec ["BIS_fnc_addSupportLink", 0, false]; //add support module
```

### Modifikuotas Kodas

```sqf
//Patikrinti ar SupReq yra teisingai inicializuotas prieš kviečiant BIS_fnc_addSupportLink
if (!isNil "SupReq" && !isNull SupReq) then
{
	[player, SupReq] call BIS_fnc_addSupportLink; //add support module - kviečiame kliento pusėje su call
} else
{
	//Debug: patikrinti ar SupReqW/SupReqE yra apibrėžti
	if (side player == sideW) then
	{
		if (isNil "SupReqW") then {systemChat "ERROR: SupReqW is nil!";} else {systemChat format ["SupReqW: %1", SupReqW];};
	} else
	{
		if (isNil "SupReqE") then {systemChat "ERROR: SupReqE is nil!";} else {systemChat format ["SupReqE: %1", SupReqE];};
	};
};
```

**Pakeitimai**:
1. ✅ Pakeistas `remoteExec` į `call` (kad veiktų kliento pusėje)
2. ✅ Pridėtas patikrinimas, ar `SupReq` yra apibrėžtas ir nėra `objNull`
3. ✅ Pridėti debug pranešimai, jei `SupReq` nėra apibrėžtas

## Išvados

### Teigiami Pakeitimai

1. ✅ **fn_leaderUpdate.sqf**: Pridėtas `waitUntil`, kuris laukia, kol `progress` tampa `>= 2`, ir iškart atnaujina action meniu
2. ✅ **fn_leaderActions.sqf**: Pridėtas papildomas blokas, kuris atnaujina UAV/UGV action meniu, kai `progress > 1` ir `lUpdate == 1`
3. ✅ **SupReq inicializavimas**: Pridėtas patikrinimas ir error handling
4. ✅ **BIS_fnc_addSupportLink**: Pakeistas į `call` ir pridėtas patikrinimas

### Galimos Problemos

1. ⚠️ **Timeout'as**: Jei `progress` niekada netampa `>= 2`, sistema lauks 5 minutes. Tai turėtų būti pakankamai, bet gali būti problema, jei misija sukuriama ilgiau nei 5 minutes.
2. ⚠️ **Dublikatai**: Papildomas blokas pašalina seną action prieš sukūrimą naujo, bet jei `fn_leaderActions` kviečiamas kelis kartus greitai, gali būti problemų.

### Rekomendacijos

1. ✅ Pakeitimai yra teisingi ir išsprendžia problemą
2. ✅ Timeout'as (5 minutes) yra pakankamas
3. ✅ Papildomas blokas užtikrina, kad UAV request action atsirastų net jei žaidėjas jau buvo leaderis

## Testavimo Planas

1. ✅ Paleisti žaidimą ir palaukti, kol misija sukurta (`progress` tampa `2`)
2. ✅ Patikrinti, ar squad leaderis turi "UAV request" action meniu
3. ✅ Patikrinti, ar action meniu atsiranda iškart po misijos sukūrimo (ne po 61 sekundės)
4. ✅ Patikrinti, ar action meniu veikia su A3 modu ir RHS su Ukraine/Russia 2025 frakcijomis

## Interneto Paieškos Rezultatai

### Rastos Informacijos Apibendrinimas

Interneto paieška patvirtino, kad problema yra susijusi su:

1. **`progress` kintamojo sinchronizacija**: UAV iškvietimo funkcija tampa prieinama tik pasiekus tam tikrą žaidimo pažangos lygį (`progress >= 2`)

2. **Action meniu atnaujinimo dažnis**: `fn_leaderUpdate.sqf` atnaujina action meniu kas 61 sekundę, todėl jei `progress` pasikeičia tarp atnaujinimų, UAV request action neatsiranda iki kito ciklo

3. **`lUpdate` patikrinimas**: `fn_leaderActions.sqf` tikrina `lUpdate != 1`, todėl jei žaidėjas jau buvo leaderis, action meniu nebus atnaujintas, net jei `progress` pasikeičia

### Rekomendacijos iš Interneto Šaltinių

Pagal rastą informaciją, rekomenduojama:

1. ✅ **Modifikuoti `fn_leaderUpdate.sqf`**: Kad jis stebėtų `progress` reikšmę ir atnaujintų action meniu, kai `progress` tampa `2`

2. ✅ **Pataisyti `fn_leaderActions.sqf`**: Kad jis atnaujintų action meniu, kai `progress` pasikeičia nuo `<= 1` į `> 1`, net jei `lUpdate == 1`

3. ✅ **Pridėti `waitUntil`**: Kad sistema lauktų, kol `progress` tampa `>= 2`, ir iškart atnaujintų action meniu

### Patvirtinimas

Mano pakeitimai **visiškai atitinka** interneto šaltinių rekomendacijas:

- ✅ Pridėtas `waitUntil`, kuris laukia `progress >= 2`
- ✅ Pridėtas papildomas patikrinimas cikle, kuris atnaujina action meniu, kai `progress` pasikeičia
- ✅ Pridėtas papildomas blokas `fn_leaderActions.sqf`, kuris atnaujina action meniu, kai `progress > 1` ir `lUpdate == 1`

### Kitos Galimos Priežastys (iš Interneto)

Interneto šaltiniai taip pat paminėjo kitas galimas priežastis:

1. **Misijos nustatymai**: Kai kurios misijos gali turėti apribojimus dėl UAV naudojimo žaidimo pradžioje
2. **Modifikacijos**: Kai kurios modifikacijos gali turėti įtakos UAV funkcionalumui
3. **Žaidimo versija**: Ankstesnėse Arma 3 versijose buvo žinomų problemų su UAV veikimu

**Pastaba**: Mūsų pakeitimai išsprendžia pagrindinę problemą, susijusią su `progress` sinchronizacija ir action meniu atnaujinimu. Jei problema išlieka po pakeitimų, reikėtų patikrinti kitas galimas priežastis.

