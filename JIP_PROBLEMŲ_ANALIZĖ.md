# JIP Problemų Analizė ir Sprendimai

## Rastos JIP Problemos

### 1. ✅ IŠSPRĘSTA: Respawn Laiko Bugas
**Problema**: JIP žaidėjai gavo 5 sekundžių respawn laiką vietoj teisingo `rTime`.  
**Sprendimas**: Pakeista `onPlayerKilled.sqf`, kad visada naudotų `rTime` vietoj `fs` kintamojo.  
**Failas**: `onPlayerKilled.sqf`

### 2. ✅ IŠSPRĘSTA: Support Provider'io Sinhronizacija
**Problema**: JIP žaidėjai gavo neteisingus CAS lėktuvus ir artilerijos prieigą.  
**Sprendimas**: Pridėta `wrm_fnc_V2syncSupportProvidersClient` funkcija, kuri sinchronizuoja support provider'ius JIP žaidėjams.  
**Failas**: `functions/client/fn_V2syncSupportProvidersClient.sqf`, `initPlayerLocal.sqf`

### 3. ✅ IŠSPRĘSTA: AI Valdymo Bugas
**Problema**: AI nustojo klausyti burio vado komandų po tam tikro laiko.  
**Sprendimas**: Pridėtas periodinis support link'o atnaujinimas `fn_leaderActions.sqf`.  
**Failas**: `functions/client/fn_leaderActions.sqf`

## Potencialios JIP Problemos (Reikia Patikrinti)

### 4. Event Handler'iai - Potenciali Problema
**Problema**: `init.sqf` prideda event handler'ius tik vieną kartą, kai misija prasideda (eilutė 869-876). Jei JIP žaidėjas prisijungia po to, jis gali neturėti handler'io.

**Dabartinė situacija**:
- `init.sqf` (eilutė 869-876): Prideda MPRespawn handler'ius visiems `playableUnits` tik vieną kartą
- `V2playerSideChange.sqf` (eilutė 80-90): Prideda MPRespawn handler'į tik JIP žaidėjams (`if(didJip)then`)
- `V2playerSideChange.sqf` (eilutė 94-95): Prideda MPKilled handler'į visiems žaidėjams

**Galima problema**: Jei JIP žaidėjas prisijungia prieš tai, kai `init.sqf` prideda handler'ius, jis gali neturėti handler'io. Bet `V2playerSideChange.sqf` turėtų tai padengti.

**Rekomendacija**: Patikrinti, ar visi JIP žaidėjai gauna event handler'ius. Jei ne, pridėti patikrinimą ir handler'io pridėjimą.

### 5. Leader Update Funkcija - Potenciali Problema
**Problema**: `wrm_fnc_leaderUpdate` kviečiama su `remoteExec ["wrm_fnc_leaderUpdate", 0, true];` (eilutė 1858), bet jei JIP žaidėjas prisijungia prieš tai, kai misija prasideda (`progress < 2`), jis gali negauti šio kvietimo.

**Dabartinė situacija**:
- `V2startServer.sqf` (eilutė 1858): Kviečia `wrm_fnc_leaderUpdate` su persistent flag'u (`true`), kas turėtų užtikrinti, kad JIP žaidėjai taip pat gautų šį kvietimą
- `fn_leaderUpdate.sqf`: Turi `waitUntil {progress >= 2 || time >= _timeout};`, kas turėtų užtikrinti, kad funkcija veiks net jei JIP žaidėjas prisijungia prieš misijos pradžią

**Rekomendacija**: Patikrinti, ar JIP žaidėjai gauna leader update funkciją. Jei ne, pridėti patikrinimą ir funkcijos kvietimą.

### 6. V2firstSpawn.sqf - Potenciali Problema
**Problema**: `V2firstSpawn.sqf` turi `waitUntil {!alive player};` (eilutė 22), kas gali sukelti problemą JIP žaidėjams, jei jie prisijungia jau mirę.

**Dabartinė situacija**:
- Eilutė 22: `waitUntil {!alive player};` - laukia, kol žaidėjas miršta
- Eilutė 24-29: Yra timeout'as, bet jis tik patikrina, ar žaidėjas jau gyvas

**Rekomendacija**: Patikrinti, ar JIP žaidėjai, kurie prisijungia jau mirę, gali respawn'inti. Jei ne, pakeisti logiką.

## Testavimo Rekomendacijos

1. **Respawn laikas**: Patikrinti, ar JIP žaidėjai gauna teisingą respawn laiką (pagal config parametrus)
2. **Support provider'iai**: Patikrinti, ar JIP žaidėjai gauna teisingus CAS lėktuvus ir artilerijos prieigą
3. **AI valdymas**: Patikrinti, ar AI vis dar klauso burio vado komandų po ilgo kuro laiko
4. **Event handler'iai**: Patikrinti, ar JIP žaidėjai gauna visus event handler'ius (MPRespawn, MPKilled)
5. **Leader update**: Patikrinti, ar JIP žaidėjai gauna leader update funkciją
6. **V2firstSpawn**: Patikrinti, ar JIP žaidėjai, kurie prisijungia jau mirę, gali respawn'inti

## Nuorodos

- `onPlayerKilled.sqf` - respawn laiko nustatymas
- `functions/client/fn_V2syncSupportProvidersClient.sqf` - support provider'io sinchronizacija
- `functions/client/fn_leaderActions.sqf` - leader action'ų valdymas
- `init.sqf` - event handler'io inicializacija
- `V2playerSideChange.sqf` - JIP žaidėjų inicializacija
- `warmachine/V2startServer.sqf` - leader update funkcijos kvietimas
- `warmachine/V2firstSpawn.sqf` - pirmo respawn'o logika

