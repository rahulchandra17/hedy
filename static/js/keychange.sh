#!/bin/bash
#Replaces the keywords from syntaxKeywords.ts to be used in syntaxModesRules.ts to the ones listed in the appropriate language.
#How to use: add the argument for which language you want when using the script, e.g. 'keychange.sh en' for english

set -eu
scriptdir=$(cd $(dirname $0) && pwd)
cd $scriptdir
#ls

echo "//Generated through keychange.sh
" > syntaxKeywords.ts

cat ../../grammars/keywords-$1.lark | while read line; do
  newline=$(echo ${line/:/=})
  echo var ${newline/\r?\n|\r/}';' >> syntaxKeywords.ts
done

