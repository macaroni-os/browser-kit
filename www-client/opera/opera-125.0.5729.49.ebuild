# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi \
  hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv \
  sw ta te th tr uk vi zh-CN zh-TW"

QA_PREBUILT="*"
inherit chromium-2 xdg-utils unpacker desktop

DESCRIPTION="A fast and secure web browser"
HOMEPAGE="https://www.opera.com/"
SRC_URI="https://get.geo.opera.com/pub/opera/desktop/125.0.5729.49/linux/opera-stable_125.0.5729.49_amd64.deb -> opera-stable_125.0.5729.49_amd64.deb"
LICENSE="OPERA-2014"
SLOT="0"
KEYWORDS="*"
RDEPEND="dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libnotify
	x11-libs/pango[X]
	
"
S="${WORKDIR}"
src_unpack() {
	unpack_deb ${A}
}
src_prepare() {
	default
	OPERA_HOME="usr/$(get_libdir)/${PN}-stable"
	case ${ARCH} in
	  amd64)
	    mv usr/lib/x86_64-linux-gnu usr/$(get_libdir) || die
	    rm -r usr/lib || die
	    ;;
	esac
	rm usr/bin/${PN} || die
	rm usr/share/doc/${PN}-stable/copyright || die
	mv usr/share/doc/${PN}-stable usr/share/doc/${PF} || die
	gunzip usr/share/doc/${PF}/changelog.gz || die
	pushd "${OPERA_HOME}"/localization > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die
	sed -i \
	  -e 's|^TargetEnvironment|X-&|g' \
	  usr/share/applications/${PN}.desktop || die
}
src_install() {
	rm "${OPERA_HOME}"/${PN}_autoupdate || die
	mv * "${D}" || die
	dosym ../$(get_libdir)/${PN}/${PN} /usr/bin/${PN}
	fperms 4711 /"${OPERA_HOME}"/opera_sandbox
}
pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}


# vim: filetype=ebuild
