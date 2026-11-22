# 🐶 Rover Search Companion

**Remember the little dog from Windows XP search? He's back - in Windows 11.**

Press `Win+S` or click the search icon and Rover pops up in the corner, greets you and sniffs around while you search. Close the search and he hides again.

> 🇵🇱 [Wersja polska poniżej](#-po-polsku)

## Requirements

- Windows 10 or 11
- [DoubleAgent](https://sourceforge.net/projects/doubleagent/), a free, open-source replacement for Microsoft Agent
- `rover.acs`, the Rover character file (**not included**, see below)

## Getting `rover.acs`

Rover is owned by Microsoft, so this repository does **not** ship the character file. Copy it from your own Windows XP installation (a VM works fine):

```
C:\Windows\srchasst\chars\rover.acs
```

## Install

1. Install **DoubleAgent**.
2. Download this repository (**Code → Download ZIP**) and unzip it.
3. Put `rover.acs` in the unzipped folder (or in your `Downloads` folder).
4. Open PowerShell in that folder and run:

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

Options:
- `-AcsPath "C:\path\to\rover.acs"`: use a character file from a custom location
- `-NoAutostart`: don't start Rover with Windows

Rover gets installed to `%LOCALAPPDATA%\RoverSearchCompanion`.

## Uninstall

```powershell
powershell -ExecutionPolicy Bypass -File uninstall.ps1
```

## How it works

A small PowerShell script (32-bit, because DoubleAgent is 32-bit) checks every 300 ms which window is in the foreground. When it's Windows Search (`SearchHost.exe`), it shows Rover through the DoubleAgent COM API, plays his original animations (`Searching`, `Books`, `LookUp`...) and has him speak a random line. Rover speaks Polish or English, depending on your system language.

## Troubleshooting

- **Rover doesn't appear:** check that DoubleAgent is installed and that `rover.acs` is in `%LOCALAPPDATA%\RoverSearchCompanion`.
- **Search closes when Rover shows up / wrong position:** open an issue with your Windows version and screen setup.

## Disclaimer

This is a fan project, not affiliated with or endorsed by Microsoft. Rover and Microsoft Agent are trademarks/property of Microsoft Corporation. The MIT license covers only the scripts in this repository.

---

## 🇵🇱 Po polsku

**Pamiętasz pieska z wyszukiwania w Windows XP? Wrócił - w Windows 11.**

Wciśnij `Win+S` albo kliknij lupkę, a Rover pojawi się w rogu ekranu, przywita się i będzie węszył, gdy szukasz. Zamknij wyszukiwanie, a się schowa.

### Instalacja

1. Zainstaluj [DoubleAgent](https://sourceforge.net/projects/doubleagent/).
2. Pobierz to repozytorium (**Code → Download ZIP**) i rozpakuj.
3. Wrzuć `rover.acs` do rozpakowanego folderu (albo do `Pobrane`). Plik skopiujesz z Windows XP: `C:\Windows\srchasst\chars\rover.acs`. Nie dołączamy go, bo Rover należy do Microsoftu.
4. Uruchom w PowerShellu w tym folderze:

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

Odinstalowanie: `powershell -ExecutionPolicy Bypass -File uninstall.ps1`
