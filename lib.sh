#!/bin/bash

#Colors
purple='\033[1;35m'
yellow='\033[1;33m'
cyan="\033[1;36m"

#Taking Inputs
echo -n -e "${purple}Enter the name of the book: "
read book
book=${book//[ ]/+}
echo "${Yellow}Getting the required Data......"
echo ""
t=" https://libgen.is/"$(curl -s https://libgen.is/search.php?req=$book | grep -Eo  "book\/[a-zA-Z?=0-9.]{46}" | head -1 | tail -1)
d=$(curl -s $t | grep -Eo "http(s?):\//[0-9a-zA-Z?.]*\/((main|md5))\/[0-9a-zA-Z?.]*" | head -1 | tail -1)
wget $(curl -s $d | grep -Eo "http(s?)://.*(\.pdf|\.epub|\.mobi)" | head -1 | tail -1)
