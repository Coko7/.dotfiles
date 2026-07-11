function copy_commandline_to_clipboard
    set --local buf (commandline --current-buffer)

    if test -n "$buf"
        commandline |
            wl-copy --trim-newline &&
            ntfy-toast.sh 'fish shell' '✅ Copied command line to clipboard' fish_shell.png
    end
end
