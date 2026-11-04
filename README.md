# freebsd-mokka

A reproducible, Git-managed FreeBSD 15 workstation setup with a warm, dark Mokka-inspired visual identity.

The goal is a streamlined developer desktop built around KDE Plasma 6, Xorg, SDDM, Kvantum, Zsh, and Starship. This is an original Mokka-inspired configuration, not a copy of another distribution's desktop.

## Design direction

- Deep espresso and charcoal surfaces
- Muted copper / bronze accents
- Restrained transparency and visual effects
- Consistent KDE and application styling
- A compact, useful developer shell
- Minimal dependencies and no unnecessary configuration framework

## Current scope

The setup currently manages Zsh, Starship, and the Espresso Copper KDE color scheme. The custom Kvantum widget theme, Plasma layout, icons, fonts, wallpaper, and SDDM will be added after testing against the installed FreeBSD desktop.

## Requirements

- FreeBSD 15
- KDE Plasma 6 (installed separately)
- Git
- Zsh
- Starship

Install the shell tools with:

```sh
sudo pkg install git zsh starship
```

Kvantum can be installed when beginning the application-theme setup:

```sh
sudo pkg install kvantum
```

## Setup

Clone the repository and run:

```sh
git clone https://github.com/flushwhy/freebsd-mokka.git
cd freebsd-mokka
sh setup.sh
```

The setup script links the repository's Zsh and Starship configuration and installs the Espresso Copper color scheme into your user data directory. Existing files are backed up before they are replaced. It does not change your login shell, modify system files, or install packages automatically.

After setup, make Zsh your login shell if desired:

```sh
chsh -s "$(command -v zsh)"
```

Log out and back in for the login-shell change to take effect. Then open **System Settings → Colors & Themes → Colors** and select **Espresso Copper**.

## Repository layout

```text
config/
  starship/starship.toml
  zsh/.zshrc
setup.sh
packages.txt
```

## Principles

- Keep setup safe to rerun.
- Prefer native FreeBSD and KDE mechanisms.
- Back up user configuration before changing it.
- Avoid hidden system-wide changes.
- Keep the configuration understandable and easy to maintain.
- Test desktop-specific settings on FreeBSD before documenting them as supported.

## License

MIT
