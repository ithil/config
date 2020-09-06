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

# Environment Variables
export CLICOLOR
export LESS=R
export PAGER=vimpager
export EDITOR="/usr/bin/vim"
export VIMPAGER_RC=$HOME/.backdoor/config/vimpagerrc
export ZSH_BMS=$HOME/.zsh_bookmarks
export PATH="$PATH:/usr/local/Cellar/ruby/2.1.2/bin"

fpath=(/usr/local/share/zsh-completions $fpath)

setopt HIST_IGNORE_SPACE
setopt promptsubst

autoload -U colors && colors
# Prompt-related stuff
autoload -U promptinit
promptinit

function precmd
{
    if [[ -d ./.git ]] then
        IS_GIT=0
    else
        IS_GIT=1
    fi

    if [[ $IS_GIT -eq 0 ]] then
        PROMPTCHAR='±'
        if ! git diff-index --quiet HEAD
        then
            GIT_CHANGED='*'
        else
            GIT_CHANGED=''
        fi
        branch_name=$(git symbolic-ref -q HEAD)
        branch_name=${branch_name##refs/heads/}
        branch_name=${branch_name:-HEAD}
        RPROMPT="[%{$fg[green]%}$branch_name%{$reset_color%}]"
    else
        PROMPTCHAR='%%'
        GIT_CHANGED=''
        RPROMPT=''
    fi
}

PROMPT='%(1j.%{$fg[red]%}{%{$reset_color%}%j%{$fg[red]%}}%{$reset_color%}.) %{$fg[magenta]%}%?%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%}%{$fg[yellow]%}${GIT_CHANGED}%{$reset_color%} ${PROMPTCHAR} '

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
alias vim='/usr/bin/vim'
alias love='/Users/janus/Applications/love.app/Contents/MacOS/love'
alias nwjs="/Applications/nwjs.app/Contents/MacOS/nwjs"
alias myip='curl -s http://wtfismyip.com/text'
alias timestamp='exiftool "-filename<CreateDate" -d %Y-%m-%d_%H-%M-%S%%-c.%%le -r'
function cped() # Clipboard editor
{
    PASTEPATH=/tmp/paste.txt
    pbpaste >$PASTEPATH
    $EDITOR $PASTEPATH
    pbcopy <$PASTEPATH
}
function curtab()
{
    osascript -e '
    tell application "Google Chrome"
        get URL of active tab of first window as text
    end tell'
}
alias -g T='`curtab`'
alias -g P='`pbpaste`'
alias -g C='|pbcopy'
alias -g CIP='`myip`'

function extract-domain()
{
    [[ $1 =~ 'https?://([^/:]+)' ]]
    echo $match
}
alias -g Td='`extract-domain T`'

function get-finder-selection()
{
    applescript='tell application "Finder" to set theSelection to (selection) as alias list
        set myFiles to ""
        repeat with i from 1 to length of theSelection
            if (i < length of theSelection) then
                set myFiles to myFiles & POSIX path of (item i of the theSelection) & "\n"
            else
                set myFiles to myFiles & POSIX path of (item i of the theSelection)
            end if
        end repeat'

    echo "$( osascript -e $applescript )"
    #echo ${(q)${(z)files[@]}}
}
function get-finder-directory()
{
    osascript -e '
    tell application "Finder" to POSIX path of (insertion location as alias)
    '
}
alias -g Fs="get-finder-selection | gxargs -d '\n'"
alias -g Fd='"$(get-finder-directory)"'

function bm()
{
    hash -d $1="$PWD"
    echo "hash -d $1=\"$PWD\"" >> $ZSH_BMS
}
function bmrm()
{
    hash -dr #Clears dir hash table
    grep -v $PWD $ZSH_BMS > /tmp/zsh_bookmarks
    mv /tmp/zsh_bookmarks $ZSH_BMS
    source $ZSH_BMS
}
source $ZSH_BMS


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

# Quotes insertion shortcuts
insert-single-quotes () {
    LBUFFER+="''"
    zle backward-char
}
insert-double-quotes () {
    LBUFFER+='""'
    zle backward-char
}

zle -N insert-single-quotes
zle -N insert-double-quotes
bindkey '^y' insert-single-quotes
bindkey '^x' insert-double-quotes

# Edit command line with $EDITOR
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Toggle background jobs
background-toggle() {fg}
zle -N background-toggle
bindkey '^Z' background-toggle

# Command line syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
