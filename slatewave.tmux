#!/usr/bin/env bash
# TPM entry point -- sources the theme file alongside this script.
# Works with tpm (https://github.com/tmux-plugins/tpm) when the repo is
# cloned into ~/.tmux/plugins/ and @plugin 'kevinlangleyjr/tmux-slatewave'
# is added to .tmux.conf.

PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux source-file "$PLUGIN_DIR/slatewave.tmux.conf"
