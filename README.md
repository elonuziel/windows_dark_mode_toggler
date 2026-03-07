# Windows Dark Mode Toggler

A simple, lightweight batch script to toggle between Light and Dark mode on Windows 10 and 11.

## Features
- **One-click Toggle**: Instantly switch between Light and Dark themes.
- **No Admin Required**: Modifies user-specific registry keys (`HKCU`), so it works without elevated permissions.
- **Robust Logic**: Includes protection against stale variables and handles standard Windows registry query formats.

## How to use
Just run `toggle_dark_mode.bat`. The script will detect your current theme and switch it to the opposite.

## Requirements
- Windows 10 or Windows 11.

## License
MIT
