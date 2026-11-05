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

- An enhanced Zsh setup with autosuggestions, syntax highlighting, fuzzy search, and Starship.
- A matching Nusa Obsidian Konsole color scheme.
- The Nusa Obsidian KDE color scheme.
- A matching Kvantum configuration.
- A Plasma 6 desktop theme with rounded floating-panel artwork.
- An optional custom Nusa Obsidian Aurorae window decoration; Breeze is the recommended native window-decoration foundation.
- A native Plasma layout template for the Nusa Mokka top menu bar and centered bottom dock.

The Plasma style is based on the installed Breeze default theme. The setup script copies that theme into the current user's data directory, then overlays the Nusa metadata and panel artwork. This keeps the full set of standard Plasma assets while version-controlling only the files Nusa changes.

The Nusa Mokka layout template creates a slim top menu bar and a centered bottom dock using Plasma's built-in widgets. It keeps the application launcher and task manager native to KDE; no third-party dock is required. The Nusa panel artwork provides a rounded pill background and uses the Nusa dark palette.

## Icons

Use **Papirus-Dark** as the icon foundation for now. It has broad application coverage, works well with dark desktops, and is packaged for FreeBSD. Keeping the upstream icon set intact is more maintainable than copying hundreds of icons into this repository; Nusa-specific folder accents can be added after checking the base theme in Plasma.

Install it with:

```sh
sudo pkg install papirus-icon-theme
```

Then open **System Settings → Colors & Themes → Icons**, select **Papirus-Dark**, and apply it. If it does not appear, log out and back in.

## Typography

Use **Cantarell** for the desktop interface and **JetBrains Mono** for terminals and code. Cantarell has a humanist shape that stays readable at KDE UI sizes; JetBrains Mono gives terminal text a distinct, consistent rhythm. Both are available as FreeBSD packages.

Install them with:

```sh
sudo pkg install cantarell-fonts jetbrains-mono
```

In **System Settings → Colors & Themes → Fonts**, choose Cantarell for the general, small, toolbar, and menu fonts. Set the fixed-width font to JetBrains Mono. Start with 10 pt for the interface and 10 pt for fixed-width text, then adjust for display scaling and readability. Apply the changes; restart applications that keep their own font settings.

## Requirements

- FreeBSD 15
- KDE Plasma 6 (installed separately)
- Git
- Zsh
- Starship
- Kvantum for the custom Qt widget style
- Papirus icon theme
- Cantarell and JetBrains Mono fonts

Install the shell tools and desktop theme packages as needed:

```sh
sudo pkg install git zsh starship zsh-autosuggestions zsh-syntax-highlighting zsh-completions fzf zoxide eza bat fd ripgrep fastfetch btop nerd-fonts-jetbrainsmono kvantum papirus-icon-theme
```

Run the setup as your regular desktop user:

```sh
git clone https://github.com/flushwhy/freebsd-mokka.git
cd freebsd-mokka
sh setup.sh
```

The setup script links the repository's Zsh and Starship configuration, installs the Nusa Obsidian KDE and Konsole color schemes, Plasma Style, Aurorae window decoration, and the Nusa Mokka Plasma layout template under `~/.local/share/plasma/`. Existing shell and color-scheme files are backed up before replacement. The Plasma style is generated from the system's installed Breeze default theme. The script does not install packages, modify system files, or change the login shell.

Select **Nusa Obsidian** under **System Settings → Colors & Themes → Colors** and **System Settings → Colors & Themes → Plasma Style**. For window decorations, select **Breeze** under **System Settings → Colors & Themes → Window Decorations** and open its configuration. Choose **Small** or **Tiny** button size, enable the circle around the close button if desired, and disable the title-bar gradient for the flatter Nusa look. Keep the Nusa Obsidian color scheme selected; Breeze supplies the native button behavior and layout while Nusa supplies the palette. The custom **Nusa Obsidian** Aurorae decoration is still installed as an optional alternative. Select it in Window Decorations if you prefer the fully custom rounded title bar. Select **Papirus-Dark** under **System Settings → Colors & Themes → Icons**. To add the two-panel layout, right-click the desktop, choose **Add Panel → Nusa Mokka**, and let Plasma create the menu bar and dock. This is an opt-in layout action so rerunning setup does not replace an existing panel arrangement. If a style or template does not appear immediately, log out and back in.

## Login screen (SDDM)

Nusa Obsidian includes a Qt 6 SDDM theme based on KDE Breeze 6.7.5. It keeps Breeze's login flow, user/session selection, virtual keyboard, and power actions, while adding a custom obsidian wallpaper, Nusa wordmark, and warm palette for Breeze's native greeter controls. The wallpaper and palette are intentionally restrained so the login form remains the focus.

Install it after cloning the repository:

```sh
sudo sh install-sddm.sh
```

The installer copies the installed Breeze theme into `/usr/local/share/sddm/themes/NusaObsidian`, then overlays the Nusa theme settings, wallpaper, logo, and palette-tuned `Main.qml` based on Plasma 6.7.5. It backs up an existing Nusa theme before replacing it and leaves Breeze untouched as a fallback.

Then open **System Settings → Colors & Themes → Login Screen (SDDM)**, select **Nusa Obsidian**, and apply. To revert, select **Breeze** in the same settings page. The installer changes theme files only; it does not change the active SDDM theme automatically.

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

## Terminal

The Konsole color scheme uses Nusa's obsidian background, warm ivory text, and restrained copper accents. After running setup, open **Konsole → Settings → Edit Current Profile → Appearance** and select **Nusa Obsidian**. Set the profile font to **JetBrainsMono Nerd Font** at a comfortable size (start at 10–11 pt). This includes the extra symbols used by Starship and modern terminal tools.

The Zsh configuration enables command autosuggestions, syntax highlighting, case-insensitive completion, and fuzzy shortcuts. `Ctrl+R` searches command history, `Ctrl+T` finds files, and `Alt+C` jumps to a directory with fzf. `z` uses zoxide's directory history. `eza` provides enhanced listings, `bat` is available as `c`, `v` opens Neovim, and `fastfetch` shows a system summary when a new interactive shell starts.

The Neovim aliases point to the existing `nvim` installation; NvChad remains your Neovim configuration and is not overwritten.

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
