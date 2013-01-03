#!/usr/bin/bash

git pull
sudo salt-call --local salt.highstate
