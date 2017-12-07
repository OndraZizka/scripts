if [ "$1" == "skip" -o  "$1" == "no" ] ; then exit; fi
set -x
set -e


TMPDIR=/tmp/windup
BUILD_CORE=""
BUILD_RULESETS=""

if [[ "$1" != "" && ( "$1" != "no" || "$1" != -* ) ]] ; then
  BUILD_CORE="yes"
  if [[ "$1" != -* ]] ; then shift; fi;
fi

if [ "$1" == "rules" ] ; then
  BUILD_RULESETS="yes";
  shift;
fi

## Rebuild Windup Core
#if [[ "$1" != "" && "$1" != "no" ]] ; then
if [ "$BUILD_CORE" != "" ] ; then
  cd ~/work/mig/windup
  mvn clean install -DskipTests "$@"
fi

## Rebuild Windup Rulesets
#if [ "$1" != "" ] ; then
if [ "$BUILD_RULESETS" != "" ] ; then
  cd ~/work/mig/windup-rulesets
  mvn clean install -DskipTests
fi


## Rebuild Windup and unzip it.
cd ~/work/mig/windup-distribution/


## Rebuild Windup Distribution
if [ "$1" == "stash" ] ; then
  mvn clean
  git stash
  git checkout master
  git pull
  mvn install -DskipTests
  git checkout -
  #git stash pop || true
else
  mvn clean install -DskipTests
fi

rm -rf $TMPDIR/unzipped
mkdir -p $TMPDIR/
unzip -q target/rhamt-cli-*-offline.zip -d $TMPDIR/
mv $TMPDIR/rhamt-cli-* $TMPDIR/unzipped
#$TMPDIR/home/bin/windup -e "addon-remove --addons org.jboss.windup.quickstarts:windup-weblogic-javaee-servlet,2.0.0.Beta3"
#$TMPDIR/home/bin/windup -e "cd ../WindupQuickstarts/weblogic-javaee-servlet; addon-install; cd ../../Windup"
#$TMPDIR/home/bin/windup
set +x
cd -


## Build Windup Web
if [[ "$@" == "web" ]] ; then
    cd ~/work/mig/windup-web
    mvn clean install -DskipTests
fi

echo "Build finished at " $(date '+%Y-%m-%d %H:%M:%S') ""



: <<'END'
while test $# -gt 0 ; do 
    case "$1" in
        --opt1) echo "option 1"
            ;;
        --opt2) echo "option 2"
            ;;
        --*) echo "bad option $1"
            ;;
        *) echo "argument $1"
            ;;
    esac
    shift
done
END

exit 0
