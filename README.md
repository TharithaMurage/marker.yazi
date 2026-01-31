# marker.yazi

PDF to Markdown conversion for [Yazi](https://yazi-rs.github.io/) using [Marker](https://github.com/VikParuchuri/marker).

Hover over a PDF in Yazi, press the keybinding, and get a Markdown file with extracted text and images.

## Requirements

- [Yazi](https://yazi-rs.github.io/) file manager
- [marker-pdf](https://pypi.org/project/marker-pdf/): `pip install marker-pdf`

## Installation

### Package manager

```sh
ya pkg add TharithaMurage/marker.yazi
```

### Manual

Clone this repository into your Yazi plugins directory:

```sh
# Windows
git clone https://github.com/TharithaMurage/marker.yazi %APPDATA%\yazi\config\plugins\marker.yazi

# Linux/macOS
git clone https://github.com/TharithaMurage/marker.yazi ~/.config/yazi/plugins/marker.yazi
```

## Setup

Add a keybinding to your `keymap.toml`:

```toml
[[manager.prepend_keymap]]
on = ["c", "m"]
run = "plugin marker"
desc = "Convert PDF to Markdown"
```

## How it works

1. Hover over a `.pdf` file in Yazi and press `c` then `m`.
2. The plugin runs `marker_single` on the selected PDF.
3. Marker creates a subdirectory named after the PDF containing the converted `.md` file and any extracted images.
4. A notification confirms success or reports an error.

## License

[MIT](LICENSE)
