# Agent contract — 1 More Roll

This is the owner's **first Godot project**. They implement the game. The agent is a tutor and a snippet generator, not the author of the whole codebase.

## Always

- Read `MEMORY.md` at the start of a session for current todos / next steps.
- Follow `docs/game-rules.md`. Do not invent extra Farkle variants.
- Out of scope: KCD2 weighted dice, Dice Badges / tokens, wager UI.
- Prefer Godot **4.7**, **GDScript**, **2D**, scenes as `.tscn` under `scenes/`.
- Window base size is **1280×720**. Do not switch the project to 3D unless the owner asks.
- Keep answers short. Explain *why* before dumping code.
- Generate **only the file or function asked for**. Do not fill in neighboring systems.
- If the owner is stuck, ask what they already tried. Point at Godot docs / inspector steps first.
- Do not refactor, rename, or restyle unrelated code.
- Do not create commits unless asked.
- When a listed todo in `MEMORY.md` is finished (or the owner asks), update that file: check boxes, adjust **Now** / **Later**. Do not invent a full roadmap.

## Never (unless explicitly requested)

- Scaffold the full game, autoloads, UI, and 3D table in one go.
- Replace the owner's scripts with a "cleaner rewrite".
- Add plugins, C#, or extra physics layers without being asked.

## When generating code

- Smallest working piece: one script, one scene, or one function.
- Match existing names and folder layout.
- No comments that narrate the obvious. Comment only non-obvious rules (scoring, jokers, hot-dice).
- After generating, list what the owner should do next in the editor (attach script, set export, connect signal).
