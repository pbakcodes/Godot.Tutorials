# Shooter Project — Code Review & Improvement Plan

## Rating: 6/10 → Improved to ~8/10

---

## What Was Done Well (Original)

1. **Scene inheritance** — `LevelParent` as a base class for `inside.gd`/`outside.gd`
2. **Signal-based decoupling** — Player emits shooting signals, containers emit `open`, scouts emit `laser`
3. **Scene transition system** — `TransitionLayer` autoload with fade-to-black and deferred scene change
4. **Physics layer organization** — 5 named layers (Player, Enemies, Objects, Projectiles, Items & Zones)
5. **Tween usage** — Item spawn animations, camera zoom, player speed reduction on level exit
6. **Invulnerability window** — Damage cooldown with timer
7. **Global groups** — Container, Scouts, Entity groups with runtime `connect()` in `_ready()`

---

## Issues Found & Changes Made

### Phase 1: Critical Bug Fixes

| Issue | Fix | Files |
|-------|-----|-------|
| **Grenade hit every frame** — `_process()` called `hit()` on targets every frame during explosion | Replaced with single `_apply_explosion_damage()` call inside `explode()`, removed `_process` entirely | `grenade.gd` |
| **No death state** — Health could go below 0 with no consequence | Added `player_died` signal in `Globals`, health clamped to `[0, MAX_HEALTH]` via `clampi()` | `globals.gd` |
| **`load()` vs `preload()`** — Initially flagged, but `inside.gd`↔`outside.gd` have a circular dependency | Kept `load()` with explanatory comment (circular preload would crash) | `inside.gd`, `outside.gd` |

### Phase 2: Damage System Refactor

| Issue | Fix | Files |
|-------|-----|-------|
| **No damage parameter** — `hit()` took no args, everything dealt hardcoded damage | All `hit()` functions now accept `hit(damage: int)` with sensible defaults from `Constants` | All entity/container scripts |
| **Duck typing** — `if "hit" in body` could match properties, not just methods | Replaced with `body.has_method("hit")` | `laser.gd`, `grenade.gd` |
| **Health logic in Globals** — Invulnerability, immune timer belonged on the player | Moved `can_be_damaged`, `_start_immune_timer()` to `player.gd`; Globals only stores the value | `globals.gd`, `player.gd` |

### Phase 3: Code Quality

| Issue | Fix | Files |
|-------|-----|-------|
| **"granade" typo everywhere** | Renamed to "grenade" in all files, variables, signals, nodes, and filenames | All files |
| **Missing type hints** | Added parameter types, return types, signal parameter types, variable types | All `.gd` files |
| **String-based item types** | Replaced `options[]` array with `enum ItemType { LASER, GRENADE, HEALTH }` and `match` statements | `item.gd` |
| **Dead code** | Removed `trigger_open()` workaround from `item_container.gd`; `logo.gd` marked for deletion | `item_container.gd` |
| **Variable shadowing in player** | Renamed `direction` → `input_direction`, `player_direction` → `aim_direction` | `player.gd` |
| **Hardcoded colors** | Extracted to `Constants` class (`COLOR_UI_GREEN`, `COLOR_UI_RED`, etc.) | `ui.gd`, `item.gd` |
| **Signal connection style** | Changed `Globals.connect("stat_change", func)` to `Globals.stat_change.connect(func)` | `ui.gd` |

### Phase 4: Feature Completion

| Issue | Fix | Files |
|-------|-----|-------|
| **Drone non-functional** | Added health, hit reaction (red flash), death, chase AI (distance-based detection), patrol with wall bounce | `drone.gd` |
| **Magic numbers everywhere** | Created `Constants` class with all shared values (damage, speeds, colors, health caps, pickup amounts) | `constants.gd` (new) |

---

## New File: `globals/constants.gd`

Centralized `class_name Constants` with all game balance values:
- Player stats (MAX_HEALTH, PLAYER_MAX_SPEED, PLAYER_IMMUNE_DURATION)
- Damage values (LASER_DAMAGE, GRENADE_DAMAGE)
- Weapon stats (LASER_SPEED, GRENADE_SPEED, GRENADE_EXPLOSION_RADIUS)
- Enemy stats (DRONE_HEALTH, DRONE_SPEED, DRONE_DETECTION_RANGE, SCOUT_HEALTH)
- Pickup amounts (LASER_PICKUP_AMOUNT, GRENADE_PICKUP_AMOUNT, HEALTH_PICKUP_AMOUNT)
- Colors (COLOR_UI_GREEN, COLOR_UI_RED, COLOR_ITEM_LASER, COLOR_ITEM_GRENADE, COLOR_ITEM_HEALTH)

---

## Manual Cleanup Required

Delete these obsolete files (replaced by correctly-named versions):

```
shooter/scenes/projectiles/granade.gd   → replaced by grenade.gd
shooter/scenes/projectiles/granade.tscn  → replaced by grenade.tscn
shooter/scenes/logo.gd                   → unused tutorial leftover
```

---

## Future Improvements (Not Yet Implemented)

- **Game over screen** — `player_died` signal is emitted but nothing listens to it yet. Add a UI overlay with restart option.
- **Screen shake on hit** — Add camera shake feedback when the player takes damage.
- **Death animation** — Player sprite effect on death (fade out, explosion, etc.).
- **Enemy variety** — Different drone patrol patterns, scout movement, new enemy types.
- **Sound effects** — No audio system exists at all.
- **Persistent state** — Ammo/health don't reset between level transitions via Globals; consider resetting or saving state intentionally.
