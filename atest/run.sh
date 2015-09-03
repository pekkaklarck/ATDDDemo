ROOT=`dirname $0`/..
BIN=$ROOT/bin
SRC=$ROOT/src
TESTS=$ROOT/atest/vacalc
LIBS=$ROOT/atest/libraries
CP=$BIN/robotframework-2.9.1.jar:$BIN:$LIBS/swinglibrary-1.9.4.jar
CLASSPATH=$CP java org.robotframework.RobotFramework \
    -P "$SRC" -P "$LIBS" --outputdir "$ROOT/results" --critical regression "$@" "$TESTS"
