# configures my personal settings on my current version of Ubuntu
# only run once (preferably on a clean machine)
STARTING_DIR=$(pwd)
WORKING_DIR="$STARTING_DIR/.configureScripts"

# copy into /usr/bin scripts and make globally available
sudo cp "$STARTING_DIR/usrbin/*" /usr/bin
exec bash

# Check for internet connection

