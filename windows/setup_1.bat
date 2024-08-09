@echo off


echo "Setting execution policy"
powershell -Command "Set-ExecutionPolicy unrestricted -Scope CurrentUser -F"
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\chocolatey_install.ps1"

pause