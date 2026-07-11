function wrfe() {
    if [ -z "$1" ]; then
        echo "wrfe: expects arguments"
        return 1
    fi
    query=$(url.sh --encode "$@")
    $BROWSER "https://www.wordreference.com/fren/$query";
}

function wref() {
    if [ -z "$1" ]; then
        echo "wref: expects arguments"
        return 1
    fi
    query=$(url.sh --encode "$@")
    $BROWSER "https://www.wordreference.com/enfr/$query";
}
