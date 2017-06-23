#!/bin/bash

if [ "$#" -ne 2 ]
then
  echo "Usage: $0 SRT_FILE DELTA > NEW_SRT_FILE"
  exit
fi

# arg1: time label, arg2: delta time
function moveTime {
    TIMEOLDSEC=$(date -d${1} +%s.%N)
    TIMENEWSEC=$(echo "${TIMEOLDSEC}+${2}"|bc)
    date -d@${TIMENEWSEC} +%T.%3N
}

while read line; do
    read start arrow end <<< "$line"
    if [ "$arrow" == '-->' ]; then
	echo "$(moveTime $start $2) --> $(moveTime $end $2)"
    else
	echo $start $arrow $end
    fi
done < "$1"
