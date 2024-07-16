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
briefcase package macOS --identity 9513220CA1EAF778B3A9CF47591D349D60EE0677
briefcase package macOS --installer-identity D8596223E82222CED00F89C4AA8458AB883ACE86
mv dist/* InstructLab-${PROCESSOR}-${VERSON}.pkg
