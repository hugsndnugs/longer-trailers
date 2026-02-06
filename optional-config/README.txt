Copy Engine.ini to:
  %localappdata%\MotorTown\Saved\Config\Windows\Engine.ini
(merge with existing content if the file already exists: add [ConsoleVariables] and mh.maxCombinedVehicleLength=15000)
Then set the file to Read Only so the game doesn't overwrite it.
Or run from repo root: .\scripts\apply-engine-ini.ps1 -SetReadOnly
