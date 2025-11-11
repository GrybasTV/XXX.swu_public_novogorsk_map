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

## VII. Išvados: Audito Sistema ir Tolimesnė Plėtra

Ekspertinis misijų ir modifikacijų kodo auditas reikalauja ne tik funkcinio veikimo patikrinimo, bet ir griežto atitikimo "Arma 3" našumo bei stabilumo reikalavimams. Toliau pateikiamas patikrinimo sąrašas, skirtas patvirtinti kritinius SQF faktus ir geriausias praktikas.

### A. SQF Dokumento Validavimo Patikrinimo Sąrašas

- **Sintaksė**: Ar visos išraiškos užbaigtos su ; arba , (preferuojamas ;) ?
- **Vykdymas**: Ar sustabdymo komandos (sleep, uiSleep, waitUntil) naudojamos tik suplanotuose kontekstuose, t. y., tik po spawn ar execVM?
- **Apimtis**: Ar scenarijų blokai, paleisti per spawn ar įvykių tvarkykles (kurios naudoja izoliuotą apimtį), tinkamai perduoda parametrus per _this, užuot kliavusios paveldimais privatiais kintamaisiais? Ar privatūs kintamieji, reikalingi po kontrolinio bloko, yra inicializuoti už jo ribų?
- **Tinklo protokolas**: Ar BIS_fnc_MP yra visiškai pakeista remoteExec arba remoteExecCall?
- **Optimizavimas**: Ar masyvo operacijos naudoja optimizuotas komandas (select, apply, findIf), o ne bendrą forEach, kai tai įmanoma? Ar yra minimizuojamas aktyvių suplanuotų gijų (sukurtų per spawn/execVM) skaičius?
- **Našumas**: Ar naudojami efektyvūs duomenų tipai (HashMap) ir optimizuoti algoritmai?

### B. Pažvelgimas į Ateitį

Nors SQF išlieka pagrindine kalba "Arma 3" platformoje, kūrėjai turėtų pripažinti, kad SQF yra pakeista Enforce Script "Arma Reforger" žaidime. Todėl, kuriant misijas, patariama naudoti ypač modulines funkcijų struktūras, kurios veikia kaip BIS funkcijos. Toks požiūris ne tik pagerina kodo kokybę dabartinėje aplinkoje, bet ir palengvina galimą kodo migraciją į ateities BI platformas, mažinant priklausomybę nuo unikalių ir sudėtingų SQF sintaksės ypatumų.

---

**Paskutinis Atnaujinimas**: 2025-11-10
**Versija**: 4.0
**Pakeitimai v4.0**:
- Pilnai perrašyta dokumentacija į išsamią ekspertinio SQF audito sistemą
- Įtraukti techniniai faktai apie SQF architektūrą ir evoliuciją
- Išplėsta kintamųjų apimties anatomija su praktiniais pavyzdžiais
- Detalizuoti scenarijų vykdymo modeliai su palyginimo lentele
- Išplėsta tinklo komunikacijos sekcija su absoliučiais reikalavimais
- Pridėta audito patikrinimo sistema ir ateities perspektyvos