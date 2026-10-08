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

## Now

Goal of this stretch: **set aside a scoring selection, roll the rest, bust or bank** (`docs/scenezero.md`). One player only. No opponent yet: bust and bank both start a fresh turn for the same player. Scoring numbers come from `docs/game-rules.md`.

**Next session start here:** rewrite `_on_roll_button_pressed` — `first_roll_of_turn` → roll all unbanked; else commit selection (`turn_score`, `banked`, `_layout_banked_dice()`), then roll the rest.

- [x] Show the points of the dice currently selected (2026-10-07)
- [ ] **Roll** has two cases. The first roll of a turn needs no selection: throw all six. After that, Roll only commits a legal selection (points > 0, and every selected die is part of that score), adds those points to the turn total, sets those dice `banked`, and rerolls the rest. Banked dice stay out and do not combine with the new roll.
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
