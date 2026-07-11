#!/usr/bin/env bash

OLLAMA_URL=$1
CHAT_MODEL=$2
PROMPT=$3

[[ -z "$OLLAMA_URL" ]] && echo "error: expects arg 1 to be ollama_url" && exit 1
[[ -z "$CHAT_MODEL" ]] && echo "error: expects arg 2 to be model" && exit 1
[[ -z "$PROMPT" ]] && echo "error: expects arg 3 to be prompt" && exit 1

curl "$OLLAMA_URL/api/generate" \
    --silent --request POST \
    --header "Content-Type: application/json" \
    --data "{
        \"model\": \"$CHAT_MODEL\",
        \"prompt\": \"$PROMPT\",
        \"stream\": false
    }"
