#!/bin/bash

# Get the documentation module
hugo mod get -u

# Write it to disk locally (=vendor)
hugo mod vendor

# Update addenda for translation contributors
chmod 700 tools/update-translations.sh
./tools/update-translations.sh

# Auto-gen website translations
chmod 700 tools/build-translations.sh
./tools/build-translations.sh --add
