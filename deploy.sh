#!/bin/sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
for nix_file in ${SCRIPTPATH}/*.nix; do
  sudo cp ${nix_file} /etc/nixos/
done
