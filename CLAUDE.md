# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

marker.yazi is a Yazi file manager plugin (Lua) that converts PDFs to Markdown using the [Marker](https://github.com/VikParuchuri/marker) CLI tool (`marker_single`). Single-file plugin: `main.lua`.

## Architecture

The entire plugin is `main.lua`, which exports an `entry` function following the Yazi plugin API (`--- @sync entry` annotation). The flow:
1. Gets the hovered file from `cx.active.current.hovered`
2. Validates it's a PDF
3. Shells out to `marker_single "<path>" --output_dir "<dir>"`
4. Marker creates `<dir>/<basename>/<basename>.md` plus extracted images
5. Notifies the user via `ya.notify()`

## Dependencies

- **Runtime**: Yazi file manager, `marker-pdf` Python package (`pip install marker-pdf`)
- **No build step or tests** — this is a single Lua file loaded by Yazi

## Key Yazi Plugin APIs Used

- `cx.active.current.hovered` — currently hovered file
- `h.url` — file URL (needs `file:///` prefix stripped)
- `ya.notify()` — user notifications
- `os.execute()` — runs shell commands (blocking)

## Installation for Development

```sh
# Symlink or clone into Yazi plugins dir
# Windows: %APPDATA%\yazi\config\plugins\marker.yazi
# Linux/macOS: ~/.config/yazi/plugins/marker.yazi
```

Keybinding in `keymap.toml`:
```toml
[[manager.prepend_keymap]]
on = ["c", "p"]
run = "plugin marker"
desc = "Convert PDF to Markdown"
```

## Testing

No automated tests. Test manually by hovering over a PDF in Yazi and pressing `c` then `m`. Verify the `.md` output appears in a subdirectory alongside extracted images.
