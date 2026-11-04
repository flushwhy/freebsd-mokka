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

## Current scope

The repository provides the Zsh and Starship configuration, the Nusa Obsidian KDE color scheme, and a matching Kvantum configuration. The Plasma layout, window decorations, icons, fonts, wallpaper, and SDDM styling are the remaining desktop-polish work.

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

The setup script links the repository's Zsh and Starship configuration and installs the Nusa Obsidian KDE color scheme. Existing files are backed up before replacement. It does not install packages, modify system files, or change the login shell.

Select **Nusa Obsidian** in **System Settings → Colors & Themes → Colors**.

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
