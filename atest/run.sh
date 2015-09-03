ROOTDIR=`dirname $0`/..
BINPATH=$ROOTDIR/bin
SRCPATH=$ROOTDIR/src
TESTDATA=$ROOTDIR/atest/vacalc
TESTLIBS=$ROOTDIR/atest/libraries
CP=$BINPATH/robotframework-2.9.1.jar:$TESTLIBS/swinglibrary-1.9.4.jar:$BINPATH
echo $CP
CLASSPATH=$CP java org.robotframework.RobotFramework -P $SRCPATH -P $TESTLIBS $* --outputdir $ROOTDIR/results --critical regression $TESTDATA
