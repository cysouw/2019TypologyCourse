#!/bin/sh

grep -v "^#" $1 > tmp1.txt
grep -v "^#" $2 > tmp2.txt

csvjoin -t -c 1,1 -u 3 tmp1.txt tmp2.txt |
csvcut -c 2,3 |
csvformat -U 3 -D '@' -P % |
sed 's/%\"/\"/g' |
sed 's/@/ ||| /g' > input.txt

rm tmp1.txt tmp2.txt

# ./executables/fast_align/build/fast_align -i input.txt -dov > align.txt
