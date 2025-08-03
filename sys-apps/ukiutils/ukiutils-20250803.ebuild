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

pkg_postinst() {
	elog "The script `mkuki` is no longer available"
	elog "Use sys-kernel/installkernel with `dracut`, `efistub` and `uki` USE flags instead"
	elog "See https://wiki.gentoo.org/wiki/Unified_kernel_image#Dracut"
}
