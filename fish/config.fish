# =============================================================================
# setting {{{
# =============================================================================
set fish_greeting ""
set -gx EDITOR nvim
fish_vi_key_bindings

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

# }}}

# =============================================================================
# fzf
# =============================================================================
# set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --ansi --preview-window=wrap --marker="*"'
# set -gx FZF_DEFAULT_COMMAND 'fd --type file --color always --follow --hidden'

# }}}

# =============================================================================
# pyenv {{{
# =============================================================================
# set -g PYENV $HOME/.pyenv
# set -gx PATH $PYENV/bin $PATH

pyenv init - | source

# }}}

# =============================================================================
# conda {{{
# =============================================================================
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/jarudatevorasee/.pyenv/versions/miniforge3-latest/bin/conda
    eval /Users/jarudatevorasee/.pyenv/versions/miniforge3-latest/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<

# }}}

# =============================================================================
# starship prompt {{{
# =============================================================================
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml

starship init fish | source

# }}}
