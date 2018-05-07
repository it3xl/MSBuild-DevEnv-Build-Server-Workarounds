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


@REM Uncomment the following workarounds as needed.
CALL %env_qManager%\workaround\MSBuild-File-System-Redirector-fail-System32-to-SysWOW64.bat
REM CALL %env_qManager%\workaround\MSBuild-Unable-to-create-Temp-directory.bat


ECHO Prepare the development environment.
@REM We need to invoke preparations script here because after migration from VS2010 to VS2015 we got a broken environment on our Build-Server
@REM  and we are getting the empty SDK40ToolsPath.
@REM MSB3086 Microsoft.Common.targets Task could not find "sgen.exe" using the SdkToolsPath "" or the registry key "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x86". Make sure the SdkToolsPath is set and the tool exists in the correct processor specific location under the SdkToolsPath and that the Microsoft Windows SDK is installed
@REM http://stackoverflow.com/questions/2731365/running-msbuild-fails-to-read-sdktoolspath
@REM http://stackoverflow.com/questions/34045326/msbuild-sgen-exe-is-missing
@REM http://stackoverflow.com/questions/26442450/why-is-visual-studio-2013-using-the-wrong-sdktoolspath-for-lc-exe
@REM
SET dev_cmd="C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\Tools\VsDevCmd.bat"
ECHO CALL %dev_cmd%
CALL %dev_cmd%
CALL %env_qUtil%\exit_if_error


ECHO CALL MSBuild %*
CALL MSBuild %*
CALL %env_qUtil%\exit_if_error


ECHO End %scriptName%
