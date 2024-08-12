Import-Module Boxstarter.Chocolatey
$cred=Get-Credential $env:username
Install-BoxstarterPackage -PackageName (Join-Path $PSScriptRoot 'package.ps1') -Credential $cred

