#!/usr/bin/env bash

OLLAMA_URL='http://192.168.77.124:11434'
CHAT_MODEL='gpt-oss:20b'

pre_prompt_file=$(fd . "$XDG_CONFIG_HOME/local/bin-sh/global/data/prompts" \
    | fzf --select-1 --delimiter '/' \
    --with-nth='{10..}' --preview="bat {}")

if [ -f "$pre_prompt_file" ]; then
    pre_prompt=$(cat "$pre_prompt_file")
else
    pre_prompt=""
fi

prompt=$(gum write --header="Ask AI")
[[ -z "$prompt" ]] && exit 1

full_prompt=$(echo "$pre_prompt $prompt" | tr -d '\n')

if ! response=$(gum spin --title="Thinking..." -- \
    curl "$OLLAMA_URL/api/generate" \
    --silent --request POST \
    --header "Content-Type: application/json" \
    --data "{
        \"model\": \"$CHAT_MODEL\",
        \"prompt\": \"$full_prompt\",
        \"stream\": false
    }"); then

    echo "failed to send request: $response" && exit 1
fi

echo "$response" | jq -r '.response' | glow
