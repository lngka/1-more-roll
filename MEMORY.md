# Memory — cross-session

Working scratchpad across chats. Owner updates when priorities change. Agent: read this first; mark todos done; add next steps only when asked or when a task finishes.

## Decisions (locked for now)

- **2D** prototype
- Window **1280×720**
- Layout: `scenes/*.tscn` + matching `.gd` beside them; `assets/` when art exists

## Now

Goal of this stretch: **see dice on a board and roll random faces**. No scoring / Farkle rules yet.

- [x] Project setup: Godot 4.7, window 1280×720, Main Scene → `scenes/main.tscn`
- [x] Create `scenes/table.tscn` (root `Table` Node2D, `Board` TextureRect + `DiceRollArea` / `DiceKeepArea`)
- [x] Create `scenes/dice.tscn` (Area2D `Dice` + `dice.gd` with `roll()`, 6 face textures)
- [x] Create `scenes/main.tscn` = Table + `DiceGroup` (6 dice) + CanvasLayer/RollButton
- [ ] Add a **Roll** button that randomizes face(s) on the dice

## Later (parking lot)

- Scoring from faces (`docs/game-rules.md`)
- Hold / bank / continue / bust
- Devil’s Head
- Opponent / goal UI
- Optional 3D — only after 2D loop works

## Notes

- Out of scope: weighted dice, badges, wager UI.
- Owner builds scenes in the editor; agent helps with one piece at a time.
