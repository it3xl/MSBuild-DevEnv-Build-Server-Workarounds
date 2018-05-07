@SETLOCAL
@REM 
@ECHO OFF

ECHO: & ECHO Start %~nx0 & ECHO:


@REM The workaround for building .vdproj by DevEnv for the following error:
@REM Visual Studio has encountered an unexpected error.------ Starting pre-build validation for project 'Setup1' ------ 
@REM ERROR: An error occurred while validating.  HRESULT = '8000000A'
@REM http://stackoverflow.com/questions/8648428/an-error-occurred-while-validating-hresult-8000000a
@REM https://connect.microsoft.com/VisualStudio/feedback/details/595632/inconsistent-hanging-with-devenv-2010

SET current_path="%CD%"
REM Bug! The DisableOutOfProcBuild.exe doesn't work if the current directory of CMD doesn't set to the installation location of DisableOutOfProcBuild.exe.
ECHO Seting the current path to the DisableOutOfProcBuild.exe installation folder.
@REM
CD "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\CommonExtensions\Microsoft\VSI\DisableOutOfProcBuild"
ECHO:
CALL DisableOutOfProcBuild.exe


IF [%env_qUtil%] NEQ [] (
  CALL %env_qUtil%\exit_if_error
)


ECHO: & ECHO Revert the previous current directory.
CD %current_path%
ECHO CD is set to %CD%


@ECHO End %~nx0 & ECHO:
