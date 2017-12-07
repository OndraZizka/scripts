rm -f /home/ondra/.rhamt/log/*

MIGR_DIR="/home/ondra/work/mig"
APPS_DIR="/home/ondra/work/mig/_apps/MarcZ/12GBset"

WINDUP=/tmp/windup/unzipped/bin/rhamt-cli
INPUT=""
DEBUG=""
if [ "$1" == "debug" ] ; then DEBUG="--debug"; shift; fi
ARGS="--batchMode --target eap7 $DEBUG" # --mavenize --offline --keepWorkDirs


if [ "$1" == "sample" ] ; then
  OUTPUT_SUFFIX=""
  INPUT="--input /tmp/windup/unzipped/samples/jee-example-app-1.0.0.ear"
  shift
fi

if [ "$1" == "seam" ] ; then
  OUTPUT_SUFFIX="-$1"
  INPUT="--input $MIGR_DIR/windup/test-files/seam-booking-5.2 --sourceMode --explodedApp"
  shift
fi

if [ "$1" == "double" ] ; then
  OUTPUT_SUFFIX=""
  INPUT="--input /tmp/windup/unzipped/samples/jee-example-app-1.0.0.ear  \
                 $APPS_DIR/15/resteasy-jaxrs-war-1.0-beta-4.war"
  shift
fi

if [ "$1" == "multi" ] ; then
  OUTPUT_SUFFIX="-$1"
  INPUT="--input
    /tmp/windup/unzipped/samples/jee-example-app-1.0.0.ear
    $APPS_DIR/15/resteasy-jaxrs-war-1.0-beta-4.war
    $APPS_DIR/15/spring-small-example.war
    $APPS_DIR/13/jms-topic-war-1.5.1.war
    $APPS_DIR/02/daytrader-ee7-1.0-SNAPSHOT.ear"
  shift
fi

if [[ "$1" == mz* ]] ; then
  SUBDIR=${1#mz}
  LIST=`ls -d -1 $APPS_DIR/$SUBDIR/*`
  OUTPUT_SUFFIX="-$1"
  INPUT="--input
    /tmp/windup/unzipped/samples/jee-example-app-1.0.0.ear
    $LIST"
  shift
fi

OUTPUT_DIR="/tmp/windup/testRunReport$OUTPUT_SUFFIX"
rm -rf $OUTPUT_DIR



echo "Starting at `date +%H:%M:%S`"
COMMAND="$WINDUP $ARGS $INPUT --output $OUTPUT_DIR $@"
echo ">>> $COMMAND"
$COMMAND
cp ~/.rhamt/log/rhamt.log $OUTPUT_DIR || :

echo "Finished `date +%H:%M:%S`"

