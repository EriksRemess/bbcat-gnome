# bbcat for GNOME

`bbcat-gnome` packages the bbcat tools as one GNOME desktop integration:

- [`bbcat`](https://github.com/EriksRemess/bbcat) for viewing ANSI and BBS art
  in a terminal or exporting it as PNG, APNG, or GIF
- [`bbcat-gtk`](https://github.com/EriksRemess/bbcat-gtk) for opening artwork
  in a GTK4 desktop window
- [`bbcat-sushi`](https://github.com/EriksRemess/bbcat-sushi) for previewing
  artwork with <kbd>Space</kbd> in GNOME Files

The Debian package installs all three together, including their desktop entry,
icon, and shared MIME definitions. It targets system-installed GNOME Sushi 46
or newer. Flatpak Sushi needs the separate user installer from `bbcat-sushi`
because Debian packages cannot place files inside a user's Flatpak data.

## Build

Clone the pinned component revisions together with this repository:

```console
git clone --recurse-submodules https://github.com/EriksRemess/bbcat-gnome.git
cd bbcat-gnome
make deb
```

The build requires Rust, `dpkg-dev`, the GTK4 development files, `make`, and
`pkg-config`. The resulting package is written to `dist/`.

Install it with:

```console
sudo apt install ./dist/bbcat-gnome_*_$(dpkg --print-architecture).deb
```

`bbcat-gnome` has its own version in `VERSION`. Git submodules pin the exact
compatible component revisions; updating a component does not change the
package's version automatically.
