"""
  Read Ansel source code translations and init the documentation translations
  where we find exact matches.

  Call with `python tools/merge-translations.py path/to/ansel`
"""

import regex as re
import glob
import sys
import os

entry_pattern = re.compile(r"(?:#~ )?msgid ((?:\"[\s\S]*?\"\n)+)(?:#~ )?msgstr ((?:\"[\s\S]*?\"\n)+)")

SOURCE = os.path.join(sys.argv[1], "po")

for file in glob.glob("po/*.po"):
    lang = re.match(r".*\.(\S+?)\.po", file).group(1)
    lang_code = lang.split("_")

    if len(lang_code) > 1:
        lang = lang_code[0] + "_" + lang_code[1].upper()

    orig: dict
    with open(os.path.join(SOURCE, f'{lang}.po'), "r") as f:
        orig = { match[0]: match[1] for match in entry_pattern.findall(f.read()) }

    lang = re.match(r".*\.(\S+?)\.po", file).group(1)

    dest: dict
    content: str
    with open(f'po/content.{lang}.po', "r") as f:
        content = f.read()

    num_identical = 0
    num_empty = 0

    dest = { match[0]: match[1] for match in entry_pattern.findall(content) }
    for key, value in dest.items():
        if key in orig:
            num_identical += 1
            if orig[key] != value and len(orig[key]) > 3 and len(value) < 4:
                # We found a matching msgid in Ansel software .po for which the translation is not empty
                num_empty += 1

                template_in = "msgid " + key + "msgstr " + orig[key]
                template_out = "msgid " + key + "msgstr " + value

                if(content.find(template_out) > -1):
                    content = content.replace(template_out, template_in)
                else:
                    key_pos = content.find(key)
                    print("Template not found. Here is the context:")
                    print(content[key_pos - 20 :key_pos+len(template_out)])

    with open(f'po/content.{lang}.po', "w") as f:
        f.write(content)

    print(lang, "\t", num_empty, "\t", num_identical)
