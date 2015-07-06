# Disable beeping
xset b off
xset b 0 0 0

# # Keybindings
# xcape
# xmodmap ~/.Xmodmap

# Speed up key repeat rate
xset r rate 200 27

# Visual tweaks
# compton -b
unclutter &
# redshift -l 33.415474:-117.584803 &

# Apply .Xresources
# xrdb -load ~/.Xresources

# Start the show
# urxvtd -q -f -o
# sxhkd &
# exec bspwm > /dev/null
exec gnome-session
