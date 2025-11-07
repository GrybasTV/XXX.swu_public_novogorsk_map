# JIP Respawn Laiko Bugas - Greitas Respawn Naujiems Žaidėjams

## Problema

Prisijungus į naują misiją (JIP), leidžiama respawn'inti daug greičiau nei turėtų būti. JIP žaidėjai gauna 5 sekundžių respawn laiką vietoj teisingo `rTime` (kuris gali būti 30, 60, 120, 180 arba 200 sekundžių pagal config parametrus).

## Priežastis

### Dabartinė Sistema

1. **initPlayerLocal.sqf**: Nustato `fs=0;` visiems žaidėjams (įskaitant JIP)
2. **V2firstSpawn.sqf**: Nustato `fs=1;` tik po pirmo respawn'o
3. **onPlayerKilled.sqf**: Tikrina `fs` kintamąjį:
   - Jei `fs==1`: Naudoja `rTime` (teisingas respawn laikas)
   - Jei `fs!=1`: Naudoja hardkodintą 5 sekundžių respawn laiką

### Problema

JIP žaidėjams `fs` kintamasis gali likti `0`, nes:
- Jie neprisijungia per `V2firstSpawn.sqf` arba
- Jie gali respawn'inti prieš tai, kai `V2firstSpawn.sqf` nustato `fs=1`

Todėl JIP žaidėjai gauna 5 sekundžių respawn laiką vietoj teisingo `rTime`.

## Sprendimas

Pakeista `onPlayerKilled.sqf` logika:
- **Anksčiau**: Naudojo `fs` kintamąjį, kad nustatytų respawn laiką
- **Dabar**: Visada naudoja `rTime` kintamąjį, kuris yra teisingai nustatomas visiems žaidėjams (įskaitant JIP) per `V2playerSideChange.sqf`

**Pakeitimai**:
- `onPlayerKilled.sqf`: Pašalinta `fs` kintamojo priklausomybė, dabar visada naudoja `rTime`
- Pridėtas fallback, jei `rTime` nėra apibrėžtas (naudojama default reikšmė 100 sekundžių)

## Testavimas

Po pakeitimų reikia patikrinti:
1. Ar JIP žaidėjai gauna teisingą respawn laiką (pagal config parametrus)
2. Ar originalūs žaidėjai vis dar gauna teisingą respawn laiką
3. Ar nėra jokių error'ų arba warning'ų

## Nuorodos

- `onPlayerKilled.sqf` - nustato respawn laiką žaidėjui mirus
- `V2playerSideChange.sqf` - nustato `rTime` pagal config parametrus (asp12)
- `initPlayerLocal.sqf` - inicializuoja `fs=0;` kintamąjį
- `warmachine/V2firstSpawn.sqf` - nustato `fs=1;` po pirmo respawn'o

