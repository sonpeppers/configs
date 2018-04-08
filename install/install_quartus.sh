#!/bin/bash

source "$(pwd)/install_utils.sh"

display_install quartus
echo_and_run sudo apt-get install vim


echo_and_run wget http://download.altera.com/akdlm/software/acdsinst/17.1std/590/ib_tar/Quartus-lite-17.1.0.590-linux.tar
echo_and_run tar -xvf -C ~/devel
echo_and_run_silent rm Quartus-lite-17.1.0.590-linux.tar
