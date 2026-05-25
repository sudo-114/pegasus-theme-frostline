# AGENTS.md — Frostline Theme for Pegasus Frontend

This file tells any AI agent how this project is structured, what the conventions are, and how to make changes safely. Read this before touching anything.

---

## What This Is

A custom theme for [Pegasus Frontend](https://pegasus-frontend.org/) — a cross-platform emulator launcher. Themes are written in **QML** (Qt Markup Language) with **JavaScript** for logic. No HTML, no CSS, no React.

The theme is called **Frostline**. PS5-inspired, dark, cinematic, controller-first.

---

## Visual Design

- **Background**: Full-bleed blurred game art that crossfades on selection. Dark overlay gradient so the bottom is near-black.
- **Hero area**: Selected game's cover art (center-left, slight tilt), game info on the right (title, developer, description, last played / play time / year).
- **Bottom row**: Horizontal scrollable game covers. Selected cover is larger with a white glow border. Others scale down and fade the further from center.
- **Play button**: White fill, black text, rounded, subtle glow.
- **Sort overlay**: Triggered by a button press. Frosted glass panel slides up from bottom center. Options: A-Z, Last Played, Play Time, Release Year.
- **No system selector UI** — Pegasus handles collection switching natively.
- **No search**.

---

## File Structure

```
pegasus-theme-frostline/
├── AGENTS.md               ← you are here
├── README.md               ← user-facing install instructions
├── theme.cfg               ← Pegasus theme metadata (name, author, version)
├── theme.qml               ← entry point, root FocusScope, loads everything
├── components/
│   ├── Background.qml      ← blurred art background + gradient overlay
│   ├── HeroArea.qml        ← cover art + game info panel
│   ├── GameRow.qml         ← horizontal scrollable game cover strip
│   ├── SortOverlay.qml     ← sort panel triggered by button press
│   └── MetadataRow.qml     ← last played · play time · year display
└── assets/
    ├── fonts/              ← any custom fonts (woff2 or ttf)
    └── icons/              ← any SVG or PNG icons used in UI
```

---

## QML Conventions

- **Root element** in `theme.qml` must be `FocusScope` — Pegasus requires this.
- **Screen dimensions**: Use `parent.width` and `parent.height`. Never hardcode pixel values. Use multipliers (e.g. `width: parent.width * 0.4`) so the theme scales to any resolution.
- **Pegasus API**: Game data comes from `api.currentGame`, `api.collections`, etc. Full reference: https://pegasus-frontend.org/docs/themes/api/
- **Font sizes**: Use relative units tied to screen height (e.g. `font.pixelSize: parent.height * 0.04`).
- **Colors**: Define all colors as `readonly property color` at the top of `theme.qml` and pass them down. Never hardcode hex values inside components.
- **Animations**: Use `Behavior on opacity {}` and `Behavior on scale {}` for smooth transitions. Target 300–400ms for most transitions, 150ms for snappy micro-interactions.
- **Focus**: Only one component handles focus at a time. Use `Keys.onPressed` for controller input. Never use mouse-dependent interactions as primary UX.

---

## Pegasus API Cheatsheet

```qml
// Current game
api.currentGame.title
api.currentGame.developer
api.currentGame.publisher
api.currentGame.description
api.currentGame.releaseYear
api.currentGame.playCount
api.currentGame.lastPlayed       // returns a Date object
api.currentGame.playTime         // in seconds
api.currentGame.assets.screenshot
api.currentGame.assets.boxFront
api.currentGame.assets.video

// Collections (systems)
api.collections.count
api.collections.get(index).name
api.collections.get(index).games

// Launching
api.currentGame.launch()
```

---

## Controller Input Mapping

| Action | Key in QML |
|---|---|
| D-pad / Left stick | `Key_Left`, `Key_Right`, `Key_Up`, `Key_Down` |
| Confirm / A / Cross | `Key_Return` |
| Back / B / Circle | `Key_Escape` |
| Sort overlay / Y / Triangle | `Key_Y` or gamepad button 3 |
| Dismiss overlay | same as sort trigger, or `Key_Escape` |

---

## What to Never Do

- Never hardcode resolution-specific pixel values
- Never use `MouseArea` as the primary interaction — gamepad must work first
- Never remove the `FocusScope` root from `theme.qml`
- Never break the component file structure — keep each concern in its own file
- Never skip null checks on game assets — if `boxFront` is empty the theme must not crash

---

## Handling Missing Data

Always guard against missing metadata:

```qml
// Description
text: api.currentGame.description || ""

// Last played
text: api.currentGame.lastPlayed ? Qt.formatDate(api.currentGame.lastPlayed, "MMM d, yyyy") : "Never played"

// Play time (convert seconds to hours/minutes)
text: api.currentGame.playTime > 0 ? formatPlayTime(api.currentGame.playTime) : ""

// Box art
source: api.currentGame.assets.boxFront || ""
visible: api.currentGame.assets.boxFront !== ""
```

---

## How to Add a Feature

1. Check if the feature needs new Pegasus API data — if so, verify it exists in the API reference first
2. If it's a new UI piece, create a new file in `components/`
3. Import and use it in `theme.qml` or the relevant parent component
4. Test by pressing `F5` in Pegasus to hot-reload the theme
5. Guard all new data fields against null/empty values

---

## How to Change the Visual Style

All colors and key measurements live at the top of `theme.qml` as properties:

```qml
readonly property color clrBackground: "#0a0a0f"
readonly property color clrText: "#ffffff"
readonly property color clrTextDim: "rgba(255,255,255,0.6)"
readonly property color clrAccent: "#ffffff"
readonly property real coverTilt: -4  // degrees
readonly property int animDuration: 300  // ms
```

Change these, not individual component values.

---

## Publishing Checklist

- [ ] Theme works with no game assets (empty library)
- [ ] Theme works with partial metadata (missing description, missing art, missing play time)
- [ ] All transitions smooth at 60fps
- [ ] Controller navigation complete — no dead ends
- [ ] README.md written with install instructions and scraper recommendations
- [ ] Screenshots added to `theme.cfg` as `assets.screenshots`
- [ ] Tested on at least 1080p and 720p
