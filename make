#!/bin/bash

echo "Checking for easyrpz..."
if command -v easyrpz > /dev/null; then
  echo "Command easyrpz is already installed!"
  else
  echo "Installing easyrpz to /usr/local/bin"
  cd /tmp
  curl -fsSO https://raw.githubusercontent.com/pure-dns/easyrpz/main/bin/easyrpz
  chmod +x easyrpz
  sudo mv easyrpz /usr/local/bin
  sudo chown $whoami:$whoami /usr/local/bin/easyrpz
  echo "Successfully installed easyrpz!"
fi

# generate filter-family.rpz file
echo "Generating filter-family.rpz file..."
easyrpz \
  -i https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts \
  -i https://raw.githubusercontent.com/ABPindo/indonesianadblockrules/master/subscriptions/hosts_adult.txt \
  -i safesearch/bing \
  -i safesearch/google \
  -i safesearch/youtube \
  -e excludes/localhost \
  -o filter-family.rpz

# generate filter-security.rpz file
echo "Generating filter-security.rpz file..."
easyrpz \
  -i https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts \
  -i https://raw.githubusercontent.com/ABPindo/indonesianadblockrules/master/subscriptions/hosts.txt \
  -e excludes/localhost \
  -o filter-security.rpz
