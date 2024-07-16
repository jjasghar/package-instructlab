#!/bin/bash

PROCESSOR=$(uname -m)
VERSION=$(python ./scripts/get_version.py)

sudo rm -rf /usr/local/bin/ilab && sudo rm -rf /Library/InstructLab/
git checkout overrides/welcome.html
rm -f dist/*

briefcase create
sed -i '' -e "s/VERSION/$VERSION/g" overrides/welcome.html
cp -f overrides/welcome.html build/instructlab/macos/app/installer/resources
cp -f overrides/postinstall build/instructlab/macos/app/installer/scripts

chmod +x build/instructlab/macos/app/installer/scripts/postinstall

briefcase build
briefcase package macOS --identity "Developer ID Application: Jonathan Asghar (94J7FVM977)" --installer-identity "Developer ID Installer: Jonathan Asghar (94J7FVM977)"
mv dist/* dist/InstructLab-${PROCESSOR}-${VERSION}.pkg
