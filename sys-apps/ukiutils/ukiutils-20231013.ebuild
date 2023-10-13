# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

DESCRIPTION="Utility scripts to generate Universal Kernel Image artifacts"
HOMEPAGE="https://git.sr.ht/~gbrlsnchs/ebuilds"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-crypt/efitools
	dev-libs/openssl
	sys-kernel/dracut
	sys-boot/efibootmgr
	sys-apps/systemd-utils[boot]
"
DEPEND="${RDEPEND}"
BDEPEND=""

src_unpack() {
	mkdir -p "${S}"
}

src_compile() {
	:
}

src_install() {
	dobin ${FILESDIR}/*
}
