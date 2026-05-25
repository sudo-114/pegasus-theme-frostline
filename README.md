# Frostline

A cinematic, PS5-inspired dark theme for [Pegasus Frontend](https://pegasus-frontend.org/). Controller-first. Full-bleed game art. Clean and modern.

---

## Preview

_Screenshots coming soon._

---

## Features

- Full-screen blurred game art background
- Hero view with cover art, title, description, and metadata
- Metadata row: Last Played · Play Time · Release Year
- Horizontal scrollable game row with scaled focus and white glow on selected cover
- Sort by last played, title, release year, play count, and play time

---

### Recommended Skraper settings

When scraping, make sure to pull at minimum:

- Box art (front)
- Screenshot or background image
- Game description
- Release year
- Developer / Publisher

---

## Installation

1. Download or clone this repository
2. Copy the `pegasus-theme-frostline` folder into your Pegasus themes directory:
   - **Linux/Mac**: `~/.config/pegasus-frontend/themes/`
   - **Windows**: `%AppData%\Local\pegasus-frontend\themes\`
   - macOS: `~/Library/Application Support/pegasus-frontend/themes/dark-carousel`

Then select `Frostline` theme in Pegasus Frontend.

---

## Controls

| Action          | Gamepad            | Keyboard    |
| --------------- | ------------------ | ----------- |
| Navigate games  | D-pad / Left stick | Arrow keys  |
| Launch game     | A / Cross          | Enter       |
| Open sort menu  | Y / Triangle       | Y           |
| Close sort menu | B / Circle or Y    | Escape or Y |

---

## Notes

- Play time and last played are tracked natively by Pegasus for launched games. Emulated games may show no data until played through Pegasus.
- If a game has no box art, a placeholder with the first letter of the title is shown.
- If a game has no description, the info panel adjusts gracefully — no empty space.

---

## License

MIT — free to use, modify, and redistribute. Credit appreciated but not required.
