@SETLOCAL

ECHO %~n0
ECHO Create an archive for a current build.

CALL %env_qUtil%\exit_if_error

SET buildLabel=%1
IF [%buildLabel%] EQU [] EXIT 1001

SET accumPath=%2
IF [%accumPath%] EQU [] EXIT 1002
IF [%accumPath%] EQU [""] EXIT 1002
SET accumPath=%accumPath:"=%
SET q_accumPath="%accumPath%"

SET storePath=%3
IF [%storePath%] EQU [] EXIT 1003
IF [%storePath%] EQU [""] EXIT 1003
SET storePath=%storePath:"=%
SET q_storePath="%storePath%"


SET archType=7z
SET q_archivePath="%accumPath%\..\%buildLabel%.%archType%"

REM Create an archive.
@REM "C:\Program Files\WinRar\winrar.exe" a -afzip -r0 %accumPath%.zip *.*
"C:\Program Files\7-Zip\7z.exe" a %q_archivePath% "%accumPath%\*"
ECHO ERRORLEVEL %ERRORLEVEL%


IF NOT EXIST %q_storePath% MKDIR %q_storePath%

REM Move archive file to atrifacts
MOVE /Y %q_archivePath% %q_storePath%

ECHO ERRORLEVEL %ERRORLEVEL%

