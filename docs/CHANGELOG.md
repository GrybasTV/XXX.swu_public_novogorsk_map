# Changelog

## [Neišleistas] - 2025-11-XX

### Ištaisytos klaidos
- **UAV cooldown sistema**: Ištaisytas trūkumas, kai UAV galėjo būti kviečiamas iškart po pirmo sunaikinimo. Dabar įgyvendinta 3 minučių cooldown sistema per būrį visoms frakcijoms.
  - Pakeista sistema iš globalių cooldown kintamųjų (`uavWr`, `uavEr`) į grupės-based sistemą (`uavGroupCooldowns`)
  - Pridėtas patikrinimas prieš UAV sukūrimą, ar grupė neturi aktyvaus cooldown
  - Išsaugoma grupės informacija serverio pusėje su `uavGroupObjects` masyvu
  - Automatinis cooldown pradėjimas UAV sunaikinimo metu naudojant `fn_V2uavGroupRemove`

- **Fortifikacijų ištrynimo klaida**: Ištaisytas kritinis trūkumas fortifikacijų ištrynimo sistemoje, kai bandant ištrinti tranšėjas su pasirinkimu buvo meta klaida.
  - Pakeista neteisinga masyvo manipuliavimo sintaksė `fortifications_player = fortifications_player - [_nearestFort]` į teisingą `deleteAt` metodą
  - Pridėtas saugus objekto patikrinimas prieš `deleteVehicle` iškvietimą
  - Pakeistas artimiausios fortifikacijos paieškos algoritmas naudojant `_forEachIndex` vietoj tiesioginio elemento lyginimo
  - Ištaisytas limitų tikrinimo funkcijos (`fnc_checkFortLimits`) masyvo valdymas

### Optimizuota pagal SQF geriausių praktikų dokumentaciją
- **AI našumo optimizavimas**: Ištaisytos kritinės našumo problemos remiantis SQF_SYNTAX_BEST_PRACTICES.md dokumentacija
  - Pakeistas begalinis ciklas `for "_i" from 0 to 1 step 0 do` į aiškesnį `while {true} do` sintaksę
  - Pridėtas AI įstrigimo aptikimas su pozicijos delta stebėjimu vietoj nepapikimo `canMove` komandos
  - Sukurta nauja funkcija `fn_V2aiStuckCheck.sqf` įstrigimo aptikimui ir taisymui
  - Padidintas AI atnaujinimo ciklo intervalas nuo 30 iki 45 sekundžių
  - Optimizuotos `nearRoads` komandos - sumažinti spinduliai nuo 200->150 ir 30->20
  - Optimizuota `nearestLocations` - sumažintas spindulys nuo worldSize/2 iki worldSize/4
  - Įjungta Dinaminė Simuliacija tolimiems AI vienetams išjungti su atstumais: Group-1000m, Vehicle-2500m, EmptyVehicle-500m

### Pridėta
- **Fortifikacijų valdymo sistema**: Įgyvendintas fortifikacijų griovimo mechanizmas su limitais
  - Maksimalus kiekis: po 3 kiekvieno tipo fortifikacijas (Trench T, Trench Bunker, Trench Firing Position)
  - Automatinis seniausių ištrynimas viršijus limitą
  - Rankinis ištrynimas: lyderiai gali ištrinti artimiausią savo fortifikaciją (10m spindulys)
  - Pagerinta serverio našumas išvalant null objektus ir sugadintas fortifikacijas

### Pataisyta
- **autoStart.sqf**: Pašalintas 30 sekundžių laukimas prieš misijos pradžią
  - Pašalintas komentaras "// Wait 30 seconds to allow the server and players to initialize properly."
  - Pašalinta `sleep 30;` komanda
  - Misija dabar prasideda greičiau, iškart po žaidėjų inicializacijos
- **V2startServer.sqf**: Pataisyta kritinė klaida "Error Undefined variable in expression: plhe" ir "Error Undefined variable in expression: plhw" 964 eilutėje ir kitose vietose
  - Pataisyta klaida "Error Undefined variable in expression: _x" 411 eilutėje (anksčiau)
  - Pridėti `isNil` patikrinimai prieš naudojant `plHE` ir `plHW` kintamuosius
  - Pataisyta klaida, kai `plHE` arba `plHW` kintamieji nebuvo apibrėžti prieš jų naudojimą
  - Pridėti saugumo patikrinimai visose vietose, kur naudojami šie kintamieji:
    - Kintamųjų inicializacijoje (437-473 eilutės) - pridėti patikrinimai, kad `plHE` ir `plHW` būtų apibrėžti prieš juos naudojant `publicVariable`
    - Combat Support modulių pozicijose (477-483 eilutės)
    - Respawn pozicijose (517-549 eilutės) - pakeista logika, kad palyginimai būtų vykdomi tik jei kintamieji apibrėžti
    - Lėktuvų kūrime (551-592 eilutės)
    - Gunship kūrime (594-640 eilutės) - pakeista logika, kad palyginimai būtų vykdomi tik jei kintamieji apibrėžti
    - Flag kūrime (976-1013 eilutės) - pakeista logika, kad palyginimai būtų vykdomi tik jei kintamieji apibrėžti
  - Pakeista logika: vietoj ilgų `isNil` patikrinimų kiekvienoje sąlygoje, dabar naudojami lokalūs kintamieji `_plHWDefined`, `_plHEDefined`, `_planesCheck`, kurie patikrinami vieną kartą ir naudojami visur
- **fn_V2flagActions.sqf**: Jau turėjo `isNil` patikrinimus, bet patikrinta, kad jie veikia teisingai
- **V2aiStart.sqf**: Pataisyta kritinė klaida "Error Undefined variable in expression: plhw" 93 eilutėje
  - Pridėti `isNil` patikrinimai prieš naudojant `plHW` ir `plHE` kintamuosius
  - Pakeista logika: vietoj ilgų sąlygų su `isNil` patikrinimais, dabar naudojami lokalūs kintamieji `_plHWDefined` ir `_plHEDefined`
  - Pataisyta klaida, kai `plHW` arba `plHE` kintamieji nebuvo apibrėžti prieš jų naudojimą distance operacijose
  - Kintamieji dabar tikrinami tik jei jie apibrėžti, prieš juos naudojant
- **fn_V2uavRequest.sqf**: Pataisyta klaida, kai `plHW` ir `plHE` naudojami be patikrinimų (155, 176 eilutės)
  - Pridėti `isNil` patikrinimai prieš naudojant `plHW` ir `plHE` kintamuosius
  - Pridėti fallback pranešimai, jei aerodromai neapibrėžti
- **fn_V2aiVehicle.sqf**: Pataisyta klaida, kai `plHW` ir `plHE` naudojami be patikrinimų (312, 610 eilutės)
  - Pridėti `isNil` patikrinimai prieš naudojant `plHW` ir `plHE` kintamuosius
  - AI transporto priemonės dabar kuriamos tik jei aerodromai apibrėžti
- **fn_V2rearmVeh.sqf**: Pataisyta klaida, kai `plHW` ir `plHE` naudojami be patikrinimų (28, 29, 33, 34 eilutės)
  - Pridėti `isNil` patikrinimai prieš naudojant `plHW` ir `plHE` kintamuosius
  - Naudojami lokalūs kintamieji `_plHWDefined` ir `_plHEDefined` efektyvesniam kodo vykdymui
- **fn_V2aiCAS.sqf**: Pataisyta klaida, kai `plHW` ir `plHE` naudojami be patikrinimų (81, 130 eilutės)
  - Pridėti `isNil` patikrinimai prieš naudojant `plHW` ir `plHE` kintamuosius
  - CAS moduliai dabar nustato kryptį tik jei aerodromai apibrėžti
- **fn_V2entityKilled.sqf**: Pataisyta klaida, kai `plHW` ir `plHE` naudojami be patikrinimų (62, 69, 72, 79 eilutės)
  - Pridėti `isNil` patikrinimai prieš naudojant `plHW` ir `plHE` kintamuosius
  - Naudojami lokalūs kintamieji `_plHWDefined` ir `_plHEDefined` efektyvesniam kodo vykdymui
  - Transporto priemonės dabar respawninamos tik jei aerodromai apibrėžti
- **V2startServer.sqf**: Pataisyta kritinė klaida "Error Undefined variable in expression: _x" 406 eilutėje
  - Pridėti `isNil` patikrinimai prieš naudojant `plH1`, `plH2`, `plH3`, `plH4`, `plH5` kintamuosius
  - Pakeista logika: vietoj tiesioginio masyvo kūrimo, dabar patikriname ar kintamieji apibrėžti prieš juos pridedant
  - Pagerinta forEach ciklo logika: filtruojame masyvą, pašalindami nil arba neapibrėžtus elementus
  - Tai išsprendžia klaidą, kai `_x` kintamasis nebuvo pasiekiamas forEach cikle dėl nil elementų masyve
- **fn_V2flagActions.sqf**: Pataisyta kritinė klaida "Error Undefined variable in expression: plhe" 124 eilutėje
  - Pakeista logika: vietoj ilgų sąlygų su `isNil` patikrinimais, dabar naudojami lokalūs kintamieji `_plHWDefined`, `_plHEDefined`, `_planesCheck`
  - Palyginimai dabar vykdomi tik jei visi kintamieji apibrėžti, panašiai kaip V2startServer.sqf faile
  - Tai išsprendžia klaidą, kai `plHE` kintamasis buvo naudojamas palyginimuose net jei jis nebuvo apibrėžtas
- **fn_V2uavRequest.sqf**: Pataisyta kritinė klaida "Error Undefined variable in expression: _groupuavlocal" 134 eilutėje
  - Pakeista logika: pagal SQF geriausias praktikas, `spawn` sukuria izoliuotą apimtį, todėl reikia perduoti parametrus per `_this`
  - Pridėtas papildomas tikrinimas prieš sukurdamas naują UAV, kad apsaugotų nuo greitų paspaudimų
  - Tai išsprendžia klaidą, kai `_groupUavLocal` kintamasis nebuvo pasiekiamas `spawn` bloke
- **fn_V2uavGroupAdd.sqf**: Pridėtas papildomas tikrinimas serverio pusėje, kad apsaugotų nuo kelių UAV sukūrimo
  - Jei grupė jau turi aktyvų UAV, naujas UAV bus sunaikintas
  - Tai apsaugo nuo greitų užklausų, kurios gali sukurti kelis UAV vienu metu
- **V2aoCreate.sqf**: Pataisyta kritinė klaida, kai `nameBW1` ir `nameBE1` kintamieji nebuvo apibrėžti prieš jų naudojimą
  - Pridėtas `isNil` patikrinimas, kad kintamieji būtų apibrėžti tik jei jie dar neapibrėžti
  - Tai išsprendžia "Error Undefined variable in expression: namebwl" ir "Error Undefined variable in expression: namebel" klaidas
  - Misijos generavimas dabar turėtų veikti be klaidų
- **V2startServer.sqf**: Pridėtas laukimas iki misijos objektų (aerodromų) inicializacijos
  - Pridėta `waitUntil {sleep 1; !isNull plH1};` prieš "CLIENTS START SCRIPT" sekciją
  - Tai užtikrina, kad misijos objektai būtų inicializuoti prieš pradedant klientų skriptus
  - Išvengiama galimų klaidų, kai objektai dar nėra sukurti

### Paaiškinimas
- `nameBW1` ir `nameBE1` kintamieji naudojami 249, 300, 332, 370, 420, 452 eilutėse `V2aoCreate.sqf` faile
- Anksčiau šie kintamieji buvo apibrėžti tik `V2startServer.sqf` faile, bet tik po `V2aoCreate.sqf` vykdymo
- Dabar `V2aoCreate.sqf` pats apibrėžia šiuos kintamuosius, jei jie dar neapibrėžti, taip užtikrinant, kad jie visada būtų prieinami
- **Kritinis**: Jei `nameBW1` arba `nameBE1` nebuvo apibrėžti, kodas galėjo "crash'inti" ir stabdyti AO kūrimą, dėl ko `AOcreated` likdavo kaip `0` arba `2`, o `V2startServer.sqf` interpretuodavo tai kaip "failed to create AO"
- Pridėti saugumo patikrinimai `factionW`, `factionE` ir `missType` kintamiesiems, kad būtų užtikrinta, kad jie visada būtų apibrėžti prieš naudojimą

