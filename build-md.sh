#!/bin/sh

process_file ()
{
    sed -nf include.sed $1.md.in | sed 'N;N;s/\n//' | sed -f - $1.md.in  > $1.md
}

for file in *.md.in
do
    process_file `basename $file .md.in`
done



