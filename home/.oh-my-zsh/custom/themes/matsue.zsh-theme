local ruby_version=''
if which rbenv &> /dev/null; then
  ruby_version='<$(rbenv version | sed -e "s/ (set.*$//")>%{$reset_color%}'
fi
local git_info='$(git_prompt_info)$(git_prompt_status)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[255]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*]"
ZSH_THEME_GIT_PROMPT_CLEAN="]"

PROMPT="%{$FG[040]%}%n%{$reset_color%}%{$FG[239]%}%{$FG[001]%}${ruby_version}%{$reset_color%}%{$FG[239]%}%{$reset_color%}%{$terminfo[bold]$FG[226]%}%B%c%{$reset_color%}${git_info%} %# "
