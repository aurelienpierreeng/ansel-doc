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

# Aggregate available .po files
for lang in `find po -name '*.po' | cut -d . -f 2 | sort -u`; do
    languages="$languages $lang"
done

# Create a blank conf file
po4a_conf="po/po4a.conf"
touch $po4a_conf
> $po4a_conf

# Populate languages with what we found in po/ folder
echo "[po_directory] po" > $po4a_conf
echo "[po4a_langs] $languages" > $po4a_conf
echo "[po4a_paths] po/content.pot \$lang:po/content.\$lang.po" >> $po4a_conf

# Parsing options
# opt:"--option neverwrap" and opt:"--option nobullets" ensure Markdown bullet lists don't get separated by an extra newline that would break them
cat >> $po4a_conf <<EOF

[options] opt:"--addendum-charset=UTF-8" opt:"--localized-charset=UTF-8" opt:"--master-charset=UTF-8" opt:"--msgmerge-opt='--no-wrap'" opt:"--porefs=file" opt:"--wrap-po=no" opt:"--master-language=en_US"

[po4a_alias:markdown] text opt:"--option markdown" opt:"--option yfm_keys=title" opt:"--addendum-charset=UTF-8" opt:"--localized-charset=UTF-8" opt:"--master-charset=UTF-8" opt:"--option neverwrap" opt:"--option nobullets"

EOF

for f in  $(find content -type f -name '*.md'); do

    # Enqueue the translations only for Git-tracked files.
    # When building translations, the .LANG.md files are added to the content/ folder.
    # Hugo could manage translations using content/LANG/ subfolders, but that would prevent
    # sharing untranslated image assets between languages as of Hugo 0.146
    # (aka duplicate images and bloat the website for no reason - remember Github Pages limit storage to 1 GB).
    # If user generated the translation files and forgot to remove them before running this script,
    # content/ has the English original .md and generated .LANG.md translations.
    # We obviously don't wont to re-add the translations to the translatable content...
    if [ "$(git ls-files $f)" = "$f" ]; then
        echo "[type: markdown] $f \$lang:$(dirname $f)/$(basename $f .md).\$lang.md" >> $po4a_conf
    fi

done

# Update .pot and .po content with fresh .md files
po4a $1 --verbose $po4a_conf --keep 0 --no-translations --rm-translations
