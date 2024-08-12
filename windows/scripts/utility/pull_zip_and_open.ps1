$url = 'https://github.com/gravitate-energy/environment_setup/archive/refs/heads/master.zip'; `
$extract_path = 'C:\temp\setup'; `
$tempFile =  Get-ChildItem ([IO.Path]::GetTempFileName()) | Rename-Item -NewName { [IO.Path]::ChangeExtension($_, ".zip") } -PassThru; `
Invoke-WebRequest -Uri $url -OutFile $tempFile.FullName; `
Expand-Archive -Path $tempFile.FullName -DestinationPath 'C:\temp\setup' -Force; `
Remove-Item $tempFile.FullName; `
Invoke-Item (Join-Path $extract_path 'environment_setup-master\windows');


