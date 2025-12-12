# Changelog

## [Neišleistas] - 2025-01-XX

### v5.7 - 2025-12-11
- **IŠSPRĘSTA**: Runtime sintaksės klaida `enableArtillery` komandoje
  - **PRIEŽASTIS**: Dviejų PBO failų konfliktas:
    - `Documents\Arma 3\missions\XXX.swu_public_novogorsk_map.pbo` (pervadintas į `_OLD_BACKUP`)
    - `Steam\Arma 3\MPMissions\XXX.swu_public_novogorsk_map.pbo` (pervadintas į `_OBSOLETE_STEAM_BACKUP`)
  - **SPRENDIMAS**: Išvalyti visi seni PBO failai, pridėtas failo versijos identifikatorius
  - **DOKUMENTACIJA**: Vadovautasi `ANALYSIS_ARTILLERY.md` specifikacija dėl įgulos reikalavimo
- **PRIDĖTA**: Įgulos kūrimas artilerijos transporto priemonėms respawn atveju
  - West: `objArtiW` su `crewW` įgula (Gunner + Commander)
  - East: `objArtiE` su `crewE` įgula (Gunner + Commander)
- **PATAISYTA**: East artilerijos kintamieji ir funkcijos (hints ID: 19→20)
- **PATAISYTA**: `BIS_fnc_addSupportLink` iškvietimas respawn atveju
- **DERINIMAS**: Pridėtas unikalus failo identifikatorius `FILE_MARKER_V2aiVehicle_FOLDER_VERSION`

### Realistiškos Artilerijos Sistemos Įgyvendinimas
- **AI Artilerijos pertvarka**: Pakeista "Dievo akies" sistema realistiškesne spotter-based sistema
  - **PRIEŠ**: Sistema naudojo `allUnits` ir žinojo apie visus vienetus ant žemėlapio
  - **PO**: Sistema naudoja tik AI squad leader grupes kaip spotterius (žaidėjai nėra spotteriai)
  - **PRIVALUMAI**: Realistiškesnė žvalgyba, spotting paklaidos (±30m), galimybė "apakinti" artileriją
  - **FILTRAVIMAS**: Tik AI grupės su leader'iais (min 2 nariai), ne žaidėjų grupės
  - **KONFIGŪRACIJA**: Automatinis spotter grupių aptikimas (`V2_spotterGroupsW`, `V2_spotterGroupsE`)
  - **ATGAL SUDERINAMUMAS**: Jei nėra spotter grupių, sistema veikia kaip anksčiau

### Dokumentacijos atnaujinimai
- **ARTILLERY_SPOTTER_SYSTEM.md**: Naujas dokumentas apie realistišką artilerijos sistemą
- **Dokumentacijos validavimas**: Atlikta interneto paieška ir patikrintos kritinės techninės tezės
  - Patikslinta `waitUntil` terminologija: "server freeze" → "scheduler starvation"
  - Koreguota OnOwnerChange callback formato informacija
  - Paaiškinti skirtingi AI freeze problemų tipai
- **Dokumentacijos sistemingumas**: Standartizuoti versijų ir datų formatai visuose dokumentuose
- **README.md atnaujinimas**: Pridėtas JIP_FIX.md ir patikslinta legacy reference informacija
- **DEVELOPMENT_GUIDELINES.md v1.1**: Patobulintas SAFE while loops pavyzdys su konkrečia fallback logika vietoj komentarų

### Ištaisytos klaidos
- **Kritinis serverio optimizavimas**: AI transporto spawninimo ciklai optimizuoti, kad neapkrautų serverio
  - **PROBLEMA**: Serveris "lūždavo" su "f16 Overflow" klaida dėl per dažno (10 kartų per sekundę) visų vienetų tikrinimo `fn_V2aiVehicle.sqf` faile
  - **SPRENDIMAS**: Padidintas `sleep` intervalas nuo 0.1s iki 5s visuose bazės gynybos patikrinimo cikluose
  - **REZULTATAS**: Drastiškai sumažinta serverio apkrova ir tinklo srautas, išvengta "f16 Overflow" klaidų

- **Coop režimo balansas sutvarkytas**: AI parama dabar teikiama abiem pusėms nepriklausomai nuo žaidėjų skaičiaus
  - **PROBLEMA**: Coop režime AI parama buvo išjungiama žaidėjų pusei, kas sukeldavo disbalansą
  - **SPRENDIMAS**: Priverstinai nustatytas `coop = 0` (Balanced) režimas `fn_V2aiVehicle.sqf` ir `fn_V2dynamicAIon.sqf` failuose
  - **REZULTATAS**: Abi pusės visada gauna AI paramą, o balansas reguliuojamas dinamiškai pagal sektorių kontrolę (`AIon` lygis)

- **Teleportacija į bazes sutvarkyta**: Pašalintos sąlygos, kurios blokavo teleportaciją
  - **PROBLEMA**: Žaidėjai negalėjo teleportuotis į bazes per vėliavas dėl neteisingų sąlygų (`flgDel`, `sideA`)
  - **SPRENDIMAS**: Pašalintos sąlygos iš `addAction` komandų `fn_V2flagActions.sqf` faile
  - **REZULTATAS**: Teleportacijos veiksmai dabar visada matomi ir veikia

- **Vėliavų ir arsenalo sąveikos pataisytos JIP žaidėjams**: Sutvarkytas side inicializavimo laukimas
  - **PROBLEMA**: JIP (Join In Progress) ir respawn žaidėjai nematė vėliavų teleportacijos veiksmų ir negalėjo naudotis arsenalais dėl per greito timeout (30s) laukiant player side nustatymo
  - **SPRENDIMAS**:
    - `fn_V2flagActions.sqf`: Padidintas timeout iki 60 sekundžių su retry logika ir aiškiais įspėjimais
    - `V2startClient.sqf`: Arsenal inicializacija dabar laukia player side nustatymo su progress logais
  - **REZULTATAS**: Vėliavos ir arsenalai veikia visiems žaidėjams, įskaitant prisijungusius vėliau arba po respawn

- **Bazių pavadinimai suvienodinti**: Ištaisyta painiava tarp "Infantry", "Armor" ir "Transport" bazių
  - **PROBLEMA**: Bazių pavadinimai keitėsi priklausomai nuo misijos tipo, sukeldami painiavos (pvz., abi bazės vadinosi "Armor base")
  - **SPRENDIMAS**: `V2aoCreate.sqf` faile nustatyta, kad Bazė 1 visada yra "Transport base", o Bazė 2 - "Armor base"
  - **REZULTATAS**: Aiškesnis bazių identifikavimas žaidėjams

- **"Undefined variable" klaidos V2aoRespawn.sqf faile ištaisytos**:
  - **PROBLEMA**: Scriptas lūždavo dėl neapibrėžtų kintamųjų `_objDir`, `_res`, `_baseDirW2`
  - **SPRENDIMAS**: 
    - Pašalinti `_objDir` naudojimai, pakeisti matematiniais skaičiavimais
    - Pridėti saugumo patikrinimai `!isNil "_res"`
    - Apibrėžtas trūkstamas `_baseDirW2` kintamasis
  - **REZULTATAS**: Stabilus respawn sistemos veikimas

- **Transporto susidubliuojimas pataisytas**: BASE 2 dabar neturi transporto sraigtasparnio
  - **PROBLEMA**: Transporto bazėje (BASE 1) atsirado du transporto sraigtasparniai, kurių neturėtų būti. Armor bazėje (BASE 2) atsirado per daug technikos (dešimtys), o oro bazė dingo
  - **ANALIZĖ**: `V2aoRespawn.sqf` kuria transporto sraigtasparnius (HeliTrW/HeliTrE) abiejose bazėse - BASE 1 ir BASE 2 abi prideda pozicijas į tą patį rHeliTrW/rHeliTrE masyvą, todėl transporto bazėje atsiranda du sraigtasparniai. Taip pat pakeista logika, kad kiekvienam transportui masyve būtų kuriama atskira pozicija, sukėlė per daug technikos armor bazėje
  - **SPRENDIMAS**: BASE 2 neturi transporto sraigtasparnio visai - transporto sraigtasparniai turėtų būti tik BASE 1 (Transport base). Grįžta prie senos logikos - kiekvienam masyvui kuriama viena pozicija (ne kiekvienam transportui)
  - **PATAISYTA**: 
    - `V2aoRespawn.sqf`: Pridėtas missType inicializavimas ir patikrinimas
    - `V2aoRespawn.sqf`: WEST BASE 2 - naudojamas `[ArmorW1, ArmorW2]` (be HeliTrW), kiekvienam masyvui kuriama viena pozicija
    - `V2aoRespawn.sqf`: EAST BASE 2 - naudojamas `[ArmorE1, ArmorE2]` (be HeliTrE), kiekvienam masyvui kuriama viena pozicija
  - **REZULTATAS**: Dabar transporto bazėje (BASE 1) yra tik vienas transporto sraigtasparnis (nėra dubliavimosi), o armor bazėje (BASE 2) yra normalus kiekis technikos - po vieną poziciją kiekvienam masyvui (ArmorW1, ArmorW2). Oro bazė turėtų būti kuriama V2startServer.sqf, jei missType == 3

### Kritinis Serverio Užstrigimo Klaidos Ištaisymas
- **Server Scheduler Starvation Fix**: Ištaisyta kritinė problema dėl per daug aktyvių skriptų (152-257 vienu metu)
  - **PROBLEMA**: Serveris užstrigdavo dėl script scheduler starvation - base defense sistema spawnindavo custom Russian vienetus (RUS_spn_reconsniper, etc.) ir bandydavo pritaikyti vanilla Arma 3 loadout'us, sukeldama "Switch uniform!" ir "Trying to add inventory item with empty name" klaidas, kurios dauginosi į šimtus vienu metu veikiančių skriptų
  - **DIAGNOZĖ**: Interneto tyrimas patvirtino, kad šios klaidos nėra "nekaltos" - jos sukuria šimtus vienalaikių skriptų ir perpildo scheduler'į, ypač kai naudojami custom mod'ai su specialiais vienetų klasėmis
  - **SPRENDIMAS**:
    - `fn_V2loadoutChange.sqf`: Pridėtas custom vienetų aptikimas - praleidžia loadout keitimą vienetams kurių klasės prasideda "RUS_" arba "UA_" (jie turi savo loadout'us iš klasės konfigūracijų)
    - `fn_V2secDefense.sqf`: Panašus apsauginis mechanizmas base defense spawninimui - praleidžia loadout keitimą custom vienetams
    - Papildomi saugumo patikrinimai prieš `setUnitLoadout` iškvietimus (patikrina ar _gr nėra tuščias)
  - **REZULTATAS**: Išvengta uniformų/item'ų konfliktų, aktyvių skriptų skaičius išlieka normalus (<100), serverio užstrigimai išspręsti, ypač RU2025/RHS frakcijų misijose

### Žaidėjų Navigacijos Įrankių Aprūpinimas
- **Automatic Map & GPS Distribution**: Įgyvendinta automatine žemėlapių ir GPS išdavimo sistema žaidėjams
  - **PROBLEMA**: Žaidėjai neturėjo žemėlapių ir GPS misijos pradžioje arba po respawn'o, kas darė misiją neįmanomą žaisti (negalima matyti žemėlapio, tikslų, koordinates, navigacijos)
  - **SPRENDIMAS**:
    - `initPlayerLocal.sqf`: Pridėtas automatines žemėlapio ir GPS išdavimas misijos pradžioje
    - Respawn event handler: Žemėlapis ir GPS išduodami po kiekvieno respawn'o
    - Patikrinimas `assignedItems`: Išvengiama dubliavimo jei įrankiai jau yra
    - Išmanūs pranešimai: Žaidėjai informuojami tik jei gauna naujus įrankius
  - **REZULTATAS**: Visi žaidėjai (įskaitant JIP) turi žemėlapį ir GPS nuo misijos pradžios, pilna navigacija ir tikslų matymas užtikrintas

### Vėliavų Teleportacijos Sistemos Taisymas
- **Flag Teleport Bug Fix**: Ištaisyta teleportacija į tą pačią bazę vietoj pasirinktos paskirties
  - **PROBLEMA**: Žaidėjai teleportuodavosi į tą pačią bazę vietoj pasirinktos paskirties dėl trūkstamų sąlygų iš originalaus kodo
  - **DIAGNOZĖ**: Palyginus su originalia versija, trūko sąlygų `"(flgDel==0||sideA == sideW)"` ir `"(flgDel==0||sideA == sideE)"` teleportacijos veiksmams
  - **SPRENDIMAS**:
    - `fn_V2flagActions.sqf`: Pridėtos trūkstamos sąlygos teleportacijos veiksmams (WEST/EAST)
    - Išplėsta debug sistema su išsamiu log'inimu ir pozicijų sekimu
    - Pridėti įspėjimai jei teleportacija nepavyksta (žaidėjas lieka toje pačioje vietoje)
    - Pilnas teleportacijos proceso monitoring'as
  - **REZULTATAS**: Teleportacija į pasirinktas bazes veikia teisingai, pridėta diagnostika problemų identifikavimui

### AI Atgaivinimo Sistemos Taisymas
- **AI Revive System Fix**: Ištaisyta problema kai AI neprikeldavo žaidėjų būdami šalia
  - **PROBLEMA**: Žaidėjai gulėdavo INCAPACITATED būsenoje, nors AI būdavo šalia, bet neprikeldavo jų
  - **DIAGNOZĖ**: Trūko HandleDamage event handler nustatymo V2startClient.sqf faile - revive sistema nebuvo aktyvuojama kai revOn >= 2
  - **SPRENDIMAS**:
    - `warmachine/V2startClient.sqf`: Pridėtas HandleDamage event handler kai revOn >= 2
    - `functions/client/fn_plRevive.sqf`: Išplėsta debug sistema su išsamiu log'inimu
    - Event handler aktyvuoja custom revive logiką kai žaidėjas tampa incapacitated
    - Sistema randa artimiausią AI vienetą ir siunčia jį atgaivinti žaidėją
  - **REZULTATAS**: AI dabar prikelia žaidėjus kai yra šalia, pridėta diagnostika revive proceso sekimo

### Artilerijos Šaudymo Sistemos Taisymas
- **Artillery Firing Fix**: Ištaisyta problema kai artilerija rodė šaudymo logus, bet iš tikrųjų nešaudo
  - **PROBLEMA**: Custom Russian artilerijos vienetai (RUS_MSV_West_2s3m1, RUS_MSV_West_2s1) neturėjo įjungto artilerijos kompiuterio, todėl `doArtilleryFire` neveikė nepaisant logų
  - **DIAGNOZĖ**: Custom vienetai nebuvo konfigūruoti kaip artilerija - trūko `enableArtillery true` ir BIS_artilleryComputer kintamojo
  - **SPRENDIMAS**:
    - `fn_V2aiVehicle.sqf`: Pridėtas `enableArtillery true` ir BIS_artilleryComputer inicializavimas respawn metu
    - `warmachine/V2startServer.sqf`: Pridėtas artilerijos inicializavimas misijos pradžioje
    - Išplėsta debug sistema su ETA patikrinimu ir išsamiais logais apie artilerijos būklę
  - **REZULTATAS**: Artilerija dabar tikrai šaudo į taikinius, pridėta diagnostika gedimų identifikavimui

### Serverio Užstrigimo Klaidos Ištaisymas (Kritinis)
- **Server Crash Fix - Undefined Variable**: Ištaisyta kritinė serverio užstrigimo klaida dėl undefined `_friendlyUnits` kintamojo
  - **PROBLEMA**: Server crash'indavo dėl "Undefined variable in expression: _friendlyUnits" artilerijos funkcijoje, sukeldamas scheduler starvation su 267 aktyviais skriptais
  - **DIAGNOZĖ**: Artilerijos funkcija `_fnc_fireArti` tikėjosi `_friendlyUnits` parametro, bet kintamieji `_unitsW` ir `_unitsE` nebuvo apibrėžti pagrindinėje cikle
  - **SPRENDIMAS**:
    - `fn_V2aiArtillery.sqf`: Pridėti `_unitsW` ir `_unitsE` kintamųjų apibrėžimą pagrindinėje cikle
    - Kintamieji apibrėžiami kaip `allUnits select {alive _x && side _x == sideW/E}` saugumo patikrinimams
    - Pridėta debug log'inimas sekti artilerijos ciklo būklę
  - **REZULTATAS**: Server nebeužstringa dėl undefined kintamųjų, artilerijos sistema veikia stabiliai

### AI FPV Dronų Iššaukimo Sistema
- **AI FPV Drone Calling System**: Įgyvendinta AI squad leader'ių galimybė iškviesti FPV dronus
  - **PROBLEMA**: AI buvo per silpni prieš aukštos vertės taikinius (tankai, APC), žaidėjai dominavo technikos mūšiuose
  - **SPRENDIMAS**:
    - `fn_V2aiFPV.sqf`: AI dronų iššaukimo ir valdymo sistema
    - `fn_V2aiFPVLogic.sqf`: AI sprendimų logika kada kviesti dronus (taikinio vertė, atstumas, tikimybė)
    - Integracija su artilerijos sistema - dronai kaip alternatyva kai artilerija negali šaudyti
    - Trys drono režimai: kamikaze (aukštos vertės taikiniams), žvalgyba, parama
    - Grupės-based cooldown sistema (3 minutės tarp iškvietimų)
    - Faction ribojimai (tik Ukraine 2025 ir Russia 2025 turi FPV dronus)
  - **REZULTATAS**: AI tampa agresyvesni technikos mūšiuose, žaidėjai gauna įspėjimus apie AI dronus, pridėtas taktinio gylio

### Serverio Sintaksės Klaida Artillerijoje (Kritinis Taisymas)
- **Syntax Error Fix - Missing Semicolon**: Ištaisyta kritinė sintaksės klaida artilerijos respawn funkcijoje
  - **PROBLEMA**: "Error Missing ;" artilerijos vehicle funkcijoje dėl neteisingos kodo struktūros
  - **DIAGNOZĖ**:
    - Papildomas `};` uždarymo simbolis per anksti uždarė if bloką, palikdamas `createVehicle` iškvietimus už bloko ribų
    - `enableArtillery` komanda buvo iškviečiama už if-else bloko ribų, todėl galėjo būti iškviesta ant neegzistuojančio objekto
  - **SPRENDIMAS**:
    - `fn_V2aiVehicle.sqf`: Perstrukturizuota visa artilerijos respawn logika
    - Visi vehicle konfigūracijos iškvietimai (`enableArtillery`, `lockDriver`, etc.) perkelta į kiekvieną if-else šaką
    - Dabar kiekvienas konfigūracijos kodas vykdomas tik tada, kai vehicle buvo sėkmingai sukurtas
    - Taikyti tiek West (_par==9) tiek East (_par==10) artilerijos sekcijoms
  - **REZULTATAS**: Artilerijos respawn veikia be sintaksės klaidų, serveris nestabdo, vehicle konfigūracija garantuota

### Kodo Sintaksės Standartizacija (SQF_SYNTAX_BEST_PRACTICES.md Atitikimas)
- **Code Formatting Standardization**: Standartizuota visa kodo sintaksė pagal SQF_SYNTAX_BEST_PRACTICES.md reikalavimus
  - **PROBLEMA**: Nekonsistentiškas formatavimas, tarpų stygius aplink operatorius, neaiški kodo struktūra
  - **DIAGNOZĖ**:
    - Trūksta tarpų aplink operatorius (`if(_par==1)` vietoj `if (_par == 1)`)
    - Nekonsistentiškas kintamųjų deklaravimas (`_typ="";_tex=""` vietoj `_typ = ""; _tex = ""`)
    - Netvarkingi if statement'ai (`if(!alive aiVehW)exitWith{_liv=false;}`)
    - Capitalizacijos klaidos (`publicvariable` vietoj `publicVariable`)
    - Neteisingas masyvo elementų pasiekimas pozicijų masyvuose (`posArti param [0, 0]` vietoj `posArti select 0`)
  - **SPRENDIMAS**:
    - Standartizuoti visus operatorių tarpus pagal dokumentacijos rekomendacijas
    - Sulygiuoti kintamųjų deklaracijas ir funkcijų iškvietimus
    - Pataisyti if-else struktūrų formatavimą su teisingais tarpais ir skliaustais
    - Ištaisyti funkcijų pavadinimų capitalizaciją
    - Pakeisti `param` į `select` masyvo elementų pasiekimui pozicijų masyvuose (pagal dokumentacijos rekomendacijas)
    - Taikyti konsistentišką formatavimą visame faile
  - **REZULTATAS**: Kodas pilnai atitinka SQF_SYNTAX_BEST_PRACTICES.md standartus, pašalinti visi sintaksės pažeidimai, įskaitant teisingą masyvo elementų pasiekimą

### Cursor IDE Taisyklių Sistema (Integracija su Dokumentacija)
- **Cursor Rules System**: Sukurta išsami Cursor IDE taisyklių sistema SQF kūrimui
  - **PROBLEMA**: Nebuvo automatizuoto kodo validavimo pagal dokumentaciją ir interneto paiešką
  - **SPRENDIMAS**:
    - `.cursorrules`: Išsamių taisyklių sistema su 50+ validavimo pattern'ais
    - `.cursor/settings.json`: IDE nustatymai su interneto paieška ir AI pagalba
    - `.eslintrc.sqf.js`: ESLint konfigūracija SQF failams
    - `CURSOR_RULES_README.md`: Išsami naudojimo dokumentacija
    - Integracija su SQF_SYNTAX_BEST_PRACTICES.md visomis nuorodomis
  - **VALIDACIJOS TIPAI**:
    - Sintaksės klaidos (missing semicolons, brace matching)
    - Kodo formatavimas (operator spacing, capitalization)
    - Geriausios praktikos (safe array access, waitUntil timeout)
    - Dokumentacijos atitikimas (section references)
    - Interneto paieška sudėtingiems klausimams
    - AI pagalba kodu generavimui ir problemų sprendimui
  - **AUTO-FIX GALIMYBĖS**: Automatinis taisymas 10+ dažniausių klaidų tipų
  - **REZULTATAS**: Automatizuota kodo kokybės kontrolė, greitesnis development, mažiau klaidų
