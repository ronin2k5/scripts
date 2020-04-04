@echo off

REM Syntax: gen_spa_supplicant.bat <ssid> <pass>

(
    echo ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    echo update_config=1
    echo country=CA
    echo.
    echo network={
    echo   	ssid=%1
    echo   	psk=%2
    echo   	key_mgmt=WPA-PSK
    echo }
) > wpa_supplicant.conf
