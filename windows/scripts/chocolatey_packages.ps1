Write-Output "Installing Chocolatey Packages"

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    throw "Chocolatey is not installed or isn't avaliable in this Window. Please run this in a new administrative window after chocolatey is installed."
} else {
    # Chocolatey is installed
    choco feature enable -n allowGlobalConfirmation;
    $plugin_file = Join-Path $PSScriptRoot "chocolatey-package-list.txt"
    $installed = choco list --lo -r  | ConvertFrom-Csv -delimiter "|" -Header Id,Version | ForEach-Object { $_.Id }
    $plugin_list = Get-Content $plugin_file | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
    foreach ($plugin in $plugin_list) {
        if ($installed -contains $plugin) {
            Write-Host "skipping [$plugin] because it is already installed"
        }else {
            Write-Output "installing [$plugin]"
            choco install $plugin -y
        }
    }

}






