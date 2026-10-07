# Memory — cross-session

Working scratchpad across chats. Owner updates when priorities change. Agent: read this first; mark todos done; add next steps only when asked or when a task finishes.

## Decisions (locked for now)

- **2D** prototype
- Window **1280×720**
- Layout: `scenes/*.tscn` + matching `.gd` beside them; `assets/` when art exists

## Done

- Stretch 1 — **see dice on a board and roll random faces** (2026-10-03)
  - `scenes/table.tscn`: `Table` Node2D → `Board` TextureRect (`assets/board/painted_wood.jpg`) + `DiceRollArea` / `DiceKeepArea` ColorRects
  - `scenes/dice.tscn` + `dice.gd`: Area2D `Dice`, `Face` Sprite2D, `roll()` picks `value` 1–6 from `face_textures`
  - `scenes/main.tscn` + `main.gd`: Table + `DiceGroup` (Dice1–6) + CanvasLayer/`RollButton` → `_on_roll_button_pressed()` rolls all
  - Assets: Kenney white dice (`assets/dice/die_white_*.png`), Lilita One font
- Stretch 2 — **click a die to hold it; Roll only rerolls unheld dice** (2026-10-06)
  - `dice.gd`: `held` flag, toggled by the `select_die` action; held dice draw a `StyleBoxFlat` border in `_draw()`
  - `roll()` returns immediately when `held`; `main.gd` skips held dice
  - Audio: `RollSound` plays a random `assets/audio/die-throw-*.ogg`; `Music` loops `TremLoadingloopl.wav`

## Now

Goal of this stretch: **set aside a scoring selection, roll the rest, bust or bank** (`docs/scenezero.md`). One player only. No opponent yet: bust and bank both start a fresh turn for the same player. Scoring numbers come from `docs/game-rules.md`.

- [x] Show the points of the dice currently selected (2026-10-07)
- [ ] **Roll** has two cases. The first roll of a turn needs no selection: throw all six. After that, Roll only commits a legal selection (points > 0, and every selected die is part of that score), adds those points to the turn total, locks those dice, and rerolls the rest. Locked dice stay out and do not combine with the new roll.
- [ ] **Bust:** right after a roll, if the dice just rolled have no scoring combination, the turn total is lost and all six dice unlock. Show “Bust”. Do not switch to a CPU turn.
- [ ] **Bank:** add the turn total to a saved total, then unlock all six and start a new turn. This is the only way points survive. Without it, a turn can only end by busting.

## Later (parking lot)

- Hot dice (every die scored → roll all 6 again on the same turn). Until then, if every die in play is locked, Roll has nothing left to throw — Bank instead.
- Devil’s Head
- Opponent / goal UI (bust or bank passes the turn)
- Optional 3D — only after 2D loop works

## Notes

- Out of scope: weighted dice, badges, wager UI.
- Owner builds scenes in the editor; agent helps with one piece at a time.
