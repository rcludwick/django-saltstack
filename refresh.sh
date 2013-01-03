#!/bin/bash

git pull
sudo salt-call --local state.highstate
