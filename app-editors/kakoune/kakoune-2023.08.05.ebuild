# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Modal editor inspired by vim"
HOMEPAGE="http://kakoune.org/ https://github.com/mawww/kakoune"
SRC_URI="https://github.com/mawww/kakoune/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"

BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-window-title.patch
)

src_prepare() {
	sed -i '/CXXFLAGS += -O3/d' src/Makefile || die
	default
}

src_configure() {
	tc-export CXX
}

src_compile() {
	emake -C src all
}

src_test() {
	emake -C src test
}

src_install() {
	emake PREFIX="${D}"/usr docdir="${ED}/usr/share/doc/${PF}" install

	rm "${ED}/usr/share/man/man1/kak.1.gz" || die
	doman doc/kak.1
}
