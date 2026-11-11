# Arena Survivor

A fast top-down pixel arena shooter. Survive waves of enemies, aim with the mouse, and beat your best score. Built solo in **Godot 4 (GDScript)** as a gameplay-programming portfolio project.

**▶ [Play in your browser on itch.io](https://jonjud.itch.io/arena-survivor)**

## Controls
Move | WASD

Aim | Mouse

Shoot | Left click (hold to keep firing)

Pause | P or Esc

## What this project demonstrates

| System | Where | Why it's built this way |
|---|---|---|
| **State machine** | `scripts/core/state.gd`, `state_machine.gd` | One class per state (Chase, Attack, Stunned) instead of a big `match`. States are independent and new ones need no changes to existing code. Fully reusable, no game-specific references. |
| **Component-based health** | `scripts/core/health_component.gd` | One `HealthComponent` shared by player and all enemies (composition over inheritance). Emits `damaged`, `died`, `health_changed`; the owner decides what happens. |
| **Event bus** | `scripts/core/event_bus.gd` (autoload) | Gameplay announces events; UI, audio, camera shake, and particles listen. No system holds a reference to another. |
| **Data-driven content** | `scripts/enemies/enemy_data.gd`, `wave_data.gd`, `resources/*.tres` | Three enemy types and all waves are `Resource` files on a single enemy scene. New content = new `.tres`, no new code. |
| **Save system** | `scripts/core/save_system.gd` (autoload) | Generic key-value JSON store in `user://`, works on desktop and Web. The high score logic lives in `ScoreKeeper`, not here. |

Other details: pooled `SfxPlayer` for overlapping sounds, an infinite tiled background that snaps to the camera, a reusable `HitFlash` shader component, `CPUParticles2D` bursts (Web-friendly), and a project-wide UI `Theme`.

## Project structure
assets/ sprites, audio, fonts
resources/ EnemyData, WaveData, UI themes (.tres)
scenes/ player, enemies, ui, main
scripts/
core/ reusable systems (StateMachine, HealthComponent, EventBus, SaveSystem, SfxPlayer ...)
player/ player, projectile, camera
enemies/ enemy, states, spawner, data resources
ui/ HUD, menus, score keeper


## Run it locally
1. Install [Godot 4.x](https://godotengine.org) (developed with <godot-version>)
2. Clone this repo and open `project.godot`
3. Press **F5**

## Development notes
- Scope was fixed at 4 weeks: 3 enemy types, 1 player attack. Out-of-scope ideas are parked in [ideas.md](ideas.md).
- Changes were driven by a playtest: a tester did not know the mouse aims, so the cursor became a crosshair and a first-shot hint was added.
- Release history is in the [tags](../../tags): v0.1 movement and shooting, v0.2 enemy AI and health, v0.3 data-driven waves and save, v1.0 polish and release.

## Credits
- Code, design, and project management: <your-name>
- Pixel art and sound effects: procedurally generated placeholder assets
- Font: **Silkscreen** by Jason Kottke, SIL Open Font License 1.1
- Made with [Godot Engine](https://godotengine.org)