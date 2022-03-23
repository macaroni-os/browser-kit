# Distributed under the terms of the GNU General Public License v2

EAPI=6
MOZ_ESR=0

MOZ_LANGS=(  )

# Convert the ebuild version to the upstream mozilla version, used by mozlinguas
MOZ_PV="${PV/_beta/b}" # Handle beta for SRC_URI
MOZ_PV="${MOZ_PV/_rc/rc}" # Handle rc for SRC_URI
# Conditionally detect Firefox package name to support Firefox Release Channels
# https://bugs.funtoo.org/browse/FL-9572
if [[ ${PN} == "firefox-beta-bin" ]]; then
	MOZ_PN="${PN/-beta-bin}"
elif [[ ${PN} == "firefox-dev-bin" ]]; then
	MOZ_PN="${PN/-dev-bin}"
elif [[ ${PN} == "firefox-nightly-bin" ]]; then
	MOZ_PN="${PN/-nightly-bin}"
else
	MOZ_PN="${PN/-bin}"
fi

if [[ ${MOZ_ESR} == 1 ]]; then
	# ESR releases have slightly version numbers
	MOZ_PV="${MOZ_PV}esr"
fi

MOZ_P="${MOZ_PN}-${MOZ_PV}"

if [[ ${PN} == "firefox-dev-bin" ]]; then
	MOZ_HTTP_URI="https://archive.mozilla.org/pub/mozilla.org/devedition/releases/"
elif [[ ${PN} == "firefox-nightly-bin" ]]; then
	OZ_HTTP_URI="https://archive.mozilla.org/pub/mozilla.org/${MOZ_PN}/nightly/latest-mozilla-central/"
else
	MOZ_HTTP_URI="https://archive.mozilla.org/pub/mozilla.org/${MOZ_PN}/releases/"
fi

inherit mozlinguas-v2 nsplugins pax-utils xdg-utils eapi7-ver

DESCRIPTION="Firefox Web Browser"
SRC_URI="${SRC_URI}
	amd64? ( https://archive.mozilla.org/pub/firefox/releases/99.0b7/linux-x86_64/en-US/firefox-99.0b7.tar.bz2 -> firefox-beta-bin_x86_64-99.0_beta7.tar.bz2 )
	x86? ( https://archive.mozilla.org/pub/firefox/releases/99.0b7/linux-i686/en-US/firefox-99.0b7.tar.bz2 -> firefox-beta-bin_i686-99.0_beta7.tar.bz2 )"
HOMEPAGE="https://www.mozilla.org/en-US/firefox/"
RESTRICT="strip mirror"

KEYWORDS="-* amd64 x86"
SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE="+alsa +ffmpeg geckodriver +pulseaudio selinux startup-notification"

DEPEND="app-arch/unzip
	alsa? (
		!pulseaudio? (
			dev-util/patchelf
			media-sound/apulse
		)
	)"
RDEPEND="dev-libs/atk
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.72
	>=dev-libs/glib-2.26:2
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/gtk+-3.4.0:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	>=x11-libs/pango-1.22.0
	virtual/freedesktop-icon-theme
	alsa? (
		!pulseaudio? (
			media-sound/apulse
		)
	)
	geckodriver? ( www-apps/geckodriver )
	pulseaudio? ( media-sound/pulseaudio )
	ffmpeg? ( media-video/ffmpeg )
	selinux? ( sec-policy/selinux-mozilla )
"

QA_PREBUILT="
	opt/${MOZ_PN}/*.so
	opt/${MOZ_PN}/${MOZ_PN}
	opt/${MOZ_PN}/${PN}
	opt/${MOZ_PN}/crashreporter
	opt/${MOZ_PN}/webapprt-stub
	opt/${MOZ_PN}/plugin-container
	opt/${MOZ_PN}/mozilla-xremote-client
	opt/${MOZ_PN}/updater
	opt/${MOZ_PN}/minidump-analyzer
	opt/${MOZ_PN}/pingsender
"

S="${WORKDIR}/${MOZ_PN}"

src_unpack() {
	unpack ${A}

	# Unpack language packs
	mozlinguas_src_unpack
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/firefox-beta

	local size sizes icon_path icon name
	sizes="16 32 48 128"
	icon_path="${S}/browser/chrome/icons/default"
	icon="${PN}"
	name="Mozilla Firefox"

	# Install icons and .desktop for menu entry
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png"
	done
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs
	newicon "${S}"/browser/chrome/icons/default/default48.png ${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop
	sed -i -e "s:@NAME@:${name}:" -e "s:@ICON@:${icon}:" \
		"${ED}usr/share/applications/${PN}.desktop" || die

	# Add StartupNotify=true bug 237317
	if use startup-notification; then
		echo "StartupNotify=true" >> "${ED}"usr/share/applications/${PN}.desktop
	fi

	# Install firefox in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${ED}"${MOZILLA_FIVE_HOME} || die

	# Disable built-in auto-update because we update firefox-bin through package manager
	insinto ${MOZILLA_FIVE_HOME}/distribution/
	newins "${FILESDIR}"/disable-auto-update.policy.json policies.json

	# Fix prefs that make no sense for a system-wide install
	insinto ${MOZILLA_FIVE_HOME}/defaults/pref/
	doins "${FILESDIR}"/local-settings.js
	insinto ${MOZILLA_FIVE_HOME}
	newins "${FILESDIR}"/all-gentoo-3.js all-gentoo.js

	# Install language packs
	# Do not install for Firefox Nightly Release Channel at this time
	# Nightly Releases have monolithic lang packs
	# The get_lang_artifacts function from autogen.py will need to be refactored to support single lang packs
	# Upstream Nightly xpi file name example: firefox-100.0a1.en-US.langpack.xpi
	# Upstream Source URI example: http://archive.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-100.0a1.en-US.langpack.xpi
	if [[ ${PN} != "firefox-nightly-bin" ]]; then
		MOZEXTENSION_TARGET="distribution/extensions" \
			MOZ_INSTALL_L10N_XPIFILE="1" \
			mozlinguas_src_install
	fi

	if use alsa && ! use pulseaudio; then
		local apulselib="/usr/$(get_libdir)/apulse"
		patchelf --set-rpath "${apulselib}" "${ED}"${MOZILLA_FIVE_HOME}/libxul.so || die
	fi

	# Create /usr/bin/firefox-bin or /usr/bin/firefox-dev-bin
	dodir /usr/bin/
	local apulselib=$(usex pulseaudio "" $(usex alsa "/usr/$(get_libdir)/apulse:" ""))
	cat <<-EOF >"${ED}"usr/bin/${PN}
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="${apulselib}/opt/firefox-beta/" \\
	GTK_PATH=/usr/$(get_libdir)/gtk-3.0/ \\
	exec /opt/firefox-beta/${MOZ_PN} "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=${MOZILLA_FIVE_HOME}" >> ${T}/10${PN}
	doins "${T}"/10${PN}

	# Plugins dir, still used for flash
	share_plugins_dir

	# Required in order to use plugins and even run firefox on hardened.
	pax-mark mr "${ED}"${MOZILLA_FIVE_HOME}/{firefox,firefox-bin,plugin-container}
}

pkg_postinst() {
	# Update mimedb for the new .desktop file
	xdg_desktop_database_update
	xdg_icon_cache_update

	if ! has_version 'gnome-base/gconf' || ! has_version 'gnome-base/orbit' \
		|| ! has_version 'net-misc/curl'; then
		einfo
		einfo "For using the crashreporter, you need gnome-base/gconf,"
		einfo "gnome-base/orbit and net-misc/curl emerged."
		einfo
	fi

	use ffmpeg || ewarn "USE=-ffmpeg : HTML5 video will not render without media-video/ffmpeg installed"

	local HAS_AUDIO=0
	if use alsa || use pulseaudio; then
		HAS_AUDIO=1
	fi

	if [[ ${HAS_AUDIO} -eq 0 ]] ; then
		ewarn "USE=-pulseaudio & USE=-alsa : For audio please either set USE=pulseaudio or USE=alsa!"
	fi

	local show_doh_information

	if [[ -z "${REPLACING_VERSIONS}" ]] ; then
		# New install; Tell user that DoH is disabled by default
		show_doh_information=yes
	else
		local replacing_version
		for replacing_version in ${REPLACING_VERSIONS} ; do
			if ver_test "${replacing_version}" -lt 70 ; then
				# Tell user only once about our DoH default
				show_doh_information=yes
				break
			fi
		done
	fi

	if [[ -n "${show_doh_information}" ]] ; then
		elog
		elog "Note regarding Trusted Recursive Resolver aka DNS-over-HTTPS (DoH):"
		elog "Due to privacy concerns (encrypting DNS might be a good thing, sending all"
		elog "DNS traffic to Cloudflare by default is not a good idea and applications"
		elog "should respect OS configured settings), \"network.trr.mode\" was set to 5"
		elog "(\"Off by choice\") by default."
		elog "You can enable DNS-over-HTTPS in ${PN^}'s preferences."
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
}