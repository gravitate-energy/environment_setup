@echo off


echo "Installing Rider Plugins"
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\toolbox_plugins.ps1"
