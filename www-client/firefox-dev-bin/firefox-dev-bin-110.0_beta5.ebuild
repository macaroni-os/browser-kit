# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOZ_LANGS=( ach af an ar ast az be bg bn br bs ca-valencia ca cak cs cy da de dsb el en-CA en-GB en-US eo es-AR es-CL es-ES es-MX et eu fa ff fi fr fy-NL ga-IE gd gl gn gu-IN he hi-IN hr hsb hu hy-AM ia id is it ja ka kab kk km kn ko lij lt lv mk mr ms my nb-NO ne-NP nl nn-NO oc pa-IN pl pt-BR pt-PT rm ro ru sco si sk sl son sq sr sv-SE szl ta te th tl tr trs uk ur uz vi xh zh-CN zh-TW )

# Convert the ebuild version to the upstream mozilla version, used by mozlinguas
MOZ_PV="${PV/_beta/b}" # Handle beta for SRC_URI
MOZ_PV="${MOZ_PV/_rc/rc}" # Handle rc for SRC_URI
MY_PN="${PN/-bin}"
MOZ_PN="${MY_PN/-dev}"

MOZ_P="${MOZ_PN}-${MOZ_PV}"

inherit desktop linux-info pax-utils xdg

DESCRIPTION="Firefox Web Browser (dev)"
SRC_URI="
	amd64? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/en-US/firefox-110.0b5.tar.bz2 -> firefox-dev-bin_x86_64-110.0_beta5.tar.bz2 )
	x86? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-i686/en-US/firefox-110.0b5.tar.bz2 -> firefox-dev-bin_i686-110.0_beta5.tar.bz2 )
	l10n_ach? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ach.xpi -> firefox-110.0b5-ach.xpi )
	l10n_af? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/af.xpi -> firefox-110.0b5-af.xpi )
	l10n_an? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/an.xpi -> firefox-110.0b5-an.xpi )
	l10n_ar? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ar.xpi -> firefox-110.0b5-ar.xpi )
	l10n_ast? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ast.xpi -> firefox-110.0b5-ast.xpi )
	l10n_az? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/az.xpi -> firefox-110.0b5-az.xpi )
	l10n_be? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/be.xpi -> firefox-110.0b5-be.xpi )
	l10n_bg? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/bg.xpi -> firefox-110.0b5-bg.xpi )
	l10n_bn? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/bn.xpi -> firefox-110.0b5-bn.xpi )
	l10n_br? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/br.xpi -> firefox-110.0b5-br.xpi )
	l10n_bs? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/bs.xpi -> firefox-110.0b5-bs.xpi )
	l10n_ca-valencia? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ca-valencia.xpi -> firefox-110.0b5-ca-valencia.xpi )
	l10n_ca? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ca.xpi -> firefox-110.0b5-ca.xpi )
	l10n_cak? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/cak.xpi -> firefox-110.0b5-cak.xpi )
	l10n_cs? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/cs.xpi -> firefox-110.0b5-cs.xpi )
	l10n_cy? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/cy.xpi -> firefox-110.0b5-cy.xpi )
	l10n_da? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/da.xpi -> firefox-110.0b5-da.xpi )
	l10n_de? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/de.xpi -> firefox-110.0b5-de.xpi )
	l10n_dsb? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/dsb.xpi -> firefox-110.0b5-dsb.xpi )
	l10n_el? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/el.xpi -> firefox-110.0b5-el.xpi )
	l10n_en-CA? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/en-CA.xpi -> firefox-110.0b5-en-CA.xpi )
	l10n_en-GB? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/en-GB.xpi -> firefox-110.0b5-en-GB.xpi )
	l10n_en-US? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/en-US.xpi -> firefox-110.0b5-en-US.xpi )
	l10n_eo? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/eo.xpi -> firefox-110.0b5-eo.xpi )
	l10n_es-AR? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/es-AR.xpi -> firefox-110.0b5-es-AR.xpi )
	l10n_es-CL? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/es-CL.xpi -> firefox-110.0b5-es-CL.xpi )
	l10n_es-ES? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/es-ES.xpi -> firefox-110.0b5-es-ES.xpi )
	l10n_es-MX? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/es-MX.xpi -> firefox-110.0b5-es-MX.xpi )
	l10n_et? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/et.xpi -> firefox-110.0b5-et.xpi )
	l10n_eu? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/eu.xpi -> firefox-110.0b5-eu.xpi )
	l10n_fa? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/fa.xpi -> firefox-110.0b5-fa.xpi )
	l10n_ff? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ff.xpi -> firefox-110.0b5-ff.xpi )
	l10n_fi? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/fi.xpi -> firefox-110.0b5-fi.xpi )
	l10n_fr? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/fr.xpi -> firefox-110.0b5-fr.xpi )
	l10n_fy-NL? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/fy-NL.xpi -> firefox-110.0b5-fy-NL.xpi )
	l10n_ga-IE? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ga-IE.xpi -> firefox-110.0b5-ga-IE.xpi )
	l10n_gd? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/gd.xpi -> firefox-110.0b5-gd.xpi )
	l10n_gl? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/gl.xpi -> firefox-110.0b5-gl.xpi )
	l10n_gn? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/gn.xpi -> firefox-110.0b5-gn.xpi )
	l10n_gu-IN? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/gu-IN.xpi -> firefox-110.0b5-gu-IN.xpi )
	l10n_he? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/he.xpi -> firefox-110.0b5-he.xpi )
	l10n_hi-IN? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/hi-IN.xpi -> firefox-110.0b5-hi-IN.xpi )
	l10n_hr? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/hr.xpi -> firefox-110.0b5-hr.xpi )
	l10n_hsb? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/hsb.xpi -> firefox-110.0b5-hsb.xpi )
	l10n_hu? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/hu.xpi -> firefox-110.0b5-hu.xpi )
	l10n_hy-AM? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/hy-AM.xpi -> firefox-110.0b5-hy-AM.xpi )
	l10n_ia? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ia.xpi -> firefox-110.0b5-ia.xpi )
	l10n_id? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/id.xpi -> firefox-110.0b5-id.xpi )
	l10n_is? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/is.xpi -> firefox-110.0b5-is.xpi )
	l10n_it? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/it.xpi -> firefox-110.0b5-it.xpi )
	l10n_ja? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ja.xpi -> firefox-110.0b5-ja.xpi )
	l10n_ka? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ka.xpi -> firefox-110.0b5-ka.xpi )
	l10n_kab? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/kab.xpi -> firefox-110.0b5-kab.xpi )
	l10n_kk? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/kk.xpi -> firefox-110.0b5-kk.xpi )
	l10n_km? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/km.xpi -> firefox-110.0b5-km.xpi )
	l10n_kn? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/kn.xpi -> firefox-110.0b5-kn.xpi )
	l10n_ko? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ko.xpi -> firefox-110.0b5-ko.xpi )
	l10n_lij? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/lij.xpi -> firefox-110.0b5-lij.xpi )
	l10n_lt? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/lt.xpi -> firefox-110.0b5-lt.xpi )
	l10n_lv? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/lv.xpi -> firefox-110.0b5-lv.xpi )
	l10n_mk? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/mk.xpi -> firefox-110.0b5-mk.xpi )
	l10n_mr? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/mr.xpi -> firefox-110.0b5-mr.xpi )
	l10n_ms? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ms.xpi -> firefox-110.0b5-ms.xpi )
	l10n_my? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/my.xpi -> firefox-110.0b5-my.xpi )
	l10n_nb-NO? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/nb-NO.xpi -> firefox-110.0b5-nb-NO.xpi )
	l10n_ne-NP? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ne-NP.xpi -> firefox-110.0b5-ne-NP.xpi )
	l10n_nl? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/nl.xpi -> firefox-110.0b5-nl.xpi )
	l10n_nn-NO? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/nn-NO.xpi -> firefox-110.0b5-nn-NO.xpi )
	l10n_oc? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/oc.xpi -> firefox-110.0b5-oc.xpi )
	l10n_pa-IN? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/pa-IN.xpi -> firefox-110.0b5-pa-IN.xpi )
	l10n_pl? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/pl.xpi -> firefox-110.0b5-pl.xpi )
	l10n_pt-BR? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/pt-BR.xpi -> firefox-110.0b5-pt-BR.xpi )
	l10n_pt-PT? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/pt-PT.xpi -> firefox-110.0b5-pt-PT.xpi )
	l10n_rm? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/rm.xpi -> firefox-110.0b5-rm.xpi )
	l10n_ro? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ro.xpi -> firefox-110.0b5-ro.xpi )
	l10n_ru? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ru.xpi -> firefox-110.0b5-ru.xpi )
	l10n_sco? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/sco.xpi -> firefox-110.0b5-sco.xpi )
	l10n_si? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/si.xpi -> firefox-110.0b5-si.xpi )
	l10n_sk? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/sk.xpi -> firefox-110.0b5-sk.xpi )
	l10n_sl? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/sl.xpi -> firefox-110.0b5-sl.xpi )
	l10n_son? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/son.xpi -> firefox-110.0b5-son.xpi )
	l10n_sq? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/sq.xpi -> firefox-110.0b5-sq.xpi )
	l10n_sr? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/sr.xpi -> firefox-110.0b5-sr.xpi )
	l10n_sv-SE? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/sv-SE.xpi -> firefox-110.0b5-sv-SE.xpi )
	l10n_szl? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/szl.xpi -> firefox-110.0b5-szl.xpi )
	l10n_ta? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ta.xpi -> firefox-110.0b5-ta.xpi )
	l10n_te? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/te.xpi -> firefox-110.0b5-te.xpi )
	l10n_th? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/th.xpi -> firefox-110.0b5-th.xpi )
	l10n_tl? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/tl.xpi -> firefox-110.0b5-tl.xpi )
	l10n_tr? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/tr.xpi -> firefox-110.0b5-tr.xpi )
	l10n_trs? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/trs.xpi -> firefox-110.0b5-trs.xpi )
	l10n_uk? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/uk.xpi -> firefox-110.0b5-uk.xpi )
	l10n_ur? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/ur.xpi -> firefox-110.0b5-ur.xpi )
	l10n_uz? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/uz.xpi -> firefox-110.0b5-uz.xpi )
	l10n_vi? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/vi.xpi -> firefox-110.0b5-vi.xpi )
	l10n_xh? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/xh.xpi -> firefox-110.0b5-xh.xpi )
	l10n_zh-CN? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/zh-CN.xpi -> firefox-110.0b5-zh-CN.xpi )
	l10n_zh-TW? ( https://archive.mozilla.org/pub/devedition/releases/110.0b5/linux-x86_64/xpi/zh-TW.xpi -> firefox-110.0b5-zh-TW.xpi )
	
"
HOMEPAGE="https://www.mozilla.org/en-US/firefox/"
RESTRICT="strip"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE="+alsa +ffmpeg geckodriver +pulseaudio selinux wayland startup-notification l10n_ach l10n_af l10n_an l10n_ar l10n_ast l10n_az l10n_be l10n_bg l10n_bn l10n_br l10n_bs l10n_ca-valencia l10n_ca l10n_cak l10n_cs l10n_cy l10n_da l10n_de l10n_dsb l10n_el l10n_en-CA l10n_en-GB l10n_en-US l10n_eo l10n_es-AR l10n_es-CL l10n_es-ES l10n_es-MX l10n_et l10n_eu l10n_fa l10n_ff l10n_fi l10n_fr l10n_fy-NL l10n_ga-IE l10n_gd l10n_gl l10n_gn l10n_gu-IN l10n_he l10n_hi-IN l10n_hr l10n_hsb l10n_hu l10n_hy-AM l10n_ia l10n_id l10n_is l10n_it l10n_ja l10n_ka l10n_kab l10n_kk l10n_km l10n_kn l10n_ko l10n_lij l10n_lt l10n_lv l10n_mk l10n_mr l10n_ms l10n_my l10n_nb-NO l10n_ne-NP l10n_nl l10n_nn-NO l10n_oc l10n_pa-IN l10n_pl l10n_pt-BR l10n_pt-PT l10n_rm l10n_ro l10n_ru l10n_sco l10n_si l10n_sk l10n_sl l10n_son l10n_sq l10n_sr l10n_sv-SE l10n_szl l10n_ta l10n_te l10n_th l10n_tl l10n_tr l10n_trs l10n_uk l10n_ur l10n_uz l10n_vi l10n_xh l10n_zh-CN l10n_zh-TW"

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
		!pulseaudio? ( media-sound/apulse )
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

# Allow MOZ_GMP_PLUGIN_LIST to be set in an eclass or
# overridden in the enviromnent (advanced hackers only)
if [[ -z "${MOZ_GMP_PLUGIN_LIST+set}" ]] ; then
	MOZ_GMP_PLUGIN_LIST=( gmp-gmpopenh264 gmp-widevinecdm )
fi

S="${WORKDIR}/${MOZ_PN}"

moz_install_xpi() {
	debug-print-function ${FUNCNAME} "$@"

	
	if [[ ${#} -lt 2 ]] ; then
		die "${FUNCNAME} requires at least two arguments"
	fi
	

	local DESTDIR=${1}
	shift

	insinto "${DESTDIR}"

	local emid xpi_file xpi_tmp_dir
	for xpi_file in "${@}" ; do
		emid=
		xpi_tmp_dir=$(mktemp -d --tmpdir="${T}")

		# Unpack XPI
		unzip -qq "${xpi_file}" -d "${xpi_tmp_dir}" || die

		# Determine extension ID
		if [[ -f "${xpi_tmp_dir}/install.rdf" ]] ; then
			emid=$(
				sed -n -e '/install-manifest/,$ { /em:id/!d; s/.*[\">]\([^\"<>]*\)[\"<].*/\1/; p; q }' \
				"${xpi_tmp_dir}/install.rdf")
			[[ -z "${emid}" ]] && die "failed to determine extension id from install.rdf"
		elif [[ -f "${xpi_tmp_dir}/manifest.json" ]] ; then
			emid=$(sed -n -e 's/.*"id": "\([^"]*\)".*/\1/p' "${xpi_tmp_dir}/manifest.json")
			[[ -z "${emid}" ]] && die "failed to determine extension id from manifest.json"
		else
			die "failed to determine extension id"
		fi

		einfo "Installing ${emid}.xpi into ${ED}/${DESTDIR} ..."
		newins "${xpi_file}" "${emid}.xpi"
	done
}

pkg_setup() {
	CONFIG_CHECK="~SECCOMP"
	WARNING_SECCOMP="CONFIG_SECCOMP not set! This system will be unable to play DRM-protected content."

	linux-info_pkg_setup
}

src_unpack() {
	einfo "${A}"
	local _lp_dir="${WORKDIR}/language_packs"
	local _src_file

	if [[ ! -d "${_lp_dir}" ]] ; then
		mkdir "${_lp_dir}" || die
	fi

	for _src_file in ${A} ; do
		if [[ ${_src_file} == *.xpi ]]; then
			cp "${DISTDIR}/${_src_file}" "${_lp_dir}" || die "Failed to copy '${_src_file}' to '${_lp_dir}'!"
		else
			unpack ${_src_file}
		fi
	done
}


src_install() {
	local MOZILLA_FIVE_HOME=/opt/${MY_PN}

	dodir /opt
	cd "${ED}"/opt &>/dev/null || die
	mv "${S}" "${ED}"/${MOZILLA_FIVE_HOME} || die


	pax-mark m "${ED}/"${MOZILLA_FIVE_HOME}/{firefox,firefox-bin,plugin-container}

	# Patch alsa support
	local apulselib=
	if use alsa && ! use pulseaudio ; then
		apulselib="${EPREFIX}/usr/$(get_libdir)/apulse"
		patchelf --set-rpath "${apulselib}" "${ED}${MOZILLA_FIVE_HOME}/libxul.so" || die
	fi

	# Install policy (currently only used to disable application updates)
	insinto "${MOZILLA_FIVE_HOME}/distribution"
	newins "${FILESDIR}"/disable-auto-update.policy.json policies.json

	# Install system-wide preferences
	local PREFS_DIR="${MOZILLA_FIVE_HOME}/browser/defaults/preferences"
	insinto "${PREFS_DIR}"
	newins "${FILESDIR}"/all-gentoo-3.js all-gentoo.js

	# Fix prefs that make no sense for a system-wide install
	insinto ${MOZILLA_FIVE_HOME}/defaults/pref/
	doins "${FILESDIR}"/local-settings.js

	local GENTOO_PREFS="${ED}${PREFS_DIR}/all-gentoo.js"

	for plugin in "${MOZ_GMP_PLUGIN_LIST[@]}" ; do
		einfo "Disabling auto-update for ${plugin} plugin ..."
		cat >>"${GENTOO_PREFS}" <<-EOF || die "failed to disable autoupdate for ${plugin} media plugin"
		pref("media.${plugin}.autoupdate",   false);
		EOF
	done

	# Install language packs
	local langpacks=( $(find "${WORKDIR}/language_packs" -type f -name '*.xpi') )
	if [[ -n "${langpacks}" ]] ; then
		moz_install_xpi "${MOZILLA_FIVE_HOME}/distribution/extensions" "${langpacks[@]}"
	fi

	# Install SVG icons
	# local icon_symbolic_file="${FILESDIR}/firefox-symbolic.svg"
	# insinto /usr/share/icons/hicolor/symbolic/apps
	# newins "${icon_symbolic_file}" ${PN}-symbolic.svg

	# Install icons
	local icon_srcdir="${ED}/${MOZILLA_FIVE_HOME}/browser/chrome/icons/default"
	local icon size
	for icon in "${icon_srcdir}"/default*.png ; do
		size=${icon%.png}
		size=${size##*/default}

		if [[ ${size} -eq 48 ]] ; then
			newicon "${icon}" ${PN}.png
		fi

		newicon -s ${size} "${icon}" ${PN}.png
	done

	# Install menu
	local app_name="Mozilla ${MOZ_PN^} (bin)"
	local desktop_file="${FILESDIR}/${PN}.desktop"
	local desktop_filename="${PN}.desktop"
	local exec_command="${PN}"
	local icon="${PN}"
	local use_wayland="false"

	if use wayland ; then
		use_wayland="true"
	fi

	cp "${desktop_file}" "${WORKDIR}/${PN}.desktop-template" || die

	sed -i \
		-e "s:@NAME@:${app_name}:" \
		-e "s:@EXEC@:${exec_command}:" \
		-e "s:@ICON@:${icon}:" \
		"${WORKDIR}/${PN}.desktop-template" \
		|| die

	newmenu "${WORKDIR}/${PN}.desktop-template" "${desktop_filename}"

	rm "${WORKDIR}/${PN}.desktop-template" || die

	# Create /usr/bin/firefox-bin or /usr/bin/firefox-dev-bin
	[[ -f "${ED}/usr/bin/${PN}" ]] && rm "${ED}/usr/bin/${PN}"

	# Update wrapper
	#sed -i \
	#	-e "s:@PREFIX@:${EPREFIX}/usr:" \
	#	-e "s:@MOZ_FIVE_HOME@:${MOZILLA_FIVE_HOME}:" \
	#	-e "s:@APULSELIB_DIR@:${apulselib}:" \
	#	-e "s:@DEFAULT_WAYLAND@:${use_wayland}:" \
	#	"${ED}/usr/bin/${PN}" \
	#	|| die


	dodir /usr/bin/
	local apulselib=$(usex pulseaudio "" $(usex alsa "/usr/$(get_libdir)/apulse:" ""))
	cat <<-EOF >"${ED}/"usr/bin/${PN}
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="${apulselib}${MOZILLA_FIVE_HOME}/" \\
	GTK_PATH=/usr/$(get_libdir)/gtk-3.0/ \\
	exec ${MOZILLA_FIVE_HOME}/${MOZ_PN} "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=${MOZILLA_FIVE_HOME}" >> ${T}/10${PN}
	doins "${T}"/10${PN}
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