class BtcToolkit < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin CLI: read OP_RETURN, decode and verify transactions, validate addresses"
  homepage "https://github.com/devdavidejesus/btc-toolkit"
  url "https://files.pythonhosted.org/packages/34/35/e62298100d2b98a3680aefef86a783772566d5b45dac04056140d99023b4/btc_toolkit-1.8.2.tar.gz"
  sha256 "8ebdf7b026bc2a3b0ec31ce9073656b5b66021a7d2391dbbc4b4b88780ec1111"
  license "MIT"

  depends_on "python@3.15"

  def install
    virtualenv_install_with_resources
    # The sdist ships the completion scripts since 1.8.2.
    bash_completion.install "completions/btc-toolkit.bash" => "btc-toolkit"
    zsh_completion.install "completions/btc-toolkit.zsh" => "_btc-toolkit"
    fish_completion.install "completions/btc-toolkit.fish"
  end

  test do
    assert_match "btc-toolkit #{version}", shell_output("#{bin}/btc-toolkit --version")
    assert_match "invalid", shell_output("#{bin}/btc-toolkit opreturn nothex 2>&1", 2).downcase
    # Offline address validation: checksum verified, nothing sent over the network.
    assert_match '"address_type": "P2WPKH"',
                 shell_output("#{bin}/btc-toolkit validate bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq --json")
    shell_output("#{bin}/btc-toolkit validate bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdx --json", 2)
    assert_path_exists bash_completion/"btc-toolkit"
    assert_path_exists zsh_completion/"_btc-toolkit"
    assert_path_exists fish_completion/"btc-toolkit.fish"
  end
end
