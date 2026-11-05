# freebsd-mokka

A reproducible, Git-managed FreeBSD 15 workstation setup with a polished Mokka-inspired KDE desktop and Nusa's own visual identity.

Mokka is the UI reference: refined spacing, rounded controls, cohesive application styling, a considered panel and dock, and restrained effects. Nusa supplies the identity: an obsidian and espresso foundation with copper, sand, and ivory accents. This is an original desktop design, not a copy of another distribution.

## Visual identity

| Role | Color | Hex |
|---|---|---|
| Obsidian | Primary dark background | `#17191B` |
| Espresso | Window and elevated surfaces | `#292725` |
| Copper | Focus, selection, and key accents | `#B47750` |
| Sand | Secondary warm accent | `#D2B99A` |
| Ivory | Primary text | `#E8E3DA` |

Use copper sparingly. Keep large surfaces neutral and dark; sand and ivory provide warmth and readability. Avoid turning every control brown or adding decorative effects without a purpose.

## Desktop configuration

The repository currently provides:

- Zsh and Starship configuration.
- The Nusa Obsidian KDE color scheme.
- A matching Kvantum configuration.
- A Plasma 6 desktop theme with rounded floating-panel artwork.
- A custom Aurorae window decoration with rounded corners and warm title bars.

The Plasma style is based on the installed Breeze default theme. The setup script copies that theme into the current user's data directory, then overlays the Nusa metadata and panel artwork. This keeps the full set of standard Plasma assets while version-controlling only the files Nusa changes.

The existing KDE floating panel is retained. The Nusa panel artwork provides a rounded pill background and uses the Nusa dark palette.

Still to build: icons, fonts, wallpaper, panel widget layout, and SDDM styling.

## Requirements

- FreeBSD 15
- KDE Plasma 6 (installed separately)
- Git
- Zsh
- Starship
- Kvantum for the custom Qt widget style

Install the shell tools and Kvantum with FreeBSD packages as needed:

```sh
pkg install git zsh starship kvantum
```

Run the setup as your regular desktop user:

```sh
git clone https://github.com/flushwhy/freebsd-mokka.git
cd freebsd-mokka
sh setup.sh
```

The setup script links the repository's Zsh and Starship configuration, installs the Nusa Obsidian KDE color scheme, and installs the Nusa Plasma Style under `~/.local/share/plasma/desktoptheme/`, and installs the Nusa Aurorae window decoration under `~/.local/share/aurorae/themes/`. Existing shell and color-scheme files are backed up before replacement. The Plasma style is generated from the system's installed Breeze default theme. The script does not install packages, modify system files, or change the login shell.

Select **Nusa Obsidian** under **System Settings → Colors & Themes → Colors**, **System Settings → Colors & Themes → Plasma Style**, and **System Settings → Appearance → Window Decorations**. If the style does not appear immediately, log out and back in.

## Kvantum

The matching Kvantum palette is in `config/kvantum/NusaObsidian.kvconfig`. For now, use the installed `KvBrown.svg` as the widget-shape base:

```sh
mkdir -p ~/.config/Kvantum/NusaObsidian
cp /usr/local/share/Kvantum/KvBrown/KvBrown.svg \
  ~/.config/Kvantum/NusaObsidian/NusaObsidian.svg
cp config/kvantum/NusaObsidian.kvconfig \
  ~/.config/Kvantum/NusaObsidian/NusaObsidian.kvconfig
```

Then select **NusaObsidian** in Kvantum Manager and ensure **Kvantum** is selected under **System Settings → Colors & Themes → Application Style**. The SVG provides the existing Mokka-like widget geometry; the config supplies Nusa's palette.

## Shell

After setup, make Zsh your login shell if desired:

```sh
chsh -s "$(command -v zsh)"
```

Log out and back in for the login-shell change to take effect.

## Principles

- Keep setup safe to rerun.
- Prefer native FreeBSD and KDE mechanisms.
- Back up user configuration before changing it.
- Avoid hidden system-wide changes.
- Keep the configuration understandable and easy to maintain.
- Test desktop-specific settings on FreeBSD before documenting them as supported.

## License

MIT
