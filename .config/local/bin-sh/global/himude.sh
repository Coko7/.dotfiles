#!/usr/bin/env bash

function main() {
    mode=$(gum choose "Encrypt" "Decrypt" "Peek")
    if [ -z "$mode" ]; then
        exit 1
    fi

    case $mode in
        Encrypt) encrypt ;;
        Decrypt) decrypt ;;
        Peek) peek ;;
        *)
            echo "himude: error: unknown option '$mode'" >&2
            exit 1 ;;
    esac
}

function encrypt() {
    dirs=$(find . -maxdepth 1 -type d ! -name . -printf '%P/\n')
    if [ -z "$dirs" ]; then
        echo "himude: no suitable directory for encryption here" >&2
        exit 1
    fi

    in_dir=$(echo "$dirs" | gum choose) || exit 1
    passwd=$(gum input --password --prompt="Passphrase> ") || exit 1
    confirm_passwd=$(gum input --password --prompt="Confirm passphrase> ") || exit 1

    if [ "$passwd" != "$confirm_passwd" ]; then
        echo "himude: error: passphrases do not match!" >&2
        exit 1
    fi

    out_file=$(gum input --prompt="Encrypted filename> " --value "secret.gpg")
    if [ -z "$out_file" ]; then
        exit 1
    fi

    if [ -f "$out_file" ]; then
        echo "himude: error: file already exists: $out_file" >&2
        exit 1
    fi

    gum spin --title="Encrypting $in_dir..." -- gpgtar --encrypt --symmetric --output $out_file --gpg-args "--cipher-algo AES-256 --passphrase=\"$passwd\" --batch" $in_dir
    if [ $? -ne 0 ]; then
        echo "himude: error: failed to encrypt" >&2
        exit 1
    fi

    rm -rf "$in_dir"
    echo "himude: successfully encrypted $in_dir into $out_file"
}

function decrypt() {
    candidates=$(find . -maxdepth 1 -type f -name "*.gpg")
    if [ -z "$candidates" ]; then
        echo "himude: no suitable file to decrypt here" >&2
        exit 1
    fi

    in_file=$(echo "$candidates" | gum choose) || exit 1
    passwd=$(gum input --password --prompt="Passphrase> ")
    if [ -z "$passwd" ]; then
        exit 1
    fi

    gum spin --title "Decrypting $in_file..." -- gpgtar --decrypt --directory ./ --gpg-args "--cipher-algo AES-256 --passphrase=\"$passwd\" --batch" $in_file
    if [ $? -ne 0 ]; then
        echo "himude: error: failed to decrypt" >&2
        exit 1
    fi

    rm "$in_file"
    echo "himude: successfully decrypted $in_file into current dir"
}

function peek() {
    files=$(find . -maxdepth 1 -type f)
    if [ -z "$files" ]; then
        echo "himude: no suitable file to peek at, here" >&2
        exit 1
    fi

    in_file=$(echo "$files" | gum choose) || exit 1
    passwd=$(gum input --password --prompt="Passphrase> ") || exit 1

    gum spin --show-output -- gpgtar --list-archive --gpg-args "--passphrase=\"$passwd\" --batch" "$in_file"
}

main "$@"; exit
