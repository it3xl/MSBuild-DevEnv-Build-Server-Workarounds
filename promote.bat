SETLOCAL

@ECHO Promote starting
CALL %_util%\exit_if_error

SET rootPromoteFolderName=%1
IF [%rootPromoteFolderName%] EQU [] GOTO BrokenInputParameter

IF [%accumPath%] EQU [] GOTO BrokenEnvironment
IF [%buildName%] EQU [] GOTO BrokenEnvironment


SET rootSupportSharedFolder=\\some\share\distrib\folder
SET currentPromoteRootPath=%rootSupportSharedFolder%\%rootPromoteFolderName%
SET promotingPathRoot="%currentPromoteRootPath%\.last promotions"
SET prodPathRoot="%currentPromoteRootPath%\PROD"
SET uatPathRoot="%currentPromoteRootPath%\UAT"

SET prodMarkFolder=%prodPathRoot%\"x- now promoting %buildName%"
MKDIR %prodMarkFolder%
SET uatMarkFolder=%uatPathRoot%\"! now promoting %buildName%"
MKDIR %uatMarkFolder%

REM Put to temp promoting fodler.
MKDIR %promotingPathRoot% 2> NUL
SET promotingPath=%promotingPathRoot%\"%buildName%"

MKDIR %promotingPath%
XCOPY %accumPath%\* %promotingPath%\ /E /I /Y

REM Promote to Productions artifacts.
SET prodTempFolder=%prodPathRoot%\"x-%buildName%"
XCOPY %promotingPath%\* %prodTempFolder%\ /E /I /Y
@REM
ECHO MOVE %prodTempFolder% %prodPathRoot%\"%buildName%"
CALL %_util%\network-MOVE.bat %prodTempFolder% %prodPathRoot%\"%buildName%"
RD /S /Q %prodMarkFolder%
CALL %_util%\cleanup_old_folders.bat 25 %prodPathRoot%

REM Promote to UAT artifacts.
CALL %_util%\network-clean-dir.bat %uatPathRoot%
@REM Check UAT is empty.
SET uatEmpty=true
FOR /F "delims=" %%i IN ('DIR %uatPathRoot% /A-D /B /O:GN 2^>NUL') DO SET uatEmpty=false
IF %uatEmpty% NEQ true (
  @ECHO.
  @ECHO Warning! Not all files were deleted in %uatPathRoot%
  @ECHO.
  
  FOR /F "delims=" %%i IN ('DIR %uatPathRoot% /A-D /B /S /O:GN 2^>NUL') DO (
    @REM Compromises content of remaining files.
    (TYPE nul> "%%i") 2> NUL
    @REM Tries to delete remaining files.
    DEL /Q /F "%%i" 2> NUL
  )
  
  @REM Last chance to empty the folder.
  CALL %_util%\clean-network-dir %uatPathRoot%
  
  @REM Check UAT is empty.
  SET uatEmpty=true
  FOR /F "delims=" %%i IN ('DIR %uatPathRoot% /A-D /B /O:GN 2^>NUL') DO SET uatEmpty=false
  
)

MKDIR %uatMarkFolder%
IF %uatEmpty% EQU true (
  @ECHO Copying to UAT foder.
  XCOPY %promotingPath%\* %uatPathRoot%\ /E /I /Y
  MKDIR %uatPathRoot%\"! done promote %buildName%"
) ELSE (
  @ECHO.
  @ECHO Error! Sorry, still can't clear %uatPathRoot%
  @ECHO Copy UAT files from %promotingPath%
  @ECHO.
  
  MKDIR %uatPathRoot%\"! Error promote. Copy %buildName% from PROD"
)
RD /S /Q %uatMarkFolder%



CALL %_util%\cleanup_old_folders.bat 5 %promotingPathRoot%




@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333

:BrokenEnvironment
ECHO  !#!  Interrupted. Not all environment variables have been set to call this script!
ECHO.
EXIT 334