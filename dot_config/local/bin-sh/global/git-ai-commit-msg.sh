#!/usr/bin/env bash

# Stolen from: https://github.com/junegunn/fzf-git.sh/blob/c823ffd521cb4a3a65a5cf87f1b1104ef651c3de/fzf-git.sh#L194
_fzf_git_check() {
  git rev-parse > /dev/null 2>&1 && return

  [[ -n $TMUX ]] && tmux display-message "Not in a git repository"
  return 1
}

_fzf_git_check || exit 0

git_diff=$(git diff --cached)
if [ -z "$git_diff" ]; then
    echo "No staged changes found. Please stage changes before running this script."
    exit 1
fi

read -r -d '' prompt <<EOF
You are an AI developer assistant.
Analyze the following git diff and generate a concise commit message that follows the Conventional Commits specification (https://www.conventionalcommits.org):
- Use 'feat' for new features,
- 'fix' for bug fixes,
- 'refactor' for code changes,
- 'docs' for documentation, etc.
The message should be a single line and summarize the main purpose of the change.

Here is the git diff:
$git_diff
EOF

OLLAMA_URL='http://192.168.77.124:11434'
CHAT_MODEL='gpt-oss:20b'

json_payload=$(jq -n \
    --arg prompt "$prompt" --arg model "$CHAT_MODEL" \
    '{prompt: $prompt, model: $model, stream: false}')

# commit_message=$(ollama run llama2:13b --keep-session --format "plain" "$prompt" | head -n 1)
commit_message=$(gum spin --title="✨ Thinking..." -- \
    curl --silent --request POST "$OLLAMA_URL/api/generate" \
    --header "Content-Type: application/json" \
    --data "$json_payload" | jq -r '.response')

echo "$commit_message"

# Optionally, automatically commit (uncomment below to commit automatically)
# git commit -m "$commit_message"
