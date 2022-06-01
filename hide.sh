#!/bin/bash
echo "Content of the data directory:"
ls -lah
id

path="*"
test_mode="false"
total_count=0
passed_count=0
while getopts "d:e:p:t" opt; do
  case $opt in
    d) path="$OPTARG"
    ;;
    e) ef="$OPTARG"
    ;;
    p) password="$OPTARG"
    ;;
    t) test_mode="true"
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

hide()
{
    echo "Hiding $1"
    p_out_dir="$(dirname $1)/out"
    mkdir -p "$p_out_dir"
    p_out="$p_out_dir/$(basename $1 | sed 's/\(.*\)\..*/\1/')_out.wav"
    steghide embed -ef "$ef" -cf "$1" -p "$password" -sf "$p_out"
}

extract()
{
    echo "Extracting $1"
    p_out_dir="$(dirname $1)"
    p_xf_dir="$(dirname $1)/xf"
    mkdir -p "$p_xf_dir"
    p_out="$p_out_dir/$(basename $1)"
    p_xf="$p_xf_dir/$(basename $1).txt"
    steghide extract -sf "$p_out" -p "$password" -xf "$p_xf"
    ((total_count++))
}

test()
{
    echo "Testing $1"
    p_xf_dir="$(dirname $1)/xf"
    p_xf="$p_xf_dir/$(basename $1).txt"
    if cmp -s "$p_xf" "$ef"
    then
      echo "Test passed."
      ((passed_count++))
    else
      echo "Test failed."
    fi
    rm -r "$p_xf_dir"
}

if [ "$test_mode" == "true" ]
then
  for f in $(find $path -name '*_out.wav')
  do
    extract "$f"
    test "$f"
  done
  echo -e "\n====\n$passed_count of $total_count files passed the test."
else
  for f in $(find $path -name '*.wav')
  do
    hide "$f"
  done
fi


