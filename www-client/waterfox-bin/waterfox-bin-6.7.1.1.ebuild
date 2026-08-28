# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
RESTRICT="strip"
QA_PREBUILT="
/opt/waterfox/*.so
/opt/waterfox/waterfox-bin
/opt/waterfox/updater
/opt/waterfox/glxtext
/opt/waterfox/vaapitest
"

inherit desktop pax-utils xdg

DESCRIPTION="Waterfox Web Browser Precompiled (stable)"
HOMEPAGE="https://www.waterfox.net/"
SRC_URI="https://cdn1.waterfox.net/waterfox/releases/6.7.1.1/Linux_x86_64/waterfox-6.7.1.1.tar.bz2 -> waterfox-bin-6.7.1.1.tar.bz2"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 +alsa +ffmpeg geckodriver +pulseaudio selinux
"
RDEPEND="dev-libs/atk
	sys-apps/dbus
	dev-libs/dbus-glib
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/cairo[X]
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/pango
	virtual/freedesktop-icon-theme
	alsa? (
	  !pulseaudio? ( media-sound/apulse )
	)
	geckodriver? ( www-apps/geckodriver )
	pulseaudio? ( media-sound/pulseaudio )
	ffmpeg? ( media-video/ffmpeg )
	selinux? ( sec-policy/selinux-mozilla )
	
"
DEPEND="app-arch/unzip
	alsa? (
	  !pulseaudio? (
	    dev-util/patchelf
	    media-sound/apulse
	  )
	)
	
"
S="${WORKDIR}/waterfox"
src_install() {
	local WATERFOX_HOME=/opt/waterfox
	dodir /opt
	cd "${ED}"/opt &>/dev/null || die
	mv "${S}" "${ED}"/${WATERFOX_HOME} || die
	pax-mark m "${ED}/"${WATERFOX_HOME}/{waterfox,waterfox-bin}
	# Patch alsa support
	local apulselib=
	if use alsa && ! use pulseaudio ; then
		apulselib="${EPREFIX}/usr/$(get_libdir)/apulse"
		patchelf --set-rpath "${apulselib}" "${ED}${WATERFOX_HOME}/libxul.so" || die
	fi
	# Install policy (currently only used to disable application updates)
	insinto "${WATERFOX_HOME}/distribution"
	newins "${FILESDIR}"/disable-auto-update.policy.json policies.json
	# Install system-wide preferences
	local PREFS_DIR="${WATERFOX_HOME}/browser/defaults/preferences"
	insinto "${PREFS_DIR}"
	newins "${FILESDIR}"/all-macaroni.js all-macaroni.js

	# Fix prefs that make no sense for a system-wide install
	insinto ${WATERFOX_HOME}/defaults/pref/
	doins "${FILESDIR}"/local-settings.js

	local MACARONI_PREFS="${ED}${PREFS_DIR}/all-macaroni.js"

	# Install icons
	local icon_srcdir="${ED}/${WATERFOX_HOME}/browser/chrome/icons/default"
	local icon size
	for icon in "${icon_srcdir}"/default*.png ; do
		size=${icon%.png}
		size=${size##*/default}

		if [[ ${size} -eq 48 ]] ; then
			newicon "${icon}" ${PN}.png
		fi

		newicon -s ${size} "${icon}" ${PN}.png
	done

	# Install icons
	local icon_srcdir="${S}/browser/branding/official"
	local icon_symbolic_file="${FILESDIR}/icon/waterfox-symbolic.svg"
	insinto /usr/share/icons/hicolor/symbolic/apps
	newins "${icon_symbolic_file}" ${PN}-symbolic.svg

	# Install menu
	local app_name="Waterfox (bin)"
	local desktop_file="${FILESDIR}/icon/${PN}.desktop"
	local desktop_filename="${PN}.desktop"
	local exec_command="${PN}"
	local icon="${PN}"

	cp "${desktop_file}" "${WORKDIR}/${PN}.desktop-template" || die

	sed -i \
		-e "s:@NAME@:${app_name}:" \
		-e "s:@EXEC@:${exec_command}:" \
		-e "s:@ICON@:${icon}:" \
		"${WORKDIR}/${PN}.desktop-template" \
		|| die

	newmenu "${WORKDIR}/${PN}.desktop-template" "${desktop_filename}"

	rm "${WORKDIR}/${PN}.desktop-template" || die

	[[ -f "${ED}/usr/bin/${PN}" ]] && rm "${ED}/usr/bin/${PN}"

	dodir /usr/bin/
	local apulselib=$(usex pulseaudio "" $(usex alsa "/usr/$(get_libdir)/apulse:" ""))
	cat <<-EOF >"${ED}/"usr/bin/${PN}
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="${apulselib}${WATERFOX_HOME}/" \\
	GTK_PATH=/usr/$(get_libdir)/gtk-3.0/ \\
	exec ${WATERFOX_HOME}/waterfox "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=${WATERFOX_HOME}" >> ${T}/10${PN}
	doins "${T}"/10${PN}
}
pkg_postinst() {
	# Update mimedb for the new .desktop file
	xdg_desktop_database_update
	xdg_icon_cache_update
}
pkg_postrm() {
	xdg_icon_cache_update
}


# vim: filetype=ebuild
