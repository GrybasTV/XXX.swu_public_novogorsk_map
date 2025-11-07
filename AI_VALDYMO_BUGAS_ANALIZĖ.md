# AI Valdymo Bugas Analizė - AI Neklauso Burio Vado Po Kuro Laiko

## Problema

Po tam tikro kuro laiko AI vienetai nustoja klausyti burio vado komandų. Burio vadas vis dar yra leaderis, bet AI nebereaguoja į komandas.

## Analizė

### Dabartinė Sistema

1. **fn_leaderUpdate.sqf**: Kviečia `fn_leaderActions.sqf` kas 61 sekundę
2. **fn_leaderActions.sqf**: Tikrina, ar žaidėjas yra leaderis
   - Jei `lUpdate != 1`: Prideda `BIS_fnc_addSupportLink` ir action'us
   - Jei `lUpdate == 1`: **NIEKO NEDARO SU SUPPORT LINK'U** - tik prideda action'us

### Galimos Priežastys

1. **BIS_fnc_addSupportLink gali nustoti veikti po laiko**:
   - Dėl tinklo problemų
   - Dėl objektų (SupReq) sunaikinimo arba keitimo
   - Dėl Arma 3 vidinio bug'o su support link'ų valdymu
   - Dėl grupės vadovo keitimo (net jei žaidėjas vis dar yra leaderis)

2. **Support link'as neatsinaujinamas periodiškai**:
   - Jei žaidėjas jau yra leaderis (`lUpdate == 1`), support link'as nepridedamas iš naujo
   - Tai gali sukelti problemą, jei support link'as nustos veikti po tam tikro laiko

3. **Grupės vadovo patikrinimas**:
   - `leader player == player` patikrinimas gali būti nepatikimas po tam tikro laiko
   - Arma 3 gali automatiškai pakeisti grupės vadovą dėl įvairių priežasčių

## Sprendimas

### 1. Periodiškai atsinaujinti Support Link'ą

Pridėti support link'o atnaujinimą, net jei žaidėjas jau yra leaderis. Tai užtikrins, kad support link'as visada veiks.

**Pakeitimai fn_leaderActions.sqf**:
- Pridėti support link'o atnaujinimą, net jei `lUpdate == 1`
- Pirmiausia pašalinti seną support link'ą, tada pridėti naują
- Tai užtikrins, kad support link'as visada bus teisingai sukonfigūruotas

### 2. Patikrinti grupės vadovo statusą

Pridėti papildomą patikrinimą, kad žaidėjas tikrai yra grupės vadovas, ir jei ne - automatiškai jį paskirti.

### 3. Debug informacija

Pridėti debug informaciją, kad galėtume sekti, kada ir kodėl support link'as nustos veikti.

## Rekomenduojamas Sprendimas

Periodiškai atsinaujinti support link'ą, net jei žaidėjas jau yra leaderis. Tai užtikrins, kad support link'as visada veiks, net jei jis nustos veikti dėl Arma 3 vidinių problemų.

## Įgyvendintas Sprendimas

Pridėtas support link'o atnaujinimas `fn_leaderActions.sqf`:
- Jei žaidėjas jau yra leaderis (`lUpdate == 1`), support link'as atsinaujinamas kas 61 sekundę
- Pirmiausia pašalinamas senas support link'as, tada pridedamas naujas
- Tai užtikrina, kad support link'as visada bus teisingai sukonfigūruotas

**Pakeitimai**:
- `functions/client/fn_leaderActions.sqf`: Pridėtas support link'o atnaujinimas po `lUpdate == 1` patikrinimo

## Testavimas

Po pakeitimų reikia patikrinti:
1. Ar AI vis dar klauso burio vado komandų po ilgo kuro laiko (60+ minučių)
2. Ar support link'as veikia teisingai ir atsinaujinamas kas 61 sekundę
3. Ar nėra jokių error'ų arba warning'ų
4. Ar AI vienetai vis dar reaguoja į burio vado komandas (pvz., "Follow me", "Move to position", etc.)

## Nuorodos

- `functions/client/fn_leaderUpdate.sqf` - atnaujina action meniu kas 61 sekundę
- `functions/client/fn_leaderActions.sqf` - prideda support link'ą ir action'us
- `JIP_SUPPORT_PROVIDER_FIX.md` - susijusi dokumentacija apie support provider'ius

