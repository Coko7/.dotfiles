function ezaic
    eza --icons=auto --group-directories-first $argv
end

function ls
    ezaic $argv
end

function l
    ezaic --long $argv
end

function lsd
    ezaic --treat-dirs-as-files */ $argv
end

function ll
    ezaic --all --long --classify=auto $argv
end

function lst
    ezaic --tree --no-permissions --no-filesize --no-user --no-time $argv
end

function lstg
    lst --git-ignore $argv
end

function lls
    ezaic --recurse --all --long --classify=auto --sort=modified $argv
end

function lld
    ezaic --all --long --classify=auto --treat-dirs-as-files */ $argv
end

function la
    ezaic --almost-all $argv
end
