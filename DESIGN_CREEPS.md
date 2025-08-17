# Creep Design

## Overview
Creeps are enemy units that traverse predefined paths toward the player's base. They spawn in waves, each becoming progressively more challenging. Defeating creeps rewards the player with gold.

## Core Attributes
- **Health** – total hit points before the creep is destroyed.
- **Speed** – movement rate along the path.
- **Armor/Resistance** – damage mitigation or immunity to certain elements.
- **Bounty** – gold rewarded upon defeat.
- **Abilities** – special traits such as regeneration or shielding.

## Movement
- Creeps follow a Path2D. Their position is updated each frame based on speed.
- Reaching the end of the path reduces the player's lives or triggers loss conditions.

## Creep Categories
1. **Normal Creeps**
   - Baseline units with no special abilities.
2. **Fast Creeps**
   - Lower health but higher speed, designed to slip past slow defenses.
3. **Armored Creeps**
   - High health or damage resistance; vulnerable to magic or armor-piercing towers.
4. **Flying Creeps**
   - Ignore ground pathing; require specific anti-air towers.
5. **Boss Creeps**
   - Appear periodically with massive health pools and unique abilities.

## Abilities
- **Regeneration** – restores health over time.
- **Shielding** – absorbs a fixed amount of damage before health is affected.
- **Spawn on Death** – splits into smaller creeps when destroyed.

## Wave Structure
- Waves define the number of creeps, spawn interval, health multiplier, and creep type.
- Difficulty scaling is achieved by increasing health, speed, and introducing new abilities in later waves.

