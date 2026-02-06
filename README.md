# Longer Trailers

Increases the max trailer length in **Motor Town: Behind the Wheel** from 35 m to **150 m**. The game reads the limit from **Engine.ini** via the console variable `mh.maxCombinedVehicleLength` (value in **centimeters**). This mod gives you the correct config and an optional script so you don't have to look it up.

## Install (recommended: Engine.ini)

The game only applies the trailer length limit from **Engine.ini**, not from a .pak override. Do one of the following.

### Option A – Script (easiest)

From the repo root (or after downloading the repo):

```powershell
.\scripts\apply-engine-ini.ps1 -SetReadOnly
```

That writes `mh.maxCombinedVehicleLength=15000` (150 m) into your Engine.ini and sets the file to read-only so the game doesn't reset it.

To use a different length (in cm), e.g. 100 m:

```powershell
.\scripts\apply-engine-ini.ps1 -LengthCm 10000 -SetReadOnly
```

### Option B – Manual

1. Press **Win + R**, paste: `%localappdata%\MotorTown\Saved\Config\Windows` → OK.
2. Open **Engine.ini** in a text editor (create it if it doesn't exist).
3. Add at the bottom:

   ```ini
   [ConsoleVariables]
   mh.maxCombinedVehicleLength=15000
   ```

   (15000 cm = 150 m. Use e.g. 10000 for 100 m, 6000 for 60 m.)
4. Save, then right‑click Engine.ini → **Properties** → check **Read-only** → OK.

Start (or restart) the game. Max trailer length is now 150 m.

### Optional config file

You can copy `optional-config\Engine.ini` into the folder above instead of typing the lines. Merge with existing content if you already have an Engine.ini.

## Uninstall

Remove the `[ConsoleVariables]` section (or the `mh.maxCombinedVehicleLength` line) from `%localappdata%\MotorTown\Saved\Config\Windows\Engine.ini`, and uncheck Read-only if you set it.

## Dedicated server

Put the same two lines in the server's Engine.ini:

- Path: `Motor Town Behind The Wheel - Dedicated Server\MotorTown\Saved\Config\WindowsServer\Engine.ini`
- Create the file if needed. Example: `mh.maxCombinedVehicleLength=15000` for 150 m. Clients are limited by the server's value in multiplayer.

## Compatibility

- If the game resets Engine.ini (e.g. some test builds), keep the file **Read-only** or re-run the script after updates.
