@SETLOCAL
@REM 
@ECHO OFF

SET scriptName=%~n0
@ECHO %scriptName%

SET invokePath=%~dp0.
@REM The CALL preserves quotes for ~dp0. Prevents problems "Extra quotes inside a path" if this file invoked with a path with quotes.
SET invokePath=%invokePath:"=%
CALL "%invokePath%\util\set-evnironment.bat"

@ECHO Prepare MsBuild environment (by invoking the Visual Studio Command Prompt for VS2010).
  @REM VS2010 has no "MSBuild Command Prompt"!
  @REM We need to invoke preparations script here because after migration from VS2010 to VS2015 we got a broken environment on our Build-Server
  @REM  and we are getting the empty SDK40ToolsPath.
  @REM MSB3086 Microsoft.Common.targets Task could not find "sgen.exe" using the SdkToolsPath "" or the registry key "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x86". Make sure the SdkToolsPath is set and the tool exists in the correct processor specific location under the SdkToolsPath and that the Microsoft Windows SDK is installed
  @REM Bug urls:
  @REM http://stackoverflow.com/questions/2731365/running-msbuild-fails-to-read-sdktoolspath
  @REM http://stackoverflow.com/questions/34045326/msbuild-sgen-exe-is-missing
  @REM http://stackoverflow.com/questions/26442450/why-is-visual-studio-2013-using-the-wrong-sdktoolspath-for-lc-exe
  CALL "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
  @IF %ERRORLEVEL% NEQ 0 (
    @ECHO Error. Exit. Preparetions has an error/s. Exit code: %ERRORLEVEL%
    EXIT %ERRORLEVEL%
  )
@ECHO DONE: Prepare MsBuild environment (by invoking the Visual Studio Command Prompt for VS2010).

@ECHO Call MSBuild
  @ECHO Parameters: %*
  @IF [%1] EQU [] (
    @ECHO Error. Exit. Parameters for the target call was not specified.
    EXIT 30
  )
  @ECHO #
  @ECHO #
  CALL MSBuild %*
  @ECHO #
  @ECHO #
@ECHO DONE: Call MSBuild.

@ECHO Exit batch file with the exit code: %ERRORLEVEL%
@REM We will use the EXIT command to inform any Build-Server with a status of execution (0 means no errors).
EXIT %ERRORLEVEL%
