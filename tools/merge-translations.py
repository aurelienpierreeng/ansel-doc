"""
    Read source code translations and init the documentation translations
    where we find exact matches for `msgid` fields.

    Call with `python tools/merge-translations.py path/to/sourcecode path/to/doc`.
    We assume both directories contain an immediate `po/` subdirectory.

    Copyright (c) Aurélien Pierre - 2025
"""

import regex as re
import glob
import sys
import os

entry_pattern = re.compile(r"(?:#~ )?msgid ((?:\"[\s\S]*?\"\n)+)(?:#~ )?msgstr ((?:\"[\s\S]*?\"\n)+)")

SOURCE = os.path.join(sys.argv[1], "po")
DOC = os.path.join(sys.argv[2], "po")

for file in glob.glob(os.path.join(DOC, "*.po")):
    lang = re.match(r".*\.(\S+?)\.po", file).group(1)

    # Source code translations have regional code in uppercase
    # like pt_BR or zh_CN, otherwise we have de, pl, fr, gl, etc.
    lang_code = lang.split("_")
    if len(lang_code) > 1:
        lang = lang_code[0] + "_" + lang_code[1].upper()

    # Build the dictionnary msgid -> msgstr for the source code .po
    sourcecode: dict
    with open(os.path.join(SOURCE, f'{lang}.po'), "r") as f:
        sourcecode = { match[0]: match[1] for match in entry_pattern.findall(f.read()) }

    documentation: dict
    content: str
    with open(file, "r") as f:
        content = f.read()

    num_identical = 0
    num_empty = 0
    num_replaced = 0

    # Build the dictionnary msgid -> msgstr for the documentation .po
    documentation = { match[0]: match[1] for match in entry_pattern.findall(content) }
    for msgid, msgstr in documentation.items():
        if msgid in sourcecode:
            num_identical += 1
            if sourcecode[msgid] != msgstr and len(sourcecode[msgid]) > 3 and len(msgstr) < 4:
                # We found a matching msgid in software .po for which the translation is not empty
                num_empty += 1

                template_source = "msgid " + msgid + "msgstr " + sourcecode[msgid]
                template_doc = "msgid " + msgid + "msgstr " + msgstr

                if(content.find(template_doc) > -1):
                    num_replaced += 1
                    content = content.replace(template_doc, template_source)
                else:
                    key_pos = content.find(msgid)
                    print("Template not found. Here is the context:")
                    print(content[max(key_pos - 20, 0) :key_pos+len(template_doc)])

    with open(file, "w") as f:
        f.write(content)

    print("Lang:", lang, "\t", "Strings replaced:", num_replaced, "\t", "Candidate strings:", num_empty, "\t", "Matching strings:", num_identical)
