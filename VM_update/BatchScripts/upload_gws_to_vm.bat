@echo off & setlocal DisableDelayedExpansion EnableExtensions
REM
REM upload_gws_to_vm.bat <host_name> [<user> [<password>]]
REM
REM Call PuTTY Secure File Transfer to push local JAR file
REM

REM Make sure Unix tools are in path
if not defined PathUnixTools set Path=%Path%;%~sdp0..\Tools\Unix

call Logs ---------------------------------------------------------------------------------
call Logs  %0 host_name=%1 user=%2 password=%3
call Logs ---------------------------------------------------------------------------------

REM Set default user & password
set user=genesys
set passwd=genesys

REM Check mandatory command-line arguments
if [%1X] EQU [X] goto NoHost
REM Check optional command-line arguments
if [%2X] NEQ [X] set user=%2
if [%3X] NEQ [X] set passwd=%3

goto JustDoIt

:NoHost
call Logs ERROR - Host name not specified. Doing nothing
goto end

:JustDoIt

REM Do whatever we have to do
pushd "%~sdp0"

REM Make sure host key is known
call import_registry_key %1

call Logs Updating GWS on host %1
PLINK.EXE -pw %passwd% %user%@%1 -m plink_cmd_files\%~n0.src -batch -t

call Logs

popd

:end
endlocal