# Rover Search Companion - installer
# Usage:  powershell -ExecutionPolicy Bypass -File install.ps1 [-AcsPath C:\path\to\rover.acs] [-NoAutostart]

param(
    [string]$AcsPath,
    [switch]$NoAutostart
)

$ErrorActionPreference = 'Stop'
$InstallDir = Join-Path $env:LOCALAPPDATA 'RoverSearchCompanion'
$Src        = Join-Path $PSScriptRoot 'src'

function Test-AcsFile([string]$Path) {
    if (-not $Path -or -not (Test-Path -LiteralPath $Path -PathType Leaf)) { return $false }
    $fs = [System.IO.File]::OpenRead($Path)
    try {
        $buf = New-Object byte[] 4
        $null = $fs.Read($buf, 0, 4)
    } finally { $fs.Close() }
    # Microsoft Agent .acs signature: C3 AB CD AB
    return ($buf[0] -eq 0xC3 -and $buf[1] -eq 0xAB -and $buf[2] -eq 0xCD -and $buf[3] -eq 0xAB)
}

Write-Host "`n== Rover Search Companion installer ==`n" -ForegroundColor Cyan

# 1. DoubleAgent
if (-not (Test-Path 'Registry::HKEY_CLASSES_ROOT\DoubleAgent.Control')) {
    Write-Host "DoubleAgent is not installed." -ForegroundColor Red
    Write-Host "Install it first from https://sourceforge.net/projects/doubleagent/files/latest/download and run this script again."
    exit 1
}
Write-Host "[ok] DoubleAgent found"

# 2. rover.acs
if (-not $AcsPath) {
    $candidates = @(
        (Join-Path $PSScriptRoot 'rover.acs'),
        (Join-Path $env:USERPROFILE 'Downloads\rover.acs'),
        (Join-Path $env:WINDIR 'msagent\chars\rover.acs'),
        (Join-Path $env:WINDIR 'srchasst\chars\rover.acs')
    )
    $AcsPath = $candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
}
if (-not $AcsPath) {
    $AcsPath = Read-Host "Path to rover.acs (copy it from C:\Windows\srchasst\chars on a Windows XP install)"
}
$AcsPath = $AcsPath.Trim('"')
if (-not (Test-AcsFile $AcsPath)) {
    Write-Host "'$AcsPath' is not a valid Microsoft Agent character file (.acs)." -ForegroundColor Red
    exit 1
}
Write-Host "[ok] Character file: $AcsPath"

# 3. Copy files
& (Join-Path $Src 'stop_rover.ps1') 2>$null
New-Item -ItemType Directory -Force $InstallDir | Out-Null
Copy-Item (Join-Path $Src '*') $InstallDir -Force
Copy-Item -LiteralPath $AcsPath (Join-Path $InstallDir 'rover.acs') -Force
Write-Host "[ok] Installed to $InstallDir"

# 4. Autostart
$lnk = Join-Path ([Environment]::GetFolderPath('Startup')) 'Rover Search Companion.lnk'
if (-not $NoAutostart) {
    $s = (New-Object -ComObject WScript.Shell).CreateShortcut($lnk)
    $s.TargetPath       = Join-Path $env:WINDIR 'System32\wscript.exe'
    $s.Arguments        = '"' + (Join-Path $InstallDir 'start_rover.vbs') + '"'
    $s.WorkingDirectory = $InstallDir
    $s.Save()
    Write-Host "[ok] Autostart enabled"
}

# 5. Start
Start-Process (Join-Path $env:WINDIR 'System32\wscript.exe') -ArgumentList ('"' + (Join-Path $InstallDir 'start_rover.vbs') + '"')
Write-Host "`nDone! Press Win+S or click the search icon - Rover is on his way. Woof!`n" -ForegroundColor Green
