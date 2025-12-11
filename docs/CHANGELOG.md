# Changelog

## [Neišleistas] - 2025-01-XX

### Dokumentacijos atnaujinimai
- **Dokumentacijos validavimas**: Atlikta interneto paieška ir patikrintos kritinės techninės tezės
  - Patikslinta `waitUntil` terminologija: "server freeze" → "scheduler starvation"
  - Koreguota OnOwnerChange callback formato informacija
  - Paaiškinti skirtingi AI freeze problemų tipai
- **Dokumentacijos sistemingumas**: Standartizuoti versijų ir datų formatai visuose dokumentuose
- **README.md atnaujinimas**: Pridėtas JIP_FIX.md ir patikslinta legacy reference informacija

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
