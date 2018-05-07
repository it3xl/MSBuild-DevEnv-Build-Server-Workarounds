ECHO Start %~nx0


@REM The workaround for building .vdproj by DevEnv for the following error:
@REM Visual Studio has encountered an unexpected error.------ Starting pre-build validation for project 'Setup1' ------ 
@REM ERROR: An error occurred while validating.  HRESULT = '8000000A'
@REM http://stackoverflow.com/questions/8648428/an-error-occurred-while-validating-hresult-8000000a
@REM https://connect.microsoft.com/VisualStudio/feedback/details/595632/inconsistent-hanging-with-devenv-2010

REG ADD HKCU\SOFTWARE\Microsoft\VisualStudio\12.0_Config\MSBuild /t REG_DWORD /v EnableOutOfProcBuild /d 0 /f

@CALL %env_qUtil%\exit_if_error


ECHO End %~nx0
