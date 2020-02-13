@SETLOCAL
@REM 
@ECHO OFF

SET scriptName=%~nx0
ECHO Start %scriptName%

SET invokePath=%~dp0.
@REM The CALL preserves quotes for ~dp0. Prevents problems "Extra quotes inside a path" if this file invoked with a path with quotes.
SET invokePath=%invokePath:"=%

CALL "%invokePath%\util\set-environment.bat"
CALL %env_qUtil%\exit_if_error

CALL "%invokePath%\set-manager-environment.2019.bat"
CALL %env_qUtil%\exit_if_error


REM The following prevents build-machines (Jenkins) from locking (freezing) and a crash at the end of a build.
REM https://stackoverflow.com/questions/7916687/error-msb4166-child-node-exited-prematurely-shutting-down
REM https://techdocs.ed-fi.org/display/ODSAPI20/Step+4.+Prepare+the+Development+Environment
REM We can use "-nodeReuse:False" with "-maxCpuCount" on a MSBuild call but it is possible to use "SET MSBUILDDISABLENODEREUSE=1" globally to do the same.
SET MSBUILDDISABLENODEREUSE=1


@REM Uncomment the following workarounds as needed.
CALL %env_qManager%\workaround\MSBuild-File-System-Redirector-fail-System32-to-SysWOW64.bat
REM CALL %env_qManager%\workaround\MSBuild-Unable-to-create-Temp-directory.bat


ECHO Prepare the development environment.
@REM We need to invoke the exact preparation script here because after migration from VS2010 to VS2015 we got a broken environment on our Build-Server. It is actual for VS2017 too.
@REM  and we are getting the empty SDK40ToolsPath.
@REM MSB3086 Microsoft.Common.targets Task could not find "sgen.exe" using the SdkToolsPath "" or the registry key "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x86". Make sure the SdkToolsPath is set and the tool exists in the correct processor specific location under the SdkToolsPath and that the Microsoft Windows SDK is installed
@REM http://stackoverflow.com/questions/2731365/running-msbuild-fails-to-read-sdktoolspath
@REM http://stackoverflow.com/questions/34045326/msbuild-sgen-exe-is-missing
@REM http://stackoverflow.com/questions/26442450/why-is-visual-studio-2013-using-the-wrong-sdktoolspath-for-lc-exe
@REM
ECHO CALL %env_vs2019_dev_cmd%
CALL %env_vs2019_dev_cmd%
CALL %env_qUtil%\exit_if_error


ECHO CALL MSBuild %*
CALL MSBuild %*
CALL %env_qUtil%\exit_if_error


ECHO End %scriptName%
