echo -n "Enter The name of the Book: "
read book
book=${book//[ ]/+}
(curl -s $(curl -s "https://libgen.is/search.php?req=$book" | grep -Eo "http://library.lol/main\/[0-9A-Z]{32}") | grep -Eo 'http://.*(\.epub)' | head -1 | tail -1) | wc -l  > temp.txt
a=$(cat < temp.txt)
if (( $a == 0  )); then
wget $(curl -s $(curl -s "https://libgen.is/search.php?req=$book" | grep -Eo "http://library.lol/main\/[0-9A-Z]{32}") | grep -Eo 'http://.*(\.epub|\.pdf)' | head -1 | tail -1)
else
wget $(curl -s $(curl -s "https://libgen.is/search.php?req=$book" | grep -Eo "http://library.lol/main\/[0-9A-Z]{32}") | grep -Eo 'http://.*(\.epub)' | head -1 | tail -1)
fi
rm -rf temp.txt
