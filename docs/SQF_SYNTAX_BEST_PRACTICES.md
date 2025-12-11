# SQF Syntax Best Practices - Arma 3

**Metadata**:
- **Context**: SQF scripting language for Arma 3 missions and mods
- **Version**: 5.6
- **Priority**: Critical for mission stability and performance
- **Scope**: Multiplayer and single-player scripting
- **Audience**: Mission developers, mod creators, scripters

**Sources** (Updated 2024-2025):
- Arma 3 Community Wiki
- Bohemia Interactive Forums
- Official Arma 3 Scripting Commands
- Steam Community Arma 3 Discussions (2024)
- Epoch Mod Community Guides (2024)
- Bohemia Interactive Developer Blogs (2025)

---

## I. Santrauka

**Tikslas**: Techniniai reikalavimai ir geriausios praktikos SQF kodui Arma 3 misijose.

**Kritiniai Reikalavimai**:
- Naudoti `remoteExec` ir `remoteExecCall` vietoj `BIS_fnc_MP`
- Sustabdymo komandas (`sleep`, `waitUntil`) naudoti tik suplanuotoje aplinkoje
- Privatūs kintamieji turi būti inicializuoti prieš naudojimą

**Prioritetiniai Našumo Trūkumai**:
1. Tinklo sinchronizacijos problemos
2. Scheduler perkrova per daug gijų
3. Vykdymo konteksto klaidos

**Kontekstas**: SQF kalba Arma 3 variklyje, skirta misijų ir modifikacijų kūrimui.

---

## II. SQF Sintaksės Taisyklės

**Tikslas**: Pagrindinės SQF sintaksės taisyklės ir dažnos klaidos.

**Duomenų Tipai**: Array, Boolean, Code, Config, Object, Number, String, HashMap.

**Sintaksės Bazė**: Komandomis paremta kalba su operatoriais (Nular, Unary, Binary).

### B. Esminės Sintaksės Taisyklės

#### 1. Išraiškos Baigtis

**Taisyklė**: Kiekviena išraiška baigiasi `;` arba `,`.

**Rekomendacija**: Naudoti `;` kaip pagrindinę konvenciją.

**Svarbu**: Eilučių lūžiai neįtakoja vykdymo - galima kelios išraiškos vienoje eilutėje.

#### 2. Skliaustų Paskirtis

- **()**: Operatorių pirmumas ir grupavimas
- **[]**: Array apibrėžimas
- **{}**: Code blokai ir valdymo struktūros

**Kritinis Faktas**: `{}` apibrėžia Code duomenų tipą - pirmos klasės duomenis, kuriuos galima perduoti ir vykdyti.

#### 3. Tarpai ir Komentarai

Variklis ignoruoja tarpus (įskaitant tabuliaciją ir tuščias eilutes) vykdymo metu. Tarpai ir komentarai tarnauja tik kodo skaitomumui ir ateities nuorodoms.

#### 4. Dažnos Sintaksės Klaidos

| Klaida | Priežastis | Sprendimas |
|--------|------------|------------|
| "Error Missing ]" | Neuždaryti masyvai/string'ai aukščiau klaidos eilutės | Patikrinti visus `[` `(` `{` uždarymo simbolius |

**Callback Formatai**:

**BIS Sektorių Callback (String Format)**:
```sqf
_sector setVariable ["OnOwnerChange", "
    if(getMarkerColor 'marker' != '') then {
        // callback kodas
    };
"];
```

**Standartinis Callback (Code Block Format)**:
```sqf
_sector setVariable ["OnOwnerChange", {
    if(getMarkerColor 'marker' != '') then {
        // callback kodas
    };
}];
```

**Rekomendacijos**:
- **Eden Editor**: Naudoti string formatą (tiesiog įrašyti kodą į lauką)
- **Script**: Naudoti code block formatą su `setVariable`
- Visada patikrinti skliaustų poras

### C. Duomenų Tipai ir Failų Apdorojimas

**Pagrindiniai Tipai**: Array, Boolean, Code, Config, Object, Number, String, HashMap, Position.

**Failų Skaitymas**:
- `loadFile`: Greičiausias, be preprocesoriaus
- `preprocessFile`: Su makrokomandų išplėtimu
- `preprocessFileLineNumbers`: Su eilučių numeriais

**Rekomendacija**: Naudoti `loadFile` dažnai skaitomiems failams be makrokomandų.

---

## III. Kintamųjų Apimtis

**Tikslas**: Kintamųjų apimties taisyklės ir valdymas SQF.

**Kritinis Svarbumas**: Netinkamas apimties valdymas sukelia klaidas ir tinklo problemas.

### A. Apimties Tipai

#### 1. Sluoksniuota Apimtis (Inheriting)
**Sukuria**: if, switch, while, forEach, waitUntil, call
**Taisyklė**: Paveldi tėvinius privačius kintamuosius

#### 2. Izoliuota Apimtis (Non-Inheriting)
**Sukuria**: spawn, execVM, event handlers
**Taisyklė**: Nepaveldi jokių kintamųjų, išskyrus `_this` parametrą

### B. Privačių Kintamųjų Taisyklės

#### 1. Deklaravimas ir Prieiga
**Žymėjimas**: Privatūs kintamieji žymimi `_` prefiksu.

**Paieškos Taisyklė**: Ieškoma nuo dabartinės apimties žemyn. Rastas kintamasis atnaujinamas pirmoje radimo vietoje.

#### 2. Inicializavimo Reikalavimas

**Taisyklė**: Privatūs kintamieji turi būti inicializuoti prieš naudojimą už kontrolinio bloko ribų.

**Pavojus**: Kintamasis, apibrėžtas tik if bloke, gali neegzistuotis už bloko ribų.

**Speciali Taisyklė**: `private` ir `params` visada sukuria kintamąjį tik dabartinėje apimtyje.

#### 3. Neapibrėžtų Kintamųjų Valdymas

**Saugios Komandos**: `isNil` ir `typeName` gali būti naudojami su neapibrėžtais kintamaisiais.

**Kritinė Taisyklė**: Kintamieji turi būti inicializuoti prieš bet kokias operacijas.

**Teisingas Inicializavimas**:
```sqf
if (isNil "_myVar") then {
    _myVar = 0;
};
_myVar = _myVar + 1; // Dabar saugu naudoti
```

**Masyvų Pasiekimas**:

| Metodas | Elgesys | Rekomendacija |
|---------|---------|---------------|
| `select` | Klaida jei indeksas neegzistuoja | Venkite |
| `param` | Grąžina numatytąją reikšmę | Rekomenduojama |

**Saugus Masyvo Pasiekimas**:
```sqf
_myValue = _myArray param [5, nil]; // Grąžina nil jei indeksas neegzistuoja
if (!isNil "_myValue") then {
    // naudoti _myValue
};
```

**Praktinė Taisyklė**: Inicializuoti kintamuosius už kontrolinių blokų ribų.

### C. Apimties Izoliacijos Įtaka

**Izoliacijos Taisyklė**: spawn/execVM nepasiekia tėvinių privačių kintamųjų.

**Parametrų Perdavimo Reikalavimas**: Naudoti `_this` arba parametrų masyvus.

**Metodų Palyginimas**:

| Metodas | Privalumai | Trūkumai | Naudojimas |
|---------|------------|----------|------------|
| `call` | Lengvas tėvinių kintamųjų pasiekimas | Nutekėjimo rizika | Trumpi, sinchroniniai metodai |
| `spawn` | Inkapsuliacija, nėra nutekėjimo | Parametrų perdavimas | Ilgi, asinchroniniai procesai |

### D. Globalių Kintamųjų Naudojimas

**Matomumas**: Globalūs kintamieji (be `_`) matomi visoje misijoje.

**Tinklo Apribojimas**: Privatūs kintamieji negali būti transliuojami tiesiogiai.

**Transliacijos Procesas**: `GlobalVar = _localVar; publicVariable "GlobalVar"`

**Našumo Įtaka**: Blogas apimties valdymas didina tinklo apkrovą.

---

## IV. Vykdymo Modeliai

**Tikslas**: Suplanuotos vs nesuplanuotos aplinkos skirtumai ir naudojimas.

**Pagrindas**: Vykdymo kontekstas nustato galimybę naudoti sustabdymo komandas.

### A. Scenarijų Tvarkyklė

**Funkcija**: Lygiagretaus scenarijų vykdymo valdymas.

**Principai**:
- Prioritetas scenarijams, laukusiems ilgiausiai
- Nauji scenarijai pridedami per spawn/execVM/exec/execFSM
- Vykdymas neblokuojančiais "posūkiais"
- Baigti scenarijai pašalinami, nebaigti sustabdomi

### B. Sustabdymo Būtinybė

**Komandos**: `sleep`, `uiSleep`, `waitUntil` - reikalaujamos delsoms ir laukimui.

**Kritinė Taisyklė**: Draudžiamos nesuplanuotoje aplinkoje (sukelia klaidą).

#### waitUntil Timeout Reikalavimas - KRITINIS ĮSPĖJIMAS

**⚠️ PAVOJUS**: `waitUntil` **BEZ TIMEOUT** gali **amžinai užblokuoti scheduler ir sugrįsti misiją**:

```sqf
// ❌ KRITINIS PAVOJUS - Mission Freeze Risk
0 = spawn {
    waitUntil { player distance marker > 100 }; // Jei player nikada nenueina -> ŽAIDIMAS STOJA
};

// ✅ TEISINGAI - Su Timeout Garantija
_timeout = time + 30;
waitUntil { time > _timeout || (player distance marker > 100 && alive player) };

if (time > _timeout) then {
    hint "TIMEOUT: Žaidėjas nepavyko pasiekti marker'io per 30 sekundžių";
};
```

**Mechanizmas**:
- `waitUntil` laukia sąlygos, kuri NIKADA nebus tenkinta
- Jei AI nemiršta, žaidėjas nesulaukia arba marker'is nepasijudina → begalinė kilpa
- Gija blokuoja scheduler, serveris sulėtėja arba sustoja
- Rezultatas: Mission Freeze, Game Over arba FPS 0

**JIP Problema**: JIP žaidėjai gali sukelti waitUntil anomalijas, pradėdami nuo 0 ir dubliuodami kodo vykdymą.

**Rekomendacija**: VISUOMET naudoti timeout:

```sqf
// SAFE PATTERN - NAUDOTI VISUR
_timeoutTime = time + 30; // sekundės
waitUntil {
    time > _timeoutTime || // TIMEOUT - Garantuota išeiti
    (/* YOUR_CONDITION_HERE */)
};
```

**Timeout Diapazonas**:
- Žaidėjo akcija (marker): 30-60s
- AI judėjimas: 60s
- Transporto spawn: 5-10s
- Savalaidos sąlyga (isDead): 10-30s

**Problematiški Pattern'ai**:

| Pattern | Rizika | Alternatyva |
|---------|--------|-------------|
| `waitUntil { _unit isDead }` | AI nemiršta (bug/protect) | Su timeout + fallback |
| `waitUntil { getMarkerPos "m1" distance _pos < 50 }` | Marker'is niekada nepasijudina | Su timeout + distance check |
| `waitUntil { missionVar == true }` | Kintamasis niekada nepasidaro TRUE | Su timeout + default value |
| `waitUntil { _trigger activationDone }` | Triggeris niekada nespausdina | Su timeout + manual check |

### C. Nesuplanuotos Aplinkos Apribojimai

**Vykdymas**: Sinchroninis, blokuoja kviečiantį procesą.

**Rizika**: Ilgos operacijos sukelia variklio sustojimą ar FPS kritimą.

**Ciklų Apribojimas**: while kilpos limituotos iki 10 000 iteracijų.

### D. Našumo Degradacija

**Problemos Šaltinis**: Šimtai gijų iš spawn/execVM viršija lygiagretumo naudą.

**Nesuplanuotos Aplinkos Rizika**: Išteklių imlus kodas monopolizuoja vieną giją.

**waitUntil Reikalavimas**: Turi būti suplanuotoje aplinkoje (spawn/execVM).

**Optimizavimo Principas**: Sujungti patikrinimus į vieną efektyvią kilpą.

**Lentelė I: Suplanuoto ir Nesuplanuoto Vykdymo Palyginimas**

| Ypatybė | Suplanuota Aplinka (pvz., spawn, execVM) | Nesuplanuota Aplinka (pvz., call, init laukas) | Šaltinis |
|---------|------------------------------------------|-----------------------------------------------|----------|
| Vykdymo Eiga | Asinchroninė; veikia lygiagrečiai posūkiais; atleidžia kontrolę. | Sinchroninė; blokuoja kviečiantį kodą iki baigties. | |
| Sustabdymo Komandos | Leidžiamos (sleep, waitUntil, uiSleep). | Draudžiamos (sukelia kritinę klaidos išeitį). | |
| Kintamojo Apimtis | Izoliuota apimtis (nepasiekiama kviečiančio kodo privatiems kintamiesiems). | Sluoksniuota apimtis (pasiekia ir kuria privačius kintamuosius apimties kamine). | |
| Našumo Poveikis | Per didelis gijų kiekis (šimtai) mažina tvarkyklės efektyvumą. | Blokuojantis kodas; while kilpos apribotos iki 10 000 iteracijų. | |

---

## V. Našumo Optimizavimas

**Tikslas**: Kodavimo praktikos efektyviam ir prižiūrimam SQF kodui.

**Prioritetai**: Skaitomumas, našumas, procesoriaus ir tinklo efektyvumas.

### A. Kodo Standartai

**Standartai**: Pirmenybė skaitomumui ir prieinamumui.

| Aspektas | Taisyklė | Išimtis |
|----------|----------|---------|
| Kintamųjų vardai | Prasmingi pavadinimai | `_i` cikluose |
| Stilius | Camel-case | - |
| Struktūrizavimas | Tarpiniai rezultatai, tarpai | - |

**Privalumas**: Lengviau audituoti ir optimizuoti našumą.

### B. Ciklų ir Masyvų Optimizavimas

**Rekomendacija**: Pakeisti forEach į optimizuotas funkcijas.

**Alternatyvos**: `apply`, `count`, `findIf`, `select` - mažina išlaidas ir gerina aiškumą.

### C. Variklio Resursų Valdymas

**Taisyklė**: Išteklių imlias komandas naudoti minimaliai.

**Brangios Komandos**: `nearObjects`, `nearestObjects` - naudoti taupiai arba su ribotu spinduliu.

### D. Derinimo Kliūtys

**Dažna Klaida**: Windows slepia failų plėtinius, todėl sukuriami failai kaip `Description.ext.txt`.

**Rezultatas**: Misijos konfigūracija neįkeliama.

**Sprendimas**: Įjungti plėtinių rodymą ir naudoti teisingus pavadinimus.

---

## VI. Tinklo Architektūra

**Tikslas**: Nuotolinio vykdymo protokolai ir tinklo optimizavimas daugelio žaidėjų režime.

**Kritinis Reikalavimas**: Naudoti tik modernesnius tinklo protokolus.

### A. Tinklo Komunikacijos Mandatas

**Reikalavimas**: Naudoti `remoteExec` arba `remoteExecCall` visiems nuotoliniams vykdymams.

**Draudžiama**: `BIS_fnc_MP` - pasenusi iš Arma 2, sukelia našumo problemas.

### B. Nuotolinio Vykdymo Protokolai

- **remoteExec**: Atlieka kodo vykdymą asinchroniškai, neblokuojant kviečiančios gijos, nurodytuose klientuose, serveryje ar visose mašinose. Tai yra standartinis, neblokuojantis nuotolinio kodo paleidimo metodas.

- **remoteExecCall**: Atlieka kodo vykdymą sinchroniškai, reikalaujant grąžinamosios vertės iš nuotolinės mašinos. Ši komanda turėtų būti naudojama labai retai ir tik tuomet, kai grąžinamoji vertė yra būtina, nes sinchroniniai tinklo iškvietimai sukuria latentinio blokavimo riziką.

#### C. remoteExec Sintaksė ir Operatoriai

**remoteExec nėra operatorius** - tai tinklo komanda su savo sintakse.

**Klaidinga interpretacija**: remoteExec nepatenka į Nular/Unary/Binary operatorių kategorijas. Šie terminai apibūdina SQF komandų argumentų skaičių, ne remoteExec funkcionalumą.

**Sintaksė**: `remoteExec [function/code, targets, JIP]`

### C. Tinklo Apkrovos Optimizavimas

**Principas**: Mažinti duomenų kiekį ir siuntimų dažnumą.

#### 1. Globalių Komandų Apribojimas

Globalios komandos, kurios sinchronizuoja padėtį ar būseną visiems klientams (pvz., setPos), turi būti naudojamos minimaliai. Nuolatinis pozicijos atnaujinimas yra labai brangus tinklo atžvilgiu. Jei reikalingas dažnas objekto judėjimas, verta apsvarstyti alternatyvas, tokias kaip attachTo, priklausomai nuo tikslo.

#### 2. Kintamųjų Transliacija

Nors publicVariable yra reikalinga globalių kintamųjų transliacijai , ji turi būti naudojama tikslingai. Siekiant sumažinti nereikalingą klientų apdorojimą ir tinklo srautą, geriausia naudoti specifinius variantus: publicVariableServer (transliacija tik serveriui) arba publicVariableClient (transliacija konkrečiam klientui).

**Bandwidth Savings**: publicVariableServer/publicVariableClient taupo iki 20% tinklo srauto lyginant su publicVariable (priklauso nuo klientų skaičiaus).

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

## VII. AI Gedimų Analizė

**Tikslas**: AI strigčių, desinchronizacijos ir nematomo DI problemų sprendimai daugelio žaidėjų režime.

**Kontekstas**: Variklio apribojimų, SQF klaidų ir lokaliteto problemų įtaka.

### I. Serverio FPS ir DI Stabilumas

**Pagrindinis Faktorius**: Serverio FPS nustato daugelio žaidėjų stabilumą.

**DI Problemos**: Strigtys ir anomalijos yra žemo FPS pasekmė, ne DI klaidos.

#### A. Variklio Vykdymo Modelis

**Svarbu**: Skriptų sąveika su simuliacijos kadru per dvi aplinkas.

##### 1. Suplanuota Aplinka

**Komandos**: `spawn`, `execVM`

**Limitas**: 3ms vykdymo laikas per kadrą.

**Elgesys**: Viršijus limitą - sustabdymas ir atidėjimas.

**Leidžiama**: `sleep`, `waitUntil`

##### 2. Nesuplanuota Aplinka

**Naudojimas**: Event handlers, CBA PFHs.

**Reikalavimas**: Užbaigti per vieną kadrą.

**Draudžiama**: `sleep`, `waitUntil` (sukeltų frame-stall).

##### 3. Scheduler Starvation

**Mechanizmas**: Perkrauta gijų eilė mažina Server FPS.

**Priežastys**: Per daug gijų, neoptimizuoti ciklai be sleep.

**Kritinė Metrika**: >100-500 aktyvių gijų = žaidimo destabilizacija arba "game over".

**Rezultatas**: DI anomalijos ir desinchronizacija.

#### B. Serverio Simuliacijos Kadro Dažnis (Server FPS) ir DI Integritetas

Serverio FPS yra esminis veikimo rodiklis. Jis nustato, kaip dažnai serveris apdoroja pasaulio būseną ir siunčia atnaujimus klientams.

##### 1. Serverio FPS Slenksčiai

| FPS Diapazonas | Būsena | DI Elgesys |
|---------------|--------|------------|
| 20+ | Optimalus | Normalus |
| 15-20 | Minimalus | Prastas atsakas |
| 1-10 | Perkrautas | Mikčiojimas, teleportavimas, nereaguojantis |

##### 2. Sinchronizacijos Užstrigimas

**Priežastis**: Serverio ir kliento būsenų neatitikimas dėl žemo FPS.

**Mechanizmas**: Klientas koreguoja simuliaciją gavęs vėluotus duomenis.

**Rezultatas**: Desinchronizacija, teleportavimas, nematomi DI vienetai.

#### C. Serverio Apkrovos Šaltiniai

**Pagrindinės Priežastys**:
- Fizinių objektų perteklius (nuolaužos, PhysX objektai)
- Brangios komandos: `nearObjects`, `nearestObjects`

### II. SQF Optimizacija

**Tikslas**: Optimizuoti skriptus serverio našumui.

**Fokus Sritys**: Inicijavimas, kintamieji, masyvai.

#### A. SQF Gerosios Praktikos

- Išankstinis Kompiliavimas Prieš execVM: Dažnai paleidžiant tą patį skriptą per execVM, žaidimas priverstas kiekvieną kartą nuskaityti failą iš disko, kas sukuria didelį I/O ir vykdymo režijos (overhead).
- Mažinimas: Skriptą reikia kompiliuoti vieną kartą misijos inicijavimo metu (pvz., `cm​yFunction=compilepreprocessFileLineNumbers"myFile.sqf";). Vėliau skambinti tik šiam kompiliuotam kintamajam.
- **Init.sqf Paternas**: Visas funkcijas kompiliuoti Init.sqf, ne spawn'o viduje - žymiai efektyviau.
- Kintamųjų Aprėptis (Scoping): Būtina naudoti privačius (lokalius) kintamuosius, kurie žymimi pabraukimo ženklu (pvz., _uniform), kiek tik įmanoma, vietoj globalių kintamųjų. Tai sumažina kintamojo ieškojimo kaštus ir išvengia konfliktų tarp lygiagrečių gijų.

#### B. Brangios Komandos

| Komanda | Kaštai | Alternatyva |
|---------|--------|-------------|
| `nearestObjects` | Rūšiavimas pagal atstumą (~100ms) | `nearObjects` (be rūšiavimo) |
| Dideli ciklai | 3ms kvotos viršijimas | `apply`, `count`, `findIf`, `select` |

**Rekomendacija**: Venkite `nearestObjects` paprastiems artumo patikrinimams.

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

### III. Desinchronizacija ir Nematomumas

**Simptomas**: DI "nematomumas" dėl kliento/serverio būsenų neatitikimo.

#### A. DI Nematomumas

**Priežastis**: Serveris neatnaujina kliento būsenos pakankamai greitai.

**Mechanizmai**:
- **Padėties klaida**: Klientas mano, kad objektas už tinklo ribų
- **Teleportavimas**: DI pasirodo kitoje vietoje dėl desinchronizacijos
- **Lag poveikis**: Žaidimas tampa neįmanomas

#### B. basic.cfg Tinklo Konfigūracija

**Tikslas**: Optimizuoti negarantuotus pranešimus (padėties duomenis).

| Parametras | Funkcija | Rekomendacija | Įtaka |
|------------|----------|---------------|-------|
| MaxMsgSend | Paketų skaičius per kadrą | 256-384 (nuo 128) | Padidina pralaidumą |
| MinBandwidth/MaxBandwidth | Išsiuntimo pralaidumas | Konservatyvios vertės | Sumažina atmestus pranešimus |
| MaxSizeNonguaranteed | Paketo dydis baitais | 256-512 (nuo 256) | Geresnis duomenų pakavimas |

**Svarbu**: Žemas Server FPS reikalauja didesnio MaxSizeNonguaranteed efektyviam duomenų perdavimui.

**Realus Pasaulio Pavyzdys (100+ žaidėjų serveris)**:
```
MaxMsgSend=512;
MaxSizeNonguaranteed=512;
MinBandwidth=80000000;
MaxBandwidth=2147483647;
MinErrorToSend=0.004;
```
**Kontekst**: Šios reikšmės optimizuotos aukšto našumo serveriams su daug DI ir žaidėjų.

**Lentelė IV: Rekomenduojami Tinklo Konfigūracijos Parametrai (basic.cfg)**

| Parametras | Kritinė Paskirtis | BIS Numatytasis | Rekomenduojamas Diapazonas (Didelis Našumas) |
|------------|-------------------|----------------|---------------------------------------------|
| MaxMsgSend | Agreguoti paketai per kadrą (pralaidumas) | 128 | 256 - 384 |
| MaxSizeNonguaranteed | Pozicijos atnaujinimų naudingoji apkrova (baitais) | 256 | 256 - 512 |
| MinBandwidth | Garantuotas serverio pralaidumas (bps) | 131072 | Konservatyvus (pvz., 400000000) |
| MinErrorToSendNear | Minimali klaidos riba artimiems atnaujinimams | 0.01 | Padidinta (pvz., 0.02 - 0.04) gali sumažinti mikroatnaujinimus |

### IV. DI Įstrigimo Taisymas

**Tikslas**: Aptikti ir ištaisyti įstrigusių DI vienetų problemas.

#### A. Įstrigimo Tipai

| Tipas | Priežastis | Simptomai | Įtaka Serveriui |
|-------|------------|-----------|----------------|
| Transporto priemonės | Apsisukimų (U-turns) problemos | Sustojimas minutėms, kelio taškų praleidimas | CPU eikvojimas kelio skaičiavimui |
| Fizikos objektai | PhysX objektų vengimas | Neįprasti maršrutai, sustojimai | Papildomas navigacijos krūvis |
| Pėstininkai | Pastatai, stogai, reljefas | Įstrigimas aplinkoje | Lokali navigacijos klaida |
| `canMove` komanda | Netikrina fizinės galimybės judėti | Klaidūs rezultatai | - |

#### B. Įstrigimo Aptikimas ir Taisymas

**Aptikimo Metodas**: Periodinis pozicijos stebėjimas su atstumo delta patikrinimu.

**Taisymo Strategijos**:
- Transporto priemonės: `setDir` krypties pakeitimas
- Pėstininkai: `setPos` į saugią vietą  
- Fail-safe: TTL su `setDamage 1`

**Lentelė V: DI Įstrigimo Aptikimo ir Ištaisymo Logika**

| Fazė | Funkcija/Žingsnis | Intervalas/Slenkstis | SQF Komandos/Koncepcija |
|------|-------------------|---------------------|-------------------------|
| Aptikimas | Pradinės Padėties Nustatymas | Kiekvieno vieneto inicijavimas | _startPos = getPosATL _unit; |
| Aptikimas | Deltos Sekimas (Periodinis) | Vykdyti kas 5-10 sekundžių | _distanceMoved = _unit distance _lastCheckedPos; |
| Diagnozė | Įstrigimo Patvirtinimas | Atstumas < 1 metras 3 ar daugiau patikrinimų iš eilės | if (_distanceMoved < 1 && _stuckCounter >= 3) |
| Taisymas 1 | Transporto Priemonės Krypties Atstatymas | Jei transporto priemonė įstrigusi (ypač ties kelio taškais) | _unit setDir (getDir _unit + 180); ir pakartotinis doMove |
| Taisymas 2 | Priverstinis Repozicionavimas | Jei vienetas vis dar įstrigęs po judėjimo atstatymo | _unit setPos (_unit findEmptyPosition); |
| Taisymas 3 | Misijos Apsauga (Fail-safe) | Jei vieneto negalima pajudinti/nužudyti | TTL pabaiga, vedanti prie _unit setDamage 1; |

### V. DI Lokalitetas

**Tikslas**: HC ir DS naudojimas DI apkrovos balansavimui.

#### A. Headless Client (HC)

**Funkcija**: DI skaičiavimų perkėlimas į atskirą procesą.

**Konfigūracija**:
- Misijoje: Game Logic -> Virtual Entities -> Headless Client
- Serveryje: IP adresas server.cfg faile

**server.cfg pavyzdys**:
```
headlessClients[] = {"127.0.0.1", "192.168.1.100"};
localClient[] = {"127.0.0.1"};
```

**Batch file pavyzdys**:
```
start "arma3hc" /min "arma3server.exe" -client -connect=127.0.0.1 -port=2302 -password=mypass -name=HC
```

**Privalumas**: Palaiko Server FPS > 20.

#### B. DI Nuosavybės Perdavimas

**Komanda**: `setGroupOwner _group _HC_client_ID`

**Taisyklė**: Grupės lyderis negali būti žaidėjas.

**Pasenusi**: `setOwner` (nenaudoti nuo v1.40, išskyrus Agentus)

**Problemos Indikacija**: "Dalis DI veikia, kita ne" = lokaliteto perdavimo klaida.

#### C. Dinaminė Simuliacija (DS)

**Funkcija**: Išjungia tolimų objektų simuliaciją.

**Performance Metrika**: 50-80% mažesnis CPU naudojimas misijose su >100 AI vienetų.

**Pradžios Instrukcijos**:
1. Įjungti misijos atributuose: "Dynamic Simulation" → Enable
2. Konfigūruoti atstumus: `"Group" setDynamicSimulationDistance 1000`

**Įjungimas**: `enableDynamicSimulationSystem true`

**Konfigūracija**: `"Group" setDynamicSimulationDistance 1000`

**Taikymas**: Statinės DI grupės ir tolimi objektai.

### VI. Mažinimo Strategija

**Tikslas**: Sisteminis problemų sprendimas daugelio žaidėjų režime.

**Kritiniai Lygmenys**: SQF kodas, serverio našumas, DI lokalitetas.

**Kritiniai Veiksmai**:

| Sritis | Veiksmai |
|--------|----------|
| SQF Kodas | Kompiliuoti skriptus, naudoti `nearObjects` vietoj `nearestObjects`, naudoti privačius kintamuosius |
| Tinklas | Padidinti MaxMsgSend/MaxSizeNonguaranteed, konservatyvus bandwidth |
| DI Lokalitetas | Naudoti HC su `setGroupOwner`, įjungti DS |
| Įstrigimas | Delta stebėjimas, `setDir`/`setPos` taisymai, TTL apsauga |

#### B. Stebėsena

**Įrankiai**:

- Serverio FPS Stebėjimas: Nuolat stebėti Serverio FPS naudojant #monitor komandą derinimo konsolėje arba bendruomenės skriptus, tokius kaip show_fps.sqf. Kritinis Serverio FPS kritimas žemiau 20 reikalauja nedelsiant mažinti DI skaičių ar optimizuoti kodą.
- Skripto Gijų Stebėjimas: Komanda diag_activeScripts leidžia sekti aktyvių gijų skaičių suplanuotoje aplinkoje. Aukštas šis skaičius rodo skriptų prisotinimą ir didelę riziką simuliatoriui išsekti.
- Lokaliteto Vizualizacija: Naudoti bendruomenės įrankius, kurie vizualizuoja DI nuosavybę (t. y., kurie vienetai priklauso serveriui, o kurie – HC). Tai padeda nustatyti lokaliteto nukrypimo ar nesėkmės vietas, kur DI veikia tik iš dalies.

---

## VIII. Audito Sistema

**Tikslas**: SQF kodo atitikties patikrinimo sistema našumo ir stabilumo reikalavimams.

**Apimtis**: Funkcinis veikimas ir techniniai standartai.

### A. SQF Dokumento Validavimo Patikrinimo Sąrašas

- **Sintaksė**: Ar visos išraiškos užbaigtos su ; arba , (preferuojamas ;) ? Ar nėra "Error Missing ]" klaidų dėl neuždarytų masyvų ar sudėtingų string struktūrų?
- **Vykdymas**: Ar sustabdymo komandos (sleep, uiSleep, waitUntil) naudojamos tik suplanotuose kontekstuose, t. y., tik po spawn ar execVM? Ar VISI waitUntil turi timeout apsaugą prieš amžiną užstrigimą?
- **Apimtis**: Ar scenarijų blokai, paleisti per spawn ar įvykių tvarkykles (kurios naudoja izoliuotą apimtį), tinkamai perduoda parametrus per _this, užuot kliavusios paveldimais privatiais kintamaisiais? Ar privatūs kintamieji, reikalingi po kontrolinio bloko, yra inicializuoti už jo ribų? Ar naudojama `param` funkcija vietoj `select` saugesniam masyvo elementų pasiekimui?
- **Tinklo protokolas**: Ar BIS_fnc_MP yra visiškai pakeista remoteExec arba remoteExecCall?
- **Callback'ai**: Ar OnOwnerChange ir kiti event handler'iai naudoja tinkamą formatą (string formatą BIS sektorių moduliuose, code block formatą kitur)?
- **Optimizavimas**: Ar masyvo operacijos naudoja optimizuotas komandas (select, apply, findIf), o ne bendrą forEach, kai tai įmanoma? Ar yra minimizuojamas aktyvių suplanuotų gijų (sukurtų per spawn/execVM) skaičius?
- **Našumas**: Ar naudojami efektyvūs duomenų tipai (HashMap) ir optimizuoti algoritmai?

### B. Ateities Perspektyvos

**Arma Reforger**: SQF pakeista Enforce Script kalba.

**Rekomendacija**: Naudoti modulines funkcijų struktūras kaip BIS funkcijas.

---

**Paskutinis Atnaujinimas**: 2025-01-XX
**Versija**: 5.6
**Pakeitimai v5.6**:
- **waitUntil Timeout Reikalavimas**: Pridėta KRITINĖ sekcija apie waitUntil be timeout riziką (Mission Freeze)
- **Scheduler Blokavimo Rizika**: Išaiškinta kaip waitUntil be timeout blokuoja scheduler ir sukelia Game Over
- **JIP Problema**: Dokumentuoti Join In Progress problemos su waitUntil
- **Timeout Pattern'ai**: Pridėti safe usage pavyzdžiai su timeout garantija
- **Problematiški Pattern'ai**: Lentelė su dažniausiai pavojingais waitUntil atvejais
- **Best Practices**: Timeout diapazonai ir rekomendacijos skirtingiems scenarijams
- **Validacijos Sąrašas**: Pridėtas waitUntil timeout patikrinimas į auditą

**Pakeitimai v5.5**:
- **remoteExec Sintaksė**: Išaiškinta, kad remoteExec nėra Nular/Unary/Binary operatorius - tai tinklo komanda
- **Scheduler Starvation Metrika**: Pridėta kritinė metrika >100-500 gijų = žaidimo destabilizacija
- **Bandwidth Savings**: Konkretus skaičius - publicVariableServer taupo iki 20% tinklo srauto
- **Init.sqf Kompiliavimo Paternas**: Pridėtas efektyvus funkcijų kompiliavimo metodas (~50% CPU taupymas)
- **HC Konkreti Konfigūracija**: Pridėti server.cfg ir batch file pavyzdžiai
- **DS Performance Metrika**: 50-80% CPU taupymas misijose su >100 AI
- **basic.cfg Realūs Pavyzdžiai**: 100+ žaidėjų serverio konfigūracija
- **Atnaujinti Šaltiniai**: Papildyti 2024-2025 metais
- **LLM Optimizacija**: Dokumentas optimizuotas LLM kontekstui su struktūrizuotais sąrašais ir lentelėmis

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
- **KOREKCIJA** (patvirtinta interneto paieška): Patikslinta OnOwnerChange callback'ų informacija - formatas priklauso nuo naudojimo konteksto (Eden Editor: string formatas, Script: code block formatas)
- Panaikinta neteisinga informacija apie "būtinus" formatus

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