#!/bin/bash

source "$(pwd)/install_utils.sh"

display_install vim
echo_and_run sudo apt-get install vim
