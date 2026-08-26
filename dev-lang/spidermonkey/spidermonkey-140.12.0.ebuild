# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit check-reqs flag-o-matic multiprocessing toolchain-funcs python-any-r1 xdg

DESCRIPTION="Mozilla's JavaScript engine written in C and C++"
HOMEPAGE="https://spidermonkey.dev"
SRC_URI="https://archive.mozilla.org/pub/firefox/releases/140.12.0esr/source/firefox-140.12.0esr.source.tar.xz -> spidermonkey-140.12.0.tar.xz"
SLOT="0"
KEYWORDS="*"
IUSE="+clang cpu_flags_arm_neon debug +jit icu"
BDEPEND="${PYTHON_DEPS}
	app-arch/unzip
	app-arch/zip
	virtual/rust
	|| (
	  (
	    sys-devel/clang:20
	    sys-devel/llvm:20
	    clang? (
	      sys-devel/lld
	    )
	  )
	)
	dev-util/cbindgen
	virtual/pkgconfig
	
"
RDEPEND="icu? (
	    >=dev-libs/icu-76.1:=
	)
	dev-libs/nspr
	sys-libs/readline:=
	sys-libs/zlib
	!dev-lang/spidermonkey:78
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/firefox-140.12.0"
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
pkg_pretend() {
	CHECKREQS_DISK_BUILD="4300M"
	check-reqs_pkg_pretend
}
pkg_setup() {
	python-any-r1_pkg_setup
	# Build system is using /proc/self/oom_score_adj, bug #604394
	addpredict /proc/self/oom_score_adj
	# Ensure we use C locale when building, bug #746215
	export LC_ALL=C
}
src_prepare() {
	default
	eapply_user
	 # Make cargo respect MAKEOPTS
	export CARGO_BUILD_JOBS="$(makeopts_jobs)"
	 # sed-in toolchain prefix
	sed -i \
	    -e "s/objdump/${CHOST}-objdump/" \
	    python/mozbuild/mozbuild/configure/check_debug_ranges.py ||
	        die "sed failed to set toolchain prefix"
	 einfo "Removing pre-built binaries ..."
	find third_party -type f \( -name '*.so' -o -name '*.o' \) -print -delete || die
	 # Create build dir
	BUILD_DIR="${WORKDIR}/${PN}_build"
	mkdir -p "${BUILD_DIR}" || die
	 xdg_environment_reset
}
src_configure() {
	if use clang; then
	  extra_cflags="-I/usr/lib/clang/20/include/"
	  export CPPFLAGS="-I/usr/lib/clang/20/include/"
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
	mozconfig_add_options_ac '' --enable-project=js
	 mozconfig_add_options_ac 'MacaroniOS default' \
	    --host="${CBUILD:-${CHOST}}" \
	    --target="${CHOST}" \
	    --disable-jemalloc \
	    --disable-strip \
	    --enable-readline \
	    --enable-release \
	    --enable-shared-js \
	    --libdir="${EPREFIX}/usr/$(get_libdir)" \
	    --prefix="${EPREFIX}/usr" \
	    --with-intl-api \
	    --with-system-nspr \
	    --with-system-zlib \
	    --with-toolchain-prefix="${CHOST}-"
	 if use icu ; then
	  # Require >=icu-71. Disable by default for now.
	  mozconfig_add_options_ac 'MacaroniOS default' \
	    --with-system-icu
	fi
	 mozconfig_use_enable debug
	mozconfig_use_enable jit
	 mozconfig_add_options_ac '' --disable-tests
	 if use debug ; then
	    mozconfig_add_options_ac '+debug' --disable-optimize
	    mozconfig_add_options_ac '+debug' --enable-debug-symbols
	else
	    mozconfig_add_options_ac '-debug' --enable-optimize
	    mozconfig_add_options_ac '-debug' --disable-debug-symbols
	fi
	 # We always end up disabling this at some point due to newer rust versions. bgo#933372
	mozconfig_add_options_ac '--disable-rust-simd' --disable-rust-simd
	 # Modifications to better support ARM, bug 717344
	if use cpu_flags_arm_neon ; then
	    mozconfig_add_options_ac '+cpu_flags_arm_neon' --with-fpu=neon
	     if ! tc-is-clang ; then
	        # thumb options aren't supported when using clang, bug 666966
	        mozconfig_add_options_ac '+cpu_flags_arm_neon' --with-thumb=yes
	        mozconfig_add_options_ac '+cpu_flags_arm_neon' --with-thumb-interwork=no
	    fi
	fi
	 # LTO flag was handled via configure
	filter-lto
	 # Pass MAKEOPTS to build system
	export MOZ_MAKE_FLAGS="${MAKEOPTS}"
	 # Use system's Python environment
	export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE="none"
	export PIP_NETWORK_INSTALL_RESTRICTED_VIRTUALENVS=mach
	 # Disable notification when build system has finished
	export MOZ_NOSPAM=1
	 # Portage sets XARGS environment variable to "xargs -r" by default which
	# breaks build system's check_prog() function which doesn't support arguments
	mozconfig_add_options_ac 'MacaroniOS default' "XARGS=${EPREFIX}/usr/bin/xargs"
	 # Set build dir
	mozconfig_add_options_mk 'MacaroniOS default' "MOZ_OBJDIR=${BUILD_DIR}"
	 # Show flags we will use
	einfo "Build BINDGEN_CFLAGS:\t${BINDGEN_CFLAGS:-no value set}"
	einfo "Build CFLAGS:    ${CFLAGS}"
	einfo "Build CXXFLAGS:  ${CXXFLAGS}"
	einfo "Build LDFLAGS:   ${LDFLAGS}"
	einfo "Build RUSTFLAGS: ${RUSTFLAGS}"
	 ./mach configure || die
}
src_compile() {
	./mach build --verbose || die
}
src_install() {
	local mypn="mozjs"
	local mymajor="140"
	cd "${BUILD_DIR}" || die
	default
	# fix soname links
	pushd "${ED}"/usr/$(get_libdir) &>/dev/null || die
	mv lib${mypn}-${mymajor}.so lib${mypn}-${mymajor}.so.0.0.0 || die
	ln -s lib${mypn}-${mymajor}.so.0.0.0 lib${mypn}-${mymajor}.so.0 || die
	ln -s lib${mypn}-${mymajor}.so.0 lib${mypn}-${mymajor}.so || die
	popd &>/dev/null || die
	# remove unneeded files
	rm \
	    "${ED}"/usr/bin/js${mymajor}-config \
	    "${ED}"/usr/$(get_libdir)/libjs_static.ajs || die
	# fix permissions
	chmod -x \
	    "${ED}"/usr/$(get_libdir)/pkgconfig/*.pc \
	    "${ED}"/usr/include/mozjs-${mymajor}/js-config.h || die
}


# vim: filetype=ebuild
