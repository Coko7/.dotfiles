#!/usr/bin/env bash

#############################################################
#            _ _                          _          _      #
#     __   _(_) |__   ___    ___ ___   __| | ___  __| |     #
#     \ \ / / | '_ \ / _ \  / __/ _ \ / _` |/ _ \/ _` |     #
#      \ V /| | |_) |  __/ | (_| (_) | (_| |  __/ (_| |     #
#       \_/ |_|_.__/ \___|  \___\___/ \__,_|\___|\__,_|     #
#                                                           #
# ⚠️ This script was totally generated using Claude Code ⚠️ #
#                                                           #
#############################################################

# git-commit-msg.sh
# Generates a Commitizen-style commit message from staged git diffs using Claude Code CLI
#
# Usage:
#   ./git-commit-msg.sh
#   ./git-commit-msg.sh --copy      # also copy result to clipboard (requires xclip/pbcopy)
#   ./git-commit-msg.sh --commit    # auto-run git commit with the generated message
#
# Requirements:
#   - Claude Code CLI installed and authenticated (claude --version to check)
#   - git

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
COPY=false
AUTO_COMMIT=false

# ── Arg parsing ───────────────────────────────────────────────────────────────
for arg in "$@"; do
  case $arg in
  --copy) COPY=true ;;
  --commit) AUTO_COMMIT=true ;;
  --help | -h)
    echo "Usage: $0 [--copy] [--commit]"
    echo "  --copy    Copy the generated message to clipboard"
    echo "  --commit  Run git commit with the generated message"
    exit 0
    ;;
  *)
    echo "Unknown argument: $arg" >&2
    exit 1
    ;;
  esac
done

# ── Checks ────────────────────────────────────────────────────────────────────
for cmd in claude git; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "❌  Required command not found: $cmd" >&2
    [[ "$cmd" == "claude" ]] && echo "    Install Claude Code: https://docs.claude.ai/en/docs/claude-code/overview" >&2
    exit 1
  fi
done

# ── Get staged diff ───────────────────────────────────────────────────────────
DIFF=$(git diff --cached)

if [[ -z "$DIFF" ]]; then
  echo "⚠️  No staged changes found. Stage some files first with: git add <files>" >&2
  exit 1
fi

# Truncate very large diffs to avoid token limits (~12k chars ≈ ~3k tokens)
MAX_DIFF_CHARS=12000
if [[ ${#DIFF} -gt $MAX_DIFF_CHARS ]]; then
  echo "⚠️  Diff is large (${#DIFF} chars). Truncating to ${MAX_DIFF_CHARS} chars." >&2
  DIFF="${DIFF:0:$MAX_DIFF_CHARS}"$'\n[... diff truncated ...]'
fi

# ── Build prompt ──────────────────────────────────────────────────────────────
PROMPT="You are an expert software engineer. Analyze the following git diff and generate a single Commitizen-style commit message.

Follow this format exactly:
  <type>(<scope>): <short summary>

  [optional body: explain WHY and WHAT changed, wrap at 72 chars]

  [optional footer: BREAKING CHANGE: ..., Closes #issue]

Allowed types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- scope: short noun describing the area changed (omit if unclear)
- summary: imperative mood, lowercase, no period, max 72 chars
- body: only include if the change needs explanation beyond the summary
- footer: only include for breaking changes or issue references

Respond with ONLY the commit message — no preamble, no markdown fences, no commentary.

Git diff:
$DIFF"

# ── Call Claude Code CLI ──────────────────────────────────────────────────────
echo "🤖  Asking Claude to generate a commit message..." >&2

COMMIT_MSG=$(echo "$PROMPT" | claude -p --output-format text 2>/dev/null | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if [[ -z "$COMMIT_MSG" ]]; then
  echo "❌  Claude returned an empty response. Try running: claude -p 'say hi' to check your session." >&2
  exit 1
fi

# ── Output ────────────────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅  Generated commit message:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "$COMMIT_MSG"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── Optional: copy to clipboard ───────────────────────────────────────────────
if [[ "$COPY" == true ]]; then
  if command -v pbcopy &>/dev/null; then
    echo "$COMMIT_MSG" | pbcopy
    echo "📋  Copied to clipboard (pbcopy)." >&2
  elif command -v xclip &>/dev/null; then
    echo "$COMMIT_MSG" | xclip -selection clipboard
    echo "📋  Copied to clipboard (xclip)." >&2
  elif command -v wl-copy &>/dev/null; then
    echo "$COMMIT_MSG" | wl-copy
    echo "📋  Copied to clipboard (wl-copy)." >&2
  else
    echo "⚠️  No clipboard tool found (pbcopy/xclip/wl-copy). Skipping copy." >&2
  fi
fi

# ── Optional: auto-commit ─────────────────────────────────────────────────────
if [[ "$AUTO_COMMIT" == true ]]; then
  echo ""
  echo "🚀  Running: git commit ..."
  git commit -m "$COMMIT_MSG"
fi
