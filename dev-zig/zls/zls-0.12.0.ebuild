# Copyright 2024 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

inherit edo

DESCRIPTION="Language server for Zig"
HOMEPAGE="https://install.zigtools.org/"
LICENSE="MIT"

SRC_URI="
	https://github.com/zigtools/${PN}/archive/refs/tags/${PV}.tar.gz
	https://github.com/ziglibs/known-folders/archive/bf79988adcfce166f848e4b11e718c1966365329.tar.gz -> known-folders.tar.gz
	https://github.com/ziglibs/diffz/archive/e10bf15962e45affb3fcd7d9a950977a69c901b3.tar.gz -> diffz.tar.gz
"

SLOT="0"
KEYWORDS="~amd64"

IUSE="pie"

EZIG_VISION="0.12*"
BDEPEND="
	|| ( =dev-lang/zig-${EZIG_VISION} =dev-lang/zig-bin-${EZIG_VISION} )
"

QA_FLAGS_IGNORED=usr/bin/zls

# : refer to sys-fs/ncdu :
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	grep_version=$(echo ${EZIG_VISION} | sed -E 's/\./\\./g; s/\*/.*/g')
	EZIG=$(compgen -c | grep 'zig.*-'$grep_version | head -n 1) || die
}

ezig() {
	zig-set_EZIG
	edo "${EZIG}" "${@}"
}

src_prepare() {
	mkdir "${WORKDIR}/deps"
	for pkg in known-folders diffz; do
		ezig fetch --global-cache-dir "${WORKDIR}/deps" "${DISTDIR}/${pkg}.tar.gz"
	done

	default
}

src_compile() {
	local zigoptions=(
		--verbose
		--system "${WORKDIR}/deps/p"
		-Doptimize=ReleaseSafe
		-Ddata_version=${PV}
		-Dversion_data_file_path="${FILESDIR}/version_data_offline.zig"
		-Dpie=$(usex pie true false)
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" ezig build ${zigoptions[@]} --prefix /usr || die
}

src_test() {
	ezig build test || die
}

src_install() {
	cp -a "${T}/usr" "${ED}/usr" || die
	dodoc README.md || die
}
