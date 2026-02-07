source /usr/share/cachyos-fish-config/cachyos-config.fish
oh-my-posh init fish --config ~/.config/ohmyposh/theme.json | source
zoxide init fish | source
direnv hook fish | source

#Icat Alias
alias icat='kitty +kitten icat'
#Code runpy
alias runpy='python3 $argv'

function runpy
    python3 $argv
    read
end


# Substituir ls por eza
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'


# eza padrão definitivo
function ls
    command eza \
        --color=always \
        --long \
        --git \
        --icons=always \
        --no-time \
        --no-user \
        --no-permissions \
        $argv
end

# Preview padrão
set -gx FZF_DEFAULT_OPTS \
    --preview '~/.config/fzf/preview.sh' \
    --preview-window=right:60% \
    --color=border:#bcc0cc \
    --height=40% \
    --layout=reverse \
    --border \
    --color=preview-bg:#181926

# CTRL+T (arquivo/pasta)
set -gx SHOW_FILE_OR_DIR_PREVIEW '~/.config/fzf/preview.sh {}'
set -gx FZF_CTRL_T_OPTS "--preview \"$SHOW_FILE_OR_DIR_PREVIEW\""

# ALT+C (só diretórios)
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

# cd inteligente com fzf 
function cd 
    # cd normal se receber argumento 
    if test (count $argv) -gt 0 
        z $argv 
        return 
    end 
    # Se não passou argumento, usa fzf para escolher 
    set -l targets (zoxide query --list) 
    # Se não passou argumento, usa fzf para escolher 
    if test -z "$targets" 
        set targets (fd --type d --max-depth 1 --exclude .git --exclude .cache --exclude node_modules .) 
    end 
# Lista diretórios visíveis + alguns ocultos úteis 
set target (fd \ 
    --type d \ 
    --max-depth 1 \ 
    --exclude .git \ 
    --exclude .cache \ 
    --exclude node_modules \ 
    . | fzf --preview 'eza --tree --level=2 --color=always {} | head -200') 
    # se cancelou, sai 
    test -z "$target"; and return 
    # entra na pasta escolhida 
    builtin cd "$target" 
end


#zoxide no lugar de cd
#alias cd="z"
#zoxide init fish | source
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
# user scripts
set -Ua fish_user_paths $HOME/bin

