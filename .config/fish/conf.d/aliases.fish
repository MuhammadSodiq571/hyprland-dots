alias ls='lsd -1'
alias la='lsd -la'
alias clock='tty-clock -scC 3'
alias nf='fastfetch -c all'
alias ff='fastfetch'
alias pf='fastfetch -c ~/.config/fastfetch/2.jsonc'
alias enru='trans en:ru'
alias ruen='trans ru:en'
alias enuz='trans en:uz'
alias uzen='trans uz:en'
alias lsblk='sudo lsblk -fo NAME,FSTYPE,LABEL,FSAVAIL,FSUSE%,MOUNTPOINTS'

abbr -a pm pacman
abbr -a pms paru -S
abbr -a pmr paru -Rns
abbr -a pmq pacman -Qs
abbr -a grepi grep -i
abbr -a b btop
abbr -a c clear
abbr -a g git
abbr -a gcl git clone
abbr -a gr git remote
abbr -a ga git add .
abbr -a gc git commit -m
abbr -a gp git push
abbr -a gpl git pull
abbr -a gco git checkout
abbr -a gs git status
abbr -a gb git branch
abbr -a ... cd ../..

bind \co rangercd\n
