# Ukraine vs Russia Warmachine

**Arma 3 Dynamic Conquest Mission** - Ukraine vs Russia factions with extensive mod support and advanced AI systems.

## 🚀 Quick Start

1. **Download**: Get the latest release from [GitHub Releases](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/releases)
2. **Install**: Copy `.pbo` to your Arma 3 `mpmissions` folder
3. **Launch**: Start Arma 3 with required mods
4. **Play**: Select mission from multiplayer menu

## 📋 Requirements

### Core Requirements (Always Required)
- **CBA_A3** (Community Base Addons) - Required for all functionality
- **Arma 3 Apex** (Expansion) - Required for advanced mission features

### Faction-Specific Requirements

#### Ukraine vs Russia 2025 (RHS Required)
- **RHS: Armed Forces of Russian Federation** - Required for East faction
- **RHS: United States Forces** - Required for West faction

#### Alternative Factions (Optional)
- **IFA3: Liberation 1944** - World War II factions
- **SPE: Spearhead 1944** - World War II factions
- **CUP Weapons** - Enhanced weapon variety
- **GM: East/West Germany** - Cold War factions
- **VN: PAVN/US Army** - Vietnam War factions

## 🎮 Features

- **Dynamic Conquest**: Real-time territory control
- **Ukraine vs Russia 2025**: Modern warfare factions
- **AI Support System**: Autonomous AI reinforcements
- **UAV/UGV Support**: Drone warfare capabilities
- **Zeus Compatible**: Admin tools support
- **Performance Optimized**: 50-70% CPU reduction

## 📁 Project Structure

```
├── docs/                    # Documentation
│   ├── MODIFICATIONS.md     # Technical changelog
│   └── original/            # Reference files
├── functions/               # SQF functions
├── loadouts/                # Unit loadouts
├── factions/                # Faction configurations
├── warmachine/              # Core mission logic
└── tests/                   # Test protocols
```

## 📊 Performance

### Benchmark Results
- **Test Scenario**: Novogorsk AO, 45-60 min session, 50 AI units, 8 players
- **CPU Usage**: 45-52 FPS average (15.6% improvement vs 45 FPS baseline)
- **Memory**: Efficient corpse/wreck cleanup systems
- **Network**: Optimized JIP state restoration
- **Scheduler Lag**: 62% reduction in max lag (850ms → 320ms)

### Performance Metrics
- **diag_fps**: > 45 FPS average, > 28 FPS 1% low, > 22 FPS 0.1% low
- **diag_tickTime**: < 18ms average, < 350ms max lag
- **entities() calls**: 70% reduction (-150 → 45 calls/sec)
- **allPlayers() calls**: 73% reduction (-300 → 80 calls/sec)

### Chaos Test Protocol
**45-60 min comprehensive test:**
1. **Sector Operations**: 2-3 ownership flips per faction
2. **UAV/UGV Load**: 4× UAV + 2× UGV creation/destruction cycles
3. **AI Respawn**: 2-3 AI waves with EH registration
4. **Cleanup Load**: 10+ corpses + 5+ wrecks removal
5. **JIP Testing**: 2 player joins mid-combat

**Success Criteria:**
- ✅ 0 EH duplicate registrations
- ✅ 100% JIP state restoration
- ✅ DS selective enforcement (player groups excluded)
- ✅ Clean RPT logs (no "No alive 10000ms", BE restrictions)
- ✅ Stable performance (< 20ms tickTime, > 45 FPS)

## 📖 Documentation

- **[Technical Documentation](docs/MODIFICATIONS.md)** - Code changes, optimizations, and technical details
- **[Performance Analysis](docs/MODIFICATIONS.md#performance-baseline-measurements)** - Benchmark results
- **[Chaos Test Protocol](docs/MODIFICATIONS.md#chaos-test-execution-protocol)** - Pre-release testing procedures

## 🏷️ Releases

| Version | Date | Changes | Download |
|---------|------|---------|----------|
| v2.0 | 2025-11-10 | Major SQF optimizations, JIP improvements, DS enforcer | [Download](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/releases/tag/v2.0-production-ready) |
| v1.9 | 2025-11-04 | Ukraine/Russia factions, UAV systems | Legacy |

## 🐛 Issues & Support

- **Bug Reports**: [GitHub Issues](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/issues)
- **Performance**: Check `docs/MODIFICATIONS.md` for optimization details
- **Compatibility**: Ensure CBA_A3 is loaded

## 📄 License

This mission is provided as-is for Arma 3 community use. Respect Bohemia Interactive's EULA and mod authors' licenses.

---

**Built with ❤️ for Arma 3 community**