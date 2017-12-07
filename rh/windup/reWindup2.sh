
## Run from Migration/tmp.

echo "Building Windup..."
mvn -q clean install -DskipTests -f ../windup/pom.xml && \

echo "Unzipping Windup..." && \
rm -rf windup-distribution-* && \
unzip -q ../windup/dist/target/windup-distribution-*.zip  && \
echo -e "\n\n#    windup-distribution-*/bin/windup"


## Addon stuff
if 1 ; then

unzip -q dist/target/windup-distribution-2.0.0-SNAPSHOT-offline.zip -d /tmp/windup/
mv /tmp/windup/windup-distribution-* /tmp/windup/windup
/tmp/windup/windup/bin/windup -e "addon-remove --addons org.jboss.windup.quickstarts:windup-weblogic-javaee-servlet,2.0.0.Beta3"
/tmp/windup/windup/bin/windup -e "cd ../WindupQuickstarts/weblogic-javaee-servlet; addon-install; cd ../../Windup"
/tmp/windup/windup/bin/windup

## Reinstall Victi.ms addon
addon-remove --addons org.jboss.windup.quickstarts:windup-victims-parent,2.0.0-SNAPSHOT
cd ../WindupQuickstarts/victi.ms/
addon-install
cd -

fi
