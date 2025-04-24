#!/usr/bin/env bash
# Requires po4a version 0.58 or higher.

# go to project root
PROJECT_ROOT="$(cd `dirname $0`/..; pwd)"
cd "$PROJECT_ROOT"

set -e

# Is po4a installed?
if ! which po4a; then
    echo "ERROR: Install po4a from your package manager."
    exit 1
fi

# Get the config file
po4a_conf="po/po4a.conf"

if ! test -f $po4a_conf || [ ! -s $po4a_conf ]; then
    echo "The file $po4a_conf is empty or don't exist. Run `./update-translations.sh` first"
    exit 1
fi

# Get the mode
mode="undef"

if [ "$1" = "--add" ]; then
  mode="add"
elif [ "$1" = "--remove" ]; then
  mode="remove"
else
  echo "This script needs to be called with either --add or --remove arguments"
  exit 1
fi

# get list of target languages minus disabled ones
disabled_languages=$(cat "$PROJECT_ROOT/po/disable-languages")
for lang in `find po -name '*.po' | cut -d . -f 2 | sort -u`; do
    if [[ ! $disabled_languages == *$lang* ]]; then
        languages="$languages --target-lang $lang"
    fi
done

# Generate or remove the target languages
if [ "$mode" = "add" ]; then
  echo "Generating translations for $languages"
  po4a $po4a_conf --verbose --keep 0 --no-update "$languages"
elif [ "$mode" = "remove" ]; then
  echo "Removing translations for $languages"
  po4a $po4a_conf --verbose --keep 0 --rm-translations --no-update --no-translations "$languages"
fi
