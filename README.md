# devdavidejesus/tap

Homebrew formulae by [Davi de Jesus](https://github.com/devdavidejesus).

## btc-toolkit

A zero-dependency Bitcoin CLI: read OP_RETURN messages and inscriptions,
decode raw transactions, verify a transaction against its block's proof of
work, validate addresses offline, and inspect UTXOs, fees and blocks.
Source: [devdavidejesus/btc-toolkit](https://github.com/devdavidejesus/btc-toolkit).

```bash
brew install devdavidejesus/tap/btc-toolkit
btc-toolkit block 0
```

The formula installs the same source file that is published on
[PyPI](https://pypi.org/project/btc-toolkit/), pinned by its SHA-256, plus the
bash and zsh completions from the matching release tag.
