Write-Host "Checking if Hyper-V is enabled."
$hyperVFeature = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V -Online
if ($hyperVFeature.State -eq 'Enabled') {
    Write-Host "Hyper-V is enabled."
} else {
    Write-Host "Enabling Hyper-V"
    DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
}
