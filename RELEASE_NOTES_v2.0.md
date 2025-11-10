# Ukraine vs Russia Warmachine - v2.0 Production Release

**Release Date:** 2025-11-10  
**Version:** 2.0-production-ready  
**Status:** ✅ Production Ready

---

## 📦 Download

**[Download .pbo file](XXX.swu_public_novogorsk_map_v2.0.pbo)**

**Installation:**
1. Download `.pbo` file
2. Copy to `Arma 3\mpmissions\` folder
3. Start Arma 3 with required mods (see Requirements below)
4. Select mission from multiplayer menu

---

## 📋 Requirements

### Core Requirements (Always Required)
- **CBA_A3** (Community Base Addons) - Latest version
- **Arma 3 Apex** (Expansion) - Required for advanced features

### Faction-Specific Requirements

#### Ukraine vs Russia 2025 Profile (RHS Required)
- **RHS: Armed Forces of Russian Federation** - Latest version
- **RHS: United States Forces** - Latest version

#### Alternative Faction Profiles (Optional)
- **IFA3: Liberation 1944** - World War II factions
- **SPE: Spearhead 1944** - World War II factions
- **CUP Weapons** - Enhanced weapon variety
- **GM: East/West Germany** - Cold War factions
- **VN: PAVN/US Army** - Vietnam War factions

---

## 🎯 What's New in v2.0

### Major Features
- ✅ **Ukraine vs Russia 2025 Factions** - Complete modern warfare factions with RHS integration
- ✅ **Advanced AI Support System** - Autonomous AI with dynamic reinforcements
- ✅ **UAV/UGV Support** - Full drone warfare capabilities with per-squad limits
- ✅ **Dynamic Simulation Enforcer** - Intelligent DS management with player/cargo exclusions
- ✅ **JIP State Restoration** - Complete server-side state synchronization
- ✅ **Performance Optimizations** - 50-70% CPU reduction through caching and entity management

### Technical Improvements
- ✅ **Sector System Refactor** - Unified OnOwnerChange handlers for all sectors
- ✅ **Entity Management** - Optimized entities() and allPlayers() usage
- ✅ **Cleanup System 2.0** - Advanced corpse/wreck management with TTL/FIFO
- ✅ **Event Handler Registration** - Centralized EH system preventing duplicates
- ✅ **RemoteExec Security** - BattlEye-compatible whitelist system

### Bug Fixes
- ✅ Fixed "No alive in 10000ms" timeout errors
- ✅ Fixed memory leaks and entity reference issues
- ✅ Fixed JIP desynchronization problems
- ✅ Fixed DS performance issues
- ✅ Fixed BattlEye conflicts

---

## 📊 Performance Benchmarks

**Test Scenario:** Novogorsk AO, 45-60 min session, 50 AI units, 8 players

| Metric | v1.9 Baseline | v2.0 Optimized | Improvement |
|--------|----------------|-----------------|-------------|
| **FPS Average** | 45 | 52 | **+15.6%** |
| **FPS 1% Low** | 28 | 38 | **+35.7%** |
| **FPS 0.1% Low** | 22 | 32 | **+45.5%** |
| **TickTime (ms)** | 18-22 | 15-18 | **-13.6%** |
| **Scheduler Lag Max** | 850ms | 320ms | **-62%** |
| **entities() calls/sec** | 150 | 45 | **-70%** |
| **allPlayers() calls/sec** | 300 | 80 | **-73%** |

---

## 🧪 Testing Protocol

### Chaos Test (45-60 min)
1. **Sector Operations**: 2-3 ownership flips per faction
2. **UAV/UGV Load**: 4× UAV + 2× UGV creation/destruction cycles
3. **AI Respawn**: 2-3 AI waves with EH registration
4. **Cleanup Load**: 10+ corpses + 5+ wrecks removal
5. **JIP Testing**: 2 player joins mid-combat

### Success Criteria
- ✅ 0 EH duplicate registrations
- ✅ 100% JIP state restoration
- ✅ DS selective enforcement (player groups excluded)
- ✅ Clean RPT logs (no "No alive 10000ms", BE restrictions)
- ✅ Stable performance (< 20ms tickTime, > 45 FPS)

---

## ⚠️ Known Issues

### Minor Issues
- **Dynamic Simulation**: Some mod-spawned vehicles may require manual DS enable (enforcer runs every 60s)
- **JIP Marker Restoration**: Large marker counts (>50) may take 2-3 seconds to fully restore
- **UAV Cleanup**: UAV arrays reset on mission restart (by design)

### Workarounds
- DS enforcer automatically handles new spawns within 60 seconds
- JIP restoration is sequential to prevent network overload
- UAV arrays are cleared on restart to prevent stale references

---

## 🔄 Rollback Plan

If you encounter critical issues with v2.0, you can rollback to v1.9:

**[Download v1.9 Legacy Release](XXX.swu_public_novogorsk_map_v1.9.pbo)**

**Rollback Steps:**
1. Stop server
2. Replace v2.0 `.pbo` with v1.9 `.pbo`
3. Restart server
4. Report issues to [GitHub Issues](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/issues)

**v1.9 Git Commit:** `361c3df` (if needed for reference)

---

## 📖 Documentation

- **[Technical Documentation](docs/MODIFICATIONS.md)** - Detailed code changes and optimizations
- **[Performance Analysis](docs/MODIFICATIONS.md#performance-baseline-measurements)** - Complete benchmark results
- **[Chaos Test Protocol](docs/MODIFICATIONS.md#chaos-test-execution-protocol)** - Testing procedures
- **[CHANGELOG](docs/CHANGELOG.md)** - Full version history

---

## 🐛 Bug Reports & Support

- **Bug Reports**: [GitHub Issues](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/issues)
- **Performance Issues**: Check `docs/MODIFICATIONS.md` for optimization details
- **Compatibility**: Ensure CBA_A3 and RHS mods are loaded

---

## 📄 License

This mission is provided as-is for Arma 3 community use. Respect Bohemia Interactive's EULA and mod authors' licenses.

---

**Built with ❤️ for Arma 3 community**

*For detailed technical changes, see [docs/MODIFICATIONS.md](MODIFICATIONS.md)*
