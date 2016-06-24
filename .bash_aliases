# visual formatting
alias ls='ls --color=auto'
alias lss='clear; ls'
alias mount='mount |column -t'
alias diff='colordiff'
alias df='df -H'

# convenience
alias aliases='vim ~/.bash_aliases'
alias restart='reboot'
alias ex='exec bash'
alias hist='history'
alias update='ex'
alias mkdir='mkdir -pv'
alias clock='date'
alias print='lp'

# functional
alias settings='unity-control-center'
alias system='settings'
alias battery='upower -d --dump | grep -E "to\ full|percentage"; upower -i `upower -e | grep "BAT"` | grep state'
alias touchpadon='synclient TouchpadOff=0'
alias touchpadoff='synclient TouchpadOff=1'

# network
alias test='sudo ping -c 5 -i 0.01 -q google.com'
alias ping='sudo ping -c 5 -i 0.01 -q'
alias shownetwork='echo "Available networks:"; iwlist wlan0 scan | grep "ESSID" | sort | uniq; echo "Connected networks:"; nmcli dev status'

# password no longer required
alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot now'
alias visudo='sudo visudo'
alias chmod='sudo chmod'
alias vim='sudo vim'
alias gvim='sudo gvim'

# miscellaneous
alias calculator='bc -l'
alias calc='calculator'
alias scriptify='cd /usr/local/bin; vim'
alias showscripts='ls /usr/local/bin'
alias gotoscripts='cd /usr/local/bin'

# /usr/local/bin/*
# anyconnect (cisco vpn)
# connect (nmcli)
# xconnect (iwconfig, xmonad fails on regular connect)
# setvolume_to
# mute
# unmute
# dim
# brighten
# open (use gnome-open)
