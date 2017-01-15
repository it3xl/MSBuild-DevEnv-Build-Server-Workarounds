@REM it@it3xl.ru

@SET operation=MSBuild: Preventing File System Redirector fail.
@ECHO START: %operation%
  @REM This workaround is actual if your run unde Local System.
  @REM
  @REM For any build under system local account (Local System for our Build-Server's Win Service) there is a bug for implicit switching
  @REM  from C:\Windows\System32\config\systemprofile to C:\Windows\SysWOW64\config\systemprofile\AppData
  @REM A workaround for this is to use x64 MSBuild but we have no this option for the DevEnv calling.
  @REM
  @REM It is important to modify the CMD environment by this workaround before call of the MSBuild or DevEnv Command Prompt.
  @REM VsDevCmd.bat will install some .NET stuff into a current AppData.
  @REM And possibly DevEnv will be using of C:\Windows\system32\... again for the Local System account.
  @REM URLs:
  @REM https://social.msdn.microsoft.com/Forums/en-US/70f80ccd-9e15-49db-94ea-4564dfc1e593/msbuild-failure-what-permissions-are-needed-to-build-workflow-projects-compileworkflowtask?forum=msbuild
  @REM https://msdn.microsoft.com/en-us/library/windows/desktop/aa384187%28v=vs.85%29.aspx?f=255&MSPPError=-2147217396
  @REM http://stackoverflow.com/questions/9096208/cannot-build-workflow-project-with-msbuild-sharepoint-2010/9097079
  @REM https://connect.microsoft.com/VisualStudio/feedback/details/1580569/32-bit-msbuild-exe-running-as-local-system-calls-64-bit-vbcscompiler-exe-causing-csc-error-cs2001-source-file-file-could-not-be-found
  @REM
  @REM Allows to eliminate any use of the x64 MSBuild that was requested from the URLs above.
  
  @REM @SET homeRootRelative=Jenkins-Home
  @REM @SET homeRootRelative=CCN-Home
  @SET homeRootRelative=Build-Server-Home

  @ECHO %HOMEPATH% switched to
  @SET HOMEPATH=\%homeRootRelative%
  @ECHO %HOMEPATH%
  
  @SET homeRootAbsolute=C:\%homeRootRelative%

  @ECHO %APPDATA% switched to
  @SET APPDATA=%homeRootAbsolute%\AppData\Roaming
  @ECHO %APPDATA%

  @ECHO %LOCALAPPDATA% switched to
  @SET LOCALAPPDATA=%homeRootAbsolute%\AppData\Local
  @ECHO %LOCALAPPDATA%

  @ECHO %TEMP% switched to
  @SET TEMP=%homeRootAbsolute%\TEMP
  @ECHO %TEMP%

  @ECHO %TMP% switched to
  @SET TMP=%homeRootAbsolute%\TEMP
  @ECHO %TMP%

  @ECHO %USERPROFILE% switched to
  @SET USERPROFILE=%homeRootAbsolute%
  @ECHO %USERPROFILE%
  
  CALL %startRoot%util\exit_if_error %operation%
  
@ECHO DONE: %operation%
