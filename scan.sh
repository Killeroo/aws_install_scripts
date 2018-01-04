#!/bin/bash

apt-mark showmanual > installed.txt

apt list --upgradable | cut -d/ -f1 > updates.txt

grep -v -x -f updates.txt installed.txt > new.txt

# Mark updatable and non-updatable packages
sed -e 's/$/ YYYYY/' -i new.txt
sed -e 's/$/ ZZZZZ/' -i updates.txt

comm <(cat new.txt | sort) <(cat updates.txt | sort) > combo.txt
awk '$1=$1' combo.txt
cat combo.txt

while read line
do
    if [[ $line == *"YYYYY"* ]]; then
        #echo "It's there!"
    fi
    string=${line/YYYYY/ }
    #printf '\e[30m\e[102m[UP TO DATE]\e[0m %s \n' "$line"
    #printf '%s \n' "$string"
done < "new.txt"

while read line
do
    #printf '\e[30m\e[101m\e[5m[OUTDATED]\e[0m %s \n' "$line"
done < "updates.txt"

# sort installed.txt updates.txt | uniq
