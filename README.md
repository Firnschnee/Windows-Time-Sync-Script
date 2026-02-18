# Windows Time Sync Script

A lightweight Windows batch script that automatically syncs the system clock once an internet connection is available.

## Background

My problem was that `w32tm` was uninstalled, most likely due to some hardening scripts.
Symptoms were clock drift and 2FA failures, because the time was not correct anymore.

I checked with

```
w32tm /query /status
```

and got

```
C:\Users\Firnschnee>w32tm /query /status
Folgender Fehler ist aufgetreten: Der Dienst wurde nicht gestartet. (0x80070426)
C:\Users\Firnschnee>sc query w32tm
[SC] EnumQueryServicesStatus:OpenService FEHLER 1060:
Der angegebene Dienst ist kein installierter Dienst.
```

*-> The service has not been started & the service is not installed*

Fix: this script.

## What it does

1. Continuously pings `8.8.8.8` until an internet connection is detected
2. Forces a time resync via `w32tm /resync /force`
3. Logs the result (success or failure) to `%SYSTEMROOT%\Logs\timesynced.log`

## Usage

Run `time-sync.bat` with **administrator privileges** — `w32tm` requires elevated rights to resync the system clock.

### As a Scheduled Task (recommended)

Set up a Windows Task Scheduler entry to run this script at startup:

1. Open **Task Scheduler** → *Create Task*
2. **General** tab: check *Run with highest privileges*
3. **Triggers** tab: add trigger → *At startup*
4. **Actions** tab: Start a program → point to `time-sync.bat`

## Log file

Results are written to:

```
C:\Windows\Logs\timesynced.log
```

Example entries:
```
[18.02.2026 08:00:01] Time synced OK
[18.02.2026 08:00:01] Time sync FAILED - check admin rights
```

## Requirements

- Windows (tested on Windows 10/11)
- Administrator privileges

## License

MIT
