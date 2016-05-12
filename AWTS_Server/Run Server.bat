title Another Way To Start Server

REM Test JVM
REM e.g. 32-bit JVM does not have server\jvm.dll library
java -server -version > java-test.log 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo Detected following JVM error:
    echo =======================================
    more java-test.log
    echo =======================================
    echo JVM test failed. Can't run server, Exiting...
    pause
    exit /B
)

if not exist eula.txt (
    echo Missing eula.txt. Startup will fail and eula.txt will be created
    echo Make sure to read eula.txt before playing!
    goto startserver
)

find "eula=false" eula.txt 1 > NUL 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Make sure to read eula.txt before playing! Exiting.
    pause
    exit /B
)

del /f /q autostart.stamp > nul 2>1

:startserver
echo Starting server
java -server -Xms512M -Xmx4096M -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=4 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10 -jar forge-1.7.10-10.13.4.1614-1.7.10-universal.jar nogui

echo Exiting...
pause

