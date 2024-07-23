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
fish_add_path /opt/homebrew/bin/
fish_add_path $HOME/.rye/shims

# }}}

# =============================================================================
# alias {{{
# =============================================================================
alias vim '$EDITOR'
function ls
    eza --icons $argv
end
alias ll 'ls -l -g'
alias la 'ls -l -g -a'

alias ds 'cd $HOME/Documents/Projects'
alias nvc 'cd $HOME/.config/nvim'
alias fc '$EDITOR $HOME/.config/fish/config.fish'
alias tc '$EDITOR $HOME/.config/tmux/tmux.conf'
alias sc '$EDITOR $HOME/.config/starship/starship.toml'

# }}}

# =============================================================================
# fzf
# =============================================================================
set -g FZF_DEFAULT_COMMAND 'fd --type file --color=always --follow --hidden'
set -g FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

fzf --fish | source

# }}}

# =============================================================================
# starship prompt {{{
# =============================================================================
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml

starship init fish | source

# }}}
