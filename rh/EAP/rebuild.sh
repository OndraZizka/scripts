#set -x

mvn clean dependency:go-offline clean install -B -fae -s ~/work/EAP6/settings-mead-qa-trim.xml \
  -Pnormal -Ppublic-repositories -Ppublic-plugin-repositories \
  -Ptestsuite -DallTests -DskipTests \
  -Dmaven.repo.local=localRepoER2 \
  -Dmaven.test.failure.ignore=true \
  -Dsurefire.forked.process.timeout=2600 \
  #-Djboss.dist=/usr/share/jbossas \

#set +x

if [ false ] ; then

mvn dependency:go-offline -fae -s ~/work/EAP6/settings-mead-qa-trim.xml \
  -Pnormal -Ppublic-repositories -Ppublic-plugin-repositories \
  -Ptestsuite -DallTests -DskipTests \
  -Dmaven.repo.local=localRepo \
  -Dmaven.test.failure.ignore=true \
  -Dsurefire.forked.process.timeout=2600

fi


mvn clean -fae -s ~/work/EAP6/settings-mead-qa-trim.xml   -Pnormal -Ppublic-repositories -Ppublic-plugin-repositories   -Ptestsuite -DallTests -DskipTests   -Dmaven.repo.local=localRepoER2   -Dmaven.test.failure.ignore=true   -Dsurefire.forked.process.timeout=2600 

