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
  - Assets: Kenney white dice (`assets/dice/die_white_*.png`, `die_white_border_*.png` for held state), Lilita One font

## Now

Goal of this stretch: **click a die to hold it; Roll only rerolls unheld dice** (second half of `docs/scenezero.md`). Still no scoring.

- [ ] `dice.gd`: `held` flag, toggle on left-click via Area2D `input_event`, swap to `die_white_border_*` texture when held
- [ ] `dice.gd`: `roll()` does nothing when `held`
- [ ] `main.gd`: tidy — remove unused `_ready` / `_process` stubs
- [ ] Move held dice into `DiceKeepArea` (visual only, no rules yet)

## Later (parking lot)

- Scoring from faces (`docs/game-rules.md`)
- Hold / bank / continue / bust
- Devil’s Head
- Opponent / goal UI
- Optional 3D — only after 2D loop works

## Notes

- Out of scope: weighted dice, badges, wager UI.
- Owner builds scenes in the editor; agent helps with one piece at a time.
