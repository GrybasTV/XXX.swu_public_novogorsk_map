# JIP Support Provider'io Sinhronizacijos Pataisymas

## Problema

Kai žaidėjas atsijungia ir vėl prisijungia (JIP), buvo pastebėtos šios problemos:

1. **CAS Support**: JIP žaidėjai galėjo pasirinkti tik vanilla lėktuvus, o ne tuos, kurie turėtų būti pagal nustatymus (RHS Ukraine/Russia 2025 lėktuvai)
2. **Artilerijos Support**: JIP žaidėjai galėjo kviesti artileriją, net jei artilerijos objektas neegzistavo arba buvo sunaikintas

## Priežastis

1. **CAS Support Provider'iai**: CAS support provider'iai (SupCasHW, SupCasBW, SupCasHE, SupCasBE) turėjo nustatytus lėktuvus per `setVariable` su `bis_supp_vehicles`, bet tai vyko tik serveryje ir tik tada, kai misija prasideda. Kai žaidėjas prisijungia vėliau (JIP), šie nustatymai nėra sinchronizuojami su klientu. BIS support sistema naudoja `mission.sqm` failo nustatymus, kurie turi vanilla lėktuvus.

2. **Artilerijos Support**: Artilerijos objektai (objArtiW/objArtiE, objMortW/objMortE) yra susieti su support provider'iu (SupArtiV2) per `BIS_fnc_addSupportLink`, bet jei žaidėjas prisijungia (JIP), jis gali matyti artilerijos support meniu, net jei artilerijos objektas neegzistuoja arba yra sunaikintas.

## Sprendimas

### 1. Serverio funkcija: `fn_V2syncSupportProviders.sqf`

Sukurtas naujas serverio funkcija, kuri:
- Sinhronizuoja CAS support provider'ius su teisingais lėktuvais visiems klientams (įskaitant JIP)
- Naudoja `remoteExec` su `true` parametru (persistent), kad JIP žaidėjai taip pat gautų teisingus nustatymus
- Atnaujina cooldown laiką ir specialius vehicle init nustatymus (IFA3 modifikacijai)

**Integracija**: Funkcija kviečiama `V2startServer.sqf` faile po CAS support provider'io nustatymų (522-524 eilutės).

### 2. Kliento funkcija: `fn_V2syncSupportProvidersClient.sqf`

Sukurtas naujas kliento funkcija, kuri:
- Patikrina ir atnaujina support provider'ius prisijungiant (JIP)
- Atnaujina CAS support provider'ius su teisingais lėktuvais
- Jei žaidėjas yra leaderis, atnaujina support link'us
- Patikrina artilerijos prieigą - tikrina, ar artilerijos objektas (objArtiW/objArtiE) arba mortar objektas (objMortW/objMortE) egzistuoja
- Jei artilerijos objektas neegzistuoja, pašalina support link'ą

**Integracija**: Funkcija kviečiama `initPlayerLocal.sqf` faile JIP žaidėjams (58-62 eilutės).

### 3. Pakeitimai failuose

#### `functions/cfgFunctions.hpp`
- Pridėta `V2syncSupportProviders` funkcija į server klasę
- Pridėta `V2syncSupportProvidersClient` funkcija į client klasę

#### `warmachine/V2startServer.sqf`
- Pridėtas kvietimas `wrm_fnc_V2syncSupportProviders` po CAS support provider'io nustatymų (522-524 eilutės)

#### `initPlayerLocal.sqf`
- Pridėtas kvietimas `wrm_fnc_V2syncSupportProvidersClient` JIP žaidėjams (58-62 eilutės)

## Poveikis

1. **CAS Support**: Dabar JIP žaidėjai gaus teisingus lėktuvus (RHS Ukraine/Russia 2025 lėktuvai), o ne vanilla lėktuvus
2. **Artilerijos Support**: Dabar JIP žaidėjai nebegalės kviesti artilerijos, jei artilerijos objektas neegzistuoja arba yra sunaikintas

## Testavimas

Norint patikrinti, ar pataisymas veikia:

1. Paleisti serverį su misija
2. Prisijungti kaip žaidėjas ir patikrinti, kad CAS support rodo teisingus lėktuvus
3. Atsijungti ir vėl prisijungti (JIP)
4. Patikrinti, kad CAS support vis dar rodo teisingus lėktuvus (ne vanilla)
5. Patikrinti, kad artilerijos support veikia tik tada, kai artilerijos objektas egzistuoja

## Pastabos

- Funkcijos naudoja `waitUntil` ciklus, kad užtikrintų, jog visi reikalingi kintamieji yra apibrėžti prieš jų naudojimą
- Funkcijos turi debug pranešimus, kurie rodomi, jei `DBG` kintamasis yra `true`
- Funkcijos patikrina, ar objektai egzistuoja prieš juos naudojant (`isNil`, `isNull`, `alive`)

## Susiję failai

- `functions/server/fn_V2syncSupportProviders.sqf` - Serverio funkcija
- `functions/client/fn_V2syncSupportProvidersClient.sqf` - Kliento funkcija
- `warmachine/V2startServer.sqf` - Integracija serveryje
- `initPlayerLocal.sqf` - Integracija kliente
- `functions/cfgFunctions.hpp` - Funkcijų registracija

