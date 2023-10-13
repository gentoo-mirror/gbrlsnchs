# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

inherit go-module

DESCRIPTION="A stricter gofmt"
HOMEPAGE="https://github.com/mvdan/gofumpt"

SRC_URI="
	${HOMEPAGE}/archive/refs/tags/v${PV}.tar.gz
	https://user.fm/files/v2-67c6ede005d09597f1def0e02b8edee6/${P}-vendor.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -o ${PN} -v -ldflags "-X 'main.version=${PV}'" .
}

src_install() {
	dobin ${PN}

	default
}
