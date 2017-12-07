
IN=$1
OUT=$2

if [ "" == "$IN" ] ; then
    echo "Expecting parameters:  $0 <file or dir to upload> [<remote-name>]";
fi

if [ "" == "$OUT" ] ; then OUT=`basename $1`; fi
echo "OUT name will be '$OUT'."


###  If it's a file:
if [ ! -d "$IN" ] ; then
    set -x
    DIR=`dirname $OUT`;
    ssh ozizka@www.qa.jboss.com  "cd ~/public_html/; mkdir -p $DIR;"
    scp "$IN" ozizka@www.qa.jboss.com:~/public_html/"$OUT"
    echo -e "\n\nAccess the file at: http://www.qa.jboss.com/~ozizka/$OUT\n\n"
    set +x

###  If it's a directory:
##   scpQA  foo.zip  projects/windup/report01
else
    cd `dirname "$IN"`
    echo "Deleting "`pwd`"/tmp.zip"
    rm tmp.zip
    zip -r tmp.zip `basename "$IN"`
    ZIP=`dirname "$IN"`/tmp.zip
    cd -
    echo -e "\n\n=====  Copying to the QA server... ======\n\n"
    ssh ozizka@www.qa.jboss.com  "cd ~/public_html/; mkdir -p $OUT;"
    echo "scp $ZIP ozizka@www.qa.jboss.com:~/public_html/"$OUT".zip"
    scp $ZIP ozizka@www.qa.jboss.com:~/public_html/"$OUT".zip
    echo -e "\n\n=====  Unzipping at the QA server... ======\n\n"
    ssh ozizka@www.qa.jboss.com  "cd ~/public_html/; unzip '$OUT'.zip; rm '$OUT'.zip; "
    echo -e "\n\nAccess the directory at: http://www.qa.jboss.com/~ozizka/$OUT\n\n"
    rm $ZIP
fi

###  Or simply use: rsync -ave ssh $IN ozizka@www.qa.jboss.com:$OUT