# Ekspertinis Arma 3 SQF Scenarijų Rinkinio Auditas: Techninis Tikslumas ir Geriausios Praktikos

## Dokumentacijos šaltiniai
- [Arma 3 Community Wiki - Scripting](https://community.bistudio.com/wiki/Category:Scripting_Commands_Arma_3)
- [Bohemia Interactive Forums - Scripting Guides](https://forums.bohemia.net/forums/topic/229245-scripting-guides-tutorials-compilation-list/)
- [Arma 3 Scripting Commands](https://community.bistudio.com/wiki/Category:Scripting_Commands_Arma_3)

---

## I. Santrauka: Galutinis SQF Audito Standartas

Ši ataskaita pateikia išsamų techninį auditą, skirtą nustatyti techninius faktus ir geriausias praktikas, kurių privalo laikytis kūrėjai, dirbantys su "Arma 3" Real Virtuality variklio SQF (Status Quo Function) scenarijų kalba. SQF, išsivysčiusi iš senesnės SQS kalbos, yra galingas, tačiau sudėtingas įrankis, ypač modifikacijų ir misijų kūrimui. Kūrėjams būtina pripažinti, kad SQF turi griežtus vykdymo konteksto ir kintamųjų apimties reikalavimus, o neatitikimas šiems reikalavimams lemia nestabilumą ir prastą našumą.

Vienas kritiškiausių faktų, kurį turi įsisavinti "Arma 3" scenarijų kūrėjas, yra būtinybė visiškai modernizuoti tinklo komunikaciją. Tai reiškia absoliutų ir galutinį atsisakymą naudoti pasenusias tinklo vykdymo sistemas, tokias kaip BIS_fnc_MP, ir privalomą perėjimą prie šiuolaikinių remoteExec arba remoteExecCall komandų. Šis perėjimas nėra tik stiliaus klausimas, bet esminis reikalavimas stabilioms daugialypio žaidimo aplinkoms.

Techninės priežiūros auditas turėtų sutelkti dėmesį į tris pagrindinius našumo trūkumus: 1) Nepakankama tinklo sinchronizacija dėl pernelyg didelio globalių komandų ar kintamųjų naudojimo; 2) Tvarkyklės (Scheduler) perkrova, sukuriama per dažno ir neefektyvaus naujų gijų paleidimo naudojant spawn ir execVM; ir 3) Fundamentalios klaidos vykdymo konteksto valdyme, pavyzdžiui, bandymas naudoti sustabdymo komandas (sleep, waitUntil) aplinkoje, kuri nėra suplanuota. Nors SQF yra sėkmingai naudojama "Arma 3" platformoje, reikia nepamiršti, kad naujesnėje "Arma Reforger" ji jau pakeista Enforce Script kalba, o tai skatina naudoti kuo švaresnius ir modernesnius SQF kodavimo modelius, kad būtų palengvintas galimas ateities perkėlimas.

---

## II. Pamatinė SQF Semantika ir Sintaksė (Techniniai Faktai)

### A. SQF Architektūra ir Evoliucija

SQF yra iš esmės komandomis paremta kalba, pastatyta ant operatorių, kurie yra skirstomi į nuliarinius (Nular), vienetinius (Unary) ir dvejetainius (Binary). Skirtingai nei tradicinės objektinės programavimo kalbos, SQF funkcionalumą užtikrina šie operatoriai, veikiantys su įvairiais duomenų tipais. Ankstesnė kalba SQS (Status Quo Script) yra oficialiai pasenusi ir neturėtų būti naudojama misijų kūrimui nuo 2006 metų ("Armed Assault").

SQF kalbos dizainas yra paprastas, tačiau reikalauja tikslaus sintaksės laikymosi, nes variklis yra gana atlaidus klaidoms, kurios gali sukelti sunkiai aptinkamus šalutinius poveikius.

### B. Esminės Sintaksės Taisyklės

#### 1. Išraiškos Baigtis

Kiekviena SQF išraiška (komanda) turi būti užbaigta. Tai atliekama naudojant arba kabliataškį (;, tai yra labiausiai paplitusi ir rekomenduojama konvencija), arba kablelį (,). Yra kritiškai svarbu suprasti, kad eilučių lūžiai (line returns) neturi jokios įtakos kodo struktūrai ar vykdymui. Dėl šios priežasties kelios išraiškos gali būti įrašytos vienoje eilutėje, jei jos tinkamai atskirtos baigimo ženklais, nors tai nerekomenduojama dėl prastėjančio skaitomumo.

#### 2. Skliaustų Paskirtis

SQF sintaksėje skliaustai atlieka labai specifines funkcijas, kurias privalu atskirti:

- **Apvalūs skliaustai ()**: Naudojami pirmiausiai siekiant pakeisti numatytąją operatorių pirmumo tvarką arba tiesiog pagerinti kodo skaitomumą, aiškiai nurodant išraiškos dalių grupavimą.

- **Kvadratiniai skliaustai []**: Išskirtinai naudojami Array duomenų tipui apibrėžti.

- **Riečiamosios skliaustai {}**: Šie skliaustai apgaubia esminį Code Duomenų Tipą (vadinamuosius kodo blokus). Jie taip pat privalomi naudojant Valdymo Struktūras, tokias kaip if-then-else.

Faktas, kad {} apibrėžia Code duomenų tipą, yra esminis SQF programavimo kalbos bruožas. Tai reiškia, kad scenarijų blokai yra traktuojami kaip pirmos klasės duomenys, kuriuos galima perduoti kaip argumentus, vėliau vykdyti (call arba spawn) arba struktūriškai apdoroti. Šis funkcinis aspektas yra esminis misijų kūrimo elementas ir tiesiogiai lemia teisingą valdymo struktūrų ir funkcijų iškvietimų naudojimą. Nesuprantant Code kaip duomenų, neišvengiamai kyla neteisingo parametrų perdavimo ir apimties (scope) klaidų, ypač asinchroninio arba nuotolinio kodo vykdymo metu.

#### 3. Tarpai ir Komentarai

Variklis ignoruoja tarpus (įskaitant tabuliaciją ir tuščias eilutes) vykdymo metu. Tarpai ir komentarai tarnauja tik kodo skaitomumui ir ateities nuorodoms.

#### 4. Dažnos Sintaksės Klaidos ir Sprendimai

**"Error Missing ]" Klaida**: Ši klaida dažniausiai rodoma ne ten, kur yra tikroji problema. Ji atsiranda dėl neuždarytų masyvų arba sudėtingų string struktūrų aukščiau klaidos eilutės.

**Priežastys ir sprendimai:**
- **OnOwnerChange Callback'ai**: String formato callback'ai su sudėtingu escaping'u gali sukelti šią klaidą. **BIS sektorių moduliuose naudoti string formatą** (code block formatas nesuderinamas su BIS modulio sistema):
  ```sqf
  // NETEISINGA - gali sukelti "Error Missing ]":
  _sector setVariable ["OnOwnerChange", "
      if(getMarkerColor ''marker'' != '''') then { ... };
  "];

  // TEISINGA - code block formatas:
  _sector setVariable ["OnOwnerChange", {
      if(getMarkerColor 'marker' != '') then { ... };
  }];
  ```

- **String Escaping Problema**: Sudėtinguose string'uose su keliomis escaping lygiuotėmis gali atsirasti klaidų. Naudokite code block'us vietoj sudėtingų string'ų.

- **Masyvų Užbaigimas**: Visada patikrinkite, kad visi `[`, `(`, ir `{` turi atitinkamus uždarymo simbolius `]`, `)`, ir `}`.

### C. Duomenų Tipų Naudojimas ir Paruošimas

SQF palaiko platų duomenų tipų spektrą, įskaitant Array, Boolean, Code, Config, Object, Number, String, HashMap ir specializuotus tipus, tokius kaip Position (Vector3D). Patyrę kūrėjai naudoja HashMap kaip pažengusį duomenų tipą efektyviam raktų-verčių saugojimui, o tai ypač svarbu sudėtingiems misijų rėmams.

Kitas svarbus faktas susijęs su failų apdorojimu. Nors preprocessFile yra būtinas makrokomandų (pvz., #include) išplėtimui, techninė analizė rodo, kad tarp loadFile, preprocessFile ir preprocessFileLineNumbers yra nedideli, bet matuojami našumo skirtumai. loadFile yra šiek tiek greitesnis, nes jis neatlieka papildomų išankstinio apdorojimo veiksmų (makrokomandų ir eilučių numerių apdorojimo). Dėl šios priežasties, jei failas turi būti greitai nuskaitomas be preprocesoriaus išplėtimo, loadFile suteikia subtilų optimizavimo pranašumą, ypač didelio dažnio įkėlimo operacijoms.

---

## III. Kintamųjų Apimtis, Deklaravimas ir Kintamumas

Kintamųjų apimties valdymas yra bene labiausiai klaidinantis ir kritiškiausias SQF aspektas. Netinkamas apimties valdymas tiesiogiai sukelia kritines scenarijų klaidas ir netinkamą tinklo komunikacijos modelį.

### A. Dvi Esminės Apimties Aplinkos

SQF kalba iš esmės veikia dviejose kintamųjų apimties paradigmose:

#### 1. Sluoksniuota (Inheriting) Apimtis

Šią apimtį sukuria Valdymo Struktūros (if, switch, while, forEach, waitUntil, try) ir call operatorius. Naujos apimtys yra dedamos ant esamos apimties, leidžiančios naujai apimtyje pasiekti tėvinių apimčių privačius kintamuosius, nebent jie būtų perrašyti.

#### 2. Izoliuota (Non-Inheriting) Apimtis

Šią apimtį sukuria asinchroninio vykdymo metodai: spawn ir execVM, taip pat įvykių tvarkyklės (Event Handlers). Šios apimtys yra visiškai naujos ir izoliuotos; jos neperima jokių privačių kintamųjų iš jas iškviečiančio kodo. Jos prasideda su visiškai tuščia privačių kintamųjų erdve, išskyrus įterptą _this parametrą, naudojamą argumentams perduoti.

### B. Privačių Kintamųjų Taisyklės

#### 1. Deklaravimas ir Prieiga

Privatūs kintamieji, kurie yra matomi tik lokaliai, privalo būti žymimi pabraukimo ženklu (_).

Kai SQF kodas bando perskaityti ar atnaujinti privatų kintamąjį (pvz., _num = 10), variklis ieško kintamojo per apimties sluoksnių kaminą, pradedant nuo viršutinės (dabartinės) apimties ir judėdamas žemyn. Kintamasis yra atnaujinamas toje apimtyje, kurioje jis buvo pirmą kartą rastas. Jei jis nerandamas, jis sukuriamas dabartinėje (viršutinėje) apimtyje.

#### 2. Privalomas Inicializavimo Pavojus

Vienas dažnas programavimo klaidas sukeliantis faktas yra tai, kad privatūs kintamieji, kurie vėliau naudojami scenarijuje, turi būti inicializuoti už kontrolinio bloko ribų, net jei jie vėliau nustatomi tame bloke. Pavyzdžiui, jei kintamasis yra apibrėžtas tik if sąlygoje, ir ta sąlyga netampa true, kintamasis neegzistuos scenarijaus apimtyje pasibaigus if blokui. Štai kodėl private _living = false; turėtų būti nustatytas prieš if (alive player) then { _living = true; };. Kitu atveju, bandymas prieiti prie kintamojo po kontrolinio bloko sukels vykdymo klaidą.

Speciali taisyklė galioja private raktažodžiui ir params komandai: jie visada sukuria privatų kintamąjį tik dabartinėje apimtyje, ignoruodami standartinį paieškos mechanizmą apimties kamine.

#### 3. Saugus Neapibrėžtų Kintamųjų Valdymas

**Svarbu suprasti**: Komandos `isNil` ir `typeName` yra saugios naudoti su neapibrėžtais kintamaisiais. `isNil` grąžina `true`, jei kintamasis yra neapibrėžtas, o `typeName` grąžina `"NOTHING"` neapibrėžtam kintamajam, ir abu nekelia klaidų.

Tačiau **kritiškai svarbu** yra tai, kad kintamieji turi būti inicializuoti prieš naudojant juos **bet kurioje kitose operacijose** (pvz., masyvo elementų pasiekimas, funkcijų iškvietimai, aritmetinės operacijos). Pavyzdžiui:

```sqf
// TEISINGA - isNil yra saugus su neapibrėžtu kintamuoju
if (isNil "_myVar") then {
    _myVar = 0; // Inicializuojame, jei neapibrėžtas
};

// KLAIDA - bandymas naudoti neapibrėžtą kintamąjį kitose operacijose
_myVar = _myVar + 1; // Jei _myVar nebuvo inicializuotas aukščiau, tai sukels klaidą
```

**Saugus Masyvų Elementų Pasiekimas**: Naudojant `param` funkciją vietoj `select` yra rekomenduojama praktika, nes `param` leidžia nurodyti numatytąją reikšmę, jei indeksas neegzistuoja:

```sqf
// NETEISINGA - select sukels klaidą, jei indeksas neegzistuoja
_myValue = _myArray select 5; // Klaida, jei masyvas turi mažiau nei 6 elementų

// TEISINGA - param grąžina numatytąją reikšmę, jei indeksas neegzistuoja
_myValue = _myArray param [5, nil]; // Grąžina nil, jei indeksas neegzistuoja
if (!isNil "_myValue") then {
    // Naudojame _myValue
};
```

**Praktinė Rekomendacija**: Visada inicializuokite kintamuosius su numatytomis reikšmėmis prieš bet kokius patikrinimus ar naudojimą, ypač jei jie gali būti naudojami skirtingose kodo vietose. Tai užtikrina, kad kodas veiktų net jei kontrolinio bloko sąlyga netampa true.

### C. Apimties Izoliacijos Įtaka

Kadangi spawn ir execVM sukuria visiškai izoliuotas apimtis, jie negali tiesiogiai pasiekti kodo, kuris juos iškvietė, privačių kintamųjų. Tai reikalauja, kad visi reikalingi duomenys būtų perduodami per _this kintamąjį arba parametrų masyvą paleidžiant suplanuotą scenarijų. Nesugebėjimas teisingai perduoti parametrų sukelia nenustatytų kintamųjų klaidas iškviestame scenarijuje.

Ši izoliacija sukuria esminę problemą, kurią privalo spręsti gerai suplanuotas kodas. call operatorius (sluoksniuota apimtis) leidžia lengvai pasiekti tėvinius privačius kintamuosius, o tai yra patogu, bet kelia netyčinio "apimties nutekėjimo" riziką, jei giliai įdėta funkcija pakeičia kintamąjį, kurio neturėjo liesti. Priešingai, spawn (izoliuota apimtis) apsaugo nuo nutekėjimo, bet reikalauja griežto parametrų perdavimo mechanizmo, kuris padidina kodo apimtį.

Ekspertinis požiūris diktuoja naudoti call trumpiems, nuosekliems naudingumo metodams, o spawn – visiems ilgai trunkantiems, asinchroniniams ar misijai kritiškiems procesams, kad būtų užtikrinta funkcijų inkapsuliacija ir išvengta apimties užteršimo.

### D. Globalių Kintamųjų Naudojimas ir Tinklas

Globalūs kintamieji (be _ prefikso) yra matomi visoje misijos vardų erdvėje.

**Kritinis Tinklo Apribojimas**: Lokalus kintamasis (pvz., _myLocalVariable) negali būti transliuojamas tiesiogiai naudojant publicVariable "_myLocalVariable". Jo vertė pirmiausia turi būti priskirta Globaliam kintamajam, kuris vėliau transliuojamas: GlobalVariable = _myLocalVariable; publicVariable "GlobalVariable";.

Šis faktas tiesiogiai jungia kintamųjų apimties valdymą su tinklo našumu. Jei kūrėjas vengia tinkamai naudoti privačius kintamuosius ir remiasi globaliais kintamaisiais komunikacijai tarp gijų (dėl sudėtingumo tvarkant izoliuotas apimtis), jis yra priverstas naudoti publicVariable. Tai įveda nereikalingą tinklo srautą ir sinchronizavimo vėlavimus, sukeldamas našumo problemas. Taigi, prastas apimties valdymas yra tiesioginė tinklo apkrovos priežastis daugialypio žaidimo aplinkose.

---

## IV. Scenarijų Vykdymo Modeliai: Suplanuota vs. Nesuplanuota Aplinka

SQF vykdymo efektyvumas priklauso nuo tinkamo scriptų vykdymo konteksto pasirinkimo. Šis pasirinkimas tiesiogiai lemia, ar scenarijus gali naudoti sustabdymo komandas ir kiek jis apkraus variklio procesorių.

### A. Arma Scenarijų Tvarkyklė

Tvarkyklė valdo lygiagretų scenarijų vykdymą, suteikdama pirmenybę tiems scenarijams, kurie ilgiausiai laukė nuo paskutinio sustabdymo.

Naujas scenarijus, paleistas per spawn, execVM, exec ar execFSM, pridedamas prie šios tvarkyklės ir vykdomas per neblokuojančius "posūkius". Baigti scenarijai pašalinami, o nebaigti per skirtą laiką sustabdomi.

### B. Sustabdymo Būtinybė: Absoliutus Faktas

Sustabdymo komandos – sleep, uiSleep ir waitUntil – yra esminės scenarijų, reikalaujančių laiko delsos ar laukimo, funkcionavimui.

**ABSOLIUČI TAI SYKLĖ**: Sustabdymas yra visiškai draudžiamas nesuplanuotoje (blokuojančioje) aplinkoje. Bet koks bandymas naudoti šias komandas nesuplanuotame kode (pvz., kode, iškviestame per call, arba tiesiogiai objektų init lauke, jei nėra naudojama spawn/execVM) baigsis kritine klaida.

### C. Nesuplanuotos Aplinkos Apribojimai

Nesuplanuotas kodas vykdomas sinchroniškai ir blokuoja kviečiantį procesą iki baigties. Tai reiškia, kad ilgos operacijos vienoje nesuplanuotoje gijoje gali sukelti variklio sustojimą arba stiprų kadrų dažnio kritimą.

- **while Ciklo Riba**: Siekiant užkirsti kelią variklio užšalimui, while kilpos, vykdomos nesuplanuotoje aplinkoje, yra apribotos iki griežtai užkoduotos 10 000 iteracijų ribos.

### D. Našumo Degradacija Dėl Perteklinių Gijų

Nors suplanuota aplinka leidžia naudoti sustabdymą ir užtikrina lygiagretų vykdymą, esminė našumo kliūtis misijose yra šimtai gijų tvarkyklėje, kurios susidaro dėl dažno ir nekontroliuojamo spawn ir execVM naudojimo. Gijų valdymo pridėtinės išlaidos galiausiai nusveria lygiagretumo privalumus, mažindamos bendrą procesoriaus našumą.

Taip pat žalinga yra vykdyti ištekliams imlų kodą, pvz., ilgus for ciklus, už tvarkyklės ribų (nesuplanuotoje, blokuojančioje aplinkoje), nes tai monopolizuoja vieną vykdymo giją.

Konteksto Valdymas su waitUntil

Komanda waitUntil reikalauja suplanuotos aplinkos, nes tai yra sustabdymo operacija. Ji leidžia scenarijui laukti, kol sąlyga taps true, arba kol baigsis kitas scenarijus (naudojant scriptHandle). Jei scenarijus turi sinchronizuoti su išoriniu įvykiu arba periodiškai tikrinti būklę, jis privalo būti paleistas naudojant spawn arba execVM.

Sistemingas požiūris į našumo optimizavimą diktuoja, kad kūrėjai neturėtų ieškoti stebuklingo sprendimo tūkstančiams dirbtinio intelekto vienetų, veikiančių 240 kadrų per sekundę greičiu; vietoj to, saikas yra raktas. Tai reiškia, kad vietoj dešimčių trumpalaikių suplanuotų scenarijų, geriausia sujungti pasikartojančius, lengvus patikrinimus į vieną, efektyvią while true do kilpą, veikiančią vienoje gijoje.

**Lentelė I: Suplanuoto ir Nesuplanuoto Vykdymo Palyginimas**

| Ypatybė | Suplanuota Aplinka (pvz., spawn, execVM) | Nesuplanuota Aplinka (pvz., call, init laukas) | Šaltinis |
|---------|------------------------------------------|-----------------------------------------------|----------|
| Vykdymo Eiga | Asinchroninė; veikia lygiagrečiai posūkiais; atleidžia kontrolę. | Sinchroninė; blokuoja kviečiantį kodą iki baigties. | |
| Sustabdymo Komandos | Leidžiamos (sleep, waitUntil, uiSleep). | Draudžiamos (sukelia kritinę klaidos išeitį). | |
| Kintamojo Apimtis | Izoliuota apimtis (nepasiekiama kviečiančio kodo privatiems kintamiesiems). | Sluoksniuota apimtis (pasiekia ir kuria privačius kintamuosius apimties kamine). | |
| Našumo Poveikis | Per didelis gijų kiekis (šimtai) mažina tvarkyklės efektyvumą. | Blokuojantis kodas; while kilpos apribotos iki 10 000 iteracijų. | |

---

## V. Aukšto Našumo Kodavimo Praktikos ir Optimizavimas

Optimalus SQF kodas turi būti ne tik veikiantis, bet ir lengvai skaitomas, prižiūrimas bei efektyvus procesoriaus ir tinklo atžvilgiu.

### A. Kodo Skaitomumo ir Priežiūros Standartai

SQF bendruomenės standartai aiškiai pirmenybę teikia kodo skaitomumui ir prieinamumui.

- **Kintamųjų Pavadinimai**: Kintamieji ir funkcijos turi turėti prasmingus pavadinimus (pvz., _uniform vietoje _u). Nors kintamųjų pavadinimo ilgis turi nereikšmingą įtaką SQF našumui, tai neturi nusverti fakto, kad kodas turi būti skaitomas žmogui. _i yra išimtis, priimta kaip įprastas iteracijos kintamojo pavadinimas for cikluose.

- **Raidžių Stilius**: Rekomenduojama naudoti "Camel-casing" (pvz., namingLikeThis) kintamiesiems ir funkcijoms, nes tai padidina ilgų pavadinimų skaitomumą.

- **Struktūrizavimas**: Naudojant tinkamus tarpus ir tarpinius rezultatus (pvz., sudėtingus masyvo pasirinkimus priskiriant aprašomiesiems privatiems kintamiesiems) žymiai pagerėja kodo supratimas ir audito galimybė. Pavyzdžiui, sudėtinga filtracija tampa skaitomesnė ir lengviau sekama, kai ji suskaidoma į logiškus etapus.

Švarus ir prižiūrimas kodas yra lengviau audituojamas. Tai reiškia, kad geras kodo stilius yra ne tik estetinė, bet ir kritinė optimizavimo priemonė, nes lengviau nustatyti ir refaktoruoti našumo kliūtis.

### B. Ciklų ir Masyvų Optimizavimas

Audituojant senesnius scenarijus, ypač tuos, kurie konvertuojami iš ankstesnių "Arma" variklio versijų, būtina peržiūrėti komandų naudojimą.

Modernios Masyvų Iteracijos: Paprastos forEach kilpos, priklausomai nuo situacijos, turėtų būti pakeistos į optimizuotas, įmontuotas masyvų funkcijas: apply, count, findIf ir select. Pavyzdžiui, naudojant vieną select komandą, skirtą masyvo filtravimui, vietoj rankinės forEach iteracijos, dažnai sumažinamos vykdymo išlaidos ir pagerinamas aiškumas.

### C. Variklio Resursų Valdymas

Intensyviai išteklius vartojančios komandos, ypač dažnai vykdomose kilpose, turi būti naudojamos minimaliai. Techninė dokumentacija konkrečiai pabrėžia, kad nearObjects ir nearestObjects žymiai padidina procesoriaus apkrovą, kai naudojami per daug. Šios komandos turėtų būti naudojamos taupiai ir, jei įmanoma, pakeistos efektyvesniais ar riboto spindulio patikrinimais.

### D. Derinimo (Debugging) Kliūtys

Viena dažna, su aplinka susijusi klaida yra ta, kad "Windows File Explorer" slepia failų plėtinius, dėl ko kūrėjai netyčia sukuria neteisingai pavadintus konfigūracijos failus (pvz., Description.ext.txt vietoj Description.ext). Kadangi variklis neatpažįsta neteisingos plėtinio, misijos konfigūracijos nepavyksta įkelti. Kūrėjai visada turi užtikrinti, kad failų plėtiniai būtų matomi ir teisingai pavadinti.

---

## VI. Daugialypio Žaidimo Tinklo Architektūra ir Nuotolinis Vykdymas

Tinklo optimizavimas yra svarbiausias veiksnys užtikrinant misijos stabilumą ir našumą "Arma 3" platformoje. Auditavimo metu būtina griežtai laikytis naujausių tinklo protokolų.

### A. Absoliutus Tinklo Komunikacijos Mandatas

**FAKTAS**: Visiems nuotoliniams komandų vykdymams "Arma 3" misijose privaloma naudoti remoteExec arba remoteExecCall.

**KRITINIS REIKALAVIMAS**: Kūrėjams privaloma „VISIŠKAI ATMESTI BIS_fnc_MP!". Ši komanda, paveldėta iš "Arma 2" tinklo sistemos, yra pasenusi ir sukelia kritiškai blogą našumą bei stabilumo problemas "Arma 3" aplinkoje. Bet koks scenarijus, kuriame vis dar naudojama BIS_fnc_MP, turėtų būti vertinamas kaip neatitinkantis šiuolaikinių "Arma 3" geriausių praktikų ir keliančios grėsmę misijos stabilumui.

Šis agresyvus raginimas atsisakyti BIS_fnc_MP signalizuoja apie esminį technologinio pagrindo pasikeitimą tarp "Arma 2" ir "Arma 3" variklių, todėl senoji funkcija yra visiškai nesuderinama su optimizuota "Arma 3" tinklo architektūra.

### B. Nuotolinio Vykdymo Protokolai

- **remoteExec**: Atlieka kodo vykdymą asinchroniškai, neblokuojant kviečiančios gijos, nurodytuose klientuose, serveryje ar visose mašinose. Tai yra standartinis, neblokuojantis nuotolinio kodo paleidimo metodas.

- **remoteExecCall**: Atlieka kodo vykdymą sinchroniškai, reikalaujant grąžinamosios vertės iš nuotolinės mašinos. Ši komanda turėtų būti naudojama labai retai ir tik tuomet, kai grąžinamoji vertė yra būtina, nes sinchroniniai tinklo iškvietimai sukuria latentinio blokavimo riziką.

### C. Tinklo Apkrovos Optimizavimas

Sėkmingas optimizavimas daugialypio žaidimo aplinkoje reikalauja, kad kūrėjas ne tik pasirinktų teisingą komandą, bet ir minimizuotų tinklo siunčiamų duomenų kiekį ir dažnumą.

#### 1. Globalių Komandų Apribojimas

Globalios komandos, kurios sinchronizuoja padėtį ar būseną visiems klientams (pvz., setPos), turi būti naudojamos minimaliai. Nuolatinis pozicijos atnaujinimas yra labai brangus tinklo atžvilgiu. Jei reikalingas dažnas objekto judėjimas, verta apsvarstyti alternatyvas, tokias kaip attachTo, priklausomai nuo tikslo.

#### 2. Kintamųjų Transliacija

Nors publicVariable yra reikalinga globalių kintamųjų transliacijai , ji turi būti naudojama tikslingai. Siekiant sumažinti nereikalingą klientų apdorojimą ir tinklo srautą, geriausia naudoti specifinius variantus: publicVariableServer (transliacija tik serveriui) arba publicVariableClient (transliacija konkrečiam klientui).

#### 3. Žymeklių Optimizavimas

Globalios žymeklių komandos visada siunčia visą žymeklio informaciją kiekvieno atnaujinimo metu. Jei žymekliai keičiami dažnai (pvz., serverio pusėje), geriausia praktika yra redaguoti juos lokaliai. Tik po visų pakeitimų atliekama viena globali komanda, sinchronizuojanti visą galutinę žymeklio būseną tinkle, užuot siuntus daugybę mažų atnaujinimų per tinklą.

#### 4. Kliento Matymo Atstumas

Nors tai misijos ir kliento nustatymas, mažinant kliento matymo atstumą, sumažėja prašymų atnaujinti objektų pozicijas skaičius, tiesiogiai palengvinant tinklo apkrovą. Tinklo optimizavimas yra decentralizuotas: jis apima ne tik tai, kas siunčiama, bet ir kam siunčiama bei kokiu dažnumu.

**Lentelė II: Arma 3 Tinklo Komunikacijos Komandų Hierarchija**

| Funkcija | Būsena Arma 3 | Geriausia Praktika / Panaudojimas | Šaltinis |
|----------|---------------|-----------------------------------|----------|
| remoteExec | Rekomenduojamas Standartas | Asinchroninis, neblokuojantis kodo vykdymas nurodytose mašinose. | |
| remoteExecCall | Rekomenduojama (Sąlyginai) | Sinchroninis vykdymas; naudingas, kai kritiškai svarbi grąžinamoji vertė. Naudoti taupiai. | |
| BIS_fnc_MP | Pasenusi/Draudžiama | Palikimas iš Arma 2; sukelia rimtas našumo ir stabilumo problemas. | |
| publicVariable | Naudoti Tausojant | Paprasta, neapibrėžta globalaus kintamojo transliacija. Pageidautina naudoti tikslingesnius variantus. | |
| publicVariableServer | Pageidaujama Alternatyva | Tiesioginė transliacija tik serveriui. | |
| publicVariableClient | Pageidaujama Alternatyva | Tiesioginė transliacija tik nurodytam klientui. | |

---

## VII. Išsamus Techninės Analizės Pranešimas apie Nuolatinius Dirbtinio Intelekto Gedimus ir Desinchronizaciją „Arma 3" Daugelio Žaidėjų Režime: SQF ir Variklio Klaidas Mažinančios Strategijos

Šis dokumentas skirtas detalizuoti dažniausias dirbtinio intelekto (DI) strigčių, „nematomumo" ir dalinės funkcionalumo praradimo priežastis „Arma 3" daugelio žaidėjų aplinkoje. Analizė apima „ArmA" variklio apribojimus, netinkamos SQF kodo praktikos įtaką ir kritinės tinklo bei DI vietinės (locality) konfigūracijos svarbą.

### I. Esminė Veikimo Analizė: Užburtas Žemo Serverio FPS ir Desinchronizacijos Rato

„Arma 3" stabilumas daugelio žaidėjų režime tiesiogiai priklauso nuo serverio simuliacijos ciklo (Server FPS). DI strigtys ir kitos anomalijos, tokios kaip lėktuvo sustojimas ore, yra ne DI klaidų, o kritiškai sumažėjusios serverio našumo pasekmė.

#### A. „ArmA" Variklio Vykdymo Modelis: Suplanuota, Nesuplanuota ir Simuliacijos Kadras

Variklio stabilumui būtina suprasti, kaip skriptai sąveikauja su simuliacijos kadru per dvi pagrindines vykdymo aplinkas.

##### 1. Suplanuota Aplinka (Scheduled Environment)

Skriptai, paleisti komandomis, tokiomis kaip spawn ar execVM, veikia suplanuotoje aplinkoje. Ši aplinka taiko griežtą 3 milisekundžių (ms) vykdymo trukmės limitą. Jei skriptas viršija šį laiką, jis sustabdomas (yields) ir atidedamas vėlesniam vykdymui, kad kitos sistemos (įskaitant DI skaičiavimus ir fizikos atnaujinimus) gautų laiko. Šioje aplinkoje leidžiama naudoti atidėjimo komandas, tokias kaip sleep ir waitUntil.

##### 2. Nesuplanuota Aplinka (Unscheduled Environment)

Nesuplanuotoje aplinkoje vykdomas kritinis kodas, pavyzdžiui, įvykių tvarkyklės (Event Handlers) arba CBA Per Frame Handlers (PFHs). Šie skriptai veikia linijiniu būdu ir privalo būti užbaigti per vieną simuliacijos kadrą. Jiems netaikomi trukmės apribojimai, tačiau privaloma pabrėžti, kad sustabdymo komandos (sleep, waitUntil) šioje aplinkoje yra griežtai draudžiamos, nes jos tiesiogiai užblokuotų simuliacijos kadrą, sukeldamos serverio strigimą (frame-stall).

##### 3. Simuliatoriaus Išsekimo Mechanizmas (Scheduler Starvation)

Kritiškai svarbu suvokti, kad serverio našumo žlugimas dažnai kyla iš suplanuotos aplinkos perkrovos. Per didelis skaičius gijų, sukurtų naudojant spawn ir execVM, užpildo suplanuotą gijų eilę. Jei šios gijos vykdo neoptimizuotus, ilgai trunkančius ciklus be pakankamo atidėjimo (sleep), jos nuolat eikvoja savo 3ms laiko dalį. Šis gijų eilės prisotinimas atideda variklio gebėjimą atlikti visus būtinus simuliacijos atnaujinimus, įskaitant DI judėjimą, fizikos patikras ir tinklo apdorojimą. Šio proceso rezultatas yra tiesioginis serverio simuliacijos greičio (Server FPS) kritimas, kuris vėliau pasireiškia kaip DI mikčiojimas, teleportavimas ir objektų sustojimas ore – tai paaiškina vartotojo aprašytą „užšalusio lėktuvo" scenarijų.

#### B. Serverio Simuliacijos Kadro Dažnis (Server FPS) ir DI Integritetas

Serverio FPS yra esminis veikimo rodiklis. Jis nustato, kaip dažnai serveris apdoroja pasaulio būseną ir siunčia atnaujimus klientams.

##### 1. Kritinės Slenksčio Reikšmės

Serveris, veikiantis maždaug 15 FPS, yra laikomas minimaliai žaidžiamu, tačiau DI atsakas jau yra pastebimai prastas. Ideali situacija – palaikyti 20 FPS ar aukštesnį serverio simuliacijos greitį. Kai serverio FPS nukrenta iki kritiškai žemo lygio (pvz., 1-10 FPS), serveris yra laikomas perkrautu. Tokio apkrovimo metu DI pradeda mikčioti, teleportuotis arba tampa nereaguojantis, padarant žaidimą neįmanomą.

##### 2. Sinchronizacijos Užstrigimas

DI anomalijos ir sustoję objektai dažnai kyla dėl sinchronizacijos trūkumo tarp serverio autoritetingos būsenos ir kliento numatomos būsenos. Kadangi „ArmA" variklis sinchronizuoja kliento ekrano atvaizdavimo kadrą su simuliacijos apdorojimo ciklu, žemas Serverio FPS reiškia, kad serverio pasaulio būsena smarkiai atsilieka nuo kliento. Klientas privalo sparčiai koreguoti savo vietinę simuliaciją, kai pavėluoti duomenys pagaliau pasiekia. Šios korekcijos pasireiškia kaip desinchronizacija ir teleportavimas. Tai paaiškina, kodėl dalis DI gali atrodyti „nematoma" arba sustingusi: kliento vietinis vaizdas ir serverio tikroji autoritetinga pozicija smarkiai išsiskiria.

#### C. Pagrindiniai Serverio Apkrovos Šaltiniai (CPU Viršutinės Išlaidos)

Aukštos serverio apkrovos prisideda prie Server FPS kritimo. Tai kyla dėl intensyvių skaičiavimo poreikių, kuriuos sukelia tam tikros variklio ypatybės:

- Fizinių Objektų Perteklius: Per didelis fizika pagrįstų objektų, ypač transporto priemonių nuolaužų, skaičius žymiai padidina serverio skaičiavimo apkrovą.
- Brangios Komandos: Dažnas ir neapgalvotas komandų, tokių kaip nearObjects ir ypač nearestObjects, naudojimas yra pagrindinis CPU našumo žudikas.

### II. Pažangi SQF Kodo Optimizacija ir Simuliatoriaus Valdymas

Prastai parašyti SQF skriptai yra dažniausia nestabilumo ir serverio FPS kritimo priežastis daugelio žaidėjų misijose. Optimizacija turi būti orientuota į skripto inicijavimą, kintamųjų apibrėžimą ir masyvo apdorojimą.

#### A. SQF Gerosios Praktikos Didelio Našumo Aplinkoje

Norint išlaikyti simuliatoriaus sveikatą, būtina atsisakyti neefektyvių programavimo įpročių.

- Išankstinis Kompiliavimas Prieš execVM: Dažnai paleidžiant tą patį skriptą per execVM, žaidimas priverstas kiekvieną kartą nuskaityti failą iš disko, kas sukuria didelį I/O ir vykdymo režijos (overhead).
- Mažinimas: Skriptą reikia kompiliuoti vieną kartą misijos inicijavimo metu (pvz., `cm​yFunction=compilepreprocessFileLineNumbers"myFile.sqf";). Vėliau skambinti tik šiam kompiliuotam kintamajam.
- Kintamųjų Aprėptis (Scoping): Būtina naudoti privačius (lokalius) kintamuosius, kurie žymimi pabraukimo ženklu (pvz., _uniform), kiek tik įmanoma, vietoj globalių kintamųjų. Tai sumažina kintamojo ieškojimo kaštus ir išvengia konfliktų tarp lygiagrečių gijų.

#### B. Brangūs Išteklius Eikvojantys SQF Komandos

Serverio stabilumas priklauso nuo to, ar skriptai vengia skaičiavimo sudėtingumo, ypač cikluose, vykdomuose suplanuotoje aplinkoje.

- Padėties Skenavimo Kaštai: Komanda nearestObjects yra labai brangi CPU atžvilgiu. Priežastis yra ta, kad ji ne tik grąžina netoliese esančius objektus, bet ir atlieka visą masyvo rūšiavimą pagal atstumą. Rūšiuojant, pavyzdžiui, 7000 objektų, gali prireikti iki 100ms, o tai akimirksniu sunaikina 3ms simuliacijos kvotą, sukeldama serverio strigimą.
- Mažinimas: Jei atstumas nėra kritiškai svarbus (t. y., nereikia objektų surūšiuoti), vietoje nearestObjects būtina naudoti nearObjects. Pastaroji komanda yra iš esmės ta pati, bet neprideda brangaus rūšiavimo etapo, todėl veikia daug efektyviau.
- Ciklo Optimizacija: Dideli for ar while ciklai turi būti minimizuojami. Masyvo operacijoms rekomenduojama naudoti specializuotas komandas, tokias kaip apply, count, findIf, arba select, kurios dažnai yra optimizuotos variklio viduje ir veikia greičiau nei bendriniai forEach ciklai.

Neatidumas rūšiavimo kaštams yra dažnas našumo nuosmukio šaltinis. Kai misijų kūrėjai naudoja nearestObjects paprastam artumo patikrinimui (pvz., „ar yra koks nors priešas netoliese?"), jie iššaukia didelę 100ms baudos išlaidą, kuri sukelia kaskadinį serverio vėlavimą. Tai reiškia, kad visi esami skriptai turėtų būti kruopščiai peržiūrimi, o nearestObjects pakeisti į nearObjects, išskyrus atvejus, kai atstumo rūšiavimas yra absoliučiai būtinas.

**Lentelė III: SQF Komandų Našumo Hierarchija ir Mažinimo Strategijos**

| Komanda/Operacija | Kontekstas | Našumo Poveikis | Optimizacijos Rekomendacija |
|-------------------|------------|-----------------|----------------------------|
| nearestObjects | Didelio spindulio užklausos | Sunkus (Rūšiavimo režija, gali sustabdyti 100ms) | Naudoti nearObjects, jei rūšiavimas nereikalingas. Atrinkti rezultatus rankiniu būdu. |
| Pasikartojantis execVM | Dažnai kviečiami skriptai | Aukštas (I/O failų skaitymo režija) | Kompiliuoti skriptą vieną kartą, naudojant compile preprocessFileLineNumbers, ir kviesti kaip funkciją. |
| for / while ciklai | Vykdoma suplanuotoje aplinkoje be sleep | Aukštas (Gali išsekinti simuliatorių, jei > 3ms) | Įterpti sleep arba pertvarkyti kaip būsenos mašinas (FSM) arba kadrų tvarkykles (PFHs) kritiniams nestabdymo poreikiams. |
| Globalūs Kintamieji | Dažnas skaitymas/rašymas | Vidutinis (Aprėpties paieškos kaštai) | Naudoti privačius (lokalius) kintamiesiems (_variable), užtikrinant greitą vietinę paiešką. |

#### C. Transporto Priemonių Įgulos Spawninimo Geriausios Praktikos

Spawninant AI transporto priemones su įgula, būtina naudoti teisingus metodus užtikrinant, kad visos pozicijos būtų užpildytos patikimai.

##### 1. emptyPositions vs fullCrew Metodų Palyginimas

**emptyPositions** yra **paprastas ir patikimas** metodas paprastiems atvejams:
- Grąžina **skaičių** (integer) tuščių pozicijų
- **Rekomenduojamas** driver, gunner, commander, cargo pozicijoms
- **Sintaksė**: `vehicle emptyPositions "Driver"` arba `vehicle emptyPositions "Gunner"`

**fullCrew** (nuo Arma 3 1.54) yra **galingesnis** sudėtingiems atvejams:
- Grąžina **detalų masyvą** su visomis pozicijomis
- **Rekomenduojamas** kai reikia detalių informacijos arba sudėtingų turret pozicijų
- **Sintaksė**: `fullCrew [vehicle, "", true]` (true = įtraukti tuščias pozicijas)

##### 2. Turret Pozicijų Tvarkymas

**KRITINĖ PROBLEMA**: `emptyPositionsTurret` komanda gali sukelti sintaksės klaidas dėl versijų skirtumų arba netinkamo formato.

**REKOMENDUOJAMAS SPRENDIMAS**: Naudoti `turretUnit` metodą vietoj `emptyPositionsTurret`:

```sqf
// ❌ NETEISINGA - gali sukelti "Error Missing )" klaidą
if (emptyPositionsTurret [vehicle, _turretPath, "Gunner"] > 0) then {
    // spawn crew
};

// ✅ TEISINGA - patikimesnis ir paprastesnis metodas
_turretCrew = vehicle turretUnit _turretPath;
if (isNull _turretCrew) then {
    _unit = _group createUnit [crewType, _spawnPos, [], 0, "NONE"];
    _unit moveInTurret [vehicle, _turretPath];
};
```

**Kodėl `turretUnit` yra geresnis**:
- ✅ **Patikimas** - palaikomas visose Arma 3 versijose
- ✅ **Paprastas** - grąžina unit objektą arba null
- ✅ **Efektyvus** - mažiau operacijų nei `emptyPositionsTurret`
- ✅ **Tiesioginis patikrinimas** - nereikia sudėtingų parametrų

##### 3. Hibridinis Metodas (Rekomenduojamas)

**Optimalus sprendimas** - naudoti **emptyPositions** pagrindinėms pozicijoms ir **turretUnit** turret pozicijoms:

```sqf
// Driver - emptyPositions (patikimas)
if (vehicle emptyPositions "Driver" > 0) then {
    _unit = _group createUnit [crewType, _spawnPos, [], 0, "NONE"];
    _unit moveInDriver vehicle;
};

// Gunner - emptyPositions (patikimas tankams)
for "_i" from 1 to (vehicle emptyPositions "Gunner") do {
    _unit = _group createUnit [crewType, _spawnPos, [], 0, "NONE"];
    _unit moveInGunner vehicle;
};

// Turret pozicijos - turretUnit (patikimesnis nei emptyPositionsTurret)
_turretPaths = allTurrets [vehicle, true];
{
    _turretCrew = vehicle turretUnit _x;
    if (isNull _turretCrew) then {
        _unit = _group createUnit [crewType, _spawnPos, [], 0, "NONE"];
        _unit moveInTurret [vehicle, _x];
    };
} forEach _turretPaths;

// Cargo - emptyPositions (keleiviai) - PATIKIMAS PAPRASTIEMS TRANSPORTO PRIEMONĖMS
for "_i" from 1 to (vehicle emptyPositions "Cargo") do {
    _unit = _group createUnit [soldierType, _spawnPos, [], 0, "NONE"];
    _unit moveInCargo vehicle;
};
```

##### 3.1. Cargo Pozicijų Problema Tankuose (KRITINĖ INFORMACIJA)

**PROBLEMA**: `emptyPositions "Cargo"` gali būti **netikslus tankuose** - jis gali skaičiuoti turret pozicijas kaip cargo, todėl cargo pozicijose gali atsirasti crew nariai vietoj keleivių.

**SPRENDIMAS**: Tankuose naudokite **fullCrew su filtravimu** cargo pozicijoms:

```sqf
// ❌ NETEISINGA tankuose - gali sukelti neteisingą cargo skaičių
for "_i" from 1 to (tank emptyPositions "Cargo") do {
    _unit = _group createUnit [soldierType, _spawnPos, [], 0, "NONE"];
    _unit moveInCargo tank; // Gali būti per daug crew narių!
};

// ✅ TEISINGA tankuose - naudojame fullCrew su filtravimu
_crewPositions = fullCrew [tank, "", true];
_cargoPositions = [];
{
    _role = _x select 1;
    _turretPath = _x select 2;
    _unit = _x select 0;
    // Tikras cargo - role == "cargo" ir turretPath tuščias (ne turret pozicija)
    if (_role == "cargo" && {_turretPath isEqualTo []} && {isNull _unit}) then {
        _cargoPositions pushBack _x;
    };
} forEach _crewPositions;

// Spawniname keleivius tik į tikras cargo pozicijas
if (count _cargoPositions > 0) then {
    {
        _unit = _group createUnit [soldierType, _spawnPos, [], 0, "NONE"];
        _unit moveInCargo tank;
    } forEach _cargoPositions;
};
```

**Kada naudoti ką**:
- **Paprastoms transporto priemonėms** (pvz., HMMWV, Ural): `emptyPositions "Cargo"` yra patikimas
- **Tankams ir šarvuočiams** (pvz., Abrams, T-72): naudokite `fullCrew` su filtravimu cargo pozicijoms

##### 4. Svarbios Pastabos

- **NEREIKIA `createVehicleCrew`** - jei spawninate custom įgulą, nereikia kurti ir pašalinti standartinės įgulos
- **Naudokite `allTurrets [vehicle, true]`** - gauti visas turret pozicijas, įskaitant commander turret
- **Patikrinkite ar pozicija tuščia** - visada patikrinkite prieš spawninant įgulą
- **Praktinis testavimas svarbus** - net jei dokumentacija teisinga, Arma 3 variklis gali turėti versijų skirtumus

**Lentelė IV: Vehicle Crew Spawning Metodų Palyginimas**

| Metodas | Sintaksė | Patikimumas | Našumas | Rekomendacija |
|---------|----------|-------------|----------|---------------|
| **emptyPositions** | `vehicle emptyPositions "Driver"` | ⭐⭐⭐⭐⭐ Aukštas | ⭐⭐⭐⭐⭐ Greitas | **Pagrindinėms pozicijoms** |
| **emptyPositions "Cargo"** | `vehicle emptyPositions "Cargo"` | ⭐⭐⭐⭐ Aukštas (paprastoms) ⚠️ Netikslus (tankuose) | ⭐⭐⭐⭐⭐ Greitas | **Paprastoms transporto priemonėms** |
| **fullCrew + filtravimas** | `fullCrew [vehicle, "", true]` + filtravimas | ⭐⭐⭐⭐⭐ Aukštas | ⭐⭐⭐⭐ Greitas | **Tankų cargo pozicijoms** |
| **fullCrew** | `fullCrew [vehicle, "", true]` | ⭐⭐⭐⭐⭐ Aukštas | ⭐⭐⭐⭐ Greitas | **Sudėtingiems atvejams** |
| **turretUnit** | `vehicle turretUnit turretPath` | ⭐⭐⭐⭐⭐ Aukštas | ⭐⭐⭐⭐⭐ Greitas | **Turret pozicijoms** |
| **emptyPositionsTurret** | `emptyPositionsTurret [vehicle, turretPath, type]` | ⚠️ Gali neveikti | ⭐⭐⭐⭐ Greitas | **Nerekomenduojamas** (versijų skirtumai) |

### III. Desinchronizacija („Desync") ir „Nematomumo" Fenomenas

Vartotojo aprašytas DI tapimas „nematomu" yra klasikinis tinklo desinchronizacijos simptomas, kai kliento numanoma objekto būsena smarkiai skiriasi nuo serverio autoritetingos būsenos.

#### A. DI Nematomumas: Lokalinės Būsenos Gedimo Simptomas

DI nematomas, nes serveris nepajėgia pakankamai greitai atnaujinti kliento būsenos, todėl kliento simuliacija patiria didelių padėties klaidų.

- Kliento Tinklo Apribojimas: Jei padėties klaida yra kritiškai didelė, kliento atvaizdavimo variklis gali tiesiog manyti, kad DI vienetas yra per toli arba už kliento vietinio tinklo burbulo ribų, remiantis pasenusiais duomenimis.
- Būsenos Skyrimas: Esant stipriai desinchronizacijai, DI vienetai gali pasirodyti esantys kitoje vietoje, nei juos mato klientas (teleportavimas). Nors pataikymo registracija dažnai atliekama kliento pusėje, o serveris vėliau priima žalą, didelis atsilikimas (lag) daro žaidimą neįmanomą, o lėktuvai gali sustingti vietoje.

#### B. Tinklo Konfigūracijos Derinimas basic.cfg Faile

Serverio tinklo konfigūracijos optimizavimas yra gyvybiškai svarbus siekiant užtikrinti, kad kritiniai padėties duomenys (Negarantuoti pranešimai) būtų efektyviai supakuoti ir prioritetizuoti.

- MaxMsgSend: Šis parametras kontroliuoja maksimalų agreguotų paketų skaičių, kurį galima išsiųsti per vieną simuliacijos ciklą. Padidinus šią vertę (pvz., nuo numatytosios 128 iki 256 ar 384), serveriai, turintys daug DI ar žaidėjų, gali išstumti daugiau atnaujinimų per kadrą, taip padidindami pralaidumą ir potencialiai sumažindami vėlavimą.
- MinBandwidth / MaxBandwidth: Šie parametrai apibrėžia serverio prielaidas apie turimą išsiuntimo pralaidumą. Nustatyti juos per optimistiškai gali padidinti CPU apkrovą ir vėlavimą, nes serveris bandys išsiųsti daugiau pranešimų nei gali apdoroti, todėl pranešimai bus atmesti.
- MaxSizeNonguaranteed: Tai maksimalus naudingosios apkrovos dydis (baitais) negarantuotiems paketams. Kadangi DI judėjimo atnaujinimai siunčiami Negarantuotais paketais, šio dydžio optimizavimas (pvz., padidinimas nuo 256 iki 512 baitų) padeda supakuoti daugiau judėjimo duomenų į kiekvieną paketą.
- Mažas Serverio FPS sukelia „užšalusio lėktuvo" efektą, nes ne-garantuoti padėties atnaujinimai atsilieka. Jei MaxSizeNonguaranteed yra per mažas, serveris, net esant žemam Server FPS, turi sukurti daugybę individualių paketų, kad perduotų bendrą padėties informaciją. Strategiškai padidinus MaxSizeNonguaranteed užtikrinama, kad ribotas serverio ciklas bus panaudotas efektyviai supakuoti ir perduoti atidėtus DI judėjimo duomenis, taip sumažinant desinchronizacijos sunkumą.

**Lentelė IV: Rekomenduojami Tinklo Konfigūracijos Parametrai (basic.cfg)**

| Parametras | Kritinė Paskirtis | BIS Numatytasis | Rekomenduojamas Diapazonas (Didelis Našumas) |
|------------|-------------------|----------------|---------------------------------------------|
| MaxMsgSend | Agreguoti paketai per kadrą (pralaidumas) | 128 | 256 - 384 |
| MaxSizeNonguaranteed | Pozicijos atnaujinimų naudingoji apkrova (baitais) | 256 | 256 - 512 |
| MinBandwidth | Garantuotas serverio pralaidumas (bps) | 131072 | Konservatyvus (pvz., 400000000) |
| MinErrorToSendNear | Minimali klaidos riba artimiems atnaujinimams | 0.01 | Padidinta (pvz., 0.02 - 0.04) gali sumažinti mikroatnaujinimus |

### IV. DI Kelio Radimo Gedimų Diagnostika ir Taisymas (Įstrigę Vienetai)

DI vienetai, ypač transporto priemonės, nuolat susiduria su sunkumais naviguojant sudėtingoje vietovėje, o tai sukelia nuolatinį įstrigimą ir misijos užstrigimą.

#### A. Dažni Gedimo Būdai ir DI Keistenybės

- Transporto Priemonių Navigacijos Užstrigimas: DI vairuotojai, ypač didelėse transporto priemonėse, nuolat kovoja su apsisukimais (U-turns). Jie gali sustoti minutėms, o paskui staiga automatiškai užbaigti likusį maršrutą, praleisdami tarpinius kelio taškus, nes variklis tiesiog atsisako skaičiuoti kelią. Šis elgesys yra ypač pastebimas esant „SAFE" arba „CARELESS" elgsenos režimams.
- Fizikos Objektai: DI vairuotojai stengiasi išvengti mažų fizikos (PhysX) objektų. Ši savybė, nors ir skirta pagerinti navigaciją, gali priversti DI sustoti ar rinktis neįprastus kelius, jei aplinkoje yra per daug mažų interaktyvių objektų.
- Pėstininkų Įstrigimas: Pėstininkai dažnai įstringa pastatuose, ant neįprastų paviršių (pvz., stogų) ar aplink sudėtingas reljefo ypatybes, pavyzdžiui, dideles uolas.
- Nepatikimos Vietinės Komandos: Nati vvariklio komanda canmove yra nepakankama tikram įstrigimo aptikimui, nes ji tikrina tik transporto priemonės žalos būklę, o ne jos fizinę galimybę judėti (pvz., užstrigus ant bėgių).
- Šis faktas tiesiogiai jungia DI lokalitetą su serverio našumu. Kai DI transporto priemonė užstringa (pvz., nepavykus apsisukti) ir praleidžia kelio taškus, ji patenka į užstrigusią, bet aktyvią būseną. Serveris vis dar skiria CPU ciklus bandymams apskaičiuoti kelią ar atlikti fizikos patikras nejudančiam objektui. Šis eikvojamas skaičiavimo ciklas dar labiau sumažina Serverio FPS. Taigi, pradinė kelio radimo klaida (strigimas) virsta matoma desinchronizacija (sustingimu) dėl kritinio serverio našumo sumažėjimo.

#### B. Įstrigimo Aptikimo ir Atkūrimo Skriptų Įgyvendinimas

Kadangi variklis neturi patikimo vietinio įstrigimo aptikimo, misijų kūrėjai privalo įdiegti tinkintą stebėjimo sistemą, paprastai veikiančią suplanuotoje aplinkoje.

- Aptikimo Metodologija: Padėties Deltos Sekimas: Patikimiausias būdas yra periodiškai stebėti vieneto poziciją (getPosATL) tam tikru intervalu. Jei vieneto nuvažiuotas atstumas (_distanceMoved) yra mažesnis už minimalų slenkstį (pvz., 1 metras) per keletą iš eilės einančių patikrinimų, vienetas paskelbiamas įstrigusiu.
- Korekciniai Veiksmai (SQF Įgyvendinimas):
  - Krypties Pakeitimas Transporto Priemonėms: Jei transporto priemonė užstrigo ties kelio tašku dėl nepavykusio apsisukimo, priverstinis krypties pakeitimas (setDir) dažnai atblokuoja DI ir leidžia jam tęsti judėjimą.
  - Repozicionavimas: Teleportavimas į žinomą saugią vietą naudojant setPos arba setPosATL yra galutinis atkūrimo mechanizmas. Šį metodą reikia naudoti atsargiai, kad nebūtų pažeistas misijos įsitraukimas.
  - Gyvavimo Laiko (TTL) Apsauga: Misijoms, kuriose įstrigęs DI trukdo užbaigti tikslą, galima nustatyti TTL skaitiklį, kuriam pasibaigus DI vienetas nusižudo (arba deleteVehicle). Tai apsaugo misiją nuo visiško sustojimo.

**Lentelė V: DI Įstrigimo Aptikimo ir Ištaisymo Logika**

| Fazė | Funkcija/Žingsnis | Intervalas/Slenkstis | SQF Komandos/Koncepcija |
|------|-------------------|---------------------|-------------------------|
| Aptikimas | Pradinės Padėties Nustatymas | Kiekvieno vieneto inicijavimas | _startPos = getPosATL _unit; |
| Aptikimas | Deltos Sekimas (Periodinis) | Vykdyti kas 5-10 sekundžių | _distanceMoved = _unit distance _lastCheckedPos; |
| Diagnozė | Įstrigimo Patvirtinimas | Atstumas < 1 metras 3 ar daugiau patikrinimų iš eilės | if (_distanceMoved < 1 && _stuckCounter >= 3) |
| Taisymas 1 | Transporto Priemonės Krypties Atstatymas | Jei transporto priemonė įstrigusi (ypač ties kelio taškais) | _unit setDir (getDir _unit + 180); ir pakartotinis doMove |
| Taisymas 2 | Priverstinis Repozicionavimas | Jei vienetas vis dar įstrigęs po judėjimo atstatymo | _unit setPos (_unit findEmptyPosition); |
| Taisymas 3 | Misijos Apsauga (Fail-safe) | Jei vieneto negalima pajudinti/nužudyti | TTL pabaiga, vedanti prie _unit setDamage 1; |

### V. DI Lokaliteto Valdymas Naudojant „Headless Clients" (HC) ir Dinaminę Simuliaciją

Vartotojo stebėjimas, kad „dalis serverio DI veikia, kita ne", yra aiškus nesubalansuoto apdorojimo krūvio arba neteisingo DI lokaliteto valdymo simptomas. Ši problema reikalauja serverio DI skaičiavimo perkėlimo į „Headless Clients" (HC) ir naudojant Dinaminę Simuliaciją (DS).

#### A. „Headless Client" (HC) Architektūra ir Funkcija

HC yra specialus, neatvaizduojantis kliento egzempliorius, skirtas išskirtinai DI skaičiavimų perkėlimui nuo pagrindinio dedikuoto serverio (Dedicated Server, DS).

- Krūvio Balansavimas: HC yra būtinas siekiant paskirstyti didžiulį DI skaičiavimo krūvį atskiram procesoriaus branduoliui ar mašinai. Tai yra pagrindinis metodas, siekiant palaikyti Serverio FPS virš kritinės 20 FPS ribos.
- HC Konfigūracija: HC turi būti apibrėztas misijoje (Game Logic -> Virtual Entities -> Headless Client) ir nurodytas serverio konfigūracijoje (server.cfg) pagal IP adresą, kad būtų leidžiamas prisijungimas.

#### B. DI Nuosavybės Perdavimo Įgyvendinimas

Kad DI skaičiavimai veiktų HC, serveris turi perduoti DI grupės „nuosavybę" arba „lokalitetą" HC klientui.

- Svarbiausia Komanda: setGroupOwner: Norint tinkamai perkelti DI grupių nuosavybę, būtina naudoti komandą setGroupOwner _group _HC_client_ID;. Grupės lyderis negali būti žaidėjas.
- Pasenusi Komanda setOwner: Nuo „Arma 3" v1.40, komanda setOwner neturėtų būti naudojama standartinių DI vienetų ar grupių nuosavybės perkėlimui, išskyrus „Agentus". Neteisingos komandos naudojimas dažnai sukelia skriptų gedimus ir nebeveikiančią DI logiką.
- Problemos, kai „dalis DI veikia, kita ne", dažnai rodo nepavykusį DI lokaliteto perdavimą. Veikiantys DI vienetai yra tie, kurių nuosavybė sėkmingai perkelta HC. Sugedę vienetai yra tie, kurie: a) yra palikti ant perkrauto dedikuoto serverio, nesuvokus poreikio perkelti nuosavybę; arba b) patyrė „lokaliteto nukrypimą" – jie išėjo už HC aktyvios apdorojimo zonos ribų, ir automatinis perdavimas atgal į serverį ar kitą HC nepavyko. Ši lokaliteto nesėkmė sukelia DI vidaus FSM (Finite State Machine) logikos sustojimą, dėl kurio DI vienetas tampa nereaguojantis arba sustingsta.

#### C. Dinaminė Simuliacija (DS) kaip Papildomas Krūvio Mažinimas

Dinaminė Simuliacija yra antrasis optimizavimo sluoksnis, skirtas sumažinti aktyviai simuliuojamų objektų skaičių, papildantis HC krūvio balansavimą.

- Veikimas: DS selektyviai išjungia toli nuo žaidėjų esančių objektų/DI grupių simuliaciją, užkertant kelią nereikalingam išteklių eikvojimui. Neaktyvuotos esybės sustoja.
- Įgyvendinimas: DS yra įjungta pagal numatytuosius nustatymus, tačiau jai reikia nurodyti, kurioms grupėms ją taikyti. Ji gali būti valdoma globaliai (enableDynamicSimulationSystem true;) ir konfigūruojama pagal atstumą (pvz., "Group" setDynamicSimulationDistance 1000;).
- Strateginis Panaudojimas: DS turėtų būti taikoma didelėms, statinėms DI grupėms ar tolimiems aplinkos objektams. Tai užtikrina, kad net esant didelei HC apkrovai, serveris nebandys apdoroti simuliacijos atnaujinimų tūkstančiams nereikalingų, tolimų vienetų.

### VI. Išvados ir Išsamus Mažinimo Kontrolinis Sąrašas

Klaidos „Arma 3" daugelio žaidėjų režime, ypač susijusios su DI strigimu ir desinchronizacija, yra sudėtinės ir kyla iš variklio simuliatoriaus apribojimų, sustiprintų neoptimizuotu SQF kodu ir netinkamu DI lokaliteto valdymu. Stabilus žaidimas reikalauja spręsti visus šiuos lygmenis vienu metu.

#### A. Veiksmų Sintezė

Pagrindinis gedimo kelias – nuo SQF neefektyvumo iki simuliatoriaus išsekimo, kuris sukelia žemą Serverio FPS, o tai galiausiai pasireiškia kaip desinchronizacija ir DI lokaliteto gedimai (pvz., „užšalęs lėktuvas" ar „nematomas DI") – turi būti nutrauktas per kruopštų kodo optimizavimą ir infrastruktūros derinimą.

Kritiniai Veiksmai DI ir Našumo Atkūrimui:

- SQF Optimizacija:
  - Kompiliacija: Įsitikinti, kad pasikartojančiai kviečiami skriptai yra kompiliuojami vieną kartą, siekiant išvengti execVM režijos.
  - Ciklai: Vengti brangių komandų, ypač nearestObjects, keičiant jas į nearObjects arba kitus optimizuotus masyvo tvarkymo metodus.
  - Lokaliniai Kintamieji: Maksimizuoti privačių (lokalių) kintamųjų (_variable) naudojimą, užtikrinant greitą vietinę paiešką.
- Tinklo Konfigūracijos Patikslinimas:
  - Pranešimų Srautai: Padidinti MaxMsgSend ir MaxSizeNonguaranteed parametrus basic.cfg faile, siekiant efektyviai supakuoti ir išsiųsti DI padėties atnaujinimus, ypač esant žemam Server FPS.
  - Pralaidumas: Nustatyti konservatyvius MinBandwidth ir MaxBandwidth vertes, kad serveris nebandytų išsiųsti daugiau duomenų, nei gali apdoroti, taip išvengiant atmestų pranešimų ir papildomo CPU krūvio.
- DI Lokalitetas ir Krūvio Balansavimas:
  - HC Privalomas: Naudoti „Headless Client" (HC) DI skaičiavimams perkelti. HC konfigūracija turi būti atlikta tiek misijoje, tiek server.cfg.
  - Teisingas Nuosavybės Perdavimas: Visiškai atsisakyti setOwner DI grupėms ir vietoje to naudoti autoritetingą komandą setGroupOwner, kuri veikia tik iš serverio.
  - Dinaminė Simuliacija: Įjungti ir konfigūruoti Dinaminę Simuliaciją (DS), kad tolimi DI vienetai būtų laikinai išjungti, taip sumažinant serverio apdorojimo krūvį.
- DI Strigimo Atkūrimas:
  - Delta Skriptai: Įdiegti tinkintus SQF skriptus, kurie stebi DI padėties delta (pokytį) tam tikru intervalu, siekiant aptikti įstrigusius vienetus.
  - Automatinis Atkūrimas: Įstrigus DI, taikyti korekcinius veiksmus: transporto priemonėms keisti kryptį (setDir), o pėstininkams – priverstinai perkelti juos į saugią vietą (setPos). Įgyvendinti TTL mechanizmus, kad būtų išvengta misijos užstrigimo dėl nepasiekiamo DI.

#### B. Stebėsenos ir Diagnostikos Priemonės

Norint efektyviai valdyti ir optimizuoti serverį, reikia nuolatinio stebėjimo:

- Serverio FPS Stebėjimas: Nuolat stebėti Serverio FPS naudojant #monitor komandą derinimo konsolėje arba bendruomenės skriptus, tokius kaip show_fps.sqf. Kritinis Serverio FPS kritimas žemiau 20 reikalauja nedelsiant mažinti DI skaičių ar optimizuoti kodą.
- Skripto Gijų Stebėjimas: Komanda diag_activeScripts leidžia sekti aktyvių gijų skaičių suplanuotoje aplinkoje. Aukštas šis skaičius rodo skriptų prisotinimą ir didelę riziką simuliatoriui išsekti.
- Lokaliteto Vizualizacija: Naudoti bendruomenės įrankius, kurie vizualizuoja DI nuosavybę (t. y., kurie vienetai priklauso serveriui, o kurie – HC). Tai padeda nustatyti lokaliteto nukrypimo ar nesėkmės vietas, kur DI veikia tik iš dalies.

---

## VIII. Išvados: Audito Sistema ir Tolimesnė Plėtra

Ekspertinis misijų ir modifikacijų kodo auditas reikalauja ne tik funkcinio veikimo patikrinimo, bet ir griežto atitikimo "Arma 3" našumo bei stabilumo reikalavimams. Toliau pateikiamas patikrinimo sąrašas, skirtas patvirtinti kritinius SQF faktus ir geriausias praktikas.

### A. SQF Dokumento Validavimo Patikrinimo Sąrašas

- **Sintaksė**: Ar visos išraiškos užbaigtos su ; arba , (preferuojamas ;) ? Ar nėra "Error Missing ]" klaidų dėl neuždarytų masyvų ar sudėtingų string struktūrų?
- **Vykdymas**: Ar sustabdymo komandos (sleep, uiSleep, waitUntil) naudojamos tik suplanotuose kontekstuose, t. y., tik po spawn ar execVM?
- **Apimtis**: Ar scenarijų blokai, paleisti per spawn ar įvykių tvarkykles (kurios naudoja izoliuotą apimtį), tinkamai perduoda parametrus per _this, užuot kliavusios paveldimais privatiais kintamaisiais? Ar privatūs kintamieji, reikalingi po kontrolinio bloko, yra inicializuoti už jo ribų? Ar naudojama `param` funkcija vietoj `select` saugesniam masyvo elementų pasiekimui?
- **Tinklo protokolas**: Ar BIS_fnc_MP yra visiškai pakeista remoteExec arba remoteExecCall?
- **Callback'ai**: Ar OnOwnerChange ir kiti event handler'iai naudoja tinkamą formatą (string formatą BIS sektorių moduliuose, code block formatą kitur)?
- **Optimizavimas**: Ar masyvo operacijos naudoja optimizuotas komandas (select, apply, findIf), o ne bendrą forEach, kai tai įmanoma? Ar yra minimizuojamas aktyvių suplanuotų gijų (sukurtų per spawn/execVM) skaičius?
- **Našumas**: Ar naudojami efektyvūs duomenų tipai (HashMap) ir optimizuoti algoritmai?

### B. Pažvelgimas į Ateitį

Nors SQF išlieka pagrindine kalba "Arma 3" platformoje, kūrėjai turėtų pripažinti, kad SQF yra pakeista Enforce Script "Arma Reforger" žaidime. Todėl, kuriant misijas, patariama naudoti ypač modulines funkcijų struktūras, kurios veikia kaip BIS funkcijos. Toks požiūris ne tik pagerina kodo kokybę dabartinėje aplinkoje, bet ir palengvina galimą kodo migraciją į ateities BI platformas, mažinant priklausomybę nuo unikalių ir sudėtingų SQF sintaksės ypatumų.

---

**Paskutinis Atnaujinimas**: 2025-01-XX
**Versija**: 5.4
**Pakeitimai v5.4**:
- **KRITINĖ INFORMACIJA**: `emptyPositions "Cargo"` gali būti netikslus tankuose - jis gali skaičiuoti turret pozicijas kaip cargo
- **REKOMENDUOJAMAS SPRENDIMAS**: Tankuose naudoti `fullCrew` su filtravimu cargo pozicijoms
- Pridėta nauja sekcija "Cargo Pozicijų Problema Tankuose" su išsamiu paaiškinimu ir pavyzdžiais
- Atnaujinta palyginimo lentelė su `emptyPositions "Cargo"` ir `fullCrew + filtravimas` metodais
- Išplėsta praktinė rekomendacija apie tai, kada naudoti ką (paprastos transporto priemonės vs tankai)

**Pakeitimai v5.3**:
- Pridėta nauja sekcija "Transporto Priemonių Įgulos Spawninimo Geriausios Praktikos"
- Dokumentuotas emptyPositions vs fullCrew metodų palyginimas
- **KRITINĖ INFORMACIJA**: emptyPositionsTurret gali sukelti sintaksės klaidas dėl versijų skirtumų
- **REKOMENDUOJAMAS SPRENDIMAS**: Naudoti turretUnit metodą vietoj emptyPositionsTurret turret pozicijoms
- Pridėtas hibridinis metodas (emptyPositions + turretUnit) kaip optimalus sprendimas
- Pridėta palyginimo lentelė su visais vehicle crew spawning metodais
- Išplėsta praktinė rekomendacija apie praktinio testavimo svarbą net jei dokumentacija teisinga

**Pakeitimai v5.2**:
- **KRITINIS TAISYMAS** (patvirtinta interneto paieška): Ištaisytas neteisingas OnOwnerChange callback'ų rekomendavimas - BIS sektorių moduliuose būtinas string formatas su escaping'u, ne code block formatas
- Code block formatas nesuderinamas su BIS modulio sistema ir callback'ai neveiks
- Atnaujinta validavimo sistema atsižvelgiant į skirtingus callback formatų reikalavimus skirtinguose kontekstuose

**Pakeitimai v5.1**:
- Pridėtas naujas poskyris "Saugus Neapibrėžtų Kintamųjų Valdymas" su išsamią informacija apie `isNil` ir `typeName` saugumą
- Dokumentuota, kad `isNil` ir `typeName` yra saugūs naudoti su neapibrėžtais kintamaisiais (patikrinta internete)
- Pridėta informacija apie `param` funkcijos pranašumus prieš `select` masyvo elementų pasiekimui
- Išplėsta praktinė rekomendacija apie kintamųjų inicializavimą prieš naudojimą kitose operacijose
- Pridėti praktiniai pavyzdžiai, demonstruojantys teisingą ir neteisingą kintamųjų naudojimą

**Pakeitimai v5.0**:
- Pridėta išsami VII skyrius apie DI gedimus ir desinchronizaciją daugelio žaidėjų režime
- Detaliai išanalizuoti serverio FPS ir simuliatoriaus išsekimo mechanizmai
- Dokumentuoti SQF optimizacijos strategijos didelio našumo aplinkoje
- Išplėsta informacija apie nearestObjects vs nearObjects našumo skirtumus
- Pridėtos lentelės apie tinklo konfigūracijos parametrus ir DI įstrigimo taisymą
- Išsamiai aprašytas Headless Clients ir Dinaminės Simuliacijos naudojimas
- Įtrauktas išsamių kontrolinių sąrašų ir diagnostikos priemonių skyrius

**Pakeitimai v4.1**:
- Pridėta informacija apie dažnas sintaksės klaidas, ypač "Error Missing ]"
- Dokumentuoti OnOwnerChange callback'ų formatai ir jų poveikis sintaksės klaidoms
- Pridėti praktiniai pavyzdžiai apie code block vs string formatų naudojimą
- Išplėsta sintaksės taisyklių sekcija su konkrečiais sprendimais

**Pakeitimai v4.0**:
- Pilnai perrašyta dokumentacija į išsamią ekspertinio SQF audito sistemą
- Įtraukti techniniai faktai apie SQF architektūrą ir evoliuciją
- Išplėsta kintamųjų apimties anatomija su praktiniais pavyzdžiais
- Detalizuoti scenarijų vykdymo modeliai su palyginimo lentele
- Išplėsta tinklo komunikacijos sekcija su absoliučiais reikalavimais
- Pridėta audito patikrinimo sistema ir ateities perspektyvos