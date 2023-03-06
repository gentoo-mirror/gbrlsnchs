# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

inherit go-module

DESCRIPTION="Command-line tool for interacting with gRPC servers"
HOMEPAGE="https://github.com/fullstorydev/grpcurl"

SRC_URI="
	${HOMEPAGE}/archive/refs/tags/v${PV}.tar.gz
	https://user.fm/files/v2-c45a0f41cf0302c723d29f7a67027ebc/${P}-vendor.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -o ${PN} -v -ldflags "-X 'main.version=${PV}'" ./cmd/...
}

src_install() {
	dobin ${PN}

	default
}
