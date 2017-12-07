
GREMLIN=/home/ondra/sw/prog/gremlin/2.6.0/bin/gremlin.sh
GREMLIN=/home/ondra/sw/prog/RexsterJess/rexster-console-2.5.0/bin/rexster-console.sh

RESULT_DIR="$1"
CONFIG_SUBPATH="graph/TitanConfiguration.properties"

if [ "" = "$RESULT_DIR" ]; then
    RESULT_DIR="/tmp/Windup/resJee"
    RESULT_DIR="/tmp/windup/testRunReport"
fi

if [ ! -d "$RESULT_DIR" ]; then
    echo "Given report directory does not exist: $RESULT_DIR"
    exit;
fi
if [ ! -d "$RESULT_DIR/$CONFIG_SUBPATH" ]; then
    echo "No Titan config in given report directory: $RESULT_DIR/$CONFIG_SUBPATH"
fi


cat << EOF > ./script.tmp
spawn $GREMLIN
expect ">"
send "import com.thinkaurelius.titan.core.TitanFactory;
"
expect ">"
send "g = TitanFactory.open('$RESULT_DIR/$CONFIG_SUBPATH');
"
expect ">"
send "
"
# turn it back over to interactive user
interact
EOF

expect ./script.tmp
