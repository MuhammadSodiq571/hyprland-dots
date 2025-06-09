# Change shell's directory to last directory from console file manager

# function lfcd
#     cd "$(command lf -print-last-dir "$argv")"
# end

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
