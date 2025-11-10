# Ukraine vs Russia Warmachine

**Arma 3 Dynamic Conquest Mission** - Ukraine vs Russia factions with extensive mod support and advanced AI systems.

## 🚀 Quick Start

1. **Download**: [v2.0 Production Release](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/releases/download/v2.0-production-ready/XXX.swu_public_novogorsk_map_v2.0.pbo)
2. **Install**: Copy `.pbo` to your Arma 3 `mpmissions` folder
3. **Launch**: Start Arma 3 with required mods (see Requirements below)
4. **Play**: Select "Ukraine vs Russia Warmachine" from multiplayer menu

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
- **[Known Pitfalls](docs/KNOWN_PITFALLS.md)** - Common issues and solutions
- **[Rollback Plan](docs/ROLLBACK_PLAN.md)** - Rollback instructions for v1.9

## 🏷️ Releases

| Version | Date | Changes | Download | Rollback |
|---------|------|---------|----------|----------|
| **v2.0** | 2025-11-10 | Major SQF optimizations, JIP improvements, DS enforcer | [Download .pbo](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/releases/download/v2.0-production-ready/XXX.swu_public_novogorsk_map_v2.0.pbo) | N/A |
| v1.9 | 2025-11-04 | Ukraine/Russia factions, UAV systems | Legacy | [Download .pbo](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/releases/download/v1.9-ukraine-russia/XXX.swu_public_novogorsk_map_v1.9.pbo) |

## 🔧 Compatibility Matrix

| Component | Version | Status | Notes |
|-----------|---------|--------|-------|
| **CBA_A3** | Latest | ✅ Required | Always required for all functionality |
| **Arma 3 Apex** | Latest | ✅ Required | Required for advanced mission features |
| **RHS AFRF** | Latest | ✅ Required | Required for Ukraine vs Russia 2025 profile |
| **RHS USAF** | Latest | ✅ Required | Required for Ukraine vs Russia 2025 profile |
| **IFA3** | Latest | ⚠️ Optional | Alternative WW2 faction profile |
| **SPE** | Latest | ⚠️ Optional | Alternative WW2 faction profile |
| **CUP Weapons** | Latest | ⚠️ Optional | Enhanced weapon variety |
| **GM** | Latest | ⚠️ Optional | Cold War faction profile |
| **VN** | Latest | ⚠️ Optional | Vietnam War faction profile |

**Profile Selection:**
- **RHS Profile**: Requires RHS AFRF + RHS USAF (Ukraine vs Russia 2025)
- **Alternative Profiles**: CUP/IFA3/SPE/GM/VN (no RHS required)

## ⚙️ Server Configuration Tips

### Recommended Server Settings

**Difficulty Settings:**
- **AI Skill**: 0.5-0.7 (balanced challenge)
- **AI Precision**: 0.3-0.5 (realistic accuracy)
- **Revive System**: Enabled (mission supports AI revive)

**Performance Settings:**
- **MaxMsgSend**: 128-256 (network optimization)
- **MaxSizeGuaranteed**: 512 (for large marker counts)
- **MaxSizeNonguaranteed**: 256 (standard)
- **MinBandwidth**: 131072 (128 KB/s minimum)
- **MaxBandwidth**: 10000000 (10 MB/s maximum)

**Headless Client (Optional):**
- Recommended for 20+ AI units
- Configure HC to handle AI groups
- Mission automatically distributes AI to HC if available

**BattlEye Settings:**
- **RemoteExec Restrictions**: Enabled (mission uses CfgRemoteExec whitelist)
- **Script Restrictions**: Standard (mission scripts are whitelisted)
- **Signature Verification**: Enabled (recommended)

**Mission Parameters:**
- **Player Count**: 1-48 players supported
- **AI Count**: 40-60 units optimal (performance tested)
- **Sector Count**: 4 sectors (BE1, BE2, BW1, BW2)
- **UAV/UGV Limit**: Per-squad limits (prevents spam)

### Troubleshooting

**"remoteExec restriction" errors:**
- Ensure `CfgRemoteExec.hpp` is included in `description.ext`
- Check BattlEye whitelist matches mission functions
- Verify `mode=1` (whitelist) and `jip=0` settings

**Performance Issues:**
- Reduce AI count if FPS < 40
- Enable Dynamic Simulation (automatic in v2.0)
- Check cleanup systems are running (corpse/wreck limits)

**JIP Desynchronization:**
- Verify `wrm_fnc_V2jipRestoration` is called on PlayerConnected
- Check RPT logs for `[JIP_RESTORATION]` entries
- Ensure mission variables are public (`publicVariable`)

## 🧪 Smoke Tests

Quick validation scripts for production readiness:

- **[RemoteExec Check](tests/run_remoteexec_check.sqf)** - Validates CfgRemoteExec whitelist
- **[DS Enforcer Check](tests/run_ds_enforcer_smoke.sqf)** - Verifies Dynamic Simulation exclusions
- **[JIP Smoke Test](tests/run_jip_smoke.sqf)** - Tests JIP state restoration

**Usage:** ExecVM scripts on server, check RPT logs for results.

## 🐛 Issues & Support

- **Bug Reports**: [GitHub Issues](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/issues)
- **Performance**: Check `docs/MODIFICATIONS.md` for optimization details
- **Compatibility**: Ensure CBA_A3 is loaded

## 📄 License

This mission is provided as-is for Arma 3 community use. Respect Bohemia Interactive's EULA and mod authors' licenses.

---

**Built with ❤️ for Arma 3 community**