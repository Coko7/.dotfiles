#!/usr/bin/env bash

TOPICS="${1:-cli}"
LANGS="${2:-rust,go,zig}"

# --topic=cli,thermal \
# --language=rust \

NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
WEEK=$(date -u -d '7 days ago' +%Y-%m-%dT%H:%M:%SZ)
MONTH=$(date -u -d '30 days ago' +%Y-%m-%dT%H:%M:%SZ)
YEAR=$(date -u -d '365 days ago' +%Y-%m-%dT%H:%M:%SZ)

# --language=rust,go,zig

gh search repos \
  --topic="$TOPICS" \
  --language="$LANGS" \
  --sort=stars \
  --order=desc \
  --json fullName,description,pushedAt,stargazersCount,forksCount \
  --template "
{{tablerow \"NAME\" \"DESCRIPTION\" \"LAST PUSH\" \"STARS\" \"FORKS\"}}
{{range .}}
  {{- \$desc := .description -}}
  {{- if gt (len \$desc) 100 -}}
    {{- \$desc = printf \"%.100s…\" \$desc -}}
  {{- end -}}

  {{- \$p := .pushedAt -}}

  {{- if ge \$p \"$WEEK\" -}}
    {{- \$p = color \"green\" \$p -}}
  {{- else if ge \$p \"$MONTH\" -}}
    {{- \$p = color \"blue\" \$p -}}
  {{- else if ge \$p \"$YEAR\" -}}
    {{- \$p = color \"yellow\" \$p -}}
  {{- else -}}
    {{- \$p = color \"red\" \$p -}}
  {{- end -}}

  {{tablerow .fullName \$desc \$p .stargazersCount .forksCount}}
{{end}}
{{tablerender}}
"

echo 'Searched with:' | gum style --foreground=212 --underline

echo -n "  - topics: "
echo "$TOPICS" | gum style --foreground=177 --bold

echo -n "  - langs: "
echo "$LANGS" | gum style --foreground=177 --bold
