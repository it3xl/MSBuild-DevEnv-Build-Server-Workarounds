@REM it@it3xl.ru

@SET operation=MSBuild: Preventing of a bug with a non existing Temp folder.
@ECHO START: %operation%
  @REM This workaround is actual fot those who uses the "CompileWorkflowTask".
  @REM
  @REM Some MSBuild tasks really can't create a C:\...\AppData\Local\Temp folder and throws the next error:
  @REM warning MSB3245: Could not resolve this reference. Could not locate the assembly "WF.WorkflowCore, Version=27.0.5088.24788, Culture=neutral, processorArchitecture=MSIL". Check to make sure the assembly exists on disk. If this reference is required by your code, you may get compilation errors.
  @REM error MSB4018: The "CompileWorkflowTask" task failed unexpectedly.
  @REM C:\Windows\Microsoft.NET\Framework\v4.0.30319\Workflow.targets(121,5): error MSB4018: System.IO.DirectoryNotFoundException: Could not find a part of the path 'C:\...\AppData\Local\Temp\ji3foqok.tmp'.
  @REM URLs:
  @REM https://social.msdn.microsoft.com/Forums/en-US/70f80ccd-9e15-49db-94ea-4564dfc1e593/msbuild-failure-what-permissions-are-needed-to-build-workflow-projects-compileworkflowtask?forum=msbuild
  @REM https://msdn.microsoft.com/en-us/library/windows/desktop/aa384187%28v=vs.85%29.aspx?f=255&MSPPError=-2147217396
  @REM http://stackoverflow.com/questions/9096208/cannot-build-workflow-project-with-msbuild-sharepoint-2010/9097079
  @REM https://connect.microsoft.com/VisualStudio/feedback/details/1580569/32-bit-msbuild-exe-running-as-local-system-calls-64-bit-vbcscompiler-exe-causing-csc-error-cs2001-source-file-file-could-not-be-found
  @REM
  @REM Allows to eliminate any use of the x64 MSBuild that was requested from the URLs above.
  
  @IF NOT EXIST %LOCALAPPDATA%\Temp (MKDIR %LOCALAPPDATA%\Temp)

  CALL %startRoot%util\exit_if_error %operation%

@ECHO END: %operation%
