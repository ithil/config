# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/Users/janus/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==33=00}:${(s.:.)LS_COLORS}")';
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install

autoload -U colors && colors
# Prompt-related stuff
autoload -U promptinit
promptinit
PROMPT="%(1j.%{$fg[red]%}{%{$reset_color%}%j%{$fg[red]%}}%{$reset_color%}.) %{$fg[magenta]%}%?%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} %% "

# Aliases
alias ls='ls -G' #Enable colors
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lD='ls -d -- */' #Directories only
alias :q='exit'
alias ez='vim ~/.zshrc'
alias -g L='|less'
alias bd='cd ~/.backdoor'
function yalp()
{
    play $1 reverse
}

# Environment Variables
export CLICOLOR

fpath=(/usr/local/share/zsh-completions $fpath)

# Change cursor colour depending on vi mode
zle-keymap-select () {
if [ "$TERM" = "xterm" ]; then
if [ $KEYMAP = vicmd ]; then
echo -ne "\033]Plff0000\033\\" #red
    else
echo -ne "\033]Plffffff\033\\" #white
    fi
fi
}; zle -N zle-keymap-select
zle-line-init () {
  zle -K viins
  echo -ne "\033]Plffffff\033\\" #white
}; zle -N zle-line-init

# Command line syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
