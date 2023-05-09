# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

DESCRIPTION="Really simple suspend script (from Void Linux)"
HOMEPAGE="https://github.com/void-linux/void-runit"
SRC_URI="${HOMEPAGE}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/void-runit-${PV}"

src_compile() {
	:
}

src_install() {
	keepdir etc/zzz.d/{resume,suspend}
	dobin ${PN}
	doman ${PN}.*
}
