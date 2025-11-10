# Rollback Plan - v2.0 to v1.9

## Overview
This document provides step-by-step instructions for rolling back from v2.0-production-ready to v1.9-ukraine-russia if critical issues are encountered.

## Prerequisites
- Access to server file system
- v1.9 `.pbo` file (download from [GitHub Releases](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/releases/tag/v1.9-ukraine-russia))
- Server admin privileges

## Rollback Steps

### 1. Stop Server
```bash
# Stop Arma 3 server process
# Ensure all players are disconnected
```

### 2. Backup Current Version
```bash
# Backup v2.0 .pbo file
cp XXX.swu_public_novogorsk_map_v2.0.pbo XXX.swu_public_novogorsk_map_v2.0.pbo.backup
```

### 3. Replace with v1.9
```bash
# Copy v1.9 .pbo to mpmissions folder
cp XXX.swu_public_novogorsk_map_v1.9.pbo Arma3/mpmissions/XXX.swu_public_novogorsk_map.pbo
```

### 4. Verify Installation
- Check file size matches v1.9 release
- Verify file permissions (readable by server)
- Check file timestamp

### 5. Restart Server
```bash
# Start Arma 3 server
# Monitor RPT logs for errors
```

### 6. Test Mission
- Join server and verify mission loads
- Check basic functionality (spawning, sectors, AI)
- Monitor performance metrics

## v1.9 Git Reference

**Commit Hash:** `361c3df`  
**Tag:** `v1.9-ukraine-russia`  
**Date:** 2025-11-04

**Key Differences from v2.0:**
- No Dynamic Simulation enforcer
- No centralized JIP restoration
- No RemoteExec whitelist (may cause BE issues)
- Basic cleanup system (no TTL/FIFO)
- Performance optimizations not included

## Known v1.9 Limitations

1. **Performance**: Lower FPS (45 vs 52 average)
2. **Scheduler Lag**: Higher max lag (850ms vs 320ms)
3. **JIP Issues**: May experience desynchronization
4. **DS Management**: Manual DS enable required for mod spawns
5. **BattlEye**: May trigger false positives without CfgRemoteExec

## Reporting Issues

If rollback is necessary, please report:
1. **Issue Description**: What went wrong?
2. **RPT Logs**: Relevant error messages
3. **Reproduction Steps**: How to reproduce
4. **Server Environment**: Mods, player count, duration

**Report to:** [GitHub Issues](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/issues)

## Reverting Rollback (Upgrade Back to v2.0)

If issues are resolved and you want to return to v2.0:

1. Stop server
2. Replace v1.9 `.pbo` with v2.0 `.pbo`
3. Restart server
4. Monitor for issues

## Emergency Contacts

- **GitHub Issues**: [Create Issue](https://github.com/GrybasTV/XXX.swu_public_novogorsk_map/issues/new)
- **Documentation**: [MODIFICATIONS.md](docs/MODIFICATIONS.md)

---

**Last Updated:** 2025-11-10  
**Version:** 2.0-production-ready
