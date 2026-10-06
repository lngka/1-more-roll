# 1 More Roll

Farkle-style dice game in **Godot 4.7**, **2D**. Learning project: the owner writes the game; Cursor is for questions and small code snippets.

Rules: [`docs/game-rules.md`](docs/game-rules.md).  
Look: [`docs/inspirations/`](docs/inspirations/).  
Todos / next steps: [`MEMORY.md`](MEMORY.md).  
Agent contract: [`AGENTS.md`](AGENTS.md).

## Decisions

| Topic | Choice |
|---|---|
| Dimension | **2D** (`Control` / `Node2D`, sprites / labels) |
| Window | **1280×720** (16:9), stretch `canvas_items` + `expand` |
| Out of scope | Weighted dice, badges, wager UI, 3D until later |

## Open the project

1. Install [Godot 4.7](https://godotengine.org/download/) (same minor as `project.godot`).
2. Godot → Import → this folder.
3. Confirm **Display → Window** is 1280×720 (already set in `project.godot`).
4. Press **F5** once Main Scene points at `scenes/main.tscn`.

## How we work

- You build in the editor and in GDScript.
- Ask Cursor for: “giải thích X”, “chỗ này lỗi”, “viết đúng hàm / script này”.
- Do not ask it to “làm hết game”.

## Folder structure

Keep it small. Put each scene’s script next to the `.tscn`. Add folders only when you need them.

```
1-more-roll/
├── AGENTS.md
├── MEMORY.md
├── README.md
├── project.godot
├── docs/
│   ├── game-rules.md
│   └── inspirations/          # reference screenshots
├── scenes/
│   ├── main.tscn              # board + dice + Roll button
│   ├── main.gd
│   ├── board.tscn
│   ├── board.gd               # optional at first
│   ├── dice.tscn              # one die, reusable instance
│   └── dice.gd
└── assets/                    # create when you have art
    └── dice/                  # face sprites 1–6 (later)
```

Later (not now): `scripts/scoring.gd` when rules leave the UI scenes.

## Suggested order

Current stretch: [`MEMORY.md`](MEMORY.md)

After that:

1. Scoring — faces → points
2. Turn state — hold / bank / continue / bust / hot-dice
3. Goal / opponent UI
4. Devil’s Head
5. Optional 3D polish — only if you still want it
