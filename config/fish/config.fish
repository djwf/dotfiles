# vim: foldmethod=marker foldenable

# VARIABLES {{{1
set -x OS (uname -s)
set -x EDITOR nvim
set -x NVIM_TUI_ENABLE_CURSOR_SHAPE 1

if test $OS = "Darwin"
  set PATH    $HOME/.local/bin $HOME/.cabal/bin /usr/local/opt/coreutils/libexec/gnubin $PATH
  set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
  # if test $TERM_PROGRAM = "iTerm.app"
  #   set -x NVIM_TUI_ENABLE_TRUE_COLOR 1
  # end
end

# Colors {{{
set fish_color_autosuggestion  '-o' 'black'
set fish_color_command         green
set fish_color_comment         '-o' 'black'
set fish_color_cwd             '-o' 'black'
set fish_color_cwd_root        red
set fish_color_end             normal
set fish_color_error           red
set fish_color_escape          cyan
set fish_color_history_current cyan
set fish_color_host            '-o' 'cyan'
set fish_color_match           cyan
set fish_color_normal          normal
set fish_color_operator        normal
set fish_color_param           normal
set fish_color_quote           yellow
set fish_color_redirection     blue
set fish_color_search_match    --background=magenta
set fish_color_status          red
set fish_color_user            green
set fish_color_valid_path      --underline
# }}}


# ALIASES {{{1
alias ll     "ls -l"
alias V      "vim +V"
alias vim    "nvim"
alias ghc    "ghc -Wall -Werror"
alias less   "less -FSRX"
alias tmux   "tmux -2"
alias cask   "brew cask"
alias npmls  "npm ls --depth=0"
alias pls    "sudo $history[1]"
alias reload "source $HOME/.config/fish/config.fish"

# Android
alias adb      "$HOME/android/adb"
alias fastboot "$HOME/android/fastboot"

# Misc
alias love "/Applications/love.app/Contents/MacOS/love"


# FUNCTIONS {{{1
function iso2img -d "Convert an ISO to an IMG" # {{{
  for iso in $argv
    hdiutil convert -format UDRW -o "$iso.img" "$iso"
    mv "$iso.img.dmg" "$iso.img"
    mv "$iso.img" (echo "$iso.img" | sed 's/\.iso//')
  end
end # }}}

function rc -d "Open the specified program's configuration file" # {{{
  if test (count $argv) -gt 0
    switch $argv[1]
      # Editors
      case vim vi v
        eval $EDITOR $HOME/.vimrc
      case neovim nvim n
        eval $EDITOR $HOME/.config/nvim/init.vim

      # Shells
      case zsh z
        eval $EDITOR $HOME/.zshrc
      case fish f
        eval $EDITOR $HOME/.config/fish/config.fish

      case '*'
        echo Not defined: $argv
    end
  else
    echo No argument
  end
end # }}}

function ls -d "List files in the current directory" # {{{
  if test $OS = "Darwin"
    command ls -AFGh --color $argv
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
  echo "--- Updating Homebrew..."
  brew update; and brew upgrade --all

  echo "--- Updating fish completions"
  fish_update_completions

  echo "--- Updating Vim plugins..."
  vim +PlugUpgrade +PlugClean! +PlugUpdate +qa
  echo "--- Updates complete!"
end # }}}

function cpp-compile -d "Compile all .cpp files in the current directory" # {{{
  set -l cppFiles

  echo "--- Compiling:"
  for file in (ls *.cpp)
    echo -n "$file "
    set cppFiles $file $cppFiles
  end
  echo

  g++ $cppFiles -o run
end # }}}

function cpp-run -d "Compile and run all .cpp files in the current directory" # {{{
  cpp-compile $argv
  echo "--- Running:"
  clear
  ./run
end # }}}

# PROMPT {{{1
function fish_prompt
  # Prompt char
  if git rev-parse > /dev/null 2>/dev/null
    set prompt_char '± '
  else
    set prompt_char '$ '
  end

  set git_branch (git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  # NOT WORKING
  # if test $status != 0
  #   set_color red
  #   echo -n "["
  #   echo -n $status
  #   echo -n "] "
  # end
  set_color magenta; and echo -n $USER
  # set_color normal; and echo -n " on "
  # set_color blue; and echo -n (hostname)
  set_color normal; and echo -n " in "
  set_color green; and echo -n (pwd | sed "s $HOME ~ ")
  if git branch >/dev/null 2>/dev/null
    set_color normal; and echo -n " in "
    # set_color yellow; and echo -n "git:"
    set_color yellow; and echo -n $git_branch
  end
  set_color normal; and echo -n \n$prompt_char
end

# Disable greeting
set fish_greeting
