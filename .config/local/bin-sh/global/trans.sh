#!/usr/bin/env bash

text=$(gum input --prompt="Text> " --placeholder="Type text to translate...")
trans --brief :fr "$text"
