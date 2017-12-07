set -e

MIGR_DIR=~/work/mig/

if [ "$1" == "build" ] ; then
  mvn clean install -f $MIGR_DIR/windup-distribution/pom.xml  -DskipTests
fi

rm -rf /tmp/windup-unzip $MIGR_DIR/windup-instance/
unzip -q -d /tmp/windup-unzip/ $MIGR_DIR/windup-distribution/target/windup-distribution-*-offline.zip
mv /tmp/windup-unzip/windup-distribution-* $MIGR_DIR/windup-instance
$MIGR_DIR/windup-instance/bin/windup

