# Windows Time Sync Script

A lightweight Windows batch script that automatically syncs the system clock once an internet connection is available.

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
