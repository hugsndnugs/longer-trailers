# Longer Trailers

Increases the max trailer length in **Motor Town: Behind the Wheel** from 35 m to **150 m**. Single `.pak` file, drag-and-drop install.

## Install

1. Download `LongerTrailers_P.pak` from the **Actions** tab (run **Build .pak**, then download the artifact) or from a **Release** if one is published.
2. Copy `LongerTrailers_P.pak` into the game’s Paks folder:
   - **Client:** `C:\Program Files (x86)\Steam\steamapps\common\Motor Town\MotorTown\Content\Paks`  
     (or your Steam library path: `…\Steam\steamapps\common\Motor Town\MotorTown\Content\Paks`)
   - **Dedicated server:** same `MotorTown\Content\Paks` folder next to the server’s main pak.
3. Start the game. Max trailer length is now 150 m.

## Uninstall

Remove `LongerTrailers_P.pak` from the Paks folder above.

## Compatibility

- Tested with Motor Town versions that load single `.pak` mods from `Content\Paks`. If the game is updated to a different format, the mod may need to be rebuilt.
- Using other trailer mods (e.g. Maja’s Trailer Works) may override the same setting; use one or the other, or install in the order you prefer.

## Building locally

Requires [repak](https://github.com/trumank/repak) (`cargo install repak_cli`). From the repo root:

```bash
repak pack mod LongerTrailers_P.pak -v --mount-point "../../../"
```

## Finding the trailer length setting

If the mod does not take effect, the game may use a different config key or path. From the repo root, run:

```powershell
.\scripts\extract.ps1
```

That script uses repak to list and unpack `MotorTown-Windows.pak`. Search the listed paths and extracted files for `35`, `30`, `trailer`, `length`, or `max`, then update `mod\MotorTown\Config\DefaultGame.ini` (or add the correct override path) and rebuild.
