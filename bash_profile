export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export EDITOR="/usr/bin/vim"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/.cargo/bin
export PS1='\w$ '
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

eval $(thefuck --alias)

#tab to rotate through options
bind '"\t":menu-complete'

#custom alias
alias killwifi='sudo service network-manager restart'
alias killglide='rm -rf ~/.glide ; rm -rf vendor ; rm glide.lock'
alias killswp='find . -name "*.swp" -type f -delete'
alias gitcommits='git log --oneline -n 20'
alias githash='git rev-parse --short HEAD ; git rev-parse HEAD'
alias gitrevert='git reset HEAD --hard ; git clean -fd ; git checkout -- .'
alias gitsquash='git rebase -i HEAD~20'
alias gitsquash2='git add -u ; git commit -m "int" ; git reset --soft HEAD~2 && git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"'
alias gitr='cd $GOPATH/src/github.com/rigelrozanski'
alias gitt='cd $GOPATH/src/github.com/tendermint'
alias gitc='cd $GOPATH/src/github.com/cosmos'
alias edvim='cd $GOPATH/src/github.com/rigelrozanski/dotfiles ; vim vimrc'
alias edbash='cd $GOPATH/src/github.com/rigelrozanski/dotfiles ; vim bash_profile'
alias vimo='vim -c "O"'
alias vimn='vim -c "NERDTreeToggle"'
alias vimr='vim -S .session.vim'
alias vimtest='vim -c "Test"'
alias viminstall='vim -c "Install"'
alias fuck='fuck -y'

#git branch auto-completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

function _makefile_targets {
    local curr_arg;
    local targets;

    # Find makefile targets available in the current directory
    targets=''
    if [[ -e "$(pwd)/Makefile" ]]; then
        targets=$( \
            grep -oE '^[a-zA-Z0-9_-]+:' Makefile \
            | sed 's/://' \
            | tr '\n' ' ' \
        )
    fi

    # Filter targets based on user input to the bash completion
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${targets[@]}" -- $curr_arg ) );
}
complete -F _makefile_targets make
