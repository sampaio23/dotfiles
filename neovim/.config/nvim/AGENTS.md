# Neovim Config Notes

This config is intentionally built slowly and pragmatically. Prefer built-in Neovim features first. Add plugins only when they clearly improve the workflow, and discuss tradeoffs before introducing new dependencies.

## User Preferences

- Minimal, fast Neovim setup.
- Prefer built-in behavior when it is good enough.
- If a plugin is better, explain pros and cons before adding it.
- Keep configuration modular and easy to understand.
- Avoid noisy UI elements.
- Do not add dashboards or heavy UI plugins by default.
- Use `lazy.nvim` for plugins.
- Use spaces over tabs for indentation.
- Indentation width is 4 spaces.
- Leader key is Space.
- Absolute line numbers only, not relative line numbers.
- System clipboard integration should be enabled.
- Visible whitespace is desired, but subtle.
- Diagnostics should not be visually distracting in the buffer.

## Current Structure

- `init.lua` loads core modules and plugin setup.
- `lua/core/options.lua` contains core options.
- `lua/core/keymaps.lua` contains general keymaps.
- `lua/core/autocmds.lua` contains core autocmds.
- `lua/core/statusline.lua` contains the custom built-in statusline.
- `lua/core/lazy.lua` bootstraps and configures `lazy.nvim`.
- `lua/plugins/*.lua` contains plugin specs.

## Current Core Choices

- Colorscheme: built-in `koehler`.
- Statusline: custom built-in statusline, no plugin.
- Whitespace display: enabled with subtle markers.
- Persistent undo is enabled with Neovim's built-in undo files.
- Git signs are enabled in the sign column with ASCII markers only.
- Diagnostic signs, underlines, and virtual text are disabled globally.
- Query replace is implemented with a custom built-in wrapper over `:%s///gc`.
- Netrw custom config was removed after Telescope became the file finder.

## Keymaps

- `<leader>w`: write file.
- `<leader>q`: quit window.
- `<leader>x`: write and quit.
- `<leader>c`: run a command in the live compilation split.
- `<leader>C`: toggle the live compilation split.
- `<leader>n`: next buffer.
- `<leader>p`: previous buffer.
- `<leader>d`: delete current buffer.
- `<leader>u`: show undo history.
- `<leader>s`: vertical split.
- `<leader>r`: query replace.
- `<leader>f`: Telescope file finder.
- `<leader>/`: Telescope live grep.
- `<leader>b`: Telescope open buffers.
- `<leader>gp`: preview current Git hunk inline.
- `<leader>gh`: toggle Git changed-line background highlights.
- `<leader>gu`: undo current Git hunk.
- `<Esc>`: clear search highlight.
- `Ctrl-h/j/k/l`: move between windows.
- `Ctrl-Arrow`: move between windows in normal, insert, visual, and terminal modes.
- `Tab`: indent current line in normal mode, selected lines in visual mode.
- `Shift-Tab`: unindent current line in normal and insert mode, selected lines in visual mode.
- `Alt-Up` / `Alt-Down`: move current line or visual selection up/down.

## Completion

- Completion uses `blink.cmp` with `clangd` LSP.
- Completion is manual, not automatic.
- `Ctrl-Space`: open completion menu.
- `Ctrl-y`: accept selected completion.
- `Ctrl-n`: next completion item.
- `Ctrl-p`: previous completion item.
- `Ctrl-e`: close completion menu.
- Completion should not preselect or auto-insert text when opened.

## C/C++ LSP

- `clangd` is configured through Neovim's native LSP API.
- `clangd` runs with `--background-index`.
- LSP is kept for completion, hover, and code actions.
- LSP rename is intentionally not mapped to avoid delaying `<leader>r` query replace.
- Avoid relying on LSP for C/kernel navigation when project indexing is unreliable.

## Tags And Navigation

- The user prefers tags for go-to-definition/navigation in large C projects such as the Linux kernel.
- Tags discovery is configured with `./tags;` and `tags`, so parent directories are searched.
- For the Linux kernel, generate tags from the kernel root with `make tags`.
- For regular C projects, `ctags -R .` is acceptable.
- `gd`: jump to tag definition for the word under cursor.
- `gD`: show tag selection for the word under cursor.
- `gr`: Telescope grep the word under cursor to find usages/references.
- `Ctrl-t`: go back through tag stack after tag jumps.
- `Ctrl-o`: go back through normal jump list.

## Plugin Decisions So Far

- `lazy.nvim`: plugin manager.
- `telescope.nvim`: used for fuzzy file finding, live grep, and buffer listing.
- `plenary.nvim`: dependency of Telescope; not configured directly.
- `blink.cmp`: used for modern manual completion UX.
- `nvim-lspconfig`: used for LSP server configuration with native Neovim LSP APIs.
- `gitsigns.nvim`: used for Git change markers, inline hunk preview, and optional line highlights; blame, word diff, and navigation UI are not configured yet.

## Things To Preserve

- Keep completion manual-triggered unless the user asks for auto-popup.
- Keep diagnostic visuals quiet unless the user asks otherwise.
- Keep navigation choices practical for large C codebases.
- Discuss plugin pros and cons before adding more plugins.
- Prefer small, direct config over abstractions.
