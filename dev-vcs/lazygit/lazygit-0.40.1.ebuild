# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A simple terminal UI for git commands, written in Go with the gocui library"
HOMEPAGE="https://github.com/jesseduffield/lazygit"
SRC_URI="https://github.com/jesseduffield/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
BUILD_SOURCE="Gentoo-cova-overlay"
BUILD_COMMIT="579791e"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND=( sys-apps/coreutils )
RDEPEND=(
	dev-vcs/git
)

DOCS=( docs LICENSE {README,CONTRIBUTING}.md )

src_compile() {
	export CGO_ENABLED=0
	gox \
		-os=$(go env GOOS) \
		-arch=$(go env GOARCH) \
		-output lazygit \
    -ldflags "-X main.version=${PV} -X main.date=$(date -I -u) -X main.commit=${BUILD_COMMIT} -X main.buildSource=${BUILD_SOURCE}" \
		-verbose \
		. || die
}

src_install() {
	dobin lazygit
	einstalldocs
}
