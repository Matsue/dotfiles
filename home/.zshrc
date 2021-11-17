# Flutter
export PATH=$PATH:~/work/flutter/flutter/bin

# Java
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Android
export PATH=$PATH:~/Library/Android/sdk/tools/bin

# gcloud
#source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
#source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH
alias npm-exec='PATH=node_modules/.bin:$PATH'

# go
export GOPATH=~/work/golang
export PATH=$PATH:$GOPATH/bin

########################################
# ref: https://gist.github.com/mollifier/4979906
# 環境変数
export LANG=ja_JP.UTF-8
#export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/opt/local/lib/android-sdk-mac_x86/tools
#export PATH=$PATH:/Applications/android-sdk-macosx/tools
export MANPATH=/opt/local/man:$MANPATH

#export PS1="\W\\$ "

#export PATH=$PATH:/usr/local/share/npm/bin

# To use brew libraries first
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# pyenv
#export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# less
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'
 
########################################
# alias
 
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias emacs='/usr/local/bin/emacs'
alias man='env LANG=C man'
alias jman='env LANG=ja_JP.UTF-8 man'

alias la='ls -a'
alias ll='ls -l'
 
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
 
alias mkdir='mkdir -p'

alias dc='docker-compose'
 
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

alias bex='bundle exec'
 
# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
#alias ls='ls -G'

# zsh-completion
fpath=(/usr/local/share/zsh-completions $fpath)

# 色を使用出来るようにする
autoload -Uz colors
colors
 
# emacs 風キーバインドにする
bindkey -e

# Enable backward-kill-word
bindkey "^[^H" run-help
bindkey "^[h" backward-kill-word
 
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
 
# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
#PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
#%# "
 
 
# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
 
########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit
 
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
 
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
 
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
 
 
########################################
# vcs_info
 
# https://medium.com/pareture/simplest-zsh-prompt-configs-for-git-branch-name-3d01602a6f33
# Enabling and setting git info var to be used in prompt config.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
# This line obtains information from the vcs.
zstyle ':vcs_info:git*' formats "- (%b) "
precmd() {
    vcs_info
}

# Enable substitution in the prompt.
setopt prompt_subst

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)] /"
}

# Config for the prompt. PS1 synonym.
prompt='%F{green}%2/ $(parse_git_branch)>%f '
 
 
########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
 
# beep を無効にする
setopt no_beep
 
# フローコントロールを無効にする
setopt no_flow_control
 
# '#' 以降をコメントとして扱う
setopt interactive_comments
 
# ディレクトリ名だけでcdする
setopt auto_cd
 
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
 
# = の後はパス名として補完する
setopt magic_equal_subst
 
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
 
# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu
 
# 高機能なワイルドカード展開を使用する
setopt extended_glob
 
########################################
# キーバインド
 
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
 
 
# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi
 
 
########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        ;;
esac
 
# vim:set ft=zsh:
