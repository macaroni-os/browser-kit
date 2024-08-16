# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Proxy for using W3C WebDriver compatible clients to interact with Gecko-based browsers."
HOMEPAGE="https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver https://github.com/mozilla/geckodriver"
SRC_URI="https://github.com/mozilla/geckodriver/tarball/53f2b320033668644eae58a8f3af5c94f0efc0f5 -> geckodriver-0.35.0-53f2b32.tar.gz
https://distfiles.macaronios.org/c9/42/66/c94266bf25f399040623aa4736490637efe65af08545046d11053f438b48fdb95fe73ceb47500d769fecd26145d6edde7f3fa457349b28a70590358dd191886f -> geckodriver-0.35.0-funtoo-crates-bundle-ace11cf2bf99ddb2bd864c7b16dcecd482371280c531f2f95bc876e90c100a31af80933984f9542f53ebe7e8f7f6bfadefa46c24eb82f5edad967234fa85f3a8.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="*"

DOCS=( README.md )

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/mozilla-geckodriver-* ${S} || die
}