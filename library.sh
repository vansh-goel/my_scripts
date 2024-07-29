#!/bin/bash

#Colors
purple='\033[1;35m'
yellow='\033[1;33m'
cyan="\033[1;36m"

#Taking Inputs
echo -n "Enter the name of the book: "
read book
book=${book//[ ]/+}

i=$(curl -s https://libgen.is/search.php?req=$book | grep -Eo  "book\/[a-zA-Z?=0-9.]{46}" | wc -l)
echo "Getting the required Data......"
echo ""
for (( f=1 ; f<=$((5)); f++  )); do
     if [ $(($f%2)) == 0 ]; then
	echo -e "$purple[$f]  "$(curl -s  "https://libgen.is/search.php?req=$book" | grep -Eo " id=[0-9]*>[A-Za-z0-9 ?_!""''.,/\]*" | awk '{ print substr( $0, 12 ) }' | head -$f | tail -1)	
     else
	echo -e "$yellow[$f]  "$(curl -s  "https://libgen.is/search.php?req=$book" | grep -Eo " id=[0-9]*>[A-Za-z0-9 ?_!.,''""/\]*" | awk '{ print substr( $0, 12 ) }' | head -$f | tail -1)
     fi
done
for (( f=1 ; f<=$((5)); f++  )); do
	echo " https://libgen.is/"$(curl -s https://libgen.is/search.php?req=$book | grep -Eo  "book\/[a-zA-Z?=0-9.]{46}" | head -$f | tail -1) >> temp.txt
done
echo -n -e "${cyan}Choose an [Option]: "
read op
curl -s $(cat < temp.txt | head -$op | tail -1) | grep -Eo "http(s?):\//[0-9a-zA-Z?.]*\/((main|md5))\/[0-9a-zA-Z?.]*" >> temp2.txt
t=$(cat < temp2.txt | head -1 | tail -1)
rm -rf temp.txt temp2.txt
echo -e "${purple}Downloading Book...."
wget $(curl -s $t | grep ".pdf" | grep -Eo "http(s?)://.*(\.pdf)" | head -1 | tail -1)
