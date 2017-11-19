#!/bin/sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
sudo cp ${SCRIPTPATH}/*.nix /etc/nixos/
