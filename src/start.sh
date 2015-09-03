#!/bin/sh
ROOT=`dirname $0`/..
BIN=$ROOT/bin
SRC=$ROOT/src
RF=$BIN/robotframework-2.9.1.jar
java -cp $RF:$BIN -Dpython.path=$SRC org.robotframework.vacalc.VacalcRunner
