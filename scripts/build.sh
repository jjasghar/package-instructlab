#!/bin/bash

sudo rm -rf /usr/local/bin/ilab && sudo rm -rf /Library/InstructLab/
rm -f dist/*

briefcase create
cp -f overrides/welcome.html build/instructlab/macos/app/installer/resources
cp -f overrides/postinstall build/instructlab/macos/app/installer/scripts

chmod +x build/instructlab/macos/app/installer/scripts/postinstall

briefcase build
briefcase package macOS --adhoc-sign
#briefcase package macOS

