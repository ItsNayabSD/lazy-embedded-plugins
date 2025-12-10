# lazy-embedded-plugins

Additional user Neovim plugins to be used alongside [nvpunk-embedded](https://github.com/ItsNayabSD/nvpunk-embedded) distribution.

## Install
```shell
mv ~/.config/nvim ~/.config/nvim.old # Backup your existing nvim configuration if present
git clone https://github.com/ItsNayabSD/nvpunk-embedded.git ~/.config/nvim # Clone nvpunk distribution
git clone https://github.com/ItsNayabSD/lazy-embedded-plugins.git ~/.config/nvpunk # Add user plugins
```

## Plugins

> **Note:** To enable any disabled plugin, simply remove the `enabled = false` line from the plugin configuration in `lua/user/plugins.lua`.

### AI Assistants
- [yetone/avante.nvim](https://github.com/yetone/avante.nvim) - AI-powered coding assistant with Claude Code integration (enabled)
- [olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) - Claude Code companion (disabled)
- [frankroeder/parrot.nvim](https://github.com/frankroeder/parrot.nvim) - Multi-provider AI assistant (OpenAI, Anthropic, Gemini, etc.) (disabled)
- [robitx/gp.nvim](https://github.com/Robitx/gp.nvim) - GPT integration (disabled)
- [sourcegraph/amp.nvim](https://github.com/sourcegraph/amp.nvim) - Sourcegraph Amp AI assistant (disabled)
- [GeorgesAlkhouri/nvim-aider](https://github.com/GeorgesAlkhouri/nvim-aider) - Aider integration via Snacks (disabled)
- [nekowasabi/aider.vim](https://github.com/nekowasabi/aider.vim) - Denops-based Aider integration (disabled)

### Development Tools
- [f-person/git-blame.nvim](https://github.com/f-person/git-blame.nvim) - Git blame information in virtual text (enabled)
- [lewis6991/fileline.nvim](https://github.com/lewis6991/fileline.nvim) - Open files at specific line numbers (enabled)
