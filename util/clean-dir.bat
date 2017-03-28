SETLOCAL

@ECHO Clean dir
@CALL %_util%\exit_if_error

SET clean_dir_path=%1
@ECHO Clean folder %clean_dir_path%
IF [%clean_dir_path%] EQU [] GOTO BrokenInputParameter


REM Let's clear a folder.
RD /S /Q %clean_dir_path%
MKDIR %clean_dir_path%


@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333