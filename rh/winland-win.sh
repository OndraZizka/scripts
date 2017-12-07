mkdir /home/ondra/tmp/$1
echo "LANG=en rdesktop -g 1600x1120 -u user -r 'disk:mydisk=/home/ondra/tmp/$1' $1.englab.brq.redhat.com" 
LANG=en rdesktop -g 1600x1120 -u user -r 'disk:mydisk=/home/ondra/tmp/$1' $1.englab.brq.redhat.com
