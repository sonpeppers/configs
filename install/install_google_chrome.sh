#!/bin/bash

source "$(pwd)/install_utils.sh"

cmds=(
	'wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
	'sudo dpkg -i google-chrome-stable_current_amd64.deb || (sudo apt -f install -y && sudo dpkg -i google-chrome-stable_current_amd64.deb)'
	'rm -f google-chrome-stable_current_amd64.deb'
)
display_install Google Chrome
echo_and_run_all "${cmds[@]}"

display_alias goo Google Chrome
echo_and_run sudo cp aliases/goo /usr/local/bin/goo
