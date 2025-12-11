# Mission Documentation

## Core Guides
- **[Development Guidelines](DEVELOPMENT_GUIDELINES.md)** - **READ THIS FIRST**. Critical rules to prevent server hangs and bugs.
- **[SQF Best Practices](SQF_SYNTAX_BEST_PRACTICES.md)** - Detailed technical reference for SQF syntax and optimization.
- **[Changelog](CHANGELOG.md)** - History of changes and fixes.

## Feature Documentation
- **[Vehicle Spawning](HOW_TO_SPAWN_VEHICLES.md)** - Guide for spawning vehicles correctly.
- **[AI Analysis](ANALYSIS_AI_VEHICLE_CREW_SPAWNING.md)** - Deep dive into AI crew spawning logic.
- **[CAS System](ANALYSIS_CAS.md)** - Documentation for Close Air Support system.
- **[Artillery System](ANALYSIS_ARTILLERY.md)** - Documentation for Artillery system.

## Troubleshooting & Fixes
- **[Server Freeze Fix](CRITICAL_FIX_MISSION_FREEZE.md)** - Analysis of the server hang issue and how it was fixed.
- **[Scheduler Deadlock](SCHEDULER_DEADLOCK_FIX_FINAL.md)** - Fix for the scheduler deadlock issue.
- **[AI Freeze Fix](AI_FREEZE_FIX.md)** - Fix for AI freezing issues.
- **[JIP Fix](JIP_FIX.md)** - Join In Progress synchronization issues and fixes.

## Legacy
- **[Legacy Reference](legacy_reference/)** - Old mission files and backups (formerly `docs/original`).
  - **Note**: Contains the original codebase before major AI and performance improvements.
  - **Missing newer functions**: `fn_V2aiStuckCheck.sqf`, `fn_V2dynamicAIon.sqf`, `fn_V2dynamicSquads.sqf`, JIP sync functions, and UAV group management.
