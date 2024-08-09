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