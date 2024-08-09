@echo off

powershell -ExecutionPolicy Bypass -File "%~dp0scripts\hyper_v_enable.ps1"
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\chocolatey_packages.ps1"
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\zero_tier_one_install.ps1"
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\azure_cli.ps1"
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\create_ssh_keys.ps1"
dotnet workload update
dotnet workload install aspire



pause
