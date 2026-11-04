# Memory — cross-session

Working scratchpad across chats. Owner updates when priorities change. Agent: read this first; mark todos done; add next steps only when asked or when a task finishes.

## Decisions (locked for now)

- **2D** prototype
- Window **1280×720**
- Layout: `scenes/*.tscn` + matching `.gd` beside them; `assets/` when art exists
- Per-die **`banked`** = set aside on the board for the current turn. **`banked_score`** on Main = points saved with the Bank button (different layers, same word).

## Done

- Stretch 1 — **see dice on a board and roll random faces** (2026-10-03)
  - `scenes/table.tscn`: `Table` Node2D → `Board` TextureRect (`assets/board/painted_wood.jpg`) + `DiceRollArea` / `DiceBankArea` ColorRects
  - `scenes/dice.tscn` + `dice.gd`: Area2D `Dice`, `Face` Sprite2D, `roll()` picks `value` 1–6 from `face_textures`
  - `scenes/main.tscn` + `main.gd`: Table + `DiceGroup` (Dice1–6) + CanvasLayer/`RollButton` → `_on_roll_button_pressed()` rolls all
  - Assets: Kenney white dice (`assets/dice/die_white_*.png`), Lilita One font
- Stretch 2 — **click a die to select it; Roll only rerolls unselected dice** (2026-10-06)
  - `dice.gd`: `selected` toggled by `select_die`; `selected_style` border in `_draw()`.
  - `roll()` skips `selected` or `banked`; `main.gd` skips `selected` on Roll
  - Audio: `RollSound` plays a random `assets/audio/die-throw-*.ogg`; `Music` loops `TremLoadingloopl.wav`
- Stretch 3 prep — **turn UI + bank zone layout** (2026-10-08). Gameplay still stretch 2; no commit-on-Roll yet.
  - `main.tscn`: `SelectionScoreLabel`, `TurnScoreLabel`, `BankedScoreLabel`, `Bank` button → `_on_bank_button_pressed` (stub)
  - `main.gd`: `turn_score`, `banked_score`, `first_roll_of_turn` (unused until Roll two-case); `_refresh_score_labels()`; `_bank_area_rect_in_dice_group()` + `_layout_banked_dice()` — call after setting `die.banked = true`
  - `dice.gd`: `roll_home` saved in `_ready()`; `banked` blocks select + roll
- Stretch 3 — **Roll commits a scoring selection, then throws the rest** (2026-11-04)
  - `main.gd`: `_on_roll_button_pressed` — `first_roll_of_turn` clears any selection and rolls all six; later rolls call `_commit_selection`
  - `_commit_selection`: `score_dice` must be > 0, then add to `turn_score`, clear `selected`, set those dice `banked`, `queue_redraw` (drop the selection border), `_layout_banked_dice()`, then `_roll_free_dice`
  - Banked dice stay in `DiceBankArea` and are not rolled again. If every die is banked, Roll has nothing left to throw
  - Hole: a die that adds no points can still be committed when the rest of the selection scores (1 and 2 → 100, both banked)

## Now

Goal of this stretch: **set aside a scoring selection, roll the rest, bust or bank** (`docs/scenezero.md`). One player only. No opponent yet: bust and bank both start a fresh turn for the same player. Scoring numbers come from `docs/game-rules.md`.

**Next session start here:** close the hole in `_commit_selection`. A selection is legal only when every selected die is part of the score. `score_dice` returns only a total, so it cannot tell a spare 2 from a scoring 1. One check, still inside commit. Do not start Bust in the same session.

- [x] Show the points of the dice currently selected (2026-10-07)
- [x] **Roll** has two cases (2026-11-04). The first roll of a turn needs no selection: clear selection and throw all six. After that, Roll commits when points > 0, adds those points to the turn total, sets those dice `banked`, and rerolls the rest. Banked dice stay out and do not combine with the new roll.
- [ ] **Legal selection:** every selected die must be part of that score. Until this exists, choosing a 1 together with a 2 still commits both.
- [ ] **Bust:** right after a roll, if the dice just rolled have no scoring combination, the turn total is lost and all six dice unlock. Show “Bust”. Do not switch to a CPU turn.
- [ ] **Bank:** add the turn total to a saved total, then unlock all six and start a new turn. This is the only way points survive. Without it, a turn can only end by busting.

## Later (parking lot)

- Hot dice (every die scored → roll all 6 again on the same turn). Until then, if every die in play is banked, Roll has nothing left to throw — Bank instead.
- Devil’s Head
- Opponent / goal UI (bust or bank passes the turn)
- Optional 3D — only after 2D loop works

## Notes

- Out of scope: weighted dice, badges, wager UI.
- Owner builds scenes in the editor; agent helps with one piece at a time.
