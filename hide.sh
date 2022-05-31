#!/bin/bash
ls -lah
id
touch text2.txt

path="*"
while getopts ":d:e:p:" opt; do
  case $opt in
    d) path="$OPTARG"
    ;;
    e) ef="$OPTARG"
    ;;
    p) password="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

if [ -z "$ef" ]
then
    echo "Use -e to pass the path to embed_file.txt"
    exit 1
else
    echo "embed-file: $ef"
fi

if [ -z "$password" ]
then
    echo "Use -p to provide a password"
    exit 1
else
    echo "password: $password"
fi

mkdir "out"

hide()
{
    echo "Hiding $1"
    p_out="$(dirname $1)/out/$(basename $1)"
    steghide embed -ef "$ef" -cf "$1" -p "$password" -sf "$p_out"
}

for f in $(find $path -name '*.wav'); do hide "$f"; done

