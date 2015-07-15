# vim: foldmethod=marker foldenable

# INIT {{{1
# http://www.iterm2.com/shell_integration.html
if test -e $HOME/.iterm2_shell_integration.fish
  source $HOME/.iterm2_shell_integration.fish
end

# https://github.com/sjl/z-fish
if test -e $HOME/.config/fish/z.fish
  . $HOME/.config/fish/z.fish
end

# VARIABLES {{{1
set PATH $HOME/.local/bin $HOME/.cabal/bin $PATH
set -x OS (uname -s)
set -x EDITOR nvim
set -x NVIM_TUI_ENABLE_CURSOR_SHAPE 1

# Colors {{{
set fish_color_autosuggestion '-o' 'black'
set fish_color_command green
set fish_color_comment '-o' 'black'
set fish_color_cwd '-o' 'black'
set fish_color_cwd_root red
set fish_color_end normal
set fish_color_error red
set fish_color_escape cyan
set fish_color_history_current cyan
set fish_color_host '-o' 'cyan'
set fish_color_match cyan
set fish_color_normal normal
set fish_color_operator normal
set fish_color_param normal
set fish_color_quote yellow
set fish_color_redirection blue
set fish_color_search_match --background=magenta
set fish_color_status red
set fish_color_user green
set fish_color_valid_path --underline
# }}}

if test $OS = "Darwin"
  set -x NVIM_TUI_ENABLE_TRUE_COLOR 1
end


# ALIASES & FUNCTIONS {{{1
alias V "vim +V"
alias vim "nvim"
alias ghc "ghc -Wall -Werror"
alias less "less -FSRX"
alias tmux "tmux -2"
alias cask "brew cask"
alias npmls "npm ls --depth=0"
alias pls "sudo $history[1]"
alias reload "source $HOME/.config/fish/config.fish"

function rc -d "Open the specified program's configuration file" # {{{
  switch $argv[1]
    # Editors
    case vim vi v
      eval $EDITOR $HOME/.vimrc
    case neovim nvim n
      eval $EDITOR $HOME/.nvimrc

    # Shells
    case zsh z
      eval $EDITOR $HOME/.zshrc
    case fish f
      eval $EDITOR $HOME/.config/fish/config.fish

    case '*'
      echo Not defined: $argv
  end
end # }}}

function ls -d "List files in the current directory" # {{{
  if test $OS = "Darwin"
    command ls -AFGh $argv
  else if test $OS = "Linux"
    command ls -AFph --group-directories-first --color=always $argv
  else
    command ls $argv
  end
end # }}}

function files -d "Toggle visibility of hidden files in Finder" # {{{
  if test (count $argv) -gt 0
    switch $argv[1]
      case show
        echo Showing hidden files
        defaults write com.apple.Finder AppleShowAllFiles true
      case hide
        echo Hiding hidden files
        defaults write com.apple.Finder AppleShowAllFiles false
      case '*'
        echo Invalid argument
    end
    killall Finder
  else
    echo No arguments
  end

end # }}}

function trash -d "Move a specified file to the Trash" # {{{
  if test (count $argv) -gt 0
    set -l trash_dir "$HOME/.Trash"
    for item in $argv
      if test -e $item
        set -l item_name (basename $item)
        if test -e "$trash_dir/$item_name"
          set -l current_time (date "+%H.%M.%S")
          mv -f "$item" "$trash_dir/$item_name $current_time"
        else
          mv -f "$item" "$trash_dir/"
        end
      end
    end
  else
    echo "No file(s) given to delete"
  end
end # }}}

function update -d "Run update commands" # {{{
  echo --- Updating Homebrew...
  brew update

  echo --- Updating fish completions
  fish_update_completions

  echo --- Updating Vim plugins...
  vim +PlugUpgrade +PlugClean! +PlugUpdate +qa
  echo --- Updates complete!
end # }}}


# PROMPT {{{1
function fish_prompt
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color yellow
  __fish_git_prompt
  set_color normal
  echo -n ' λ '
  z --add "$PWD"
end

# Disable greeting
set fish_greeting



