# tmux config — working agreement

Goal: minimalist tmux config, no plugins, no external deps (no TPM, no
plugin-based statusbar, no third-party scripts).

## Workflow

- User asks for one feature at a time.
- Agent checks: can this be done with core tmux only (options, key-table
  binds, `#()`/`#{...}` format strings, hooks)? If yes, discuss short
  tradeoffs, then implement. If it truly needs a plugin/external binary,
  say so and propose the closest no-dep alternative instead of silently
  adding a dependency.
- Keep changes small, one feature per pass. Don't restructure existing
  config unless asked.
- Comment non-obvious binds/options briefly in the conf file itself.

## Layout (stow package)

    tmux/
      AGENTS.md
      .config/
        tmux/
          tmux.conf

Managed with GNU stow from `~/dotfiles`, so paths inside this folder must
mirror `$HOME` exactly. Config lives at `~/.config/tmux/tmux.conf` (tmux
>= 3.1 auto-detects XDG path; version here is 3.6).

## Constraints

- No plugin manager (TPM) or plugins.
- No external scripts/binaries beyond what's already on the system
  (coreutils, tmux itself). If a feature needs e.g. `xclip`/`wl-clipboard`
  for clipboard integration, call that out explicitly since it's a system
  dependency, not a tmux plugin — still fine, but flag it.
- Prefer built-in options/formats over cleverness.
