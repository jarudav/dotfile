# =============================================================================
# setting {{{
# =============================================================================
set fish_greeting ""
set -gx EDITOR nvim
set -g fish_key_bindings fish_vi_key_bindings

set -x LC_ALL 'en_US.UTF-8'
set -x LANG 'en_US.UTF-8'

# }}}

# =============================================================================
# path {{{
# =============================================================================

# }}}

# =============================================================================
# alias {{{
# =============================================================================
alias vim '$EDITOR'
function ls
    exa --icons $argv
end
alias ll 'ls --long --header'
alias la 'ls --long --header --all'

alias ds 'cd $HOME/Documents/Projects'
alias nvc 'cd $HOME/.config/nvim'
alias fc '$EDITOR $HOME/.config/fish/config.fish'
alias tc '$EDITOR $HOME/.config/tmux/tmux.conf'
alias sc '$EDITOR $HOME/.config/starship/starship.toml'
alias tl 'tmux ls'
function ta
    tmux attach-session -t $argv
end
function ts
    tmux new -s $argv
end
function tk
    tmux kill-session -t $argv
end

# }}}

# =============================================================================
# fzf
# =============================================================================
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --ansi --preview-window=wrap --marker="*"'
set -gx FZF_DEFAULT_COMMAND 'fd --type file --color always --follow --hidden'

function ff
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
end

# vim fzf
function vff
    set -l file (ff)
    if test "$file" = ""
        echo "no file selected"
    else
        vim $file
    end
end

# vim fzf python
function vfp
    set -l file (fd --type file --extension py --color always | ff)
    if test "$file" = ""
        echo "no file selected"
    else
        vim $file
    end
end

# }}}

# =============================================================================
# pyenv {{{
# =============================================================================
set -g PYENV $HOME/.pyenv
set -gx PATH $PYENV/bin $PATH

pyenv init - | source

# }}}


# =============================================================================
# starship prompt {{{
# =============================================================================
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml

starship init fish | source

# }}}
