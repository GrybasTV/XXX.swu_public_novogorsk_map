# Development Guidelines & Critical Safety Rules

**Version:** 1.1
**Last Updated:** 2025-12-11

This document summarizes the **golden rules** for developing in this mission. Following these rules is **mandatory** to prevent server crashes and freezes.

## 🚨 CRITICAL: ANTI-FREEZE RULES (The "Hang" Fixes)

### 1. NEVER use `waitUntil` without a Timeout
**Problem:** If the condition is never met, the script halts forever. If this happens in a scheduled environment (spawn), it causes **scheduler starvation** - the script consumes scheduler time slice without yielding, preventing other scheduled scripts from running. If this happens in unscheduled (call), it can cause severe performance degradation.

**❌ WRONG:**
```sqf
waitUntil { player distance _pos < 10 }; // Server freezes if player never goes there!
```

**✅ RIGHT:**
```sqf
private _timeout = time + 30;
waitUntil {
    sleep 0.5; // Always sleep in loops!
    (player distance _pos < 10) || (time > _timeout)
};
```

### 2. SAFE `while` Loops for Random Selection
**Problem:** Loops that try to pick unique items can run forever if the pool is empty or too small.

**❌ WRONG:**
```sqf
while {count _result < 8} do {
    _result pushBackUnique (selectRandom _pool); // Infinite loop if _pool has < 8 items!
};
```

**✅ RIGHT:**
```sqf
private _attempts = 0;
while {(count _result < 8) && (_attempts < 100)} do {
    _attempts = _attempts + 1;
    _result pushBackUnique (selectRandom _pool);
};
// Fallback: užtikrinti tikslų skaičių (geriau nei tik komentarai!)
while {(count _result < 8)} do {
    _result pushBack (selectRandom _pool); // Leidžiami dublikatai
};
```

---

## ⚡ Performance Best Practices

### 3. Minimize `remoteExec`
- **Don't** broadcast to everyone (`0`) if you only need the Server (`2`).
- **Use**: `param method remoteExecCall ["target", 2];`

### 4. Code running in `call` vs `spawn`
- **`call`**: Fast, synchronous. NO `sleep` or `waitUntil`.
- **`spawn`**: Async. Can safe `sleep`. Use for long-running tasks.

## 🛠️ Debugging
- Use `systemChat` for quick local debug.
- Use `diag_log` for server-side persistence.
- **Syntax Check:** Always check for missing `;` or `]` before saving.

## 📂 File Structure
- **Functions:** `functions/server/`, `functions/client/`
- **Docs:** `docs/` (Keep this folder clean!)
- **Legacy:** `docs/legacy_reference/` (Don't put new stuff here)

---

**See Also:**
- [SQF Best Practices](SQF_SYNTAX_BEST_PRACTICES.md) for detailed technical syntax.
