@SETLOCAL

@ECHO %~n0
@CALL %env_qUtil%\exit_if_error

SET cleanup_skip_newest_amount=%1
IF [%cleanup_skip_newest_amount%] EQU [] EXIT 1001

SET target_cleanup_folder=%2
IF [%target_cleanup_folder%] EQU [] EXIT 1002
IF [%target_cleanup_folder%] EQU [""] EXIT 1002
SET target_cleanup_folder=%target_cleanup_folder:"=%


REM Makes a cleanup for excessive amount of folders (any folders, not files).
ECHO Cleanup of %target_cleanup_folder%
ECHO Skip the newest %cleanup_skip_newest_amount% items.
@REM Do not use %%~fF instead of %%F to get a full path! It is unsafe and depend on current executed folder!
FOR /F "skip=%cleanup_skip_newest_amount% eol=: delims=" %%F IN ('DIR /B /O:-D /A:D "%target_cleanup_folder%"') DO (
  @REM ! SET= do not works in loops!
  ECHO deleting %target_cleanup_folder%\%%F
  RD /S /Q "%target_cleanup_folder%\%%F"
)

@REM Without the next simple ECHO I am receiving ERRORLEVEL = 1 if there's no need to delete files.
ECHO End of %~n0
