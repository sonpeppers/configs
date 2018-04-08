#!/bin/bash

source "$(pwd)/install_utils.sh"

display_install vim
echo_and_run sudo apt-get install git

# TODO Move around .gitconfig and etc.
