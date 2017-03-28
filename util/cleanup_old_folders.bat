SETLOCAL

ECHO cleanup_old_folders.bat
@CALL %_util%\exit_if_error

SET cleanup_skip_newest_amount=%1
IF [%cleanup_skip_newest_amount%] EQU [] GOTO BrokenInputParameter
SET target_cleanup_folder=%2
IF [%target_cleanup_folder%] EQU [] GOTO BrokenInputParameter


REM Makes a cleanup for excessive amount of folders (any folders, not files).
ECHO Cleanup of %target_cleanup_folder%
ECHO Skip the newest %cleanup_skip_newest_amount% items.
FOR /F "skip=%cleanup_skip_newest_amount% eol=: delims=" %%F IN ('DIR /B /O:-D /A:D %target_cleanup_folder%') DO RD /S /Q %target_cleanup_folder%\"%%F"


@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333