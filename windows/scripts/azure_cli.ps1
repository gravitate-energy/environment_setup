
if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Azure CLI"
    $ProgressPreference = 'SilentlyContinue'; 
    Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; 
    Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; 
    Remove-Item .\AzureCLI.msi
} else {
    # Chocolatey is installed
    Write-Host "Azure CLI already installed."
}

