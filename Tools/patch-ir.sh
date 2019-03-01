#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "$0 <path_to_ir> <out_file>"
    exit -1
fi

IR_FILE=$1
OUT_FILE=$2

sed '/^[[:space:]]*ret[[:space:]].*/i\urem i4711 4711, 4711' $IR_FILE > "$2"

