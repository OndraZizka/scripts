
VERBOSE=false

find -type f -size +3M -print0 | while IFS= read -r -d '' PATHX; do
    if [ true != "$VERBOSE" ] ; then echo -n '.'; fi
    
    if grep -q "$PATHX" md5-partial.txt; then 
        ##  Checksum already computed.
        #echo -e "\n$PATHX checksum already computed.";
        MD5=`grep "$PATHX" md5-partial.txt | cut -f1`
        
        OCCURENCES=`grep "$MD5" md5-partial.txt`
        COUNT=`echo "$OCCURENCES" | wc -l`
        if [ "$COUNT" != 1 ] ; then 
            echo -e "\n $COUNT duplicates:\n$OCCURENCES"; 
        fi
    else
        SIZE=`du -h "$PATHX" | cut -f1`
        MD5=`dd bs=1M count=1 if="$PATHX" status=noxfer | md5sum`
        MD5=`echo $MD5 | cut -d' ' -f1`    
        echo "$MD5 $PATHX" >> md5-partial.txt

        OCCURENCES=`grep "$MD5" md5-partial.txt`
        COUNT=`echo "$OCCURENCES" | wc -l`
        if [ "$COUNT" != 1 ] ; then 
            echo -e "\n $COUNT duplicates: Size: `du -h "$PATHX" | cut -f1`\n$OCCURENCES"; 
        fi
    fi
done

echo -e "\n"
