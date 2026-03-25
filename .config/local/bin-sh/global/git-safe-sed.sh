#!/usr/bin/env bash

COL_RESET='\e[0m'
FG_RED='\e[0;31m'

[[ -z "$1" ]] && echo "error: expects <search> string" && exit 1
[[ -z "$2" ]] && echo "error: expects <replace> string" && exit 1

occurences=$(rg --only-matching "$1" | wc --lines)
[[ "$occurences" -eq 0 ]] && { echo "no match found. Exiting..."; exit 1; }

batgrep "$1"
echo -e "You are about to sed ${FG_RED}$occurences${COL_RESET} references (maybe less)"

if ! gum confirm "Sure you wanna do this?" \
    --default=false --affirmative="yes" \
    --negative="nah"; then
    echo "Good call."
    exit 0
fi

if ! gum confirm "Yo, are you REALLY, REALLY SURE though??" \
    --default=false --affirmative="BURN EVERYTHING 🔥🔥🔥" \
    --negative="nvm, let's stop 🏃"; then
    echo "Yeah, maybe it's better that way."
    exit 0
fi

echo "Okay bud, you are on your own now o7"; sleep 2s;
echo "I hoped you backed up your git directory 💀"; sleep 2s;

gum spin --title="☢️ Ungoing fd|sd. Let's pray 🙏" -- fd --type f \
    --exclude '.git' --exclude 'bin' --exclude 'obj' \
    -e 'cs' -e 'py' -e 'cshtml' -e 'resx' \
    -e 'config' -e 'json' -e 'csproj' -e 'xml' \
    -e 'js' -e 'razor' -e 'sql' -e 'pyd' -e 'txt' \
    -e 'css' -e 'html' -e 'yaml' -e 'ps1' -e 'settings' \
    -e 'pubxml' -e 'less' -e 'yml' -e 'sln' -e 'slnf' \
    --exec sd "$1" "$2" {}

# fd -e cs -e yp --exclude .git --exclude bin --exclude obj -x sed -i 's/Core.Auth/Foobar/g' {}
# find . -path './.git' -prune -o -type f -exec sed -i 's/Core.Auth/Foobar/g' {} +
