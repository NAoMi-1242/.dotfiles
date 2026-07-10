# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

. "$HOME/.local/bin/env"

eval "$(starship init zsh)"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=117,bold"
# export LS_COLORS="$LS_COLORS:ow=01;34:tw=01;44"

alias ls='lsd'
alias l='lsd -l --group-dirs=first'
alias ll='lsd -l --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias lla='lsd -al --group-dirs=first'
alias lt='lsd --tree --group-dirs=first'
alias bat='batcat'
alias imgcat='wezterm.exe imgcat'
alias nv='nvim'
alias ag='clear && agy'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by Antigravity CLI installer
export PATH="/home/naomi/.local/bin:$PATH"

snc() {
    # 引数はすべて無視し、常に単体で実体スクリプトを実行
    command snc
    local exit_status=$?

    # git pull がエラーなく正常終了した場合のみ、自動で source を実行
    if [ $exit_status -eq 0 ]; then
        echo "🔄 変更を適用するため、.zshrc を現在のターミナル環境に再読み込みしています..."
        source ~/.zshrc
        echo "✅ 設定の反映がすべて完了しました。"
    fi
}

ssh() {
    if [[ "$*" == *"shimakaze@"* ]]; then
        if command -v sshpass &> /dev/null; then
            if [ -z "$SHIMAKAZE_PASS" ]; then
                printf "Password for shimakaze: "
                read -rs SHIMAKAZE_PASS
                echo ""
            fi

            local check_res
            check_res=$(command ssh -o NumberOfPasswordPrompts=0 -o StrictHostKeyChecking=ask "$@" 2>&1)
            local exit_status=$?

            if [[ "$check_res" == *"Host key verification failed"* ]]; then
                echo "$check_res" >&2
                unset SHIMAKAZE_PASS
                return $exit_status
            fi

            if [[ "$check_res" == *"Authenticity of host"* ]]; then
                command ssh "$@"
                return $?
            fi

            sshpass -p "$SHIMAKAZE_PASS" ssh "$@"
            SSH_STATUS=$?

            if [ $SSH_STATUS -ne 0 ]; then
                echo "⚠️ 接続に失敗したため、記憶したパスワードをクリアしました。"
                unset SHIMAKAZE_PASS
            fi
        else
            echo "sshpass is not installed. Please run: sudo apt install sshpass"
            command ssh "$@"
        fi
    else
        command ssh "$@"
    fi
}

ssht() {
    local host="$1"
    local session="${2:-tokunaga-session}"

    if [ -z "$host" ]; then
        echo "Usage: ssht <host> [session_name]"
        return 1
    fi

    ssh -t "$host" "tmux new-session -A -s $session"
}
