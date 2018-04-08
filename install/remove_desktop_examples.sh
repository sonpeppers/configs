#!/bin/bash

source "$(pwd)/install_utils.sh"

display_remove 'examples.desktop'
echo_and_run_silent rm ~/examples.desktop
