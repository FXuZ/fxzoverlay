# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs cmake systemd udev git-r3

DESCRIPTION="A userspace driver daemon for general pen tablets."
HOMEPAGE="https://github.com/kurikaesu/userspace-tablet-driver-daemon"
EGIT_REPO_URI="https://github.com/kurikaesu/userspace-tablet-driver-daemon.git"
EGIT_BRANCH="main"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="**"
IUSE=""

RDEPEND="virtual/libusb
	sys-apps/systemd:0=
	virtual/udev:*"
DEPEND="
	${RDEPEND}
"


src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/
		-DUDEV_RULES_PATH=$(get_udevdir))
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}
src_install() {
	cmake_src_install
	newinitd "${FILESDIR}"/userspace-tablet-driver-daemon userspace-tablet-driver-daemon
	# upstream has disabled root access to this daemon
	systemd_douserunit "${FILESDIR}"/userspace-tablet-driver-daemon.service
}

