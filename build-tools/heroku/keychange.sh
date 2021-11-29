#!/bin/bash
#Takes the keywords from grammars/keywords-'lang'.lark and creates a syntaxModesRules-'lang'.ts file for that language
#Then uses npx tsc to build said .ts file into a .js file
#How to use: add the argument for which language you want when using the script, e.g. 'keychange.sh en' for english

set -eu
root=$(cd $(dirname $0)/../.. && pwd)

cd $root

echo "//Generated through keychange.sh" > static/js/syntaxModesRules-$1.ts

cat ./grammars/keywords-$1.lark | while read line; do
  newline=$(echo ${line/:/=})
  echo var ${newline/\r?\n|\r/}';' >> static/js/syntaxModesRules-$1.ts
done

cat ./static/js/syntaxModesRules.ts >> static/js/syntaxModesRules-$1.ts

npx tsc static/js/syntaxModesRules-$1.ts
