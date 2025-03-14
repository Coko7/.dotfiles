#!/usr/bin/env bash

paragraphs=5
if [ -z "$1" ]; then
    paragraphs=$1
fi

curl -s "http://loripsum.net/api/$paragraphs/paragraphs/medium"
