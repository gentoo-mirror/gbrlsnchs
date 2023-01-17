# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

DESCRIPTION="Language server for Zig"
HOMEPAGE="https://install.zigtools.org/"
LICENSE="MIT"

_known_folders_commit=24845b0103e611c108d6bc334231c464e699742c
_tracy_commit=f493d4aa8ba8141d9680473fad007d8a6348628e
SRC_URI="
	https://github.com/zigtools/${PN}/archive/refs/tags/${PV}.tar.gz
	https://github.com/ziglibs/known-folders/archive/${_known_folders_commit}.tar.gz
	https://github.com/wolfpld/tracy/archive/${_tracy_commit}.tar.gz
"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/zig-0.10.0"

QA_FLAGS_IGNORED=usr/bin/zls

src_prepare() {
	default

	# Set up submodules.
	rm -rf src/{known-folders,tracy,tres}
	cp -r ../known-folders-${_known_folders_commit} src/known-folders
	cp -r ../tracy-${_tracy_commit} src/tracy
}

src_compile() {
	local zigoptions=(
		--verbose
		-Drelease-safe
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" zig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	zig build test || die
}

src_install() {
	cp -r "${T}"/usr "${ED}"/usr || die

	dodoc README.md || die
}
