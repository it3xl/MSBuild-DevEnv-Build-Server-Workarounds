@SETLOCAL
@REM @ECHO ON

@ECHO %~n0
CALL %env_qUtil%\exit_if_error

SET rootPromoteFolderName=%1
IF [%rootPromoteFolderName%] EQU [] GOTO BrokenInputParameter

IF [%accumPath%] EQU [] GOTO BrokenEnvironment
IF [%buildName%] EQU [] GOTO BrokenEnvironment


@REM ! Importaln. No white spaces in this path!
SET rootSupportSharedFolder=\\some\share\distrib\folder

SET currentPromoteRootPath=%rootSupportSharedFolder%\%rootPromoteFolderName%
SET $promotionsFolderName=.last promotions
SET promotingPathRoot=%currentPromoteRootPath%\%$promotionsFolderName%
SET promotingPathRootQ="%promotingPathRoot%"
SET promotingPath="%currentPromoteRootPath%\%$promotionsFolderName%\%buildName%"

SET prodPathRoot=%currentPromoteRootPath%\PROD
SET uatPathRoot="%currentPromoteRootPath%\UAT"

SET prodMarkFolder="%prodPathRoot%\x- now copying %buildName%"
IF NOT EXIST %prodMarkFolder% MKDIR %prodMarkFolder%
SET uatMarkFolder=%uatPathRoot%\"! now copying %buildName%"
IF NOT EXIST %uatMarkFolder% MKDIR %uatMarkFolder%

REM Put to temp promoting fodler.
IF NOT EXIST %promotingPathRootQ% MKDIR %promotingPathRootQ%

@REM <Speed up by ROBOCOPY>
@REM In case of a slow network near the Build-Machine the copying from the Build-Machine to a remote share is slow.
@REM Workaround. Copy a before promoted folder and update it by ROBOCOPY from the Build-Machine folder.
SET lastPromotionDir=""
FOR /F "eol=: delims=" %%F IN ('DIR /B /O:-D /A:D %promotingPathRootQ%') DO (
  SET lastPromotionDir="%promotingPathRoot%\%%F"
  GOTO LastPromotion
)
:LastPromotion
IF NOT EXIST %promotingPath% MKDIR %promotingPath%
IF EXIST %lastPromotionDir% (
  ECHO ! Speed up by a local copying with a subsequent updating by ROBOCOPY !
  ECHO ! Start local outdated copy creation.
  CALL %env_qUtil%\ROBOCOPY_copy.bat %lastPromotionDir% %promotingPath%
)
@REM </Speed up by ROBOCOPY>
CALL %env_qUtil%\ROBOCOPY_copy.bat %accumPath% %promotingPath%


REM Promote to Productions artifacts.
RD /S /Q %prodMarkFolder%
SET prodTempFolder="%prodPathRoot%\x-copying-%buildName%"
CALL %env_qUtil%\ROBOCOPY_copy.bat %promotingPath% %prodTempFolder%
CALL %env_qUtil%\network-delete-dir.bat "%prodPathRoot%\%buildName%"
CALL %env_qUtil%\network-MOVE.bat %prodTempFolder% "%prodPathRoot%\%buildName%"

CALL %env_qUtil%\cleanup_old_folders.bat 25 "%prodPathRoot%"


REM Promote to UAT artifacts.
SET uatTempFolder="%currentPromoteRootPath%\UAT-copying-%buildName%"
CALL %env_qUtil%\ROBOCOPY_copy.bat %promotingPath% %uatTempFolder%
CALL %env_qUtil%\network-delete-dir.bat %uatPathRoot%
CALL %env_qUtil%\network-MOVE.bat %uatTempFolder% %uatPathRoot%


CALL %env_qUtil%\cleanup_old_folders.bat 5 %promotingPathRootQ%




@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333

:BrokenEnvironment
ECHO  !#!  Interrupted. Not all environment variables have been set to call this script!
ECHO.
EXIT 334