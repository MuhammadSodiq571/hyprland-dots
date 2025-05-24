function fish_prompt
    set -g __last_command_exit_status $status

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
    if test $__last_command_exit_status != 0
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

    echo -n -s $arrow ' '$cwd $repo_info (set_color -o normal) ' '
end

function fish_right_prompt
    switch $__last_command_exit_status
        case 0
            echo ''
        case '*'
            set_color -o brred
            echo -n $__last_command_exit_status
            set_color -o normal
    end
end
