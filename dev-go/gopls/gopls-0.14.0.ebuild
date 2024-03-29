# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8
inherit go-module

ARCHIVE_URI="https://github.com/golang/tools/archive/refs/tags/gopls/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"
DESCRIPTION="\"Go please\" is the official Go language server"
HOMEPAGE="https://github.com/golang/tools/blob/master/gopls/README.md"
SLOT="0"
LICENSE="BSD"
BDEPEND=">=dev-lang/go-1.18"
SRC_URI="
	${ARCHIVE_URI}
	https://user.fm/files/v2-c520f578c260f6a77bbb977f0d082d90/${P}-deps.tar.xz
"
# TODO: fix test failure with deps tarball
RESTRICT+=" test"

S=${WORKDIR}/tools-gopls-v${PV}/${PN}

src_prepare() {
	default
	rm internal/regtest/misc/vendor_test.go || die
}

src_compile() {
	GOBIN="${S}/bin" CGO_ENABLED=0 go install ./...
	[[ -x bin/${PN} ]] || die "${PN} build failed"
}

src_test() {
	go test -work "./..." || die
}

src_install() {
	dobin bin/${PN}
	dodoc -r doc README.md
}
