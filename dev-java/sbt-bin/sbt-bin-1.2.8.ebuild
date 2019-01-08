# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Copyright 2019 Rabenda
EAPI=6

inherit java-pkg-2

DESCRIPTION="sbt, a build tool for Scala"
HOMEPAGE="https://scala-sbt.org"
SRC_URI="https://github.com/sbt/sbt/releases/download/v${PV}/${PN/-bin}-${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
        >=virtual/jre-1.8
        !dev-java/sbt"

src_unpack() {
        default
        mv "${WORKDIR}/sbt" "${S}" || die
}

src_prepare() {
        default
        java-pkg_init_paths_
}

src_compile() {
        :;
}

src_install() {
        local dest="${JAVA_PKG_SHAREPATH}"

        rm -v bin/sbt.bat || die
        sed -i -e 's#bin/sbt-launch.jar#lib/sbt-launch.jar#g;' \
                bin/sbt-launch-lib.bash || die

        insinto "${dest}/lib"
        doins bin/* || die

        insinto "${dest}"
        doins -r conf || die

        fperms 0755 "${dest}/lib/sbt" || die
        dosym "${dest}/lib/sbt" /usr/bin/sbt || die
}