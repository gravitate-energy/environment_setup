
Write-Output "Installing Zero Tier One"

if (-not (Get-Command zerotier-cli -ErrorAction SilentlyContinue)) {
    $url = "https://download.zerotier.com/dist/ZeroTier%20One.msi"; `
    $ProgressPreference = 'SilentlyContinue'; `
    Write-Output "Downloading $url"; `
    Invoke-WebRequest -Uri $url -OutFile "$env:APPDATA\zero_tier_one.msi"; `
    $ProgressPreference = 'Continue'; `
    Write-Output "Installing Zero Tier One"; `
    Start-Process msiexec "/i $env:APPDATA\zero_tier_one.msi /quiet".Split(' ') -NoNewWindow -Wait
    Write-Output "Installed Zero Tier One";
} else {
    # Chocolatey is installed
    Write-Host "Zero Tier One is already installed."
}

