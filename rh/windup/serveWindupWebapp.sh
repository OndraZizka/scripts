
WEB_DIR=/home/ondra/work/mig/windup-web/ui/src/main/webapp

## Enclose in a subshell to return back to the current dir.
#(cd $WEB_DIR && serve)
(cd $WEB_DIR && npm start)
