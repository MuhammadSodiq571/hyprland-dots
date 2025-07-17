function fish_prompt
    set -g __exit_status $status

    if not set -q -g __fish_arrow_functions_defined
        set -g __fish_arrow_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            not command git diff-index --cached --quiet HEAD -- &>/dev/null
            or not command git diff --no-ext-diff --quiet --exit-code &>/dev/null
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            set -l stat (hg status -mard 2>/dev/null)
            test -n "$stat"
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_hg_repo
                echo hg
                return 0
            else if _is_git_repo
                echo git
                return 0
            end
            return 1
        end
    end

    set -l arrow_color (set_color -o green)
    if test $__exit_status != 0
        set arrow_color (set_color -o red)
    end

    set -l arrow "$arrow_color➜ "
    if fish_is_root_user
        set arrow "$arrow_color# "
    end

    set -l cwd (set_color -o cyan)(prompt_pwd) #| path basename)

    set -l repo_info
    if set -l repo_type (_repo_type)
        set -l repo_branch (set_color -o red)(_repo_branch_name $repo_type)
        set repo_info "$(set_color -o blue) $repo_type:($repo_branch$(set_color -o blue))"

        if _is_repo_dirty $repo_type
            set -l dirty (set_color -o yellow)"✗"
            set repo_info "$repo_info $dirty"
        end
    end

    echo -n -s ' ' $cwd $repo_info '  ' $arrow (set_color -o normal)
end

function fish_right_prompt
    switch $__exit_status
        case 0
            echo ''
        case '*'
            set_color -o brred
            echo -n $__exit_status
            set_color -o normal
    end

    if test $CMD_DURATION
        if test $CMD_DURATION -gt 10000
            set -l duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
            set cmd (history | head -1)
            set -l excluded cfdisk fdisk iwctl nmtui nmcli nano vi vim nvim helix sudoedit htop btop top man history bat more less swaybg
            set -l maxlen 20

            for ex in $excluded
                if string match -rq "(^|\s)$ex(\s|\$)" -- $cmd
                    return
                end
            end

            if test (string length -- $cmd) -gt $maxlen
                set cmd (string sub -l $maxlen -- $cmd)"..."
            end

            switch $__exit_status
                case 0
                    notify-send -i dialog-information 'Command completed' (echo "$cmd\n$__exit_status after $duration")
                case '*'
                    notify-send -u critical -i dialog-error 'Command completed' (echo "$cmd\n$__exit_status after $duration")
            end
        end
    end
end

