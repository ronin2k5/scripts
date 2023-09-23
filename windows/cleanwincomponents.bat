@echo off

REM Clean up payloads of disabled and old components in WinSXS folder to save space
REM NOTE: Must be run as admin...

set FEATURES=DISM.exe /Online /English /Get-Features /Format:Table

for /f "tokens=1 delims= " %%f in ('%FEATURES% ^| find "Disabled"') do (
    
    rem echo %%f

    DISM.exe /Online /Disable-Feature /featurename:%%f /Remove

)
