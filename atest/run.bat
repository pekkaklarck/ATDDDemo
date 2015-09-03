@echo off

set ROOTDIR=%~dp0..
set BINPATH=%ROOTDIR%\bin
set SRCPATH=%ROOTDIR%\src
set TESTDATA=%ROOTDIR%\atest\vacalc
set TESTLIBS=%ROOTDIR%\atest\libraries
set CLASSPATH=%BINPATH%\robotframework-2.9.1.jar;%TESTLIBS%\swinglibrary-1.9.4.jar;%BINPATH%
java org.robotframework.RobotFramework -P "%SRCPATH%" -P "%TESTLIBS%" %* --outputdir "%ROOTDIR%\results" --critical regression "%TESTDATA%"
