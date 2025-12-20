#!/bin/bash

# Translate all comment variable in app.zen_browser.zen.desktop for multiples languages using trans.
TEXT="Zen is the best way to browse the web. Beautifully designed, privacy-focused, and packed with features. We care about your experience, not your data."


# Download trans script for use Google Translate in terminal and set permissions.
wget git.io/trans
chmod +x ./trans

# Get all iso code for translation
./trans  -list-codes > list_code.txt


# For all iso code and translate in TARGET variable and put all in all.txt
for lang in $(cat list_code.txt); do
echo "Translate for $lang"
TARGET=$(./trans -brief "$TEXT" -t $lang)
echo "Comment[$lang]=$TARGET" >> all.txt
done

# Filter all translations equal "Comment[lang]="
grep -E "=$" all.txt -v > clear.txt

