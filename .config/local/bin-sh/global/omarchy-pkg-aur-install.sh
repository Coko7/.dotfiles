#!/usr/bin/env bash

# Stolen from: https://github.com/basecamp/omarchy/blob/master/bin/omarchy-pkg-aur-install
# Swapped yay with paru

fzf_args=(
  --multi
  --height=100%
  --preview 'paru -Siia {1}'
  --preview-label='alt-p: toggle description, alt-b/B: toggle PKGBUILD, alt-j/k: scroll, tab: multi-select'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'alt-b:change-preview:paru -Gpa {1} | tail -n +5'
  --bind 'alt-B:change-preview:paru -Siia {1}'
  --color 'pointer:green,marker:green'
)

pkg_names=$(paru -Slqa | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  # Convert newline-separated selections to space-separated for paru
  echo "$pkg_names" | tr '\n' ' ' | xargs paru -S --noconfirm
  sudo updatedb
fi
