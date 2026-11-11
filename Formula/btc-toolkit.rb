class BtcToolkit < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin CLI: read OP_RETURN, decode and verify transactions, validate addresses"
  homepage "https://github.com/devdavidejesus/btc-toolkit"
  url "https://files.pythonhosted.org/packages/ae/c1/b5e7e39ca0f0ca6d6b8b468020d47b55c717ec838752dee42f99d1d6ff9c/btc_toolkit-1.8.3.tar.gz"
  sha256 "d450df2cbf7f578009d232974147678d73abbb06cf5f1516c6a98c18b65b81dd"
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
