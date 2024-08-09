

Write-Output "Installing Plugins for Rider"
$plugin_file = Join-Path $PSScriptRoot "..\..\general\rider_plugins.txt"
$riderCmdPath = "$env:localAppData\JetBrains\Toolbox\scripts\Rider.cmd"

if (Test-Path $riderCmdPath) {
    foreach ($plugin in Get-Content $plugin_file) {
        Write-Output "Installing Plugin: $plugin"
        Start-Process cmd.exe "/c $riderCmdPath installPlugins $plugin".Split(' ') -NoNewWindow -Wait
    }
} else {
    Write-Output "Rider.cmd file not found at $riderCmdPath"
}
