class BtcToolkit < Formula
  include Language::Python::Virtualenv

  desc "Bitcoin CLI: decode OP_RETURN, inspect transactions, addresses, fees, blocks"
  homepage "https://github.com/devdavidejesus/btc-toolkit"
  url "https://files.pythonhosted.org/packages/4c/56/a6e53e9daff8e0009a4f053b37607095205aea2b7d45e53accdea7da0b77/btc_toolkit-1.7.2.tar.gz"
  sha256 "7e4069dd8725d09ccb625c654ed019179c811c3f81035645e2d20c7eccd41fe5"
  license "MIT"

  depends_on "python@3.13"

  resource "bash-completion" do
    url "https://raw.githubusercontent.com/devdavidejesus/btc-toolkit/v1.7.2/completions/btc-toolkit.bash"
    sha256 "5752d09b7ea6d4b28cb59f9a9cfb594f7003f4db77da4436827ae61cf2db0b79"
  end

  resource "zsh-completion" do
    url "https://raw.githubusercontent.com/devdavidejesus/btc-toolkit/v1.7.2/completions/btc-toolkit.zsh"
    sha256 "159b294452aada67a1107ecf69484c466168d215fcfd383bf5bad3725dc8ab36"
  end

  def install
    virtualenv_install_with_resources(without: %w[bash-completion zsh-completion])
    resource("bash-completion").stage { bash_completion.install "btc-toolkit.bash" => "btc-toolkit" }
    resource("zsh-completion").stage { zsh_completion.install "btc-toolkit.zsh" => "_btc-toolkit" }
  end

  test do
    assert_match "btc-toolkit #{version}", shell_output("#{bin}/btc-toolkit --version")
    assert_match "invalid", shell_output("#{bin}/btc-toolkit opreturn nothex 2>&1", 2).downcase
  end
end
