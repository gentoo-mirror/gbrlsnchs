# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8
PYTHON_COMPAT=( python3_{6..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A utility for managing secrets in the cloud using AWS KMS and DynamoDB"
HOMEPAGE="https://github.com/fugue/credstash"
SRC_URI="${HOMEPAGE}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="yaml"

RDEPEND="
	yaml? (
		>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	)
	>=dev-python/cryptography-2.1[${PYTHON_USEDEP}]
	>=dev-python/boto3-1.1.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
