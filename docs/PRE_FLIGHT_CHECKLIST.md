# Pre-Flight Test Checklist - v2.0 Production Release

**Test Date:** _______________  
**Tester:** _______________  
**Server Environment:** _______________  
**Mods Loaded:** _______________

---

## ✅ Quick Tests (10-15 minutes)

### 1. RemoteExec/BattlEye Test (5 min)
- [ ] Start server with v2.0 `.pbo`
- [ ] Monitor RPT logs for "remoteExec restriction" errors
- [ ] **Expected:** 0 restriction errors
- [ ] **Result:** PASS / FAIL
- [ ] **Notes:** _______________

### 2. DS Enforcer Test (5-10 min)
- [ ] Wait 5-10 minutes after server start
- [ ] Spawn new AI groups (via mission or mod)
- [ ] Check RPT logs for `[DS_GROUP_SKIP]` and `[DS_VEHICLE_SKIP]`
- [ ] Verify player groups are NOT flagged with DS
- [ ] Verify active vehicles with crew/cargo are NOT flagged
- [ ] **Expected:** New AI/vehicles have DS, player groups excluded
- [ ] **Result:** PASS / FAIL
- [ ] **Notes:** _______________

### 3. JIP Smoke Test (5 min)
- [ ] Have 1-2 players join mid-combat (after 10-15 min of play)
- [ ] Verify markers are restored (check map)
- [ ] Verify support links are visible
- [ ] Verify Zeus objects are editable (if Zeus enabled)
- [ ] Verify UAV arrays are synchronized
- [ ] Check RPT logs for `[JIP_RESTORATION]` entries
- [ ] **Expected:** Complete state restoration within 2-3 seconds
- [ ] **Result:** PASS / FAIL
- [ ] **Notes:** _______________

---

## 🧪 Chaos Test Lite (15-20 minutes)

### 4. Sector Operations (5 min)
- [ ] Trigger 1 sector ownership flip (BE1/BW1)
- [ ] Check RPT logs for `[SEC_CHANGE]` entries
- [ ] Verify markers are created/deleted correctly
- [ ] Verify OnOwnerChange logic executes
- [ ] **Expected:** Clean sector flip, no errors
- [ ] **Result:** PASS / FAIL
- [ ] **Notes:** _______________

### 5. UAV/UGV Load (5 min)
- [ ] Create 1-2 UAV (WEST + EAST)
- [ ] Create 1 UGV
- [ ] Destroy UAV/UGV
- [ ] Check RPT logs for `[UAV_START]`, `[UAV_SUCCESS]`, `[UAV_ERROR]`
- [ ] Verify `uavSquadW/E` arrays update correctly
- [ ] **Expected:** Clean creation/destruction, arrays synchronized
- [ ] **Result:** PASS / FAIL
- [ ] **Notes:** _______________

### 6. AI Respawn Wave (5 min)
- [ ] Trigger 1 AI respawn wave
- [ ] Check RPT logs for EH registration (no duplicates)
- [ ] Verify `wrm_eh_mpkilled` flags are set
- [ ] **Expected:** 0 duplicate EH registrations
- [ ] **Result:** PASS / FAIL
- [ ] **Notes:** _______________

### 7. Cleanup Load (5 min)
- [ ] Generate 5+ corpses and 2+ wrecks
- [ ] Wait for cleanup cycle
- [ ] Check RPT logs for `[WRM][CLEANUP]` entries
- [ ] Verify WeaponHolder objects are removed
- [ ] **Expected:** Clean cleanup, no memory leaks
- [ ] **Result:** PASS / FAIL
- [ ] **Notes:** _______________

---

## 📊 Performance Metrics

### 8. Performance Baseline (5 min)
- [ ] Monitor `diag_fps` (average)
- [ ] Monitor `diag_tickTime` (ms)
- [ ] Monitor scheduler lag (max)
- [ ] **Expected:** 
  - FPS > 45 average
  - TickTime < 20ms average
  - Max lag < 350ms
- [ ] **Result:** PASS / FAIL
- [ ] **Actual Values:**
  - FPS: _______
  - TickTime: _______ ms
  - Max Lag: _______ ms
- [ ] **Notes:** _______________

---

## 🔍 RPT Log Analysis

### 9. Error Check
- [ ] Search RPT for "No alive in 10000ms"
- [ ] Search RPT for "remoteExec restriction"
- [ ] Search RPT for "undefined variable"
- [ ] Search RPT for "script error"
- [ ] **Expected:** 0 critical errors
- [ ] **Result:** PASS / FAIL
- [ ] **Error Count:** _______
- [ ] **Notes:** _______________

### 10. Warning Check
- [ ] Search RPT for warnings (non-critical)
- [ ] Review warning patterns
- [ ] **Expected:** Minimal warnings (DS enforcer, cleanup cycles OK)
- [ ] **Result:** PASS / FAIL
- [ ] **Warning Count:** _______
- [ ] **Notes:** _______________

---

## 📝 Final Checklist

- [ ] All quick tests PASSED
- [ ] Chaos test lite PASSED
- [ ] Performance metrics within acceptable range
- [ ] RPT logs clean (no critical errors)
- [ ] Known issues documented
- [ ] Ready for production release

---

## 🚨 Critical Issues Found

**Issue 1:**
- Description: _______________
- Severity: CRITICAL / HIGH / MEDIUM / LOW
- Impact: _______________
- Workaround: _______________

**Issue 2:**
- Description: _______________
- Severity: CRITICAL / HIGH / MEDIUM / LOW
- Impact: _______________
- Workaround: _______________

---

## ✅ Sign-Off

**Tester Signature:** _______________  
**Date:** _______________  
**Recommendation:** APPROVE / REJECT / CONDITIONAL APPROVAL

**Conditions (if conditional):**
_______________
_______________

---

**Test Protocol Version:** 1.0  
**Last Updated:** 2025-11-10
