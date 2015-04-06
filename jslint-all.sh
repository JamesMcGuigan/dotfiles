#!/bin/bash

# Runs javascript lint recursivly on a directory tree,
#   ignoring most javascript libary files
#   only displays files with actual errors or ECMA trailing comma warnings
#   this is a good pre-commit script
#
# Depends: http://www.javascriptlint.com/download.htm 
# Usage: jslint-all.sh
# Usage: jslint-all.sh ./dirname/

JSL='/usr/bin/env jsl'
if [[ $1 ]];            then DIR=$1;          else DIR="./"; fi;
if [[ -f ./jsl.conf ]]; then CONF=./jsl.conf; else CONF=~/.jsl.conf; fi;

echo "--- Validating code with JavaScript Lint ---"
ANYERRORS=''
for FILE in `find $DIR -name '*.js' -not -path '*vendor*' -not -path '*node_modules*' -not -path '*bower*' -not -path '*lib/python*'`; do
	ERROR=`($JSL -nologo -conf $CONF -process $FILE) | grep '[1-9] error\|ECMA'`;
	if [[ $ERROR != '' ]]; then
		ANYERRORS=1
		echo
		echo -n 'ERROR: '
		$JSL -nologo -conf $CONF -process $FILE | sed /^\s*$/d
		echo
	fi
done;

if [[ $ANYERRORS ]]; then
	echo "*** CODEBASE HAS ERRORS - aborting ***";
else
	echo "--- SUCCESS: No Errors Found ---";
fi;
