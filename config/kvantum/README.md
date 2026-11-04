# Kvantum

The Nusa Obsidian Kvantum config pairs with the installed KvBrown SVG as a starting point. This keeps the existing widget geometry while applying Nusa's palette.

- Obsidian surfaces: `#17191B`
- Espresso elevated surfaces: `#292725`
- Copper focus and selection: `#B47750`
- Sand secondary accent: `#D2B99A`
- Ivory text: `#E8E3DA`

Install the user theme from the repository root:

```sh
mkdir -p ~/.config/Kvantum/NusaObsidian
cp /usr/local/share/Kvantum/KvBrown/KvBrown.svg \
  ~/.config/Kvantum/NusaObsidian/NusaObsidian.svg
cp config/kvantum/NusaObsidian.kvconfig \
  ~/.config/Kvantum/NusaObsidian/NusaObsidian.kvconfig
```

Select **NusaObsidian** in Kvantum Manager. Keep the SVG and matching `.kvconfig` together in the user theme directory; do not modify the system-installed theme.
