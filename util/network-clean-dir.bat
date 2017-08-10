@SETLOCAL

@ECHO %~n0
@CALL %env_qUtil%\exit_if_error

SET clean_dir_path=%1
@ECHO Clean folder %clean_dir_path%
IF [%clean_dir_path%] EQU [] GOTO BrokenInputParameter


CALL network-delete-dir.bat %clean_dir_path%


MKDIR %clean_dir_path%


@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333