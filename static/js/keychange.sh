#!/bin/bash
#Takes the keywords from grammars/keywords-'lang'.lark and creates a syntaxModesRules-'lang'.ts file for that language
#How to use: add the argument for which language you want when using the script, e.g. 'keychange.sh en' for english

set -eu
scriptdir=$(cd $(dirname $0) && pwd)
cd $scriptdir
#ls

echo "//Generated through keychange.sh
" > syntaxModesRules-$1.ts

cat ../../grammars/keywords-$1.lark | while read line; do
  newline=$(echo ${line/:/=})
  echo var ${newline/\r?\n|\r/}';' >> syntaxModesRules-$1.ts
done

cat ./syntaxModesRules.ts >> syntaxModesRules-$1.ts

