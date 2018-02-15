#for i in `find -type f -size +1M`; do
find -type f -size +3M -print0 | while IFS= read -r -d '' i; do
  #echo $i
  echo -n '.'
  if grep -q "$i" md5-partial.txt; then echo -e "\n$i  ---- Already counted, skipping."; continue; fi
  #md5sum "$i" >> md5.txt
  MD5=`dd bs=1M count=1 if="$i" status=noxfer | md5sum`
  MD5=`echo $MD5 | cut -d' ' -f1`
  if grep "$MD5" md5-partial.txt; then echo "\n$i  ----   Duplicate!"; fi
  echo $MD5 $i >> md5-partial.txt
done
