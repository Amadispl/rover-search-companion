# Rover Search Companion - brings the Windows XP search dog back to Windows 11 search.
# Must run in 32-bit PowerShell, STA mode (DoubleAgent is 32-bit):
#   C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -STA -File rover.ps1

$ErrorActionPreference = 'Stop'

# Single instance only
$mutex = New-Object System.Threading.Mutex($false, 'Local\RoverSearchCompanion')
if (-not $mutex.WaitOne(0)) { exit }

Add-Type -AssemblyName System.Windows.Forms
Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class RoverWin {
    [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint pid);
}
'@

# Windows search processes (11 / 10)
$searchProcs = @('SearchHost', 'SearchApp', 'SearchUI')
# Keep Rover visible while these are focused (e.g. when you click the dog)
$keepProcs   = @('DaServer')

$phrasesByLang = @{
    'pl' = @(
        'Hau! Czego szukamy?',
        'Wpisz, czego szukasz, a ja powęszę!',
        'Szukamy pliku, programu czy czegoś w sieci?',
        'Mój nos jest gotowy do pracy!',
        'Hau hau! Pomogę Ci znaleźć wszystko.'
    )
    'en' = @(
        'Woof! What are we looking for?',
        'Type what you need and I will sniff it out!',
        'Looking for a file, an app, or something online?',
        'My nose is ready for work!',
        'Woof woof! I can help you find anything.'
    )
}
$lang = (Get-Culture).TwoLetterISOLanguageName
$phrases = if ($phrasesByLang.ContainsKey($lang)) { $phrasesByLang[$lang] } else { $phrasesByLang['en'] }

$searchAnims = @('Searching', 'ImageSearching', 'LookUp', 'Thinking', 'Books', 'Idle')

$agent = New-Object -ComObject DoubleAgent.Control
$agent.Connected = $true
$null = $agent.Characters.Load('Rover', (Join-Path $PSScriptRoot 'rover.acs'))
$rover = $agent.Characters.Item('Rover')

function Get-ForegroundProcessName {
    $procId = [uint32]0
    $null = [RoverWin]::GetWindowThreadProcessId([RoverWin]::GetForegroundWindow(), [ref]$procId)
    if ($procId -eq 0) { return '' }
    try { (Get-Process -Id $procId).ProcessName } catch { '' }
}

$visible  = $false
$lastAnim = Get-Date
$rand     = New-Object System.Random

while ($true) {
    $fg = Get-ForegroundProcessName
    $isSearch = $searchProcs -contains $fg
    $isKeep   = $keepProcs -contains $fg

    if ($isSearch -and -not $visible) {
        # Bottom-left corner, above the taskbar
        $wa = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
        $rover.MoveTo($wa.Left + 40, $wa.Bottom - $rover.Height - 20, 0) | Out-Null
        $null = $rover.Show()
        $null = $rover.Play('Greet')
        $null = $rover.Speak($phrases[$rand.Next($phrases.Count)])
        $visible  = $true
        $lastAnim = Get-Date
    }
    elseif (-not $isSearch -and -not $isKeep -and $visible) {
        $null = $rover.StopAll()
        $null = $rover.Hide()
        $visible = $false
    }
    elseif ($visible -and ((Get-Date) - $lastAnim).TotalSeconds -gt 6) {
        $null = $rover.Play($searchAnims[$rand.Next($searchAnims.Count)])
        $lastAnim = Get-Date
    }

    Start-Sleep -Milliseconds 300
}
