# TDRX - Teardown Runtime eXtension

**TDRX** is a dynamic performance optimization mod for [Teardown](https://teardowngame.com/) that intelligently improves framerate by disabling expensive visual effects, removing unnecessary entities, and applying runtime boosts when low FPS is detected.

---

## 🚀 Features

- 🧹 Automatically removes debris tagged with `debris`
- 💡 Disables dynamic lights to reduce GPU load
- 🎞️ Turns off post-processing effects (where supported)
- 🔧 Placeholder system for future script throttling
- 📉 Auto-detects FPS drops and applies performance boosts
- 🖥️ Optional in-game FPS counter
- 🧭 Keyboard-navigable UI to toggle options (F10 to open)

---

## 📦 Installation

1. Download or clone this repository.
2. Place the entire folder inside your `Teardown/mods/` directory.
3. Launch Teardown and **enable TDRX** from the in-game mod menu.

---

## 🕹 How to Use

- **Press `F10`** in-game to open the TDRX config menu.
- Use `Z/X` to navigate, and `ENTER` to toggle settings.
- Changes apply instantly — no need to restart.
- TDRX automatically applies extra boosts if your FPS drops below 30.

---

## 🔧 Settings Menu Options

| Option                  | Description                                         |
|-------------------------|-----------------------------------------------------|
| Remove Debris           | Deletes non-essential debris tagged with `debris`  |
| Reduce Lights           | Disables dynamic lights for better performance     |
| Throttle Scripts        | Placeholder for future heavy-script detection      |
| Disable Post-Processing | Turns off screen effects (if supported)            |
| Freeze Distant Bodies   | Freezes physics on faraway objects                 |
| Suppress Fire Effects   | Stops fire from spreading/rendering                |
| Show FPS Counter        | Displays FPS in the top-right corner               |

---

## ✅ Compatibility

- Works in most sandbox and user-made levels.
- Automatically detects campaign or mission modes and disables optimizations to avoid breaking scripted content.
- Includes built-in config persistence between play sessions.

---

## 📄 Credits

- [json.lua](https://github.com/rxi/json.lua) — Lightweight JSON parsing by [rxi](https://github.com/rxi)

---

## 🔧 Advanced Usage / Contributions

If you're a modder or developer and want to extend TDRX:
- All logic is modularized into `visuals.lua`, `entities.lua`, `scripts.lua`, `physics.lua`
- Config state is saved via `config.lua` using Teardown's savegame API
- Contributions welcome: PRs, performance ideas, or fixes!

---

## 📬 Contact

Created by [Brandon McKinney](https://brandonmckinney.dev)  
Questions? Feedback? Feature requests?  
→ Open an issue or message via GitHub or Discord.
