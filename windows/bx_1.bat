@echo off
powershell -Command "Set-ExecutionPolicy unrestricted -Scope CurrentUser -F"
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\box_starter\choco_install.ps1"