SET startRoot=%~dp0

@CALL %startRoot%util\exit_if_error

SET Command_Prompt_Path="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsMSBuildCmd.bat"

@REM Uncomment lines with workarounds.
REM CALL %startRoot%wokraround\MSBuild-File-System-Redirector-fail-System32-to-SysWOW64.bat
REM CALL %startRoot%wokraround\MSBuild-Unable-to-create-Temp-directory.bat

@SET operation=MSBuild: Prepare environment (by invoking the MSBuild Command Prompt for VS2015).
@ECHO START: %operation%
  @REM We need to invoke preparations script here because after migration from VS2010 to VS2015 we got a broken environment on our Build-Server
  @REM  and we are getting the empty SDK40ToolsPath.
  @REM MSB3086 Microsoft.Common.targets Task could not find "sgen.exe" using the SdkToolsPath "" or the registry key "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x86". Make sure the SdkToolsPath is set and the tool exists in the correct processor specific location under the SdkToolsPath and that the Microsoft Windows SDK is installed
  @REM Bug urls:
  @REM http://stackoverflow.com/questions/2731365/running-msbuild-fails-to-read-sdktoolspath
  @REM http://stackoverflow.com/questions/34045326/msbuild-sgen-exe-is-missing
  @REM http://stackoverflow.com/questions/26442450/why-is-visual-studio-2013-using-the-wrong-sdktoolspath-for-lc-exe

  CALL %Command_Prompt_Path%

  @CALL %startRoot%util\exit_if_error
@ECHO END: %operation%


@SET operation=Call MSBuild.
@ECHO START: %operation%
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

  @CALL %startRoot%util\exit_if_error
@ECHO END: %operation%

@ECHO Exit MSBuild wrapper for VS2015 with the exit code: %ERRORLEVEL%
@REM We will use the EXIT command to inform any Build-Server with a status of execution (0 means no errors).
EXIT %ERRORLEVEL%
