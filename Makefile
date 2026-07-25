CARGO ?= cargo

.PHONY: build check deb

build:
	CARGO_TARGET_DIR="$(CURDIR)/target/bbcat" \
		$(CARGO) build --manifest-path components/bbcat/Cargo.toml \
		--release --locked
	CARGO_TARGET_DIR="$(CURDIR)/target/bbcat-gtk" \
		$(CARGO) build --manifest-path components/bbcat-gtk/Cargo.toml \
		--release --locked

check:
	@test -f components/bbcat/Cargo.toml || { \
		echo "bbcat submodule is missing; run git submodule update --init --recursive" >&2; \
		exit 1; \
	}
	@test -f components/bbcat-gtk/Cargo.toml || { \
		echo "bbcat-gtk submodule is missing; run git submodule update --init --recursive" >&2; \
		exit 1; \
	}
	@test -f components/bbcat-sushi/viewers/bbcat.js || { \
		echo "bbcat-sushi submodule is missing; run git submodule update --init --recursive" >&2; \
		exit 1; \
	}
	$(CARGO) fmt --manifest-path components/bbcat/Cargo.toml -- --check
	$(CARGO) fmt --manifest-path components/bbcat-gtk/Cargo.toml -- --check
	gjs -c "const GLib = imports.gi.GLib; const source = GLib.file_get_contents('components/bbcat-sushi/viewers/bbcat.js')[1]; new Function(new TextDecoder().decode(source));"
	desktop-file-validate components/bbcat-gtk/dev.bbcat.GtkViewer.desktop
	xmllint --noout components/bbcat-gtk/bbcat.xml

deb:
	CARGO="$(CARGO)" ./scripts/build-deb
