# =============================================================================
# setting {{{
# =============================================================================
set fish_greeting ""
set -gx EDITOR nvim
set -g fish_key_bindings fish_vi_key_bindings

set -x LC_ALL 'en_US.UTF-8'
set -x LANG 'en_US.UTF-8'


# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 364A82
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

# }}}

# =============================================================================
# path {{{
# =============================================================================
fish_add_path /usr/local/opt/curl/bin
fish_add_path $HOME/.cargo/bin

# }}}

# =============================================================================
# alias {{{
# =============================================================================
alias p python
alias vi '$EDITOR'
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
fish_add_path $HOME/.pyenv
fish_add_path $HOME/.pyenv/bin
pyenv init - | source

# }}}

# =============================================================================
# pipx {{{
# =============================================================================
fish_add_path $HOME/.local/bin
# }}}

# =============================================================================
# starship prompt {{{
# =============================================================================
starship init fish | source
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml

# }}}
