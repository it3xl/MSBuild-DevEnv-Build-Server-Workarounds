@SETLOCAL

ECHO %~n0 / Create an archive for a current build.
CALL %env_qUtil%\exit_if_error

SET buildName=%1
IF [%buildName%] EQU [] GOTO BrokenInputParameter
SET accumPath=%2
IF [%accumPath%] EQU [] GOTO BrokenInputParameter

IF [%buildArtifactsFolder%] EQU [] GOTO BrokenEnvironment



SET archType=7z
REM accumPath must already contain the "%buildName%" at the end.
SET archiveAccumPath=%accumPath%.%archType%

SET archiveArtifactPath=%buildArtifactsFolder%\%buildName%.%archType%

REM Create an archive.
@REM "C:\Program Files\WinRar\winrar.exe" a -afzip -r0 %accumPath%.zip *.*
"C:\Program Files\7-Zip\7z.exe" a %archiveAccumPath% "%accumPath%\*"
ECHO ERRORLEVEL %ERRORLEVEL%


REM Create the dir for store and hide the "folder already exist" error.
MKDIR %buildArtifactsFolder% 2>NUL

REM Move archive file to atrifacts
MOVE /Y %archiveAccumPath% %buildArtifactsFolder%




@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333

:BrokenEnvironment
ECHO  !#!  Interrupted. Not all environment variables have been set to call this script!
ECHO.
EXIT 334