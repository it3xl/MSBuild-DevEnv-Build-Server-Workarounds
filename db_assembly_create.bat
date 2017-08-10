@SETLOCAL

ECHO %~n0
CALL %env_qUtil%\exit_if_error

@REM Set UTF-8 encoding.
CHCP 65001

SET assemblyName=%1
IF [%assemblyName%] EQU [] GOTO BrokenInputParameter
SET dllPath=%2
IF [%dllPath%] EQU [] GOTO BrokenInputParameter
SET accumAssemblyPath=%3
IF [%accumAssemblyPath%] EQU [] GOTO BrokenInputParameter


SET sqlScript=%accumAssemblyPath%assemblies.register.sql


@ECHO.>> %sqlScript%

@ECHO CREATE ASSEMBLY [%assemblyName%]>> %sqlScript%
@ECHO   AUTHORIZATION dbo>> %sqlScript%
@ECHO   FROM>> %sqlScript%
CALL %env_qUtil%\AssemblyToSqlHexadecimal.exe %dllPath%>> %sqlScript%
@ECHO.>> %sqlScript%
@ECHO   WITH PERMISSION_SET = SAFE>> %sqlScript%
@ECHO GO>> %sqlScript%
@ECHO GRANT ALTER ON ASSEMBLY::[%assemblyName%] TO [PUBLIC]>> %sqlScript%
@ECHO GO>> %sqlScript%

@ECHO.>> %sqlScript%



@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333