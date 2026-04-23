# Testing the Slatewave tmux theme

A hands-on walkthrough for exercising every surface the theme styles. tmux's "prefix key" (default `Ctrl+b`) gates every command — press it, release, then press the next key. Every `prefix + X` below means that two-step chord.

## Setup

```sh
# Install tmux if needed
brew install tmux

# Boot a session with JUST this theme loaded (no personal config to pollute)
tmux -L slatewave-test -f ~/Development/tmux-slatewave/slatewave.tmux.conf \
  new-session -s slatewave
```

The `-L slatewave-test` gives it a dedicated socket so it doesn't touch your real tmux later. To quit: `prefix + :` then type `kill-server` and Enter (or close the terminal).

---

## Visual checklist

Work through these in order — each exercises a different surface the theme styles.

### 1. Session pill (left)

Already visible: teal pill reading ` slatewave `. Rename it with `prefix + $`, type `editor`, Enter. Pill updates.

### 2. Window list — inactive vs. active

- `prefix + c` three times to create windows 1, 2, 3. The current one is the teal pill; others are muted gray.
- `prefix + n` / `prefix + p` to cycle. The teal pill should follow.
- `prefix + 0/1/2/3` jumps directly.

### 3. Last-window indicator

Switch from window 0 → 2, then back to 0. While on 0, window 2 should show in `fg_subtle` (slightly brighter than the other inactive windows). Toggle with `prefix + l`.

### 4. Activity indicator (sky blue)

```
prefix + :
setw -g monitor-activity on
```

Press Enter. Then in a different window, run `while true; do date; sleep 1; done`. Switch back to window 0. The busy window's label should glow sky-blue.

### 5. Bell indicator (amber)

```
prefix + :
setw -g monitor-bell on
```

In another window, run `printf '\a'` (ASCII bell). That window's label flashes amber-bold.

### 6. Prefix indicator (right side, rose)

Hold `Ctrl+b` and don't release. The right side should show a rose ` PREFIX ` pill. Release — it disappears. This tests the `#{?client_prefix,...,}` conditional.

### 7. Date & clock pills (right)

Already visible. Confirm 12-hour format with AM/PM, date reads `Wed Apr 22` style.

### 8. Pane borders

- `prefix + %` for vertical split, `prefix + "` for horizontal. You now have multiple panes.
- The active pane's border is teal; inactive borders are slate (`chrome_light`).
- `prefix + arrow` to move focus — the teal highlight should follow.

### 9. display-panes overlay

With several panes open, `prefix + q`. Large numbers overlay each pane: muted gray on inactive, teal on active.

### 10. Command prompt & message toasts

- `prefix + :` opens the command prompt (teal text on slate bar at the bottom).
- Type anything bogus like `foo`, Enter — the error message flashes in the same teal-on-slate style.
- Good commands to see success toasts: `display "hello"`.

### 11. Copy mode + selection

- `prefix + [` enters copy mode (you'll see `[0/0]` in the top-right of the active pane).
- Navigate with arrows or vi keys.
- Press `Space` to start selection, move, press `Enter` to copy. The highlighted region uses `mode-style` (dark text on teal).
- `q` exits copy mode.

### 12. Copy-mode search matches

In copy mode, press `/` (forward search) or `?` (backward), type a word present on screen, Enter. All matches highlight in sky-blue; the *current* match is teal-bold; any marks you set are amber.

### 13. Built-in clock

`prefix + t` takes over the active pane with a giant teal digital clock. Any key exits.

### 14. Menus

`prefix + <` (or right-click a window name in a mouse-enabled terminal) opens the window menu. The selected row is bg_inset text on teal; border is slate.

### 15. Popup

`prefix + :` then type `display-popup -E htop` (or `top` if no htop). The popup has a slate rounded border on the theme bg.

### 16. Pane border title

Panes can show titles in their border:

```
prefix + :
set -g pane-border-status top
```

Rename the active pane: `prefix + :` then `select-pane -T "my-pane"`. The border now shows ` 0: my-pane ` — the `#P` index is teal-bold, the title is muted. Flip back with `set -g pane-border-status off`.

---

## Truecolor sanity check

Before blaming the theme for washed-out colors, confirm your terminal is passing truecolor through tmux:

```sh
printf "\x1b[38;2;94;234;212mteal if truecolor works\x1b[0m\n"
```

That line should render in the exact Slatewave teal both outside tmux *and* inside a tmux pane. If it's dull/gray inside tmux only, add to your real `~/.tmux.conf` (before sourcing the theme):

```tmux
set -g default-terminal "tmux-256color"
set -as terminal-features ",*:RGB"
```

---

## Stress cases worth hitting

- **Very long session name** — `prefix + $`, rename to `a-really-long-session-name-here`. The left pill should grow, not break the bar (status-left-length is 100).
- **Many windows** — create 10+ windows with `prefix + c`. They should flow through the middle; when they overflow, the `<` / `>` list markers appear at the edges of the window area.
- **Tiny terminal** — resize your terminal narrow. The window list should truncate gracefully; the right side (date + clock) shouldn't wrap to a second row until very narrow.
- **Zoomed pane** — split panes, then `prefix + z` to zoom. The current window's flags (`#F`) should show a `Z` in the teal pill. `prefix + z` again to unzoom.
- **Detach/attach** — `prefix + d` to detach, then `tmux -L slatewave-test attach` to reattach. Everything should repaint identically.

Work top-to-bottom and you'll have exercised every `set -g` line in the theme.
