# Global, eXported. similar to `export VAR=val`
set -gx PATH "$PATH:/usr/lib/ccache/bin/:/home/user/.local/bin/"
set -gx EDITOR nvim
set -gx BROWSER librewolf
set -gx CM_LAUNCHER rofi

if status is-interactive
    # Commands to run in interactive sessions can go here
    pf
end

function rangercd
    set -l tmp $(mktemp)
    ranger --choosedir=$tmp $argv
    if test -f $tmp
        set -l dest (cat $tmp)
        rm -f "$tmp"
        if test -d $dest
            cd "$dest"
        end
    end
end

