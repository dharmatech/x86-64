#!/bin/sh

process_file ()
{
    sed -nf include.sed $1.md.in | sed 'N;N;s/\n//' | sed -f - $1.md.in  > $1.md
}

process_file print-literal-string

