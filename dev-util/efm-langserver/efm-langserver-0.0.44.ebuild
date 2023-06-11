# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

inherit go-module

DESCRIPTION="General purpose language server"
HOMEPAGE="https://github.com/mattn/efm-langserver"

SRC_URI="
	${HOMEPAGE}/archive/refs/tags/v${PV}.tar.gz
	https://user.fm/files/v2-5874cee5cb19cbfebed47104ff7fddd3/${P}-vendor.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -mod=vendor -o ${PN} -v -ldflags="-s -w -X 'main.revision=${PV}'" .
}

src_install() {
	dobin ${PN}
}
