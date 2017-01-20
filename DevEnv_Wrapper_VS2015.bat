@REM it@it3xl.ru

SET Command_Prompt_Path="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"

SET startRoot=%~dp0

@CALL %startRoot%util\exit_if_error

CALL %startRoot%wokraround\DevEnv-Vdproj-HRESULT-8000000A-EnableOutOfProcBuild.bat
CALL %startRoot%wokraround\MSBuild-File-System-Redirector-fail-System32-to-SysWOW64.bat
CALL %startRoot%wokraround\MSBuild-Unable-to-create-Temp-directory.bat

@SET operation=DevEnv: Prepare environment (by invoking the Developer Command Prompt for VS2015).
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


@SET operation=Call DevEnv.COM.
@ECHO START: %operation%
  @ECHO Parameters: %*
  @IF [%1] EQU [] (
    @ECHO Error. Exit. Parameters for the target call was not specified.
    EXIT 30
  )
  @ECHO #
  @ECHO #
  @REM We have to use exactly the "DevEnv.COM" wrapper of the VS IDE "DevEnv.EXE". There are some troubles with "DevEnv.EXE".
  @REM So, here we explicitly prevent cases where ".COM" not the first value at the PATHEXT environment variable.
  @REM Example of a problem - PATHEXT: ".EXE;.COM;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC"
  CALL DevEnv.COM %*
  @ECHO #
  @ECHO #

  @CALL %startRoot%util\exit_if_error
@ECHO END: %operation%

@ECHO Exit DevEnv wrapper for VS2015 with the exit code: %ERRORLEVEL%
@REM We will use the EXIT command to inform any Build-Server with a status of execution (0 means no errors).
EXIT %ERRORLEVEL%
