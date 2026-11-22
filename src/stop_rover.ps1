# Stops Rover
Get-CimInstance Win32_Process -Filter "Name='powershell.exe'" |
    Where-Object { $_.CommandLine -like '*RoverSearchCompanion\rover.ps1*' } |
    ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
Get-Process DaServer -ErrorAction SilentlyContinue | Stop-Process -Force
