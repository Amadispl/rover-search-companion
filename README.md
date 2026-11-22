# 🐶 Rover Search Companion

**Remember the little dog from Windows XP search? He's back - in Windows 11.**

Press `Win+S` or click the search icon and Rover pops up in the corner, greets you and sniffs around while you search. Close the search and he hides again.

> 🇵🇱 [Wersja polska poniżej](#-po-polsku)

## Requirements

- Windows 10 or 11
- **DoubleAgent**, a free, open-source replacement for Microsoft Agent: [download](https://sourceforge.net/projects/doubleagent/files/latest/download)
- **`rover.acs`**, the Rover character file (not included, see step 2)

## Install

### 1. Install DoubleAgent

[Download DoubleAgent](https://sourceforge.net/projects/doubleagent/files/latest/download) and run the installer with the default options.

### 2. Get `rover.acs`

Rover is Microsoft's property, so this repository can't ship the character file. Copy it from any Windows XP installation (a virtual machine works too):

```
C:\Windows\srchasst\chars\rover.acs
```

### 3. Download this repository

Click **Code → Download ZIP** at the top of this page and unzip it anywhere, e.g. to your Desktop.

### 4. Run the installer

1. Put `rover.acs` in the unzipped folder, next to `install.ps1`. Your `Downloads` folder works too, because the installer looks there automatically.
2. Open the unzipped folder in File Explorer, click the address bar, type `powershell` and press Enter.
3. In the PowerShell window, paste:

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

4. Press `Win+S`. Rover should pop up. 🐶

Rover is installed to `%LOCALAPPDATA%\RoverSearchCompanion` and starts automatically with Windows.

**Installer options:**
- `-AcsPath "C:\path\to\rover.acs"`: use a character file from another location
- `-NoAutostart`: don't start Rover with Windows

## Uninstall

Open PowerShell in the repository folder and run:

```powershell
powershell -ExecutionPolicy Bypass -File uninstall.ps1
```

## How it works

A small PowerShell script checks every 300 ms which window is in the foreground. It runs in 32-bit mode, because DoubleAgent is 32-bit. When Windows Search (`SearchHost.exe`) is in front, the script shows Rover through the DoubleAgent COM API, plays his original animations (`Searching`, `Books`, `LookUp`...) and has him say a random line. Rover speaks Polish or English, depending on your system language.

## Troubleshooting

| Problem | Fix |
|---|---|
| `DoubleAgent is not installed` | Install DoubleAgent (step 1) and run the installer again. |
| `not a valid Microsoft Agent character file` | Your `rover.acs` is damaged or isn't a real character file. Copy it again from Windows XP. |
| Rover doesn't appear | Check that `rover.acs` is in `%LOCALAPPDATA%\RoverSearchCompanion`, then sign out and back in. |
| Search closes when Rover appears / wrong position | Open an issue with your Windows version and screen setup. |

## Disclaimer

This is a fan project, not affiliated with or endorsed by Microsoft. Rover and Microsoft Agent are the property of Microsoft Corporation. The MIT license covers only the scripts in this repository.

---

## 🇵🇱 Po polsku

**Pamiętasz pieska z wyszukiwania w Windows XP? Wrócił - w Windows 11.**

Wciśnij `Win+S` albo kliknij lupkę, a Rover pojawi się w rogu ekranu, przywita się i będzie węszył, gdy szukasz. Zamknij wyszukiwanie, a się schowa.

### Instalacja

1. **Zainstaluj DoubleAgent:** [pobierz](https://sourceforge.net/projects/doubleagent/files/latest/download) i uruchom instalator z domyślnymi ustawieniami.
2. **Zdobądź `rover.acs`:** skopiuj go z dowolnego Windows XP (może być maszyna wirtualna), z folderu `C:\Windows\srchasst\chars\rover.acs`. Nie dołączamy go, bo Rover należy do Microsoftu.
3. **Pobierz to repozytorium:** kliknij **Code → Download ZIP** na górze strony i rozpakuj, np. na Pulpit.
4. **Uruchom instalator:**
   - wrzuć `rover.acs` do rozpakowanego folderu, obok `install.ps1` (albo zostaw go w `Pobrane`, instalator sam tam zajrzy),
   - otwórz ten folder w Eksploratorze, kliknij pasek adresu, wpisz `powershell` i naciśnij Enter,
   - wklej:

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

5. Wciśnij `Win+S`. Rover powinien wyskoczyć. 🐶

Rover uruchamia się automatycznie z Windows.

**Odinstalowanie:** w tym samym folderze uruchom

```powershell
powershell -ExecutionPolicy Bypass -File uninstall.ps1
```
