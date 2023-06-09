# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

CRATES="
	ansi_term-0.12.1
	anyhow-1.0.68
	bitflags-1.3.2
	cc-1.0.78
	clap-4.0.29
	clap_complete-4.0.6
	clap_derive-4.0.21
	clap_lex-0.3.0
	ctor-0.1.26
	diff-0.1.13
	errno-0.2.8
	errno-dragonfly-0.1.2
	heck-0.4.0
	indoc-1.0.3
	io-lifetimes-1.0.3
	lazy_static-1.4.0
	libc-0.2.138
	linux-raw-sys-0.1.4
	once_cell-1.16.0
	os_str_bytes-6.4.1
	output_vt100-0.1.3
	pretty_assertions-0.7.2
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.47
	quote-1.0.21
	regex-1.7.0
	regex-syntax-0.6.28
	rustix-0.36.5
	serde-1.0.133
	serde_derive-1.0.133
	strsim-0.10.0
	syn-1.0.105
	tabwriter-1.2.1
	terminal_size-0.2.3
	thiserror-1.0.26
	thiserror-impl-1.0.26
	toml-0.5.8
	unicode-ident-1.0.5
	unicode-width-0.1.10
	unindent-0.1.10
	version_check-0.9.4
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.0
	windows_aarch64_msvc-0.42.0
	windows_i686_gnu-0.42.0
	windows_i686_msvc-0.42.0
	windows_x86_64_gnu-0.42.0
	windows_x86_64_gnullvm-0.42.0
	windows_x86_64_msvc-0.42.0
"

inherit cargo bash-completion-r1

DESCRIPTION="Configuration-based dotfiles manager"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://git.sr.ht/~gbrlsnchs/park"
SRC_URI="
	${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"
S="${WORKDIR}/${PN}-v${PV}"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-text/scdoc"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install

	newbashcomp "target/completions/${PN}.bash" "${PN}"

	insinto /usr/share/fish/vendor_completions.d
	doins "target/completions/${PN}.fish"

	insinto /usr/share/zsh/site-functions
	doins "target/completions/_${PN}" 

	dodoc README.md

	doman "target/doc/park.1"
	doman "target/doc/park.5"
}
