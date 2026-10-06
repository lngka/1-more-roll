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

Goal of this stretch: **score the dice you set aside, then Bank or keep rolling** (`docs/scenezero.md`). One player only. Scoring numbers come from `docs/game-rules.md`.

- [ ] Show the points of the dice currently held
- [ ] **Bank** adds those points to a saved total and ends the turn
- [ ] **Roll** rerolls the dice still in play; if that roll scores nothing, the turn’s points are lost

## Later (parking lot)

- Hot dice (every die scored → roll all 6 again on the same turn)
- Devil’s Head
- Opponent / goal UI
- Optional 3D — only after 2D loop works

## Notes

- Out of scope: weighted dice, badges, wager UI.
- Owner builds scenes in the editor; agent helps with one piece at a time.
