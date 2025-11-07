# Kodėl Reikia Keisti Loadout'us?

## Pagrindinis Klausimas

**Kodėl mes negalime tiesiog naudoti soldier type'ų? Kodėl reikia keisti loadout'us?**

## Situacija

### Dabar `mission.sqm` naudoja:
- **Vanilla klases**: `B_Soldier_SL_F`, `B_soldier_LAT_F`, `O_Soldier_SL_F`, etc.
- Tai yra **NATO ir CSAT** klasės su jų uniformomis ir ginklais

### Mes norime:
- **Ukraine 2025** uniformas ir ginklus
- **Russia 2025** uniformas ir ginklus

## Variantai

### Variantas 1: PALIKTI Vanilla Klases + Keisti Loadout'us (DABARTINĖ SISTEMA)

**Kaip veikia:**
1. `mission.sqm` naudoja `B_Soldier_SL_F` (vanilla NATO)
2. `fn_V2loadoutChange` paverčia į `WEST800` (Ukraine 2025 loadout)
3. `setUnitLoadout` pritaiko Ukraine 2025 uniformą/ginklus

**Privalumai:**
- ✅ `mission.sqm` lieka universalus (galima naudoti su kitomis frakcijomis)
- ✅ Nereikia keisti `mission.sqm` failo
- ✅ Sistema veikia su visomis frakcijomis

**Trūkumai:**
- ❌ Reikia keisti loadout'us per skriptą
- ❌ Gali būti problemų su respawn loadout keitimu
- ❌ Sudėtingesnė sistema

### Variantas 2: KEISTI `mission.sqm` į Custom Klases (PAPRASČIAUSIA)

**Kaip veikia:**
1. `mission.sqm` naudoja `UA_Azov_lieutenant` (Ukraine 2025 klasė)
2. Žaidėjas **AUTOMATIŠKAI** gauna Ukraine 2025 uniformą/ginklus iš klasės config'o
3. **NEREIKIA** keisti loadout'ų per skriptą!

**Privalumai:**
- ✅ **PAPRASČIAUSIA** - nereikia jokios loadout keitimo sistemos
- ✅ **VEIKIA AUTOMATIŠKAI** - klasės config'as turi teisingą loadout'ą
- ✅ **MAŽIAU BUG'Ų** - nereikia sudėtingos logikos
- ✅ **VEIKIA RESPWNE** - žaidėjas visada gauna teisingą loadout'ą

**Trūkumai:**
- ❌ Reikia keisti `mission.sqm` failą (visus unit'us)
- ❌ `mission.sqm` tampa specifinis tik Ukraine/Russia frakcijoms
- ❌ Jei norėsime kitų frakcijų, reikės atsarginių kopijų

## Kodėl Originalo Sistema Naudojo Vanilla Klases?

**Originalo sistema** buvo sukurta **palaikyti daugybei frakcijų**:
- NATO vs CSAT
- USAF vs AFRF (RHS)
- West Germany vs East Germany
- etc.

Todėl `mission.sqm` naudoja **universalias vanilla klases**, o loadout'us keičia per skriptą, priklausomai nuo pasirinktos frakcijos.

## Ar Reikia Keisti Loadout'us, Jei Naudojame Tik Ukraine vs Russia?

**NE!** Jei naudojate **TIK Ukraine 2025 vs Russia 2025**, galite:

1. **Pakeisti `mission.sqm`**:
   - `B_Soldier_SL_F` → `UA_Azov_lieutenant`
   - `O_Soldier_SL_F` → `RUS_MSV_east_lieutenant`
   - etc.

2. **Pašalinti loadout keitimų sistemą**:
   - Nereikia `fn_V2loadoutChange` funkcijos
   - Nereikia `onPlayerRespawn.sqf` loadout keitimo
   - Sistema veikia automatiškai!

## Kas Būtų, Jei Naudotume Tiesiogiai Custom Klases?

**Jei `mission.sqm` naudotų `UA_Azov_lieutenant`:**
- Žaidėjas **automatiškai** gauna Ukraine 2025 uniformą/ginklus
- **Nereikia** keisti loadout'ų per skriptą
- **Veikia** respawn metu (Arma 3 automatiškai pritaiko klasės loadout'ą)

**Rezultatas:**
- Paprasčiau
- Mažiau bug'ų
- Greičiau

## Rekomendacija

**Jei naudojate TIK Ukraine 2025 vs Russia 2025:**

**KEISTI `mission.sqm` į custom klases ir PAŠALINTI loadout keitimų sistemą!**

**Kodėl:**
1. **Paprasčiau** - nereikia sudėtingos logikos
2. **Mažiau bug'ų** - Arma 3 automatiškai pritaiko loadout'ą
3. **Veikia respawn metu** - nereikia specialių skriptų

**Ką reikia padaryti:**
1. Pakeisti visus `B_Soldier_*` → `UA_Azov_*` `mission.sqm`
2. Pakeisti visus `O_Soldier_*` → `RUS_MSV_*` arba `RUS_spn_*` `mission.sqm`
3. Pašalinti `fn_V2loadoutChange` kvietimus (arba palikti tik AI unit'ams)
4. Pašalinti `onPlayerRespawn.sqf` loadout keitimą

## Išvados

1. **Loadout keitimas reikalingas** TIK jei naudojate **universalias vanilla klases** su keliais frakcijomis
2. **Jei naudojate tik vieną frakciją**, galite tiesiogiai naudoti **custom klases** `mission.sqm`
3. **Custom klases** automatiškai turi teisingus loadout'us config'e - nereikia keisti per skriptą

## Kitas Žingsnis

**Klausimas**: Ar norite pakeisti `mission.sqm` į custom klases ir pašalinti loadout keitimų sistemą?

- **Jei taip**: Pakeisime `mission.sqm` ir supaprastinsime sistemą
- **Jei ne**: Paliksime dabartinę sistemą, bet patobulinsime loadout keitimą

