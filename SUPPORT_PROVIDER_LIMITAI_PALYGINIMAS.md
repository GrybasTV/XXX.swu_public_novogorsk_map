# Support Provider Limitų Palyginimas: Originalas vs Mūsų Pakeitimai

## IŠTAISYTA: Neteisingas Supratimas

**SVARBU:** Pradžioje buvo neteisingas supratimas apie originalo elgesį. Po patikrinimo su originalo failais paaiškėjo:

## Originalo Versija (TEISINGA)

### `mission.sqm` - Support Provider Limitai
**Originalo faile:**
- `BIS_SUPP_limit_CAS_Heli` = `"-1"` (neribotas) nuo pradžių
- `BIS_SUPP_limit_Artillery` = `"-1"` (neribotas) nuo pradžių  
- `BIS_SUPP_limit_CAS_Bombing` = `"-1"` (neribotas) nuo pradžių

**Abi pusės (West ir East):**
```sqf
//Originalo mission.sqm - visi limitai "-1" nuo pradžių
value="-1"; //CAS_Heli - LAISVAS
value="-1"; //Artillery - LAISVAS
value="-1"; //CAS_Bombing - LAISVAS
```

### `warmachine/V2startServer.sqf` - Sektorių Užėmimas
**Originalo faile:**
- Nėra jokio `setVariable` kvietimo, kuris keistų support provider limitus
- Užėmus sektorius tik pridedami/pašalinami support link'ai (`BIS_fnc_addSupportLink` / `BIS_fnc_removeSupportLink`)
- Limitai lieka `-1` (neribotas) visą laiką

### Bazės Atskleidimas (Originalo Funkcionalumas)

**Originalas turėjo specialią sistemą bazės atskleidimui:**

1. **Bazės buvo paslėptos nuo pradžių:**
   - `secBW1`, `secBW2`, `secBE1`, `secBE2` = `false` pradžioje
   - Bazės marker'iai (`mFobW`, `mBaseW`, `mFobE`, `mBaseE`) buvo lokalūs ir matomi tik savo pusės žaidėjams

2. **Bazės atskleidžiamos kai priešas priartėja:**
   - Funkcijos: `fn_V2secBW1.sqf`, `fn_V2secBW2.sqf`, `fn_V2secBE1.sqf`, `fn_V2secBE2.sqf`
   - Tikrina ar priešas yra šalia bazės (200m atstumu)
   - Kai priešas priartėja, bazė tampa matoma ir sukuria sektorių

**Pavyzdys iš originalo (`fn_V2secBW1.sqf`):**
```sqf
//Originalo funkcija - tikrina ar priešas priartėjo prie bazės
while {!secBW1} do 
{
	{
		_unit=_x;
		if (side _unit==sideE) then
		{
			if (_unit distance posBaseW1 < 200) then {secBW1=true;};
		};
	}  forEach allUnits;
	sleep 5;
};
//Kai secBW1=true, bazė atskleidžiama ir sukuria sektorių
```

### Originalo Elgesys (TEISINGAS)
- **Pradžioje:** 
  - Support provider'iai (artilerija, CAS, antiair) **laisvi** (limitai `-1`)
  - Bazės (transporto ir tankų) **paslėptos** (`secBW1=false`, `secBW2=false`, `secBE1=false`, `secBE2=false`)
  
- **Užėmus sektorius:** 
  - Tik pridedami support link'ai, bet limitai lieka `-1`
  
- **Atrastus bazę (priešas priartėja 200m):**
  - Bazė atskleidžiama (`secBW1=true` arba `secBE1=true`, etc.)
  - Sukuria sektorių, kurį galima užimti
  - Bazės marker'iai tampa matomi visiems

## Mūsų Neteisingi Pakeitimai (ATŠAUKTI)

### Ką Bandėme Padaryti
- Užrakinti support provider'ius pradžioje (limitai `0`)
- Atrakinti juos užėmus sektorius (limitai `-1`)

### Kodėl Tai Buvo Neteisinga
- Originalas **neturėjo** šios funkcijos
- Support provider'iai turėjo būti **laisvi nuo pradžių**
- Problema buvo ne support provider'iuose, o bazės atskleidime

## Išvados

### Originalo Dizainas
1. **Support Provider'iai:** Laisvi nuo pradžių (artilerija, CAS, antiair)
2. **Bazės:** Paslėptos ir atskleidžiamos tik kai priešas priartėja prie 200m
3. **Sektoriai:** A, B, C (Anti-Air, Artillery, CAS) matomi nuo pradžių
4. **Bazės Sektoriai:** D, E, F, G atskleidžiami tik kai atrastos

### Mūsų Pakeitimai (ATŠAUKTI)
- ❌ Užrakinti support provider'ius - **NETEISINGA**
- ✅ Palikti support provider'ius laisvus kaip originalas - **TEISINGA**

## Dabar (Po Atšaukimų)

### `mission.sqm`
- Visi support provider limitai = `"-1"` (neribotas) kaip originalas

### `warmachine/V2startServer.sqf`
- Nėra `setVariable` kvietimų limitams keisti
- Tik support link'ai kaip originalas

## Pastaba apie Antiraketinę (Anti-Air)

Antiraketinė (Anti-Air) **nėra** support provider sistema - tai yra transporto priemonė, kuri spawn'ina užėmus sektorių. Support provider UI gali rodyti ją kaip laisvą, nes ji nėra support provider sistema ir neturi `BIS_SUPP_limit` kintamojo.

## Failai, Kurie Buvo Pakeisti ir Atšaukti

1. `mission.sqm` - atšaukti pakeitimai, grąžinti į `-1` kaip originalas
2. `warmachine/V2startServer.sqf` - pašalinti `setVariable` kvietimai limitams keisti

**Rezultatas:** Dabar elgiamės kaip originalas - support provider'iai laisvi nuo pradžių, bazės paslėptos ir atskleidžiamos tik kai atrastos.

