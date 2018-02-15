for NAME in [0-9]*.jpg; do echo $NAME; mv $NAME `printf %04d.%s ${NAME%.*} ${NAME##*.}`; done
