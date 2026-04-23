<div align="center">

# Slatewave (tmux)

A Slatewave status bar and pane styling for [tmux](https://github.com/tmux/tmux) — slate foundation, teal signature. Designed as a twin to the [Slatewave Starship prompt](https://github.com/kevinlangleyjr/starship-slatewave), [oh-my-posh prompt](https://github.com/kevinlangleyjr/slatewave-omp), [VSCode theme](https://github.com/kevinlangleyjr/vscode-slatewave), [Obsidian theme](https://github.com/kevinlangleyjr/obsidian-slatewave), [Alacritty theme](https://github.com/kevinlangleyjr/alacritty-slatewave), [Ghostty theme](https://github.com/kevinlangleyjr/ghostty-slatewave), and [iTerm2 preset](https://github.com/kevinlangleyjr/iterm2-slatewave) — editor, terminal, multiplexer, and prompt share a single color vocabulary.

> _Slate below, teal above._

</div>

---

## Layout

One status line, three zones — the session on the left, your window list in the middle, prefix/date/time on the right:

```
  session   1:editor  2:server    3:logs                              PREFIX    Wed Apr 22   3:04 PM
```

- **Left**: session name in a teal pill
- **Middle**: window list — inactive windows muted, the current window lifted into a chrome pill with teal text
- **Right**: prefix indicator (rose, only while the prefix key is held) → date → 12-hour clock

Copy mode, the command prompt, pane borders, menus, popups, and the built-in clock all share the same palette.

---

## Requirements

- **tmux** ≥ 3.2 (for `copy-mode-match-style`, `popup-style`, and modern `#{?}` formatting)
- A **Nerd Font** (or other powerline-capable font) for the `` / `` pill transitions. Tested with MesloLGS NF and Hack Nerd Font. Plain powerline fonts work too.
- A terminal with true-color support (iTerm2, Ghostty, Alacritty, WezTerm, Kitty, …). tmux itself needs `Tc` or `RGB` in its `terminal-overrides` — see [Troubleshooting](#troubleshooting) if colors look off.

---

## Installation

### Option 1 — `source-file` in `~/.tmux.conf`

```sh
git clone https://github.com/kevinlangleyjr/tmux-slatewave.git \
  ~/.config/tmux/slatewave
```

Then in `~/.tmux.conf`:

```tmux
source-file ~/.config/tmux/slatewave/slatewave.tmux.conf
```

Reload tmux (`tmux source-file ~/.tmux.conf` or `prefix + r` if bound) — the theme applies immediately.

### Option 2 — [TPM](https://github.com/tmux-plugins/tpm)

If you use the tmux plugin manager, add:

```tmux
set -g @plugin 'kevinlangleyjr/tmux-slatewave'
```

to `~/.tmux.conf`, then `prefix + I` to fetch and load.

### Option 3 — copy into an existing config

`slatewave.tmux.conf` is a plain set of `set -g` lines. Copy the whole file, or just the blocks you want, into your existing `~/.tmux.conf`. Every section is commented with the palette values it uses, so partial adoption is safe.

---

## Palette

Slatewave shares its palette with the companion themes. tmux has no variable mechanism in config files, so the hex values are inlined throughout `slatewave.tmux.conf` — but every color maps to a semantic slot:

### Backgrounds

| | Hex | Palette | Used by |
|---|---|---|---|
| ![#0f172a](https://placehold.co/20x20/0f172a/0f172a.png) | `#0f172a` | `bg_inset` | text on teal / rose pills |
| ![#1e293b](https://placehold.co/20x20/1e293b/1e293b.png) | `#1e293b` | `bg_elevated` | **status bar bg**, messages, menus, popups |
| ![#21252b](https://placehold.co/20x20/21252b/21252b.png) | `#21252b` | `bg_raised` | reserved |
| ![#282c34](https://placehold.co/20x20/282c34/282c34.png) | `#282c34` | `bg_base` | reserved |
| ![#2c313a](https://placehold.co/20x20/2c313a/2c313a.png) | `#2c313a` | `chrome_dark` | clock pill bg |
| ![#3e4451](https://placehold.co/20x20/3e4451/3e4451.png) | `#3e4451` | `chrome_light` | active-window pill bg, date pill bg, inactive pane border |

### Foregrounds

| | Hex | Palette | Used by |
|---|---|---|---|
| ![#64748b](https://placehold.co/20x20/64748b/64748b.png) | `#64748b` | `fg_faint` | reserved |
| ![#94a3b8](https://placehold.co/20x20/94a3b8/94a3b8.png) | `#94a3b8` | `fg_muted` | inactive window text, display-panes |
| ![#cbd5e1](https://placehold.co/20x20/cbd5e1/cbd5e1.png) | `#cbd5e1` | `fg_subtle` | last-window indicator |
| ![#e2e8f0](https://placehold.co/20x20/e2e8f0/e2e8f0.png) | `#e2e8f0` | `fg_default` | bar baseline, date text |
| ![#f1f5f9](https://placehold.co/20x20/f1f5f9/f1f5f9.png) | `#f1f5f9` | `fg_bright` | reserved |

### Accent

| | Hex | Palette | Used by |
|---|---|---|---|
| ![#5eead4](https://placehold.co/20x20/5eead4/5eead4.png) | `#5eead4` | `teal_300` | session pill, active window, clock, active pane border, selection, clock-mode |
| ![#99f6e4](https://placehold.co/20x20/99f6e4/99f6e4.png) | `#99f6e4` | `teal_200` | reserved |
| ![#0f766e](https://placehold.co/20x20/0f766e/0f766e.png) | `#0f766e` | `teal_600` | reserved |
| ![#0e7490](https://placehold.co/20x20/0e7490/0e7490.png) | `#0e7490` | `teal_700` | reserved |
| ![#ecfeff](https://placehold.co/20x20/ecfeff/ecfeff.png) | `#ecfeff` | `cyan_fg` | reserved |

### State

| | Hex | Palette | Meaning |
|---|---|---|---|
| ![#38bdf8](https://placehold.co/20x20/38bdf8/38bdf8.png) | `#38bdf8` | `sky_400` | window activity indicator, copy-mode match |
| ![#fb7185](https://placehold.co/20x20/fb7185/fb7185.png) | `#fb7185` | `rose_400` | prefix-active indicator |
| ![#ef5350](https://placehold.co/20x20/ef5350/ef5350.png) | `#ef5350` | `red_bright` | reserved |
| ![#b388ff](https://placehold.co/20x20/b388ff/b388ff.png) | `#b388ff` | `purple` | reserved |
| ![#fbbf24](https://placehold.co/20x20/fbbf24/fbbf24.png) | `#fbbf24` | `amber_400` | window bell, copy-mode mark |
| ![#b45309](https://placehold.co/20x20/b45309/b45309.png) | `#b45309` | `amber_700` | reserved |
| ![#ff4500](https://placehold.co/20x20/ff4500/ff4500.png) | `#ff4500` | `orange` | reserved |
| ![#193549](https://placehold.co/20x20/193549/193549.png) | `#193549` | `git_ink` | reserved |

---

## What the theme sets

| Surface | Style |
|---|---|
| `status-style` (bar bg) | `fg_default` on `bg_elevated` |
| `status-left` | ` #S ` — `bg_inset` on `teal_300`, bold |
| `window-status-format` | ` #I:#W#F ` — `fg_muted` on `bg_elevated` |
| `window-status-current-format` |  ` #I:#W#F `  — `teal_300` on `chrome_light`, bold |
| `window-status-bell-style` | `amber_400` on `bg_elevated`, bold |
| `window-status-activity-style` | `sky_400` on `bg_elevated` |
| `window-status-last-style` | `fg_subtle` on `bg_elevated` |
| `status-right` prefix indicator | ` PREFIX ` — `bg_inset` on `rose_400`, bold (only while prefix held) |
| `status-right` date | ` %a %b %-d ` — `fg_default` on `chrome_light` |
| `status-right` time | ` %-I:%M %p ` — `teal_300` on `chrome_dark` |
| `pane-border-style` | `chrome_light` |
| `pane-active-border-style` | `teal_300` |
| `message-style` | `teal_300` on `bg_elevated` |
| `mode-style` (copy / selection) | `bg_inset` on `teal_300` |
| `copy-mode-match-style` | `bg_inset` on `sky_400` |
| `copy-mode-current-match-style` | `bg_inset` on `teal_300`, bold |
| `copy-mode-mark-style` | `bg_inset` on `amber_400` |
| `display-panes-active-colour` | `teal_300` |
| `clock-mode-colour` | `teal_300` (12-hour) |
| `menu-selected-style` | `bg_inset` on `teal_300`, bold |
| `popup-border-style` | `chrome_light`, rounded lines |

---

## Customize

The theme file is a plain tmux config — every line is a `set -g`. Edit [`slatewave.tmux.conf`](./slatewave.tmux.conf) in place, or copy the blocks you want into your own `~/.tmux.conf` after the `source-file` line so your overrides win.

Common edits:

- **24-hour clock** — change ` %-I:%M %p ` to ` %H:%M ` in `status-right`, and set `clock-mode-style 24`
- **Status bar on top** — `set -g status-position top`
- **Show hostname** — append ` @#h ` (or `#H` for FQDN) to `status-left`, or splice it into `status-right` before the date
- **Drop powerline glyphs** (no Nerd Font) — delete the `#[fg=#5eead4,bg=#1e293b,nobold] ` transitions and the `` / `` chars; the theme falls back to flat pills
- **Name pane titles** — flip `pane-border-status off` to `pane-border-status top` (or `bottom`); `pane-border-format` is already Slatewave-styled
- **Slower status refresh** — bump `status-interval 5` (e.g. `15` for less CPU on laptops)
- **Different window numbering** — combine with `set -g base-index 1` and `set -g renumber-windows on` in your own config; the theme renders whatever tmux provides

---

## Troubleshooting

**Colors look washed out / wrong.** Your outer terminal supports truecolor but tmux isn't being told. Add this to `~/.tmux.conf` *before* sourcing the theme:

```tmux
set -g default-terminal "tmux-256color"
set -as terminal-features ",xterm-256color:RGB"
set -as terminal-features ",alacritty:RGB"
set -as terminal-features ",ghostty:RGB"
```

**Pill arrows render as boxes or question marks.** Install a Nerd Font in your terminal and set it as the active font. [nerdfonts.com](https://www.nerdfonts.com/) has downloads; the Slatewave sibling themes are all tested with MesloLGS NF.

**Status bar reads "can't find format 'client_prefix'" or similar.** You're on tmux < 3.2. Upgrade (`brew install tmux`, `apt install tmux`, …).

---

## Companion themes

Slatewave is one palette, many surfaces. Run them together and your editor, terminal, multiplexer, prompt, and notes all speak the same visual language.

- **Editor** — [vscode-slatewave](https://github.com/kevinlangleyjr/vscode-slatewave)
- **Prompt (oh-my-posh)** — [slatewave-omp](https://github.com/kevinlangleyjr/slatewave-omp)
- **Prompt (Starship)** — [starship-slatewave](https://github.com/kevinlangleyjr/starship-slatewave)
- **Multiplexer (tmux)** — this repo
- **Notes** — [obsidian-slatewave](https://github.com/kevinlangleyjr/obsidian-slatewave)
- **Terminal (Alacritty)** — [alacritty-slatewave](https://github.com/kevinlangleyjr/alacritty-slatewave)
- **Terminal (Ghostty)** — [ghostty-slatewave](https://github.com/kevinlangleyjr/ghostty-slatewave)
- **Terminal (iTerm2)** — [iterm2-slatewave](https://github.com/kevinlangleyjr/iterm2-slatewave)

---

## Contributing

Issues and PRs welcome. For palette or layout changes, include a before/after screenshot of the status bar in three states: idle, prefix held, and with split panes (so the active vs inactive pane border is visible).

---

## License

WTFPL — Do What The Fuck You Want To Public License. See [LICENSE](LICENSE).
