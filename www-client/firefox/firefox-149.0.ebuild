# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit desktop flag-o-matic gnome2-utils multiprocessing toolchain-funcs pax-utils python-any-r1 virtualx xdg

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="https://www.mozilla.org/en-US/firefox/"
SRC_URI="
amd64? ( https://archive.mozilla.org/pub/firefox/releases/149.0/source/firefox-149.0.source.tar.xz -> firefox-149.0.source.tar.xz )
l10n_ach? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ach.xpi -> firefox_x86_64-149.0-ach.xpi )
l10n_af? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/af.xpi -> firefox_x86_64-149.0-af.xpi )
l10n_an? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/an.xpi -> firefox_x86_64-149.0-an.xpi )
l10n_ar? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ar.xpi -> firefox_x86_64-149.0-ar.xpi )
l10n_ast? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ast.xpi -> firefox_x86_64-149.0-ast.xpi )
l10n_az? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/az.xpi -> firefox_x86_64-149.0-az.xpi )
l10n_be? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/be.xpi -> firefox_x86_64-149.0-be.xpi )
l10n_bg? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/bg.xpi -> firefox_x86_64-149.0-bg.xpi )
l10n_bn? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/bn.xpi -> firefox_x86_64-149.0-bn.xpi )
l10n_bn? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/br.xpi -> firefox_x86_64-149.0-br.xpi )
l10n_bs? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/bs.xpi -> firefox_x86_64-149.0-bs.xpi )
l10n_ca-valencia? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ca-valencia.xpi -> firefox_x86_64-149.0-ca-valencia.xpi )
l10n_ca? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ca.xpi -> firefox_x86_64-149.0-ca.xpi )
l10n_cak? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/cak.xpi -> firefox_x86_64-149.0-cak.xpi )
l10n_cs? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/cs.xpi -> firefox_x86_64-149.0-cs.xpi )
l10n_cy? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/cy.xpi -> firefox_x86_64-149.0-cy.xpi )
l10n_da? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/da.xpi -> firefox_x86_64-149.0-da.xpi )
l10n_de? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/de.xpi -> firefox_x86_64-149.0-de.xpi )
l10n_dsb? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/dsb.xpi -> firefox_x86_64-149.0-dsb.xpi )
l10n_el? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/el.xpi -> firefox_x86_64-149.0-el.xpi )
l10n_en-CA? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/en-CA.xpi -> firefox_x86_64-149.0-en-CA.xpi )
l10n_en-GB? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/en-GB.xpi -> firefox_x86_64-149.0-en-GB.xpi )
l10n_en-US? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/en-US.xpi -> firefox_x86_64-149.0-en-US.xpi )
l10n_eo? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/eo.xpi -> firefox_x86_64-149.0-eo.xpi )
l10n_es-AR? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/es-AR.xpi -> firefox_x86_64-149.0-es-AR.xpi )
l10n_es-CL? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/es-CL.xpi -> firefox_x86_64-149.0-es-CL.xpi )
l10n_es-ES? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/es-ES.xpi -> firefox_x86_64-149.0-es-ES.xpi )
l10n_es-MX? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/es-MX.xpi -> firefox_x86_64-149.0-es-MX.xpi )
l10n_et? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/et.xpi -> firefox_x86_64-149.0-et.xpi )
l10n_eu? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/eu.xpi -> firefox_x86_64-149.0-eu.xpi )
l10n_fa? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/fa.xpi -> firefox_x86_64-149.0-fa.xpi )
l10n_ff? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ff.xpi -> firefox_x86_64-149.0-ff.xpi )
l10n_fi? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/fi.xpi -> firefox_x86_64-149.0-fi.xpi )
l10n_fr? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/fr.xpi -> firefox_x86_64-149.0-fr.xpi )
l10n_fur? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/fur.xpi -> firefox_x86_64-149.0-fur.xpi )
l10n_fy-NL? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/fy-NL.xpi -> firefox_x86_64-149.0-fy-NL.xpi )
l10n_ga-IE? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ga-IE.xpi -> firefox_x86_64-149.0-ga-IE.xpi )
l10n_gd? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/gd.xpi -> firefox_x86_64-149.0-gd.xpi )
l10n_gl? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/gl.xpi -> firefox_x86_64-149.0-gl.xpi )
l10n_gn? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/gn.xpi -> firefox_x86_64-149.0-gn.xpi )
l10n_gu-IN? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/gu-IN.xpi -> firefox_x86_64-149.0-gu-IN.xpi )
l10n_he? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/he.xpi -> firefox_x86_64-149.0-he.xpi )
l10n_hi-IN? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/hi-IN.xpi -> firefox_x86_64-149.0-hi-IN.xpi )
l10n_hr? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/hr.xpi -> firefox_x86_64-149.0-hr.xpi )
l10n_hsb? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/hsb.xpi -> firefox_x86_64-149.0-hsb.xpi )
l10n_hu? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/hu.xpi -> firefox_x86_64-149.0-hu.xpi )
l10n_hy-AM? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/hy-AM.xpi -> firefox_x86_64-149.0-hy-AM.xpi )
l10n_ia? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ia.xpi -> firefox_x86_64-149.0-ia.xpi )
l10n_id? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/id.xpi -> firefox_x86_64-149.0-id.xpi )
l10n_is? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/is.xpi -> firefox_x86_64-149.0-is.xpi )
l10n_it? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/it.xpi -> firefox_x86_64-149.0-it.xpi )
l10n_ja? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ja.xpi -> firefox_x86_64-149.0-ja.xpi )
l10n_ka? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ka.xpi -> firefox_x86_64-149.0-ka.xpi )
l10n_kab? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/kab.xpi -> firefox_x86_64-149.0-kab.xpi )
l10n_kk? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/kk.xpi -> firefox_x86_64-149.0-kk.xpi )
l10n_km? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/km.xpi -> firefox_x86_64-149.0-km.xpi )
l10n_kn? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/kn.xpi -> firefox_x86_64-149.0-kn.xpi )
l10n_ko? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ko.xpi -> firefox_x86_64-149.0-ko.xpi )
l10n_lij? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/lij.xpi -> firefox_x86_64-149.0-lij.xpi )
l10n_lt? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/lt.xpi -> firefox_x86_64-149.0-lt.xpi )
l10n_lv? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/lv.xpi -> firefox_x86_64-149.0-lv.xpi )
l10n_mk? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/mk.xpi -> firefox_x86_64-149.0-mk.xpi )
l10n_mr? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/mk.xpi -> firefox_x86_64-149.0-mr.xpi )
l10n_ms? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ms.xpi -> firefox_x86_64-149.0-ms.xpi )
l10n_my? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/my.xpi -> firefox_x86_64-149.0-my.xpi )
l10n_nb-NO? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/nb-NO.xpi -> firefox_x86_64-149.0-nb-NO.xpi )
l10n_ne-NP? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ne-NP.xpi -> firefox_x86_64-149.0-ne-NP.xpi )
l10n_nl? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/nl.xpi -> firefox_x86_64-149.0-nl.xpi )
l10n_nn-NO? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/nn-NO.xpi -> firefox_x86_64-149.0-nn-NO.xpi )
l10n_oc? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/oc.xpi -> firefox_x86_64-149.0-oc.xpi )
l10n_pa-IN? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/pa-IN.xpi -> firefox_x86_64-149.0-pa-IN.xpi )
l10n_pl? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/pl.xpi -> firefox_x86_64-149.0-pl.xpi )
l10n_pt-BR? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/pt-BR.xpi -> firefox_x86_64-149.0-pt-BR.xpi )
l10n_pt-PT? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/pt-PT.xpi -> firefox_x86_64-149.0-pt-PT.xpi )
l10n_rm? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/rm.xpi -> firefox_x86_64-149.0-rm.xpi )
l10n_ro? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ro.xpi -> firefox_x86_64-149.0-ro.xpi )
l10n_ru? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ru.xpi -> firefox_x86_64-149.0-ru.xpi )
l10n_sat? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sat.xpi -> firefox_x86_64-149.0-sat.xpi )
l10n_sc? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sc.xpi -> firefox_x86_64-149.0-sc.xpi )
l10n_sco? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sco.xpi -> firefox_x86_64-149.0-sco.xpi )
l10n_si? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/si.xpi -> firefox_x86_64-149.0-si.xpi )
l10n_sk? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sk.xpi -> firefox_x86_64-149.0-sk.xpi )
l10n_skr? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/skr.xpi -> firefox_x86_64-149.0-skr.xpi )
l10n_sl? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sl.xpi -> firefox_x86_64-149.0-sl.xpi )
l10n_son? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/son.xpi -> firefox_x86_64-149.0-son.xpi )
l10n_sq? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sq.xpi -> firefox_x86_64-149.0-sq.xpi )
l10n_sr? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sr.xpi -> firefox_x86_64-149.0-sr.xpi )
l10n_sv-SE? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/sv-SE.xpi -> firefox_x86_64-149.0-sv-SE.xpi )
l10n_szl? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/szl.xpi -> firefox_x86_64-149.0-szl.xpi )
l10n_ta? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ta.xpi -> firefox_x86_64-149.0-ta.xpi )
l10n_te? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/te.xpi -> firefox_x86_64-149.0-te.xpi )
l10n_tg? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/tg.xpi -> firefox_x86_64-149.0-tg.xpi )
l10n_th? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/th.xpi -> firefox_x86_64-149.0-th.xpi )
l10n_tl? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/tl.xpi -> firefox_x86_64-149.0-tl.xpi )
l10n_tr? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/tr.xpi -> firefox_x86_64-149.0-tr.xpi )
l10n_trs? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/trs.xpi -> firefox_x86_64-149.0-trs.xpi )
l10n_uk? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/uk.xpi -> firefox_x86_64-149.0-uk.xpi )
l10n_ur? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/ur.xpi -> firefox_x86_64-149.0-ur.xpi )
l10n_uz? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/uz.xpi -> firefox_x86_64-149.0-uz.xpi )
l10n_vi? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/vi.xpi -> firefox_x86_64-149.0-vi.xpi )
l10n_xh? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/xh.xpi -> firefox_x86_64-149.0-xh.xpi )
l10n_zh-CN? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/zh-CN.xpi -> firefox_x86_64-149.0-zh-CN.xpi )
l10n_zh-TW? ( https://archive.mozilla.org/pub/firefox/releases/149.0/linux-x86_64/xpi/zh-TW.xpi -> firefox_x86_64-149.0-zh-TW.xpi )"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/00-fix-fortify-system-wrappers.patch"
	"${FILESDIR}/01-fix-rust-target.patch"
	"${FILESDIR}/02-bmo-847568-support-system-harfbuzz-graphite2.patch"
	"${FILESDIR}/03-loong0001-Enable-WebRTC-for-loongarch64.patch"
	"${FILESDIR}/04-loong0001-Enable-WebRTC-for-loongarch64.patch"
	"${FILESDIR}/05-loong0004-Fix-ycbcr-chromium_types-warning.patch"
	"${FILESDIR}/06-sandbox-sched_setscheduler.patch"
	"${FILESDIR}/07-rust-lto-thin.patch"
)
IUSE="amd64 +clang dbus debug eme-free hwaccl jack libproxy lto +openh264 pgo pulseaudio sndio
+system-av1 +system-harfbuzz +system-icu +system-jpeg +system-libevent +system-libvpx
+system-png system-python-libs +system-webp +gmp-autoupdate screecast +X
+pulseaudio selinux wayland wifi screencast system-pipewire telemetry
l10n_ach l10n_af l10n_an l10n_ar l10n_ast l10n_az l10n_be l10n_bg l10n_bn l10n_br
l10n_bs l10n_ca-valencia l10n_ca l10n_cak l10n_cs l10n_cy l10n_da l10n_de l10n_dsb
l10n_el l10n_en-CA l10n_en-GB l10n_en-US l10n_eo l10n_es-AR l10n_es-CL l10n_es-ES
l10n_es-MX l10n_et l10n_eu l10n_fa l10n_ff l10n_fi l10n_fr l10n_fur l10n_fy-NL
l10n_ga-IE l10n_gd l10n_gl l10n_gn l10n_gu-IN l10n_he l10n_hi-IN l10n_hr l10n_hsb
l10n_hu l10n_hy-AM l10n_ia l10n_id l10n_is l10n_it l10n_ja l10n_ka l10n_kab l10n_kk
l10n_km l10n_kn l10n_ko l10n_lij l10n_lt l10n_lv l10n_mk l10n_mr l10n_ms l10n_my
l10n_nb-NO l10n_ne-NP l10n_nl l10n_nn-NO l10n_oc l10n_pa-IN l10n_pl l10n_pt-BR
l10n_pt-PT l10n_rm l10n_ro l10n_ru l10n_sat l10n_sc l10n_sco l10n_si l10n_sk l10n_skr
l10n_sl l10n_son l10n_sq l10n_sr l10n_sv-SE l10n_szl l10n_ta l10n_te l10n_tg l10n_th
l10n_tl l10n_tr l10n_trs l10n_uk l10n_ur l10n_uz l10n_vi l10n_xh l10n_zh-CN l10n_zh-TW
"
REQUIRED_USE="debug? ( !system-av1 )
pgo? ( lto )
wayland? ( dbus )
wifi? ( dbus )
|| ( X wayland )
screecast? ( wayland )
"
# Commons depends
CDEPEND="dev-libs/glib
	dev-libs/atk
	dev-libs/expat
	dev-libs/libffi:=
	dev-libs/nss
	dev-libs/nspr
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
	sndio? ( media-sound/sndio )
	screencast? ( media-video/pipewire:= )
	system-av1? (
	  media-libs/dav1d:=
	  media-libs/libaom:=
	)
	system-harfbuzz? (
	  media-gfx/graphite2
	  media-libs/harfbuzz:=
	)
	system-icu? ( dev-libs/icu:= )
	system-jpeg? ( media-libs/libjpeg-turbo )
	system-libevent? ( dev-libs/libevent[threads] )
	system-libvpx? ( media-libs/libvpx[postproc] )
	system-png? ( media-libs/libpng[apng] )
	system-webp? ( media-libs/libwebp )
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
	)
	
"
BDEPEND="${PYTHON_DEPS}
	app-arch/unzip
	app-arch/zip
	dev-util/cbindgen
	net-libs/nodejs
	virtual/pkgconfig
	virtual/rust
	|| (
	  (
	    sys-devel/clang:20
	    sys-devel/llvm:20
	    clang? (
	      sys-devel/lld
	      pgo? ( sys-libs/compiler-rt-sanitizers[profile] )
	    )
	  )
	)
	amd64? ( dev-lang/nasm )
	
"
RDEPEND="${CDEPEND}
	jack? ( virtual/jack )
	openh264? ( media-libs/openh264:*[plugin] )
	pulseaudio? (
	  || (
	    media-sound/pulseaudio
	    media-sound/apulse
	  )
	)
	
"
DEPEND="${CDEPEND}
	pulseaudio? ( media-sound/pulseaudio )
	X? (
	  x11-libs/libICE
	  x11-libs/libSM
	)
	
"
# Allow MOZ_GMP_PLUGIN_LIST to be set in an eclass or
# overridden in the enviromnent (advanced hackers only)
if [[ -z "${MOZ_GMP_PLUGIN_LIST+set}" ]] ; then
	MOZ_GMP_PLUGIN_LIST=( gmp-gmpopenh264 gmp-widevinecdm )
fi
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
	 # Ensure we use C locale when building, bug #746215
	export LC_ALL=C
}
_clear_vendor_checksums() {
	sed -i 's/\("files":{\)[^}]*/\1/' third_party/rust/$1/.cargo-checksum.json
}
src_prepare() {
	default
	 # Copy Macaroni distribution.ini
	cp ${FILESDIR}/distribution.ini "${WORKDIR}/"
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
	 _clear_vendor_checksums audio_thread_priority
	_clear_vendor_checksums libc
	 # Mozilla API keys (see https://location.services.mozilla.com/api)
	# Note: These are for Gentoo Linux use ONLY. For your own distribution, please
	# get your own set of keys.
	if [[ -z "${MOZ_API_KEY_MOZILLA+set}" ]] ; then
	  MOZ_API_KEY_MOZILLA="edb3d487-3a84-46m0ap1e3-9dfd-92b5efaaa005"
	fi
	 echo -n "${MOZ_API_KEY_MOZILLA//m0ap1/}" > "${S}"/api-mozilla.key || die
	 xdg_environment_reset
}
mozconfig_add_options_ac() {
	local reason=${1}
	shift
	local option
	for option in ${@} ; do
	  echo "ac_add_options ${option} # ${reason}" >>${MOZCONFIG}
	done
}
mozconfig_add_options_mk() {
	local reason=${1}
	shift
	local option
	for option in ${@} ; do
	  echo "mk_add_options ${option} # ${reason}" >>${MOZCONFIG}
	done
}
mozconfig_use_enable() {
	local flag=$(use_enable "${@}")
	mozconfig_add_options_ac "$(use ${1} && echo +${1} || echo -${1})" "${flag}"
}
mozconfig_use_with() {
	local flag=$(use_with "${@}")
	mozconfig_add_options_ac "$(use ${1} && echo +${1} || echo -${1})" "${flag}"
}
src_configure() {
	if use clang; then
	  extra_cflags="-I/usr/lib/clang//include/"
	  export CPPFLAGS="-I/usr/lib/clang//include/"
	  local -x CC=${CHOST}-clang
	  local -x CXX=${CHOST}-clang++
	  strip-unsupported-flags
	fi
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
	 export MOZILLA_OFFICIAL=1
	 export RUST_TARGET="x86_64-unknown-linux-gnu"
	 mozconfig_add_options_ac 'Macaroni default' \
	  --allow-addon-sideload \
	  --disable-cargo-incremental \
	  --disable-crashreporter \
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
	  --update-channel=release
	   if ! use x86 && [[ ${CHOST} != armv*h* ]] ; then
	    mozconfig_add_options_ac '' --enable-rust-simd
	  fi
	  mozconfig_add_options_ac '' --enable-sandbox
	  mozconfig_add_options_ac '' --with-mozilla-api-keyfile="${S}/api-mozilla.key"
	   mozconfig_use_with system-av1
	  mozconfig_use_with system-harfbuzz
	  mozconfig_use_with system-icu
	  mozconfig_use_with system-jpeg
	  mozconfig_use_with system-libevent
	  mozconfig_use_with system-libvpx
	  mozconfig_use_with system-pipewire
	  mozconfig_use_with system-png
	  mozconfig_use_with system-webp
	   mozconfig_use_enable dbus
	  mozconfig_use_enable libproxy
	   use eme-free && mozconfig_add_options_ac '+eme-free' --disable-eme
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
	    mozconfig_add_options_ac '+x11' --enable-default-toolkit=cairo-gtk3-x11-only
	  fi
	   mozconfig_add_options_ac 'no wasm-sandbox' --without-wasm-sandboxed-libraries
	  mozconfig_use_with system-harfbuzz system-graphite2
	   # Debug flag was handled via configure
	  filter-flags '-g*'
	   # System-av1 fix
	  use system-av1 && append-ldflags "-Wl,--undefined-version"
	   # Make revdep-rebuild.sh happy; Also required for musl
	  append-ldflags -Wl,-rpath="${MOZILLA_FIVE_HOME}",--enable-new-dtags
	   # Pass $MAKEOPTS to build system
	  export MOZ_MAKE_FLAGS="${MAKEOPTS}"
	   # Use system's Python environment
	  export PIP_NETWORK_INSTALL_RESTRICTED_VIRTUALENVS=mach
	   export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE="none"
	   if ! use telemetry; then
	    mozconfig_add_options_mk '-telemetry setting' "MOZ_CRASHREPORTER=0"
	    mozconfig_add_options_mk '-telemetry setting' "MOZ_DATA_REPORTING=0"
	    mozconfig_add_options_mk '-telemetry setting' "MOZ_SERVICES_HEALTHREPORT=0"
	    mozconfig_add_options_mk '-telemetry setting' "MOZ_TELEMETRY_REPORTING=0"
	  fi
	   mozconfig_use_enable test tests
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
	# Set MOZILLA_FIVE_HOME
	local MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
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
	newins "${FILESDIR}"/distribution.ini distribution.ini
	# Set version
	sed -i -e "s|^version=.*|version=${PV}|g" \
	  ${ED}/${MOZILLA_FIVE_HOME}/distribution/distribution.ini
	newins "${FILESDIR}"/disable-auto-update.policy.json policies.json
	 # Install system-wide preferences
	local PREFS_DIR="${MOZILLA_FIVE_HOME}/browser/defaults/preferences"
	insinto "${PREFS_DIR}"
	newins "${FILESDIR}"/macaroni-default-prefs.js macaroni-prefs.js
	 local MACARONI_PREFS="${ED}${PREFS_DIR}/gentoo-prefs.js"
	 if ! use gmp-autoupdate ; then
	  local plugin
	  for plugin in "${MOZ_GMP_PLUGIN_LIST[@]}" ; do
	    einfo "Disabling auto-update for ${plugin} plugin ..."
	    echo "pref(\"media.${plugin}.autoupdate\",   false);\n" >> "${MACARONI_PREFS}"
	  done
	fi
	 # Force the graphite pref if USE=system-harfbuzz is enabled, since the pref cannot disable it
	if use system-harfbuzz ; then
	  echo "sticky_pref(\"gfx.font_rendering.graphite.enabled\", true);\n" >> "${MACARONI_PREFS}"
	fi
	 # Install language packs
	local langpacks=( $(find "${WORKDIR}/language_packs" -type f -name '*.xpi') )
	if [[ -n "${langpacks}" ]] ; then
	  moz_install_xpi "${MOZILLA_FIVE_HOME}/distribution/extensions" "${langpacks[@]}"
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
	local desktop_file="${FILESDIR}/icon/${PN}.desktop"
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
	newbin "${FILESDIR}/${PN}.sh" ${PN}
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
}
pkg_postinst() {
	xdg_pkg_postinst
}

# vim: filetype=ebuild
