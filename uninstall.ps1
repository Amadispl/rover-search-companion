# Rover Search Companion - uninstaller
$ErrorActionPreference = 'SilentlyContinue'
$InstallDir = Join-Path $env:LOCALAPPDATA 'RoverSearchCompanion'

$stop = Join-Path $InstallDir 'stop_rover.ps1'
if (Test-Path $stop) { & $stop }

Remove-Item (Join-Path ([Environment]::GetFolderPath('Startup')) 'Rover Search Companion.lnk') -Force
Remove-Item $InstallDir -Recurse -Force

Write-Host "Rover Search Companion removed. DoubleAgent was left installed - remove it from Settings > Apps if you no longer need it."
