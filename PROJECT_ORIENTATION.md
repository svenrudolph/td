# Wintermaul Wars Classic Orientation

## Overview
Wintermaul Wars is a custom map for Warcraft III that mixes tower defense with competitive head‑to‑head gameplay. Players construct mazes of towers to stop waves of creeps while sending their own waves to the opponent. Success requires balancing defense, offense, and economic growth.

## Project Goal
Create a standalone single‑player game, **Wintermaul Wars Classic**, that captures the feel of the original map. The player defends against an AI opponent which simultaneously launches creep waves and builds its own defenses.

## Key Features
- **Towers**: Arrow, splash, slowing, aura, and special towers that can be upgraded or repositioned.
- **Creeps**: Ground and air units with varied health, speed, resistances, and special behaviors such as splitting or invisibility. Boss and mini‑boss waves provide extra challenge.
- **Maze Mechanics**: Towers may block or slow pathing. Rules will balance creative mazes with fair gameplay.
- **Economy**: Gold from creep kills and periodic income bonuses. Players choose how to allocate funds between towers and offensive creep waves.
- **AI**: Opponent that places and upgrades towers, selects creep compositions, and reacts to the player’s strategy.
- **UI/UX**: Grid‑based build interface, drag‑and‑drop placement, wave info panel, mini‑map, and victory/defeat screens.

## Technology Stack
- **Engine**: Godot.
- **Language**: GDScript or C# (to be decided).
- **Assets**: Temporary placeholder art and open‑source sound, replaced later with custom assets.
- **Build**: Scripts for bundling cross‑platform builds (Windows, macOS, Linux).

## Development Phases
1. **Pre‑Production** – Document map layout, towers, creeps, resources, and UI sketches.
2. **Core Prototype** – Basic map, pathing, gold/income/life systems, and a minimal set of towers and creeps.
3. **Tower & Creep Variety** – Implement the full roster of towers, upgrades, air units, bosses, and special creep abilities.
4. **AI Development** – Defensive and offensive AI behaviors, including economy management.
5. **Gameplay Loop & Balancing** – Wave progression, difficulty tuning, and ensuring challenging yet winnable matches.
6. **Art & Audio** – Replace placeholders with polished visuals, sound effects, and simple animations.
7. **Polish & Packaging** – Performance improvements, bug fixes, menus, settings, and final builds.

## Risk Considerations
- AI behavior may require extensive tuning to feel fair and challenging.
- Pathfinding and many units on screen could cause performance issues on low‑end hardware.
- Balancing offense and defense is key to preventing dominant strategies.

## Next Steps
- Draft detailed design documents for towers, creeps, and economy systems.
- Build a minimal prototype to validate pathing and tower mechanics.
- Begin exploring art concepts for the winter theme and classic aesthetic.
