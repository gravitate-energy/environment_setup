choco feature enable -n allowGlobalConfirmation

Disable-UAC


#--- Tools / Environment ---
$packages = (
  'dotnet-8.0-sdk',
  'sysinternals',
  'jetbrainstoolbox',
  'vscode',
  'sql-server-management-studio',
  'curl',
  'agentransack',
  'filezilla',
  'git',
  'gitkraken',
  'notepadplusplus',
  'postman',
  'wiztree',
  'rdm',
  'slack',
  'bitvise-ssh-client',
  'cmder',
  'putty',
  'python',
  'everything',
  'gh',
  'dbforge-sql-cmpl',
  'kubernetes-cli',
  '7zip.install',
  'lightshot',
  'vscode',
  'another-redis-desktop-manager',
  'nvm',
  'googlechrome',
  'firefox',
  'sqlcmd',
  'git'
)

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
  throw "Chocolatey is not installed or isn't avaliable in this Window. Please run this in a new administrative window after chocolatey is installed."
} else {
  # Chocolatey is installed
  $installed = choco list --lo -r  | ConvertFrom-Csv -delimiter "|" -Header Id,Version | ForEach-Object { $_.Id }
  foreach ($plugin in $packages) {
      if ($installed -contains $plugin) {
          Write-Host "skipping [$plugin] because it is already installed"
      }else {
          Write-Output "installing [$plugin]"
          choco install $plugin -y
      }
  }
}
refreshenv

#--- Zero Tier CLI ---
if (-not (Get-Command zerotier-cli -ErrorAction SilentlyContinue)) {
  Write-Output "Installing Zero Tier One"; 
  $url = "https://download.zerotier.com/dist/ZeroTier%20One.msi"; 
  $ProgressPreference = 'SilentlyContinue'; 
  Write-Output "Downloading $url"; 
  Invoke-WebRequest -Uri $url -OutFile .\zero_tier_one.msi; 
  $ProgressPreference = 'Continue'; 
  Write-Output "Executing Installer"; 
  Start-Process msiexec -Wait  -ArgumentList "/I zero_tier_one.msi /quiet"
  Remove-Item .\zero_tier_one.msi
  Write-Output "Installed Zero Tier One";
} else {
  # Chocolatey is installed
  Write-Host "Zero Tier One is already installed."
}


#--- Azure CLI ---
if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
  Write-Output "Installing Azure CLI"
  $url = "https://aka.ms/installazurecliwindows"; 
  $ProgressPreference = 'SilentlyContinue'; 
  Write-Output "Downloading $url"; `
  Invoke-WebRequest -Uri $url -OutFile .\AzureCLI.msi; 
  Write-Output "Executing Installer"; 
  Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; 
  Remove-Item .\AzureCLI.msi
  Write-Output "Installed Azure CLI"
} else {
  # Chocolatey is installed
  Write-Host "Azure CLI already installed."
}



#--- Git ---
git config --global set core.autocrlf true
git config --global set core.fscache true
git config --global set core.symlinks false
git config --global set pull.rebase false
git config --global set init.defaultbranch master

Write-Output "Creating SSH keys for the user."
$sshKeysFolder = "$env:USERPROFILE\.ssh"
$sshKeysPath = Join-Path $sshKeysFolder "id_rsa"
$sshKeysExist = Test-Path $sshKeysPath

if ($sshKeysExist) {
    Write-Host "$sshKeysPath already exists."
} else {
    if (-not (Test-Path $sshKeysFolder)) {
        New-Item -ItemType Directory -Path $sshKeysFolder | Out-Null
    }
    ssh-keygen -q -t rsa -b 4096 -N '""' -f $sshKeysPath
    Write-Host "SSH keys generated successfully."
}



#--- Windows Settings ---
Set-ExplorerOptions -showHidenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Enable-RemoteDesktop


#--- Install Ubuntu/WSL/DockerDesktop

cinst Microsoft-Hyper-V-All -source windowsFeatures
wsl --install
cinst docker-desktop

#--- WSL Stuff ---
if (!(Get-Command 'wsl' -ErrorAction SilentlyContinue)) {
  Write-Error @'
You need Windows Subsystem for Linux setup before the rest of this script can run.

See https://docs.microsoft.com/en-us/windows/wsl/install-win10 for more information.
'@
  Exit
}

if ((wsl awk '/^ID=/' /etc/*-release | wsl awk -F'=' '{ print tolower(\$2) }') -ne 'ubuntu') {
  Write-Error 'Ensure Windows Subsystem for Linux is setup to run the Ubuntu distribution'
  Exit
}

if ((wsl awk '/^DISTRIB_RELEASE=/' /etc/*-release | wsl awk -F'=' '{ print tolower(\$2) }') -lt 16.04) {
  Write-Error 'You need to install a minimum of Ubuntu 16.04 Xenial Xerus before running this script'
  Exit
}
$windows_bash_script_path = [regex]::Escape($PSScriptRoot) + '\\install.sh'
$linux_bash_script_path=(wsl wslpath -a "$windows_bash_script_path")
wsl cp "$linux_bash_script_path" "/tmp/"

wsl bash -c "/tmp/install.sh"

refreshenv