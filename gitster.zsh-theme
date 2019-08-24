local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

#function git_prompt_info() {
#  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX$(parse_git_dirty)"
#}

function get_pwd(){
  git_root=$PWD

  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done

  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${git_root#$parent/}
  fi
  echo $prompt_short_dir
}

function get_git_subdir(){
  # get_pwd
  git_root=$PWD

  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done

  # SubDirPath
  if [[ $git_root = / ]]; then
    git_subdir=''
  else
    git_subdir="${PWD#$git_root}"
    [[ -n "${git_subdir}" ]] && git_subdir=" ${git_subdir#/}/"
  fi
  echo $git_subdir
}

PROMPT='$ret_status %{$fg[blue]%}$(get_pwd)$(git_prompt_info)$(get_git_subdir)%{$reset_color%}%{$reset_color%} $ '

# Override local method with bult-in ZSH vars
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%} git(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"
