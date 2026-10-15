class BtcToolkit < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin CLI: read OP_RETURN, decode and verify transactions, validate addresses"
  homepage "https://github.com/devdavidejesus/btc-toolkit"
  url "https://files.pythonhosted.org/packages/61/de/573397eea7f3ca794b240c70452c50fc35827a8cffdf0280ea29ad68cf03/btc_toolkit-1.8.0.tar.gz"
  sha256 "815a530f8bce34b764ab415500536c8b3ea651e2cdb15c709147162e0de3023e"
  license "MIT"

  depends_on "python@3.13"

  resource "bash-completion" do
    url "https://raw.githubusercontent.com/devdavidejesus/btc-toolkit/v1.8.0/completions/btc-toolkit.bash"
    sha256 "c705579e381a54498bfdc13f3cae9175cf36c6a8a9ea9016da446782c5adddb2"
  end

  resource "zsh-completion" do
    url "https://raw.githubusercontent.com/devdavidejesus/btc-toolkit/v1.8.0/completions/btc-toolkit.zsh"
    sha256 "57b69566db0479fffab94948ef81a08f9ab506c3101d48cc64a3a1dfacad20dd"
  end

  def install
    virtualenv_install_with_resources(without: %w[bash-completion zsh-completion])
    resource("bash-completion").stage { bash_completion.install "btc-toolkit.bash" => "btc-toolkit" }
    resource("zsh-completion").stage { zsh_completion.install "btc-toolkit.zsh" => "_btc-toolkit" }
  end

  test do
    assert_match "btc-toolkit #{version}", shell_output("#{bin}/btc-toolkit --version")
    assert_match "invalid", shell_output("#{bin}/btc-toolkit opreturn nothex 2>&1", 2).downcase
    # Offline address validation: checksum verified, nothing sent over the network.
    assert_match '"address_type": "P2WPKH"',
                 shell_output("#{bin}/btc-toolkit validate bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq --json")
    shell_output("#{bin}/btc-toolkit validate bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdx --json", 2)
  end
end
