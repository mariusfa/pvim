# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration (PVIM) using lazy.nvim as the plugin manager. The configuration follows a modular structure where each plugin is defined in its own file under `lua/plugins/`.

## Architecture

### File Structure
- `init.lua`: Entry point that loads default-settings and lazy-bootstrap
- `lua/default-settings.lua`: Global settings, keymaps, and autocommands (loaded BEFORE plugins)
- `lua/lazy-bootstrap.lua`: Bootstraps lazy.nvim and imports all plugins from `lua/plugins/`
- `lua/plugins/*.lua`: Individual plugin configurations (each file returns a lazy.nvim plugin spec)
- `lua/splash.lua`: Custom splash screen (currently disabled in init.lua)

### Plugin Loading

Lazy.nvim automatically imports all Lua files from `lua/plugins/`. Each plugin file returns a table with the plugin spec. The `plugins/init.lua` file is empty and just returns `{}`.

## Key Configuration Locations

### Adding New Plugins

Create a new file in `lua/plugins/` that returns a lazy.nvim plugin spec:
```lua
return {
    "author/plugin-name",
    config = function()
        -- setup code
    end,
}
```

### Adding Global Keymaps

Add to `lua/default-settings.lua` (NOT in plugin files unless plugin-specific)

### LSP Servers

Configured in `lua/plugins/lsp.lua`:
- Currently configured: gopls, rust_analyzer, ts_ls, tailwindcss, jdtls, kotlin_language_server, lua_ls
- Do NOT enable denols - it conflicts with ts_ls. Use ts_ls for TypeScript/JavaScript projects
- Mason auto-installs LSP servers defined in the `servers` table
- Additional tools (stylua, prettier, ktfmt) are auto-installed via mason-tool-installer

### Formatters

Configured in `lua/plugins/format.lua` using conform.nvim:
- TypeScript: Uses prettier if package.json exists, otherwise falls back to deno_fmt
- Autoformat on save is controlled by `vim.g.autoformat` (enabled by default)
- Toggle with `:FormatEnable` and `:FormatDisable` commands
- Manual format: `<leader>cf`

## Common Maintenance Tasks

### Clean Neovim State

When things break or plugins have issues:
```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

Then restart Neovim to reinstall everything.

### Remove a Plugin Tool from Mason

If a tool is causing conflicts (like Deno):
```bash
rm -rf ~/.local/share/nvim/mason/packages/<package-name>
rm ~/.local/share/nvim/mason/bin/<binary-name>
```

### Update Plugins

In Neovim: Press `U` in the lazy.nvim UI (opened with `:Lazy`)

If a plugin has local changes blocking updates, clean the directory:
```bash
cd ~/.local/share/nvim/lazy/<plugin-name>
git restore . && git clean -fd
```

## Important Custom Settings

- Leader key: Space
- Tab width: 4 spaces (tabstop, shiftwidth, softtabstop all set to 4)
- `jj` or `JJ` in insert/terminal mode: Escape to normal mode
- `<C-h/j/k/l>`: Navigate between window splits
- `<leader>e`: Open file tree (NvimTree)
- `<leader>cd`: Show diagnostic errors
- `<Esc>`: Clear search highlights

## Language-Specific Notes

### TypeScript/JavaScript
- Use ts_ls (NOT denols) for LSP
- Prettier for formatting when package.json exists
- Avoid installing Deno in Mason to prevent conflicts

### API Testing
- Hurl plugin for .hurl files
- Requires external tools: jq, prettier, tidy-html5
- Run requests with `<leader>a` or `<leader>A`

## Plugin Management Philosophy

This configuration uses versioned plugins where possible (see version fields in plugin specs) to maintain stability. When updating plugins, check lazy-lock.json for the current pinned versions.
