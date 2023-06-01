PROMPT='%{$fg[magenta]%}$(prompt_aws_vault)%{$reset_color%}%(!.%{$fg[red]%}.%{$fg[green]%})%~$(git_prompt_info)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"
