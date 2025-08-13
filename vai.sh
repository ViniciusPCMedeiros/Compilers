#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Uso: $0 arquivo.flex arquivo_entrada"
    exit 1
fi

FLEX_FILE="$1"
INPUT_FILE="$2"


BASENAME=$(basename "$FLEX_FILE" .flex)


JAVA_CLASS="$(tr '[:lower:]' '[:upper:]' <<< ${BASENAME:0:1})${BASENAME:1}"

[ -f "${JAVA_CLASS}.java" ] && rm "${JAVA_CLASS}.java"
[ -f "${JAVA_CLASS}.class" ] && rm "${JAVA_CLASS}.class"

java -jar jflex.jar "$FLEX_FILE"

javac "${JAVA_CLASS}.java"

java "$JAVA_CLASS" "$INPUT_FILE"
