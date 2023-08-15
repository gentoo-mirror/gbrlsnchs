# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

inherit go-module

DESCRIPTION="Easy and repeatable Kubernetes development"
HOMEPAGE="https://skaffold.dev/"

SRC_URI="https://github.com/GoogleContainerTools/skaffold/archive/refs/tags/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build \
		-mod=vendor \
		-gcflags="all=-N -l" \
		-tags "timetzdata osusergo netgo static_build release" \
		-ldflags "-X 'github.com/GoogleContainerTools/skaffold/v2/pkg/skaffold/version.version=${PV}' -s -w -extldflags '-static'" \
		-o ${PN} \
		-v \
		./cmd/skaffold
}

src_install() {
	dobin ${PN}
	
	./${PN} completion bash > "${PN}.bash"
	./${PN} completion fish > "${PN}.fish"
	./${PN} completion zsh > "_${PN}"

	newbashcomp "${PN}.bash" "${PN}"

	insinto /usr/share/fish/vendor_completions.d
	doins "${PN}.fish"

	insinto /usr/share/zsh/site-functions
	doins "_${PN}"

	default
}
