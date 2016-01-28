# vim: foldmethod=marker foldenable

# VARIABLES {{{1
# Environment variables {{{
set -x OS (uname -s)
set -x EDITOR nvim
set -x NVIM_TUI_ENABLE_CURSOR_SHAPE 1
set -x SXHKD_SHELL /bin/bash
set -x NVIM_TUI_ENABLE_TRUE_COLOR 1

if test $OS = "Darwin"
  set PATH    $HOME/.local/bin $HOME/.cabal/bin /usr/local/opt/coreutils/libexec/gnubin $PATH
  set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
  # if test $TERM_PROGRAM = "iTerm.app"
  #   set -x NVIM_TUI_ENABLE_TRUE_COLOR 1
  # end
end
# }}}
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
# General {{{
alias ll     "ls -l"
alias V      "nvim +V"
alias emacs  "emacs -nw"
alias E      "emacs ~/.spacemacs"
alias ghc    "ghc -Wall -Werror"
alias less   "less -FSRX"
alias tmux   "tmux -2"
alias npmls  "npm ls --depth=0"
alias reload "source $HOME/.config/fish/config.fish"
# }}}
# Android {{{
alias adb      "$HOME/android/adb"
alias fastboot "$HOME/android/fastboot"
# }}}
# OS X only {{{
if test $OS = "Darwin"
  alias cask "brew cask"
  alias love "/Applications/love.app/Contents/MacOS/love"
end
# }}}
# Linux only {{{
if test $OS = "Linux"
  alias ip "ip --color"
  alias sysls "systemctl list-unit-files"
  alias reflector-update "sudo reflector --fastest 100 --age 48 --sort 'rate' --save /etc/pacman.d/mirrorlist --threads 10"
end
# }}}


# FUNCTIONS {{{1
# OS X only {{{
if test $OS = "Darwin"
  function pman -d "Open man page in Preview.app" # {{{
    man -t $argv[1] | open -fa Preview.app
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
  function iso2img -d "Convert an ISO to an IMG" # {{{
    for iso in $argv
      hdiutil convert -format UDRW -o "$iso.img" "$iso"
      mv "$iso.img.dmg" "$iso.img"
      mv "$iso.img" (echo "$iso.img" | sed 's/\.iso//')
    end
  end # }}}
end
# }}}
# Linux only {{{
if test $OS = "Linux"
  function explicit -d "List explicitly installed" # {{{
    # By default excludes `base` and `base-devel` groups
    bash -c "comm -23 <(pacman -Qeq | sort | uniq) <(pacman -Qgq base base-devel $argv | sort | uniq) | column | less"
  end # }}}
  function battery -d "Show status of both batteries" # {{{
    echo "INTERNAL BATTERY:"
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|percentage" | sed 's/     //'
    echo
    echo "REMOVABLE BATTERY:"
    upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "state|to\ full|percentage" | sed 's/     //'
  end # }}}
end
# }}}
# Universal {{{
function rc -d "Open the specified program's configuration file" # {{{
  if test (count $argv) -gt 0
    switch $argv[1]
      # Editors
      case vim v
        eval $EDITOR $HOME/.vimrc
      case neovim nvim n
        eval $EDITOR $HOME/.config/nvim/init.vim

      # Shells
      case zsh z
        eval $EDITOR $HOME/.zshrc
      case fish f
        eval $EDITOR $HOME/.config/fish/config.fish

      # Linux
      case xorg x11 x
        eval $EDITOR $HOME/.xinitrc
      case xresources xre re
        eval $EDITOR $HOME/.config/Xresources
      case xmodmap xmod mod map
        eval $EDITOR $HOME/.config/Xmodmap
      case bspwm bsp b
        eval $EDITOR $HOME/.config/bspwm/bspwmrc
      case sxhkd sx s
        eval $EDITOR $HOME/.config/sxhkd/sxhkdrc
      case lemonbar bar
        eval $EDITOR $HOME/.config/bar.sh
      case compton comp
        eval $EDITOR $HOME/.config/compton.conf

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
function update -d "Run update commands" # {{{
  if test $OS = "Darwin"
    echo "--- Updating Homebrew packages..."
    brew update; and brew upgrade --all
  end

  if test $OS = "Linux"
    sudo pacman -Syu
    sudo aura -Aau
  end

  echo "--- Updating Fish completions..."
  fish_update_completions

  echo "--- Updating Vim plugins..."
  nvim +PlugUpgrade +PlugClean! +PlugUpdate +qa
  echo "--- Updates complete!"
end # }}}
# }}}


# PROMPT {{{1
function fish_prompt
  # Prompt char
  if git rev-parse > /dev/null 2>/dev/null
    set prompt_char '± '
  else
    set prompt_char '$ '
  end

  set time (date "+%l:%M:%S" | sed "s/ //")
  set git_branch (git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  # NOT WORKING
  # if test $status != 0
  #   set_color red
  #   echo -n "["
  #   echo -n $status
  #   echo -n "] "
  # end
  # set_color magenta; and echo -n $USER
  # set_color normal; and echo -n " on "
  # set_color blue; and echo -n (hostname)
  # set_color normal; and echo -n " in "
  # set_color white; and echo -n "$time "
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
