# Distributed under the terms of the GNU General Public License v2

EAPI="7"

LLVM_MAX_SLOT=13

PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE="ncurses,sqlite,ssl"

WANT_AUTOCONF="2.1"

VIRTUALX_REQUIRED="pgo"

MOZ_ESR=

MOZ_LANGS=( ach af an ar ast az be bg bn br bs ca-valencia ca cak cs cy da de dsb el en-CA en-GB en-US eo es-AR es-CL es-ES es-MX et eu fa ff fi fr fur fy-NL ga-IE gd gl gn gu-IN he hi-IN hr hsb hu hy-AM ia id is it ja ka kab kk km kn ko lij lt lv mk mr ms my nb-NO ne-NP nl nn-NO oc pa-IN pl pt-BR pt-PT rm ro ru sat sc sco si sk sl son sq sr sv-SE szl ta te tg th tl tr trs uk ur uz vi xh zh-CN zh-TW )

MOZ_PV=${PV}
MOZ_PV_SUFFIX=
if [[ ${PV} =~ (_(alpha|beta|rc).*)$ ]] ; then
	MOZ_PV_SUFFIX=${BASH_REMATCH[1]}

	# Convert the ebuild version to the upstream Mozilla version
	MOZ_PV="${MOZ_PV/_alpha/a}" # Handle alpha for SRC_URI
	MOZ_PV="${MOZ_PV/_beta/b}"  # Handle beta for SRC_URI
	MOZ_PV="${MOZ_PV%%_rc*}"    # Handle rc for SRC_URI
fi

if [[ -n ${MOZ_ESR} ]] ; then
	# ESR releases have slightly different version numbers
	MOZ_PV="${MOZ_PV}esr"
fi

MOZ_PN="${PN%-bin}"
MOZ_P="${MOZ_PN}-${MOZ_PV}"
MOZ_PV_DISTFILES="${MOZ_PV}${MOZ_PV_SUFFIX}"
MOZ_P_DISTFILES="${MOZ_PN}-${MOZ_PV_DISTFILES}"

inherit autotools check-reqs desktop flag-o-matic gnome2-utils linux-info \
	llvm multiprocessing pax-utils python-any-r1 toolchain-funcs \
	virtualx xdg

MOZ_SRC_BASE_URI="https://archive.mozilla.org/pub/${MOZ_PN}/releases/${MOZ_PV}"

SRC_URI="https://archive.mozilla.org/pub/firefox/releases/124.0.1/source/firefox-124.0.1.source.tar.xz -> firefox-124.0.1.source.tar.xz
	https://dev.gentoo.org/~juippis/mozilla/patchsets/firefox-124-patches-01.tar.xz -> firefox-124-patches-01.tar.xz
	l10n_ach? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ach.xpi -> firefox-124.0.1-ach.xpi )
	l10n_af? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/af.xpi -> firefox-124.0.1-af.xpi )
	l10n_an? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/an.xpi -> firefox-124.0.1-an.xpi )
	l10n_ar? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ar.xpi -> firefox-124.0.1-ar.xpi )
	l10n_ast? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ast.xpi -> firefox-124.0.1-ast.xpi )
	l10n_az? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/az.xpi -> firefox-124.0.1-az.xpi )
	l10n_be? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/be.xpi -> firefox-124.0.1-be.xpi )
	l10n_bg? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/bg.xpi -> firefox-124.0.1-bg.xpi )
	l10n_bn? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/bn.xpi -> firefox-124.0.1-bn.xpi )
	l10n_br? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/br.xpi -> firefox-124.0.1-br.xpi )
	l10n_bs? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/bs.xpi -> firefox-124.0.1-bs.xpi )
	l10n_ca-valencia? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ca-valencia.xpi -> firefox-124.0.1-ca-valencia.xpi )
	l10n_ca? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ca.xpi -> firefox-124.0.1-ca.xpi )
	l10n_cak? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/cak.xpi -> firefox-124.0.1-cak.xpi )
	l10n_cs? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/cs.xpi -> firefox-124.0.1-cs.xpi )
	l10n_cy? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/cy.xpi -> firefox-124.0.1-cy.xpi )
	l10n_da? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/da.xpi -> firefox-124.0.1-da.xpi )
	l10n_de? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/de.xpi -> firefox-124.0.1-de.xpi )
	l10n_dsb? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/dsb.xpi -> firefox-124.0.1-dsb.xpi )
	l10n_el? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/el.xpi -> firefox-124.0.1-el.xpi )
	l10n_en-CA? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/en-CA.xpi -> firefox-124.0.1-en-CA.xpi )
	l10n_en-GB? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/en-GB.xpi -> firefox-124.0.1-en-GB.xpi )
	l10n_en-US? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/en-US.xpi -> firefox-124.0.1-en-US.xpi )
	l10n_eo? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/eo.xpi -> firefox-124.0.1-eo.xpi )
	l10n_es-AR? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/es-AR.xpi -> firefox-124.0.1-es-AR.xpi )
	l10n_es-CL? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/es-CL.xpi -> firefox-124.0.1-es-CL.xpi )
	l10n_es-ES? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/es-ES.xpi -> firefox-124.0.1-es-ES.xpi )
	l10n_es-MX? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/es-MX.xpi -> firefox-124.0.1-es-MX.xpi )
	l10n_et? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/et.xpi -> firefox-124.0.1-et.xpi )
	l10n_eu? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/eu.xpi -> firefox-124.0.1-eu.xpi )
	l10n_fa? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/fa.xpi -> firefox-124.0.1-fa.xpi )
	l10n_ff? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ff.xpi -> firefox-124.0.1-ff.xpi )
	l10n_fi? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/fi.xpi -> firefox-124.0.1-fi.xpi )
	l10n_fr? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/fr.xpi -> firefox-124.0.1-fr.xpi )
	l10n_fur? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/fur.xpi -> firefox-124.0.1-fur.xpi )
	l10n_fy-NL? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/fy-NL.xpi -> firefox-124.0.1-fy-NL.xpi )
	l10n_ga-IE? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ga-IE.xpi -> firefox-124.0.1-ga-IE.xpi )
	l10n_gd? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/gd.xpi -> firefox-124.0.1-gd.xpi )
	l10n_gl? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/gl.xpi -> firefox-124.0.1-gl.xpi )
	l10n_gn? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/gn.xpi -> firefox-124.0.1-gn.xpi )
	l10n_gu-IN? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/gu-IN.xpi -> firefox-124.0.1-gu-IN.xpi )
	l10n_he? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/he.xpi -> firefox-124.0.1-he.xpi )
	l10n_hi-IN? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/hi-IN.xpi -> firefox-124.0.1-hi-IN.xpi )
	l10n_hr? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/hr.xpi -> firefox-124.0.1-hr.xpi )
	l10n_hsb? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/hsb.xpi -> firefox-124.0.1-hsb.xpi )
	l10n_hu? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/hu.xpi -> firefox-124.0.1-hu.xpi )
	l10n_hy-AM? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/hy-AM.xpi -> firefox-124.0.1-hy-AM.xpi )
	l10n_ia? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ia.xpi -> firefox-124.0.1-ia.xpi )
	l10n_id? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/id.xpi -> firefox-124.0.1-id.xpi )
	l10n_is? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/is.xpi -> firefox-124.0.1-is.xpi )
	l10n_it? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/it.xpi -> firefox-124.0.1-it.xpi )
	l10n_ja? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ja.xpi -> firefox-124.0.1-ja.xpi )
	l10n_ka? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ka.xpi -> firefox-124.0.1-ka.xpi )
	l10n_kab? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/kab.xpi -> firefox-124.0.1-kab.xpi )
	l10n_kk? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/kk.xpi -> firefox-124.0.1-kk.xpi )
	l10n_km? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/km.xpi -> firefox-124.0.1-km.xpi )
	l10n_kn? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/kn.xpi -> firefox-124.0.1-kn.xpi )
	l10n_ko? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ko.xpi -> firefox-124.0.1-ko.xpi )
	l10n_lij? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/lij.xpi -> firefox-124.0.1-lij.xpi )
	l10n_lt? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/lt.xpi -> firefox-124.0.1-lt.xpi )
	l10n_lv? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/lv.xpi -> firefox-124.0.1-lv.xpi )
	l10n_mk? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/mk.xpi -> firefox-124.0.1-mk.xpi )
	l10n_mr? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/mr.xpi -> firefox-124.0.1-mr.xpi )
	l10n_ms? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ms.xpi -> firefox-124.0.1-ms.xpi )
	l10n_my? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/my.xpi -> firefox-124.0.1-my.xpi )
	l10n_nb-NO? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/nb-NO.xpi -> firefox-124.0.1-nb-NO.xpi )
	l10n_ne-NP? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ne-NP.xpi -> firefox-124.0.1-ne-NP.xpi )
	l10n_nl? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/nl.xpi -> firefox-124.0.1-nl.xpi )
	l10n_nn-NO? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/nn-NO.xpi -> firefox-124.0.1-nn-NO.xpi )
	l10n_oc? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/oc.xpi -> firefox-124.0.1-oc.xpi )
	l10n_pa-IN? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/pa-IN.xpi -> firefox-124.0.1-pa-IN.xpi )
	l10n_pl? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/pl.xpi -> firefox-124.0.1-pl.xpi )
	l10n_pt-BR? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/pt-BR.xpi -> firefox-124.0.1-pt-BR.xpi )
	l10n_pt-PT? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/pt-PT.xpi -> firefox-124.0.1-pt-PT.xpi )
	l10n_rm? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/rm.xpi -> firefox-124.0.1-rm.xpi )
	l10n_ro? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ro.xpi -> firefox-124.0.1-ro.xpi )
	l10n_ru? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ru.xpi -> firefox-124.0.1-ru.xpi )
	l10n_sat? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sat.xpi -> firefox-124.0.1-sat.xpi )
	l10n_sc? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sc.xpi -> firefox-124.0.1-sc.xpi )
	l10n_sco? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sco.xpi -> firefox-124.0.1-sco.xpi )
	l10n_si? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/si.xpi -> firefox-124.0.1-si.xpi )
	l10n_sk? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sk.xpi -> firefox-124.0.1-sk.xpi )
	l10n_sl? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sl.xpi -> firefox-124.0.1-sl.xpi )
	l10n_son? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/son.xpi -> firefox-124.0.1-son.xpi )
	l10n_sq? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sq.xpi -> firefox-124.0.1-sq.xpi )
	l10n_sr? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sr.xpi -> firefox-124.0.1-sr.xpi )
	l10n_sv-SE? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/sv-SE.xpi -> firefox-124.0.1-sv-SE.xpi )
	l10n_szl? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/szl.xpi -> firefox-124.0.1-szl.xpi )
	l10n_ta? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ta.xpi -> firefox-124.0.1-ta.xpi )
	l10n_te? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/te.xpi -> firefox-124.0.1-te.xpi )
	l10n_tg? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/tg.xpi -> firefox-124.0.1-tg.xpi )
	l10n_th? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/th.xpi -> firefox-124.0.1-th.xpi )
	l10n_tl? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/tl.xpi -> firefox-124.0.1-tl.xpi )
	l10n_tr? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/tr.xpi -> firefox-124.0.1-tr.xpi )
	l10n_trs? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/trs.xpi -> firefox-124.0.1-trs.xpi )
	l10n_uk? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/uk.xpi -> firefox-124.0.1-uk.xpi )
	l10n_ur? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/ur.xpi -> firefox-124.0.1-ur.xpi )
	l10n_uz? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/uz.xpi -> firefox-124.0.1-uz.xpi )
	l10n_vi? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/vi.xpi -> firefox-124.0.1-vi.xpi )
	l10n_xh? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/xh.xpi -> firefox-124.0.1-xh.xpi )
	l10n_zh-CN? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/zh-CN.xpi -> firefox-124.0.1-zh-CN.xpi )
	l10n_zh-TW? ( https://archive.mozilla.org/pub/firefox/releases/124.0.1/linux-x86_64/xpi/zh-TW.xpi -> firefox-124.0.1-zh-TW.xpi )
	
"

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="https://www.mozilla.com/firefox"
KEYWORDS="*"

SLOT="0/$(ver_cut 1)"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"

IUSE="+clang cpu_flags_arm_neon dbus debug eme-free hardened hwaccel"
IUSE+=" jack libproxy lto +openh264 pgo pulseaudio sndio selinux"
IUSE+=" system-av1 system-harfbuzz +system-icu +system-jpeg +system-libevent system-libvpx system-png system-python-libs system-webp"
IUSE+=" wayland wifi"
IUSE+=" l10n_ach l10n_af l10n_an l10n_ar l10n_ast l10n_az l10n_be l10n_bg l10n_bn l10n_br l10n_bs l10n_ca-valencia l10n_ca l10n_cak l10n_cs l10n_cy l10n_da l10n_de l10n_dsb l10n_el l10n_en-CA l10n_en-GB l10n_en-US l10n_eo l10n_es-AR l10n_es-CL l10n_es-ES l10n_es-MX l10n_et l10n_eu l10n_fa l10n_ff l10n_fi l10n_fr l10n_fur l10n_fy-NL l10n_ga-IE l10n_gd l10n_gl l10n_gn l10n_gu-IN l10n_he l10n_hi-IN l10n_hr l10n_hsb l10n_hu l10n_hy-AM l10n_ia l10n_id l10n_is l10n_it l10n_ja l10n_ka l10n_kab l10n_kk l10n_km l10n_kn l10n_ko l10n_lij l10n_lt l10n_lv l10n_mk l10n_mr l10n_ms l10n_my l10n_nb-NO l10n_ne-NP l10n_nl l10n_nn-NO l10n_oc l10n_pa-IN l10n_pl l10n_pt-BR l10n_pt-PT l10n_rm l10n_ro l10n_ru l10n_sat l10n_sc l10n_sco l10n_si l10n_sk l10n_sl l10n_son l10n_sq l10n_sr l10n_sv-SE l10n_szl l10n_ta l10n_te l10n_tg l10n_th l10n_tl l10n_tr l10n_trs l10n_uk l10n_ur l10n_uz l10n_vi l10n_xh l10n_zh-CN l10n_zh-TW"

# Firefox-only IUSE
IUSE+=" geckodriver +gmp-autoupdate screencast +X"

REQUIRED_USE="debug? ( !system-av1 )
	pgo? ( lto )
	wayland? ( dbus )
	wifi? ( dbus )"

# lto using clang requires lld as linker, lld does not support linker relaxation on riscv, riscv requires linker relaxation.
REQUIRED_USE+=" riscv? ( clang? ( !lto ) )"
# Firefox-only REQUIRED_USE flags
REQUIRED_USE+=" || ( X wayland )"
REQUIRED_USE+=" pgo? ( X )"
REQUIRED_USE+=" screencast? ( wayland )"

BDEPEND="${PYTHON_DEPS}
	app-arch/unzip
	app-arch/zip
	>=dev-util/cbindgen-0.26.0
	>=net-libs/nodejs-14.19.3
	virtual/pkgconfig
	>=virtual/rust-1.59.0
	|| (
		(
			sys-devel/clang:13
			sys-devel/llvm:13
			clang? (
				=sys-devel/lld-13*
				pgo? ( =sys-libs/compiler-rt-sanitizers-13*[profile] )
			)
		)
		(
			sys-devel/clang:11
			sys-devel/llvm:11
			clang? (
				=sys-devel/lld-11*
				pgo? ( =sys-libs/compiler-rt-sanitizers-11*[profile] )
			)
		)
	)
	amd64? ( >=dev-lang/nasm-2.14 )
	x86? ( >=dev-lang/nasm-2.14 )"

COMMON_DEPEND="
	dev-libs/glib:2
	dev-libs/atk
	dev-libs/expat
	dev-libs/libffi:=
	dev-libs/nss
	>=dev-libs/nspr-4.32
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/mesa
	media-video/ffmpeg
	sys-libs/zlib
	virtual/freedesktop-icon-theme
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
	x11-libs/pixman
	dbus? (
		dev-libs/dbus-glib
		sys-apps/dbus
	)
	jack? ( virtual/jack )
	libproxy? ( net-libs/libproxy )
	selinux? ( sec-policy/selinux-mozilla )
	sndio? ( >=media-sound/sndio-1.8.0-r1 )
	screencast? ( media-video/pipewire:= )
	system-av1? (
		>=media-libs/dav1d-0.9.3:=
		>=media-libs/libaom-1.0.0:=
	)
	system-harfbuzz? (
		>=media-gfx/graphite2-1.3.13
		>=media-libs/harfbuzz-2.8.1:0=
	)
	system-icu? ( >=dev-libs/icu-67.1:= )
	system-jpeg? ( >=media-libs/libjpeg-turbo-1.2.1 )
	system-libevent? ( >=dev-libs/libevent-2.0:0=[threads] )
	system-libvpx? ( >=media-libs/libvpx-1.8.2:0=[postproc] )
	system-png? ( >=media-libs/libpng-1.6.35:0=[apng] )
	system-webp? ( >=media-libs/libwebp-1.1.0:0= )
	wayland? (
		x11-libs/gtk+:3[wayland]
		x11-libs/libdrm
		x11-libs/libxkbcommon[wayland(-)]
	)
	wifi? (
		kernel_linux? (
			dev-libs/dbus-glib
			net-misc/networkmanager
			sys-apps/dbus
		)
	)
	X? (
		virtual/opengl
		x11-libs/cairo[X]
		x11-libs/gtk+:3[X]
		x11-libs/libX11
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libxkbcommon[X]
		x11-libs/libXrandr
		x11-libs/libXtst
		x11-libs/libxcb:=
	)"

RDEPEND="${COMMON_DEPEND}
	!www-client/firefox:0
	!www-client/firefox:esr
	jack? ( virtual/jack )
	openh264? ( media-libs/openh264:*[plugin] )
	pulseaudio? (
		|| (
			media-sound/pulseaudio
			>=media-sound/apulse-0.1.12-r4
		)
	)
	selinux? ( sec-policy/selinux-mozilla )"

DEPEND="${COMMON_DEPEND}
	pulseaudio? (
		|| (
			media-sound/pulseaudio
			>=media-sound/apulse-0.1.12-r4[sdk]
		)
	)
	X? (
		x11-libs/libICE
		x11-libs/libSM
	)"

S="${WORKDIR}/${PN}-${PV%_*}"

# Allow MOZ_GMP_PLUGIN_LIST to be set in an eclass or
# overridden in the enviromnent (advanced hackers only)
if [[ -z "${MOZ_GMP_PLUGIN_LIST+set}" ]] ; then
	MOZ_GMP_PLUGIN_LIST=( gmp-gmpopenh264 gmp-widevinecdm )
fi

llvm_check_deps() {
	if ! has_version -b "sys-devel/clang:${LLVM_SLOT}" ; then
		einfo "sys-devel/clang:${LLVM_SLOT} is missing! Cannot use LLVM slot ${LLVM_SLOT} ..." >&2
		return 1
	fi

	if use clang ; then
		if ! has_version -b "=sys-devel/lld-${LLVM_SLOT}*" ; then
			einfo "=sys-devel/lld-${LLVM_SLOT}* is missing! Cannot use LLVM slot ${LLVM_SLOT} ..." >&2
			return 1
		fi

		if use pgo ; then
			if ! has_version -b "=sys-libs/compiler-rt-sanitizers-${LLVM_SLOT}*" ; then
				einfo "=sys-libs/compiler-rt-sanitizers-${LLVM_SLOT}* is missing! Cannot use LLVM slot ${LLVM_SLOT} ..." >&2
				return 1
			fi
		fi
	fi

	einfo "Using LLVM slot ${LLVM_SLOT} to build" >&2
}

moz_clear_vendor_checksums() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${#} -ne 1 ]] ; then
		die "${FUNCNAME} requires exact one argument"
	fi

	einfo "Clearing cargo checksums for ${1} ..."

	sed -i \
		-e 's/\("files":{\)[^}]*/\1/' \
		"${S}"/third_party/rust/${1}/.cargo-checksum.json \
		|| die
}

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
			emid=$(sed -n -e '/install-manifest/,$ { /em:id/!d; s/.*[\">]\([^\"<>]*\)[\"<].*/\1/; p; q }' "${xpi_tmp_dir}/install.rdf")
			[[ -z "${emid}" ]] && die "failed to determine extension id from install.rdf"
		elif [[ -f "${xpi_tmp_dir}/manifest.json" ]] ; then
			emid=$(sed -n -e 's/.*"id": "\([^"]*\)".*/\1/p' "${xpi_tmp_dir}/manifest.json")
			[[ -z "${emid}" ]] && die "failed to determine extension id from manifest.json"
		else
			die "failed to determine extension id"
		fi

		einfo "Installing ${emid}.xpi into ${ED}${DESTDIR} ..."
		newins "${xpi_file}" "${emid}.xpi"
	done
}

mozconfig_add_options_ac() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${#} -lt 2 ]] ; then
		die "${FUNCNAME} requires at least two arguments"
	fi

	local reason=${1}
	shift

	local option
	for option in ${@} ; do
		echo "ac_add_options ${option} # ${reason}" >>${MOZCONFIG}
	done
}

mozconfig_add_options_mk() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${#} -lt 2 ]] ; then
		die "${FUNCNAME} requires at least two arguments"
	fi

	local reason=${1}
	shift

	local option
	for option in ${@} ; do
		echo "mk_add_options ${option} # ${reason}" >>${MOZCONFIG}
	done
}

mozconfig_use_enable() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${#} -lt 1 ]] ; then
		die "${FUNCNAME} requires at least one arguments"
	fi

	local flag=$(use_enable "${@}")
	mozconfig_add_options_ac "$(use ${1} && echo +${1} || echo -${1})" "${flag}"
}

mozconfig_use_with() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${#} -lt 1 ]] ; then
		die "${FUNCNAME} requires at least one arguments"
	fi

	local flag=$(use_with "${@}")
	mozconfig_add_options_ac "$(use ${1} && echo +${1} || echo -${1})" "${flag}"
}

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]] ; then
		if use pgo ; then
			if ! has usersandbox $FEATURES ; then
				die "You must enable usersandbox as X server can not run as root!"
			fi
		fi

		# Ensure we have enough disk space to compile
		if use pgo || use lto || use debug ; then
			CHECKREQS_DISK_BUILD="13500M"
		else
			CHECKREQS_DISK_BUILD="6600M"
		fi

		check-reqs_pkg_pretend
	fi
}

pkg_setup() {
	if [[ ${MERGE_TYPE} != binary ]] ; then
		if use pgo ; then
			if ! has userpriv ${FEATURES} ; then
				eerror "Building ${PN} with USE=pgo and FEATURES=-userpriv is not supported!"
			fi
		fi

		# Ensure we have enough disk space to compile
		if use pgo || use lto || use debug ; then
			CHECKREQS_DISK_BUILD="13500M"
		else
			CHECKREQS_DISK_BUILD="6400M"
		fi

		check-reqs_pkg_setup

		llvm_pkg_setup

		if use clang && use lto ; then
			local version_lld=$(ld.lld --version 2>/dev/null | awk '{ print $2 }')
			[[ -n ${version_lld} ]] && version_lld=$(ver_cut 1 "${version_lld}")
			[[ -z ${version_lld} ]] && die "Failed to read ld.lld version!"

			local version_llvm_rust=$(rustc -Vv 2>/dev/null | grep -F -- 'LLVM version:' | awk '{ print $3 }')
			[[ -n ${version_llvm_rust} ]] && version_llvm_rust=$(ver_cut 1 "${version_llvm_rust}")
			[[ -z ${version_llvm_rust} ]] && die "Failed to read used LLVM version from rustc!"

			if ver_test "${version_lld}" -ne "${version_llvm_rust}" ; then
				eerror "Rust is using LLVM version ${version_llvm_rust} but ld.lld version belongs to LLVM version ${version_lld}."
				eerror "You will be unable to link ${CATEGORY}/${PN}. To proceed you have the following options:"
				eerror "  - Manually switch rust version using 'eselect rust' to match used LLVM version"
				eerror "  - Switch to dev-lang/rust[system-llvm] which will guarantee matching version"
				eerror "  - Build ${CATEGORY}/${PN} without USE=lto"
				eerror "  - Rebuild lld with llvm that was used to build rust (may need to rebuild the whole "
				eerror "    llvm/clang/lld/rust chain depending on your @world updates)"
				die "LLVM version used by Rust (${version_llvm_rust}) does not match with ld.lld version (${version_lld})!"
			fi
		fi

		python-any-r1_pkg_setup

		# Avoid PGO profiling problems due to enviroment leakage
		# These should *always* be cleaned up anyway
		unset \
			DBUS_SESSION_BUS_ADDRESS \
			DISPLAY \
			ORBIT_SOCKETDIR \
			SESSION_MANAGER \
			XAUTHORITY \
			XDG_CACHE_HOME \
			XDG_SESSION_COOKIE

		# Build system is using /proc/self/oom_score_adj, bug #604394
		addpredict /proc/self/oom_score_adj

		if use pgo ; then
			# Allow access to GPU during PGO run
			local ati_cards mesa_cards nvidia_cards render_cards
			shopt -s nullglob

			ati_cards=$(echo -n /dev/ati/card* | sed 's/ /:/g')
			if [[ -n "${ati_cards}" ]] ; then
				addpredict "${ati_cards}"
			fi

			mesa_cards=$(echo -n /dev/dri/card* | sed 's/ /:/g')
			if [[ -n "${mesa_cards}" ]] ; then
				addpredict "${mesa_cards}"
			fi

			nvidia_cards=$(echo -n /dev/nvidia* | sed 's/ /:/g')
			if [[ -n "${nvidia_cards}" ]] ; then
				addpredict "${nvidia_cards}"
			fi

			render_cards=$(echo -n /dev/dri/renderD128* | sed 's/ /:/g')
			if [[ -n "${render_cards}" ]] ; then
				addpredict "${render_cards}"
			fi

			shopt -u nullglob
		fi

		if ! mountpoint -q /dev/shm ; then
			# If /dev/shm is not available, configure is known to fail with
			# a traceback report referencing /usr/lib/pythonN.N/multiprocessing/synchronize.py
			ewarn "/dev/shm is not mounted -- expect build failures!"
		fi

		# Google API keys (see http://www.chromium.org/developers/how-tos/api-keys)
		# Note: These are for Gentoo Linux use ONLY. For your own distribution, please
		# get your own set of keys.
		if [[ -z "${MOZ_API_KEY_GOOGLE+set}" ]] ; then
			MOZ_API_KEY_GOOGLE="AIzaSyDEAOvatFogGaPi0eTgsV_ZlEzx0ObmepsMzfAc"
		fi

		if [[ -z "${MOZ_API_KEY_LOCATION+set}" ]] ; then
			MOZ_API_KEY_LOCATION="AIzaSyB2h2OuRgGaPicUgy5N-5hsZqiPW6sH3n_rptiQ"
		fi

		# Mozilla API keys (see https://location.services.mozilla.com/api)
		# Note: These are for Gentoo Linux use ONLY. For your own distribution, please
		# get your own set of keys.
		if [[ -z "${MOZ_API_KEY_MOZILLA+set}" ]] ; then
			MOZ_API_KEY_MOZILLA="edb3d487-3a84-46m0ap1e3-9dfd-92b5efaaa005"
		fi

		# Ensure we use C locale when building, bug #746215
		export LC_ALL=C
	fi

	CONFIG_CHECK="~SECCOMP"
	WARNING_SECCOMP="CONFIG_SECCOMP not set! This system will be unable to play DRM-protected content."
	linux-info_pkg_setup
}

src_unpack() {
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

src_prepare() {
(
/bin/cat <<DISTRIBUTION.INI
[Global]
id=funtoo
version=124.0.1
about=Mozilla Firefox for Funtoo
about.de=Mozilla Firefox für Funtoo

[Preferences]
app.distributor="funtoo"
app.distributor.channel="funtoo"
startup.homepage_welcome_url="https://www.funtoo.org/"

[BookmarksToolbar]
item.1.type=default
item.2.title=Funtoo Wiki
item.2.link=https://www.funtoo.org/Welcome
item.3.title=Funtoo Forums
item.3.link=https://forums.funtoo.org/
item.4.title=Funtoo Bugs Tracker
item.4.link=https://bugs.funtoo.org/

[BookmarksMenu]
item.1.title=Funtoo
item.1.type=folder
item.1.folderId=1

[BookmarksFolder-1]
item.1.type=default
item.2.title=Funtoo Wiki
item.2.link=https://www.funtoo.org/Welcome
item.3.title=Funtoo Forums
item.3.link=https://forums.funtoo.org/
item.4.title=Funtoo Bugs Tracker
item.4.link=https://bugs.funtoo.org/
DISTRIBUTION.INI
) > "${WORKDIR}/distribution.ini"

    if use lto; then
		rm -v "${WORKDIR}"/firefox-patches/*-LTO-Only-enable-LTO-*.patch || die
	fi

	if ! use ppc64; then
		rm -v "${WORKDIR}"/firefox-patches/*ppc64*.patch || die
	fi

	# Workaround for bgo#917599
	if has_version ">=dev-libs/icu-74.1" && use system-icu ; then
		eapply "${WORKDIR}"/firefox-patches/0026-bmo-1862601-system-icu-74.patch
	fi
	rm -v "${WORKDIR}"/firefox-patches/*-bmo-1862601-system-icu-74.patch || die

	# Workaround for bgo#915651 on musl
	if use elibc_glibc ; then
		rm -v "${WORKDIR}"/firefox-patches/*bgo-748849-RUST_TARGET_override.patch || die
	fi

	eapply "${WORKDIR}/firefox-patches"

	# Add fixes for riscv64
	if use riscv64 ; then
		eapply "${FILESDIR}"/firefox-95-fix-riscv64.patch
		moz_clear_vendor_checksums authenticator
	fi

	# Allow user to apply any additional patches without modifing ebuild
	eapply_user

	# Make cargo respect MAKEOPTS
	export CARGO_BUILD_JOBS="$(makeopts_jobs)"

	# Make LTO respect MAKEOPTS
	sed -i \
		-e "s/multiprocessing.cpu_count()/$(makeopts_jobs)/" \
		"${S}"/build/moz.configure/lto-pgo.configure \
		|| die "sed failed to set num_cores"

	# Make ICU respect MAKEOPTS
	sed -i \
		-e "s/multiprocessing.cpu_count()/$(makeopts_jobs)/" \
		"${S}"/intl/icu_sources_data.py \
		|| die "sed failed to set num_cores"

	# sed-in toolchain prefix
	sed -i \
		-e "s/objdump/${CHOST}-objdump/" \
		"${S}"/python/mozbuild/mozbuild/configure/check_debug_ranges.py \
		|| die "sed failed to set toolchain prefix"

	sed -i \
		-e 's/ccache_stats = None/return None/' \
		"${S}"/python/mozbuild/mozbuild/controller/building.py \
		|| die "sed failed to disable ccache stats call"

	einfo "Removing pre-built binaries ..."
	find "${S}"/third_party -type f \( -name '*.so' -o -name '*.o' \) -print -delete || die

	# Create build dir
	BUILD_DIR="${WORKDIR}/${PN}_build"
	mkdir -p "${BUILD_DIR}" || die

	# Write API keys to disk
	echo -n "${MOZ_API_KEY_GOOGLE//gGaPi/}" > "${S}"/api-google.key || die
	echo -n "${MOZ_API_KEY_LOCATION//gGaPi/}" > "${S}"/api-location.key || die
	echo -n "${MOZ_API_KEY_MOZILLA//m0ap1/}" > "${S}"/api-mozilla.key || die

	xdg_environment_reset
}

src_configure() {
	if use riscv64 ; then
		CFLAGS="${CFLAGS} -mno-relax"
	fi

	# Show flags set at the beginning
	einfo "Current BINDGEN_CFLAGS:\t${BINDGEN_CFLAGS:-no value set}"
	einfo "Current CFLAGS:\t\t${CFLAGS:-no value set}"
	einfo "Current CXXFLAGS:\t\t${CXXFLAGS:-no value set}"
	einfo "Current LDFLAGS:\t\t${LDFLAGS:-no value set}"
	einfo "Current RUSTFLAGS:\t\t${RUSTFLAGS:-no value set}"

	local have_switched_compiler=
	if use clang && ! tc-is-clang ; then
		# Force clang
		einfo "Enforcing the use of clang due to USE=clang ..."
		have_switched_compiler=yes
		AR=llvm-ar
		AS=llvm-as
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		NM=llvm-nm
		RANLIB=llvm-ranlib
	elif ! use clang && ! tc-is-gcc ; then
		# Force gcc
		have_switched_compiler=yes
		einfo "Enforcing the use of gcc due to USE=-clang ..."
		AR=gcc-ar
		CC=${CHOST}-gcc
		CXX=${CHOST}-g++
		NM=gcc-nm
		RANLIB=gcc-ranlib
	fi

	if [[ -n "${have_switched_compiler}" ]] ; then
		# Because we switched active compiler we have to ensure
		# that no unsupported flags are set
		strip-unsupported-flags
	fi

	# Ensure we use correct toolchain
	export HOST_CC="$(tc-getBUILD_CC)"
	export HOST_CXX="$(tc-getBUILD_CXX)"
	tc-export CC CXX LD AR NM OBJDUMP RANLIB PKG_CONFIG

	# Pass the correct toolchain paths through cbindgen
	if tc-is-cross-compiler ; then
		export BINDGEN_CFLAGS="${SYSROOT:+--sysroot=${ESYSROOT}} --target=${CHOST} ${BINDGEN_CFLAGS-}"
	fi

	# Set MOZILLA_FIVE_HOME
	export MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# python/mach/mach/mixin/process.py fails to detect SHELL
	export SHELL="${EPREFIX}/bin/bash"

	# Set state path
	export MOZBUILD_STATE_PATH="${BUILD_DIR}"

	# Set MOZCONFIG
	export MOZCONFIG="${S}/.mozconfig"

	# Initialize MOZCONFIG
	mozconfig_add_options_ac '' --enable-application=browser

	# Set Gentoo defaults
	export MOZILLA_OFFICIAL=1

	mozconfig_add_options_ac 'Gentoo default' \
		--allow-addon-sideload \
		--disable-cargo-incremental \
		--disable-crashreporter \
		--disable-gpsd \
		--disable-install-strip \
		--disable-parental-controls \
		--disable-strip \
		--disable-updater \
		--enable-negotiateauth \
		--enable-new-pass-manager \
		--enable-official-branding \
		--enable-release \
		--enable-system-ffi \
		--enable-system-pixman \
		--host="${CBUILD:-${CHOST}}" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--prefix="${EPREFIX}/usr" \
		--target="${CHOST}" \
		--without-ccache \
		--without-wasm-sandboxed-libraries \
		--with-intl-api \
		--with-libclang-path="$(llvm-config --libdir)" \
		--with-system-nspr \
		--with-system-nss \
		--with-system-zlib \
		--with-toolchain-prefix="${CHOST}-" \
		--with-unsigned-addon-scopes=app,system \
		--x-includes="${ESYSROOT}/usr/include" \
		--x-libraries="${ESYSROOT}/usr/$(get_libdir)"

	# Set update channel
	local update_channel=release
	[[ -n ${MOZ_ESR} ]] && update_channel=esr
	mozconfig_add_options_ac '' --update-channel=${update_channel}

	if ! use x86 && [[ ${CHOST} != armv*h* ]] ; then
		mozconfig_add_options_ac '' --enable-rust-simd
	fi

	# For future keywording: This is currently (97.0) only supported on:
	# amd64, arm, arm64 & x86.
	# Might want to flip the logic around if Firefox is to support more arches.
	if use ppc64; then
		mozconfig_add_options_ac '' --disable-sandbox
	else
		mozconfig_add_options_ac '' --enable-sandbox
	fi

	if [[ -s "${S}/api-google.key" ]] ; then
		local key_origin="Gentoo default"
		if [[ $(cat "${S}/api-google.key" | md5sum | awk '{ print $1 }') != 709560c02f94b41f9ad2c49207be6c54 ]] ; then
			key_origin="User value"
		fi

		mozconfig_add_options_ac "${key_origin}" \
			--with-google-safebrowsing-api-keyfile="${S}/api-google.key"
	else
		einfo "Building without Google API key ..."
	fi

	if [[ -s "${S}/api-location.key" ]] ; then
		local key_origin="Gentoo default"
		if [[ $(cat "${S}/api-location.key" | md5sum | awk '{ print $1 }') != ffb7895e35dedf832eb1c5d420ac7420 ]] ; then
			key_origin="User value"
		fi

		mozconfig_add_options_ac "${key_origin}" \
			--with-google-location-service-api-keyfile="${S}/api-location.key"
	else
		einfo "Building without Location API key ..."
	fi

	if [[ -s "${S}/api-mozilla.key" ]] ; then
		local key_origin="Gentoo default"
		if [[ $(cat "${S}/api-mozilla.key" | md5sum | awk '{ print $1 }') != 3927726e9442a8e8fa0e46ccc39caa27 ]] ; then
			key_origin="User value"
		fi

		mozconfig_add_options_ac "${key_origin}" \
			--with-mozilla-api-keyfile="${S}/api-mozilla.key"
	else
		einfo "Building without Mozilla API key ..."
	fi

	mozconfig_use_with system-av1
	mozconfig_use_with system-icu
	mozconfig_use_with system-jpeg
	mozconfig_use_with system-libevent
	mozconfig_use_with system-libvpx
	mozconfig_use_with system-png
	mozconfig_use_with system-webp

	mozconfig_use_enable dbus
	mozconfig_use_enable libproxy

	use eme-free && mozconfig_add_options_ac '+eme-free' --disable-eme

	mozconfig_use_enable geckodriver

	if use hardened ; then
		mozconfig_add_options_ac "+hardened" --enable-hardening
		append-ldflags "-Wl,-z,relro -Wl,-z,now"
	fi

	local myaudiobackends=""
	use jack && myaudiobackends+="jack,"
	use sndio && myaudiobackends+="sndio,"
	use pulseaudio && myaudiobackends+="pulseaudio,"
	! use pulseaudio && myaudiobackends+="alsa,"

	mozconfig_add_options_ac '--enable-audio-backends' --enable-audio-backends="${myaudiobackends::-1}"

	mozconfig_use_enable wifi necko-wifi

	if use X && use wayland ; then
		mozconfig_add_options_ac '+x11+wayland' --enable-default-toolkit=cairo-gtk3-x11-wayland
	elif ! use X && use wayland ; then
		mozconfig_add_options_ac '+wayland' --enable-default-toolkit=cairo-gtk3-wayland-only
	else
		mozconfig_add_options_ac '+x11' --enable-default-toolkit=cairo-gtk3
	fi

	if use lto ; then
		if use clang ; then
			# Upstream only supports lld when using clang
			mozconfig_add_options_ac "forcing ld=lld due to USE=clang and USE=lto" --enable-linker=lld

			mozconfig_add_options_ac '+lto' --enable-lto=cross

		else
			# ThinLTO is currently broken, see bmo#1644409
			mozconfig_add_options_ac '+lto' --enable-lto=full
			mozconfig_add_options_ac "linker is set to bfd" --enable-linker=bfd
		fi

		if use pgo ; then
			mozconfig_add_options_ac '+pgo' MOZ_PGO=1

			if use clang ; then
				# Used in build/pgo/profileserver.py
				export LLVM_PROFDATA="llvm-profdata"
			fi
		fi
	else
		# Avoid auto-magic on linker
		if use clang ; then
			if ! use riscv64 ; then
				# This is upstream's default
				mozconfig_add_options_ac "forcing ld=lld due to USE=clang" --enable-linker=lld
			else
				mozconfig_add_options_ac "forcing ld=bfd due to missing linker relaxations in lld for riscv" --enable-linker=bfd
			fi
		else
			mozconfig_add_options_ac "linker is set to bfd" --enable-linker=bfd
		fi
	fi

	# LTO flag was handled via configure
	filter-flags '-flto*'

	mozconfig_use_enable debug
	if use debug ; then
		mozconfig_add_options_ac '+debug' --disable-optimize
	else
		if is-flag '-g*' ; then
			if use clang ; then
				mozconfig_add_options_ac 'from CFLAGS' --enable-debug-symbols=$(get-flag '-g*')
			else
				mozconfig_add_options_ac 'from CFLAGS' --enable-debug-symbols
			fi
		else
			mozconfig_add_options_ac 'Gentoo default' --disable-debug-symbols
		fi

		if is-flag '-O0' ; then
			mozconfig_add_options_ac "from CFLAGS" --enable-optimize=-O0
		elif is-flag '-O4' ; then
			mozconfig_add_options_ac "from CFLAGS" --enable-optimize=-O4
		elif is-flag '-O3' ; then
			mozconfig_add_options_ac "from CFLAGS" --enable-optimize=-O3
		elif is-flag '-O1' ; then
			mozconfig_add_options_ac "from CFLAGS" --enable-optimize=-O1
		elif is-flag '-Os' ; then
			mozconfig_add_options_ac "from CFLAGS" --enable-optimize=-Os
		else
			mozconfig_add_options_ac "Gentoo default" --enable-optimize=-O2
		fi
	fi

	# Debug flag was handled via configure
	filter-flags '-g*'

	# Optimization flag was handled via configure
	filter-flags '-O*'

	# Modifications to better support ARM, bug #553364
	if use cpu_flags_arm_neon ; then
		mozconfig_add_options_ac '+cpu_flags_arm_neon' --with-fpu=neon

		if ! tc-is-clang ; then
			# thumb options aren't supported when using clang, bug 666966
			mozconfig_add_options_ac '+cpu_flags_arm_neon' \
				--with-thumb=yes \
				--with-thumb-interwork=no
		fi
	fi

	if [[ ${CHOST} == armv*h* ]] ; then
		mozconfig_add_options_ac 'CHOST=armv*h*' --with-float-abi=hard

		if ! use system-libvpx ; then
			sed -i \
				-e "s|softfp|hard|" \
				"${S}"/media/libvpx/moz.build \
				|| die
		fi
	fi

	if use clang ; then
		# https://bugzilla.mozilla.org/show_bug.cgi?id=1482204
		# https://bugzilla.mozilla.org/show_bug.cgi?id=1483822
		# toolkit/moz.configure Elfhack section: target.cpu in ('arm', 'x86', 'x86_64')
		local disable_elf_hack=
		if use amd64 ; then
			disable_elf_hack=yes
		elif use x86 ; then
			disable_elf_hack=yes
		elif use arm ; then
			disable_elf_hack=yes
		fi

		if [[ -n ${disable_elf_hack} ]] ; then
			mozconfig_add_options_ac 'elf-hack is broken when using Clang' --disable-elf-hack
		fi
	elif tc-is-gcc ; then
		if ver_test $(gcc-fullversion) -ge 10 ; then
			einfo "Forcing -fno-tree-loop-vectorize to workaround GCC bug, see bug 758446 ..."
			append-cxxflags -fno-tree-loop-vectorize
		fi
	fi

	# Additional ARCH support
	case "${ARCH}" in
		arm)
			# Reduce the memory requirements for linking
			if use clang ; then
				# Nothing to do
				:;
			elif use lto ; then
				append-ldflags -Wl,--no-keep-memory
			else
				append-ldflags -Wl,--no-keep-memory -Wl,--reduce-memory-overheads
			fi
			;;
	esac

	if ! use elibc_glibc ; then
		mozconfig_add_options_ac '!elibc_glibc' --disable-jemalloc
	fi

	# Allow elfhack to work in combination with unstripped binaries
	# when they would normally be larger than 2GiB.
	append-ldflags "-Wl,--compress-debug-sections=zlib"

	# Make revdep-rebuild.sh happy; Also required for musl
	append-ldflags -Wl,-rpath="${MOZILLA_FIVE_HOME}",--enable-new-dtags

	# Pass $MAKEOPTS to build system
	export MOZ_MAKE_FLAGS="${MAKEOPTS}"

	# Use system's Python environment
	export PIP_NETWORK_INSTALL_RESTRICTED_VIRTUALENVS=mach
	if use system-python-libs; then
        export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE="system"
    else
    	export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE="none"
    fi


	# Disable notification when build system has finished
	export MOZ_NOSPAM=1

	# Portage sets XARGS environment variable to "xargs -r" by default which
	# breaks build system's check_prog() function which doesn't support arguments
	mozconfig_add_options_ac 'Gentoo default' "XARGS=${EPREFIX}/usr/bin/xargs"

	# Set build dir
	mozconfig_add_options_mk 'Gentoo default' "MOZ_OBJDIR=${BUILD_DIR}"

	# Show flags we will use
	einfo "Build BINDGEN_CFLAGS:\t${BINDGEN_CFLAGS:-no value set}"
	einfo "Build CFLAGS:\t\t${CFLAGS:-no value set}"
	einfo "Build CXXFLAGS:\t\t${CXXFLAGS:-no value set}"
	einfo "Build LDFLAGS:\t\t${LDFLAGS:-no value set}"
	einfo "Build RUSTFLAGS:\t\t${RUSTFLAGS:-no value set}"

	# Handle EXTRA_CONF and show summary
	local ac opt hash reason

	# Apply EXTRA_ECONF entries to $MOZCONFIG
	if [[ -n ${EXTRA_ECONF} ]] ; then
		IFS=\! read -a ac <<<${EXTRA_ECONF// --/\!}
		for opt in "${ac[@]}"; do
			mozconfig_add_options_ac "EXTRA_ECONF" --${opt#--}
		done
	fi

	echo
	echo "=========================================================="
	echo "Building ${PF} with the following configuration"
	grep ^ac_add_options "${MOZCONFIG}" | while read ac opt hash reason; do
		[[ -z ${hash} || ${hash} == \# ]] \
			|| die "error reading mozconfig: ${ac} ${opt} ${hash} ${reason}"
		printf "    %-30s  %s\n" "${opt}" "${reason:-mozilla.org default}"
	done
	echo "=========================================================="
	echo

	./mach configure || die
}

src_compile() {
	local virtx_cmd=

	if use pgo ; then
		virtx_cmd=virtx

		# Reset and cleanup environment variables used by GNOME/XDG
		gnome2_environment_reset

		addpredict /root
	fi

	if ! use X && use wayland; then
		local -x GDK_BACKEND=wayland
	else
		local -x GDK_BACKEND=x11
	fi

	${virtx_cmd} ./mach build --verbose \
		|| die
}

src_install() {
	# xpcshell is getting called during install
	pax-mark m \
		"${BUILD_DIR}"/dist/bin/xpcshell \
		"${BUILD_DIR}"/dist/bin/${PN} \
		"${BUILD_DIR}"/dist/bin/plugin-container

	DESTDIR="${D}" ./mach install || die

	# Upstream cannot ship symlink but we can (bmo#658850)
	rm "${ED}${MOZILLA_FIVE_HOME}/${PN}-bin" || die
	dosym ${PN} ${MOZILLA_FIVE_HOME}/${PN}-bin

	# Don't install llvm-symbolizer from sys-devel/llvm package
	if [[ -f "${ED}${MOZILLA_FIVE_HOME}/llvm-symbolizer" ]] ; then
		rm -v "${ED}${MOZILLA_FIVE_HOME}/llvm-symbolizer" || die
	fi

	# Install policy (currently only used to disable application updates)
	insinto "${MOZILLA_FIVE_HOME}/distribution"
	newins "${WORKDIR}"/distribution.ini distribution.ini
	newins "${FILESDIR}"/disable-auto-update.policy.json policies.json

	# Install system-wide preferences
	local PREFS_DIR="${MOZILLA_FIVE_HOME}/browser/defaults/preferences"
	insinto "${PREFS_DIR}"
	newins "${FILESDIR}"/gentoo-default-prefs.js gentoo-prefs.js

	local GENTOO_PREFS="${ED}${PREFS_DIR}/gentoo-prefs.js"

	# Set dictionary path to use system hunspell
	cat >>"${GENTOO_PREFS}" <<-EOF || die "failed to set spellchecker.dictionary_path pref"
	pref("spellchecker.dictionary_path",       "${EPREFIX}/usr/share/myspell");
	EOF

	# Force hwaccel prefs if USE=hwaccel is enabled
	if use hwaccel ; then
		cat "${FILESDIR}"/gentoo-hwaccel-prefs.js-r2 \
		>>"${GENTOO_PREFS}" \
		|| die "failed to add prefs to force hardware-accelerated rendering to all-gentoo.js"

		if use wayland; then
			cat >>"${GENTOO_PREFS}" <<-EOF || die "failed to set hwaccel wayland prefs"
			pref("gfx.x11-egl.force-enabled",          false);
			EOF
		else
			cat >>"${GENTOO_PREFS}" <<-EOF || die "failed to set hwaccel x11 prefs"
			pref("gfx.x11-egl.force-enabled",          true);
			EOF
		fi
	fi

	if ! use gmp-autoupdate ; then
		local plugin
		for plugin in "${MOZ_GMP_PLUGIN_LIST[@]}" ; do
			einfo "Disabling auto-update for ${plugin} plugin ..."
			cat >>"${GENTOO_PREFS}" <<-EOF || die "failed to disable autoupdate for ${plugin} media plugin"
			pref("media.${plugin}.autoupdate",   false);
			EOF
		done
	fi

	# Force the graphite pref if USE=system-harfbuzz is enabled, since the pref cannot disable it
	if use system-harfbuzz ; then
		cat >>"${GENTOO_PREFS}" <<-EOF || die "failed to set gfx.font_rendering.graphite.enabled pref"
		sticky_pref("gfx.font_rendering.graphite.enabled", true);
		EOF
	fi

	# Install language packs
	local langpacks=( $(find "${WORKDIR}/language_packs" -type f -name '*.xpi') )
	if [[ -n "${langpacks}" ]] ; then
		moz_install_xpi "${MOZILLA_FIVE_HOME}/distribution/extensions" "${langpacks[@]}"
	fi

	# Install geckodriver
	if use geckodriver ; then
		einfo "Installing geckodriver into ${ED}${MOZILLA_FIVE_HOME} ..."
		pax-mark m "${BUILD_DIR}"/dist/bin/geckodriver
		exeinto "${MOZILLA_FIVE_HOME}"
		doexe "${BUILD_DIR}"/dist/bin/geckodriver

		dosym ${MOZILLA_FIVE_HOME}/geckodriver /usr/bin/geckodriver
	fi

	# Install icons
	local icon_srcdir="${S}/browser/branding/official"
	local icon_symbolic_file="${FILESDIR}/icon/firefox-symbolic.svg"

	insinto /usr/share/icons/hicolor/symbolic/apps
	newins "${icon_symbolic_file}" ${PN}-symbolic.svg

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
	local app_name="Mozilla ${MOZ_PN^}"
	local desktop_file="${FILESDIR}/icon/${PN}-r3.desktop"
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

	# Install wrapper script
	[[ -f "${ED}/usr/bin/${PN}" ]] && rm "${ED}/usr/bin/${PN}"
	newbin "${FILESDIR}/${PN}-r1.sh" ${PN}

	# Update wrapper
	sed -i \
		-e "s:@PREFIX@:${EPREFIX}/usr:" \
		-e "s:@MOZ_FIVE_HOME@:${MOZILLA_FIVE_HOME}:" \
		-e "s:@APULSELIB_DIR@:${apulselib}:" \
		-e "s:@DEFAULT_WAYLAND@:${use_wayland}:" \
		"${ED}/usr/bin/${PN}" \
		|| die
}

pkg_preinst() {
	xdg_pkg_preinst

	# If the apulse libs are available in MOZILLA_FIVE_HOME then apulse
	# does not need to be forced into the LD_LIBRARY_PATH
	if use pulseaudio && has_version ">=media-sound/apulse-0.1.12-r4" ; then
		einfo "APULSE found; Generating library symlinks for sound support ..."
		local lib
		pushd "${ED}${MOZILLA_FIVE_HOME}" &>/dev/null || die
		for lib in ../apulse/libpulse{.so{,.0},-simple.so{,.0}} ; do
			# A quickpkg rolled by hand will grab symlinks as part of the package,
			# so we need to avoid creating them if they already exist.
			if [[ ! -L ${lib##*/} ]] ; then
				ln -s "${lib}" ${lib##*/} || die
			fi
		done
		popd &>/dev/null || die
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	if ! use gmp-autoupdate ; then
		elog "USE='-gmp-autoupdate' has disabled the following plugins from updating or"
		elog "installing into new profiles:"
		local plugin
		for plugin in "${MOZ_GMP_PLUGIN_LIST[@]}" ; do
			elog "\t ${plugin}"
		done
		elog
	fi

	if use pulseaudio && has_version ">=media-sound/apulse-0.1.12-r4" ; then
		elog "Apulse was detected at merge time on this system and so it will always be"
		elog "used for sound.  If you wish to use pulseaudio instead please unmerge"
		elog "media-sound/apulse."
		elog
	fi

	local show_doh_information
	local show_normandy_information
	local show_shortcut_information

	if [[ -z "${REPLACING_VERSIONS}" ]] ; then
		# New install; Tell user that DoH is disabled by default
		show_doh_information=yes
		show_normandy_information=yes
		show_shortcut_information=no
	else
		local replacing_version
		for replacing_version in ${REPLACING_VERSIONS} ; do
			if ver_test "${replacing_version}" -lt 91.0 ; then
				# Tell user that we no longer install a shortcut
				# per supported display protocol
				show_shortcut_information=yes
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

	# bug 713782
	if [[ -n "${show_normandy_information}" ]] ; then
		elog
		elog "Upstream operates a service named Normandy which allows Mozilla to"
		elog "push changes for default settings or even install new add-ons remotely."
		elog "While this can be useful to address problems like 'Armagadd-on 2.0' or"
		elog "revert previous decisions to disable TLS 1.0/1.1, privacy and security"
		elog "concerns prevail, which is why we have switched off the use of this"
		elog "service by default."
		elog
		elog "To re-enable this service set"
		elog
		elog "    app.normandy.enabled=true"
		elog
		elog "in about:config."
	fi

	if [[ -n "${show_shortcut_information}" ]] ; then
		elog
		elog "Since ${PN}-91.0 we no longer install multiple shortcuts for"
		elog "each supported display protocol.  Instead we will only install"
		elog "one generic Mozilla ${PN^} shortcut."
		elog "If you still want to be able to select between running Mozilla ${PN^}"
		elog "on X11 or Wayland, you have to re-create these shortcuts on your own."
	fi

	# bug 835078
	if use hwaccel && has_version "x11-drivers/xf86-video-nouveau"; then
		ewarn "You have nouveau drivers installed in your system and 'hwaccel' "
		ewarn "enabled for Firefox. Nouveau / your GPU might not supported the "
		ewarn "required EGL, so either disable 'hwaccel' or try the workaround "
		ewarn "explained in https://bugs.gentoo.org/835078#c5 if Firefox crashes."
	fi

	elog
	elog "Unfortunately Firefox-100.0 breaks compatibility with some sites using "
	elog "useragent checks. To temporarily fix this, enter about:config and modify "
	elog "network.http.useragent.forceVersion preference to \"99\"."
	elog "Or install an addon to change your useragent."
	elog "See: https://support.mozilla.org/en-US/kb/difficulties-opening-or-using-website-firefox-100"
	elog
}