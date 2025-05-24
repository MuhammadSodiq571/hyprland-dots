alias ls='lsd -1'
alias la='lsd -la'
alias clock='tty-clock -scC 4'
alias nf='fastfetch --config ~/.config/fastfetch/all.jsonc --logo-color-2 magenta'
alias ff='fastfetch'
alias pf='fastfetch --config ~/.config/fastfetch/2.jsonc'
alias enru='trans en:ru'
alias ruen='trans ru:en'
alias enuz='trans en:uz'
alias uzen='trans uz:en'
alias suspend='echo mem | doas tee /sys/power/state'

abbr -a pmi doas pacman -S
abbr -a pmr doas pacman -Rns
abbr -a dv doas vim
abbr -a dn doas nvim
abbr -a b btop
abbr -a c clear
abbr -a g git
abbr -a gcl git clone
abbr -a ga git add .
abbr -a gc git commit -m
abbr -a gp git push
abbr -a gpo git push origin
abbr -a gco git checkout
abbr -a gs git status
abbr -a gb git branch
abbr -a ... cd ../..
abbr -a .... cd ../../..

bind \co rangercd\n
bind \cy yazicd\n
