#dependency:go-offline
if [ "$DGO" != "" ] ; then DGO='dependency:go-offline'; fi

./build.sh clean $DGO install -DskipTests -Dts.noSmoke "$@"

