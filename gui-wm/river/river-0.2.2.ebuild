# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

DESCRIPTION="Dynamic tiling wayland compositor"
HOMEPAGE="https://github.com/riverwm/river"

SRC_URI="https://github.com/riverwm/river/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	>=gui-libs/wlroots-0.16.0:=[X]
	x11-libs/cairo[X]
	x11-libs/libxkbcommon:=[X]
	x11-libs/pixman
"
DEPEND="${RDEPEND}"
BDEPEND="
	|| ( >=dev-lang/zig-0.10.0 >=dev-lang/zig-bin-0.10.0 )
	dev-libs/wayland-protocols
	virtual/pkgconfig
	app-text/scdoc
"

QA_FLAGS_IGNORED="usr/bin/river*"

src_configure() {
	export zigoptions=(
		--verbose
		-Drelease-safe
		-Dxwayland=true
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
	mkdir "${ED}"/usr/etc || die
	mv "${ED}"/usr/etc "${ED}" || die
}
