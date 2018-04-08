#!/bin/bash

source "$(pwd)/colors.sh"
source "$(pwd)/install_utils.sh"

echo "Commands to run after booting in"
echo ""

/bin/bash "$(pwd)/remove_desktop_examples.sh"
/bin/bash "$(pwd)/generate_ssh_key.sh"
/bin/bash "$(pwd)/install_vim.sh"
# /bin/bash "$(pwd)/install_google_chrome.sh"
# /bin/bash "$(pwd)/install_quartus.sh"

echo ""
echo -e "${LIGHT_GREEN}Success!${NC}"
