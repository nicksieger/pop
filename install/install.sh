#!/usr/bin/env sh

echo "Calling remote pow uninstall script"
curl get.pow.cx/uninstall.sh | sh

if [ -f /etc/resolver/dev ];
then
  echo "Removing previous dns resolver file at /etc/resolver/dev"
  sudo rm /etc/resolver/dev
fi
sudo cp dev /etc/resolver/

if [ ! -f ../config/ports.yml ];
then
  echo "Copied example ports file to ../config/ports.yml"
  cp ../config/ports_example.yml ../config/ports.yml
fi

# remove templated files if they already exist
if [ -f dev ];
then
  sudo rm *.plist && sudo rm dev
fi

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # load nvm

nvm install 6.9.2 # installs (if missing) and switches node version
npm install
./../node_modules/gulp/bin/gulp.js build
sudo chown root *.plist
sudo chgrp wheel *.plist
sudo launchctl load cx.pop.popd.plist
sudo launchctl load cx.pop.firewall.plist
