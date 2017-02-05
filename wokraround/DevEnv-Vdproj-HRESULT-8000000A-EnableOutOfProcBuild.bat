@SET operation=DevEnv: Corrections of the Registry for EnableOutOfProcBuild.
@ECHO START: %operation%
  @REM The woraround actual for building Vdproj by DevEnv from CMD where we will receive the next error:
  @REM Visual Studio has encountered an unexpected error.------ Starting pre-build validation for project 'Setup1' ------ 
  @REM ERROR: An error occurred while validating.  HRESULT = '8000000A'
  @REM URLs:
  @REM http://stackoverflow.com/questions/8648428/an-error-occurred-while-validating-hresult-8000000a
  @REM https://connect.microsoft.com/VisualStudio/feedback/details/595632/inconsistent-hanging-with-devenv-2010

  REG ADD HKCU\SOFTWARE\Microsoft\VisualStudio\14.0_Config\MSBuild /t REG_DWORD /v EnableOutOfProcBuild /d 0 /f
  @REM (use 12.0_Config for VS2013)

  @CALL %rootPath%util\exit_if_error

@ECHO END: %operation%
