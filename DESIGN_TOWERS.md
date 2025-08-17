# Tower Design

## Overview
Towers are the primary defensive structures players build to defeat incoming creeps. Each tower type offers unique offensive capabilities and is characterized by attributes such as range, damage, rate of fire, and special effects.

## Core Attributes
- **Attack Range** – distance within which the tower can acquire targets.
- **Damage** – hit points removed per successful attack.
- **Fire Rate** – number of shots per second.
- **Cost** – gold required to build the tower.
- **Upgrade Path** – higher tiers that improve stats or add new effects.

## Targeting
Towers automatically acquire the closest creep within range. Targeting logic can be expanded with priorities such as nearest to goal, highest health, or fastest.

## Tower Categories
1. **Arrow Tower**
   - Balanced tower with moderate range and damage.
   - Low cost; ideal for early waves.
2. **Cannon Tower**
   - Deals area-of-effect damage around impact point.
   - Slower fire rate and higher cost.
3. **Magic Tower**
   - Applies debuffs (e.g., slow, armor reduction).
   - Medium damage with longer range.
4. **Support Tower**
   - Provides buffs to nearby towers (range, damage, attack speed).
   - Does not attack directly.

## Upgrades
- Upgrades cost additional gold and may require previous tiers.
- Example progression:
  - Arrow Tower → Enhanced Arrow Tower → Sniper Tower
  - Each upgrade improves base stats and may unlock abilities.

## Placement Rules
- Towers must be placed on free cells not intersecting the creep path.
- Grid-based placement ensures alignment with the map.
- Selling towers returns a percentage of their cost.

## Special Effects
- Towers may possess elemental damage types (fire, frost, lightning) that interact with creep resistances.
- Advanced towers can trigger chain lightning, splash damage, or damage over time.

