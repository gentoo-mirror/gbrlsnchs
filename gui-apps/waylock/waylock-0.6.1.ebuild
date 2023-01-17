# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

DESCRIPTION="Small screenlocker for Wayland compositors"
HOMEPAGE="https://github.com/ifreund/waylock"

SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/wayland
	sys-libs/pam
	x11-libs/libxkbcommon:=[X]
"
DEPEND="${RDEPEND}"
BDEPEND="
	|| ( >=dev-lang/zig-0.10.0 >=dev-lang/zig-bin-0.10.0 )
	dev-libs/wayland-protocols
	virtual/pkgconfig
	app-text/scdoc
"

QA_FLAGS_IGNORED="usr/bin/waylock"

src_configure() {
	export zigoptions=(
		--verbose
		-Drelease-safe
		-Dstrip
		-Dpie
		-Dman-pages=true
		"${EXTRA_ECONF[@]}"
	)
}

src_compile() {
	zig build "${zigoptions[@]}" --prefix "${T}/temp_install" || die
}

src_test() {
	zig build test "${zigoptions[@]}" --prefix "${T}/temp_install" || die
}

src_install() {
	zig build install "${zigoptions[@]}" --prefix "${ED}/usr" || die
	mv "${ED}"/usr/etc "${ED}" || die
}
