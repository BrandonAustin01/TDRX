# 🛠️ Patch: TDRX v1.0.1 — "Polish & Precision"

**Release Date:** 07/12/2025
**Version:** `v1.0.1`
**Codename:** *Polish & Precision*

---

### 🔧 Bug Fixes

* 🛑 **Boost Alert Toggle Now Respected**
  The `"Show Boost Alerts"` option now correctly suppresses onscreen popups and debug logs when disabled.

---

### ✨ New Features

* 🧹 **Manual Debris Cleanup Button**
  Added a new UI option: `"Clean Up Debris"`

  * Immediately removes all non-essential debris tagged as `debris`
  * Useful after major destruction events to regain performance
  * Confirmation popup appears after cleanup

---

### 🧩 UI & UX Enhancements

* 🎯 UI navigation extended to include **manual cleanup**
* 🔁 Internal cleanup of boost alert logic for better toggle safety
* 🆔 Version number updated to `v1.0.1` in the config UI

---

### 🔒 Compatibility

* ✅ Fully backward-compatible with v1.0.0 configs
* ✅ No structural changes to config format
* ✅ Only touches `main.lua` and `ui.lua`

---

## 📝 Changelog: TDRX v1.0.0 — Initial Release

**Release Date:** 07/11/2025
**Version:** `v1.0.0`
**Codename:** *Launch Boost*

---

### 🚀 Core Features

* ✅ **Toggleable performance enhancements**, including:

  * Disable Post-Processing
  * Reduce Lights
  * Remove Debris
  * Freeze Distant Bodies
  * Throttle Scripts (placeholder for future control)
  * Suppress Fire

* ✅ **Failsafe Auto-Boost** system triggers when FPS drops below 30:

  * Dynamically applies performance settings
  * Logs a brief onscreen status message

* ✅ **Real-time FPS counter** (optional toggle)

---

### 🧩 UI & UX

* ✅ Clean, keyboard-navigable configuration UI

  * Open with `F10`
  * Navigate with `Z/X`
  * Toggle with `Enter`
* ✅ New **“Reset to Defaults”** button
* ✅ Custom **onscreen status messages** with auto-fade (instead of DebugPrint spam)
* ✅ Optimized layout and spacing for readability

---

### 💾 Config System

* ✅ All settings persist between sessions
* ✅ Config is stored safely using `savegame.mod.tdrx.config`
* ✅ Uses bundled `json.lua` (fully Teardown-compatible)

---

### 📦 Packaging & Compatibility

* ✅ Clean `info.txt` with tags, description, and 4K `preview.png`
* ✅ Fully Workshop-ready
* ✅ Does **not override** any game files or other mods
* ✅ 100% sandbox-safe and self-contained

---

### ✅ Final Notes

TDRX is designed to be:

* Lightweight 🪶
* Toggleable 🔘
* Non-invasive 🔒
* Community-ready 🌍