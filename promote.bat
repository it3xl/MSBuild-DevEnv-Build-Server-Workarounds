@SETLOCAL
@REM @ECHO ON

@ECHO %~n0
CALL %env_qUtil%\exit_if_error

SET rootPromoteFolderName=%1
IF [%rootPromoteFolderName%] EQU [] EXIT 1001

SET accumPath=%2
IF [%accumPath%] EQU [] EXIT 1002
IF [%accumPath%] EQU [""] EXIT 1002
SET accumPath=%accumPath:"=%
SET q_accumPath="%accumPath%"

SET buildLabel=%3
IF [%buildLabel%] EQU [] EXIT 1003


SET currentPromoteRootPath=%global_rootSupportSharedFolder%\%rootPromoteFolderName%
SET $promotionsFolderName=.last promotions
SET promotingPathRoot=%currentPromoteRootPath%\%$promotionsFolderName%
SET promotingPathRootQ="%promotingPathRoot%"
SET promotingPathQ="%currentPromoteRootPath%\%$promotionsFolderName%\%buildLabel%"

SET prodPathRoot=%currentPromoteRootPath%\PROD
SET uatPathRootQ="%currentPromoteRootPath%\UAT"

SET prodMarkFolderQ="%prodPathRoot%\x- now copying %buildLabel%"
IF NOT EXIST %prodMarkFolderQ% MKDIR %prodMarkFolderQ%
SET uatMarkFolder=%uatPathRootQ%\"! now copying %buildLabel%"
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
IF NOT EXIST %promotingPathQ% MKDIR %promotingPathQ%
IF EXIST %lastPromotionDir% (
  ECHO ! Speed up by a local copying with a subsequent updating by ROBOCOPY !
  ECHO ! Start local outdated copy creation.
  CALL %env_qUtil%\ROBOCOPY_copy.bat %lastPromotionDir% %promotingPathQ%
)
@REM </Speed up by ROBOCOPY>
CALL %env_qUtil%\ROBOCOPY_copy.bat %q_accumPath% %promotingPathQ%


REM Promote to Productions artifacts.
RD /S /Q %prodMarkFolderQ%
SET prodTempFolder="%prodPathRoot%\x-copying-%buildLabel%"
CALL %env_qUtil%\ROBOCOPY_copy.bat %promotingPathQ% %prodTempFolder%
CALL %env_qUtil%\network-delete-dir.bat "%prodPathRoot%\%buildLabel%"
CALL %env_qUtil%\network-MOVE.bat %prodTempFolder% "%prodPathRoot%\%buildLabel%"

CALL %env_qUtil%\cleanup_old_folders.bat 25 "%prodPathRoot%"


REM Promote to UAT artifacts.
SET uatTempFolder="%currentPromoteRootPath%\UAT-copying-%buildLabel%"
CALL %env_qUtil%\ROBOCOPY_copy.bat %promotingPathQ% %uatTempFolder%
CALL %env_qUtil%\network-delete-dir.bat %uatPathRootQ%
CALL %env_qUtil%\network-MOVE.bat %uatTempFolder% %uatPathRootQ%


CALL %env_qUtil%\cleanup_old_folders.bat 5 %promotingPathRootQ%




