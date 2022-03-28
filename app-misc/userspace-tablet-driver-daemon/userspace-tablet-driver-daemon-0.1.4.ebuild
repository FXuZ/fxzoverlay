# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs cmake systemd udev

DESCRIPTION="A userspace driver daemon for general pen tablets."
HOMEPAGE="https://github.com/kurikaesu/userspace-tablet-driver-daemon"
SRC_URI="https://github.com/kurikaesu/userspace-tablet-driver-daemon/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/libusb
	sys-apps/systemd:0=
	virtual/udev:*"
DEPEND="
	${RDEPEND}
"
S="${WORKDIR}/${PN}-${PV}"

PATCHES=("${FILESDIR}"/v${PV}-01-cmakefix.patch)

src_prepare() {
	# default
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
}

src_install_all() {
	newinitd "${FILESDIR}"/userspace-tablet-driver-daemon userspace-tablet-driver-daemon
	systemd_dounit "${FILESDIR}"/userspace-tablet-driver-daemon.service
}
