# Kvantum

The KDE color scheme is the first desktop layer. The custom Kvantum widget theme is intentionally staged after checking which themes and Qt style plugin are installed by the FreeBSD package.

## Inspect installed themes

After installing the `Kvantum` package, run:

```sh
find /usr/local/share/Kvantum -mindepth 1 -maxdepth 1 -type d -print
```

Then open **Kvantum Manager** from the application launcher and inspect the available themes. Do not assume a Linux theme path or copy files into system directories.

The custom theme will use the Espresso Copper palette: near-black espresso surfaces, warm off-white text, and restrained copper focus/hover states. Keep the SVG theme assets and matching `.kvconfig` together in a user-installed theme directory under `~/.config/Kvantum/`.
