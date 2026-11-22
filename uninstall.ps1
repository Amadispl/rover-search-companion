# Rover Search Companion - uninstaller
$ErrorActionPreference = 'SilentlyContinue'
$InstallDir = Join-Path $env:LOCALAPPDATA 'RoverSearchCompanion'

$stop = Join-Path $InstallDir 'stop_rover.ps1'
if (Test-Path $stop) { & $stop }

$startup = [Environment]::GetFolderPath('Startup')
if (-not $startup) { $startup = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup' }
Remove-Item (Join-Path $startup 'Rover Search Companion.lnk') -Force
Remove-Item $InstallDir -Recurse -Force

Write-Host "Rover Search Companion removed. DoubleAgent was left installed - remove it from Settings > Apps if you no longer need it."
