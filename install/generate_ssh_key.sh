#!/bin/bash

source "$(pwd)/install_utils.sh"

display_generic "Generating ssh key"
echo_and_run "yes '' | ssh-keygen"
echo_and_run 'eval "$(ssh-agent -s)"'
echo_and_run 'ssh-add ~/.ssh/id_rsa'
