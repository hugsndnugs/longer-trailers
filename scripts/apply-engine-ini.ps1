# Add Longer Trailers Engine.ini lines (mh.maxCombinedVehicleLength=15000 = 150 m).
# Run from repo root or any folder. Uses %localappdata%\MotorTown\Saved\Config\Windows\Engine.ini
# Optional: -SetReadOnly to set the file read-only after (recommended; game can reset the file otherwise).

param(
    [uint32] $LengthCm = 15000,
    [switch] $SetReadOnly
)

$ErrorActionPreference = "Stop"
$base = [Environment]::GetFolderPath("LocalApplicationData")
$engineIni = Join-Path $base "MotorTown\Saved\Config\Windows\Engine.ini"
$section = "[ConsoleVariables]"
$line = "mh.maxCombinedVehicleLength=$LengthCm"

$configDir = Split-Path -Parent $engineIni
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
}

$content = ""
if (Test-Path $engineIni) {
    $content = Get-Content $engineIni -Raw
}
# Ensure [ConsoleVariables] section exists and set the variable
if ($content -notmatch '\[ConsoleVariables\]') {
    $content = $content.TrimEnd() + "`r`n`r`n$section`r`n$line`r`n"
} else {
    if ($content -match 'mh\.maxCombinedVehicleLength\s*=\s*\d+') {
        $content = $content -replace 'mh\.maxCombinedVehicleLength\s*=\s*\d+', "mh.maxCombinedVehicleLength=$LengthCm"
    } else {
        # Insert after [ConsoleVariables]
        $content = $content -replace '(\[ConsoleVariables\])', "`$1`r`n$line"
    }
}
Set-Content -Path $engineIni -Value $content.TrimEnd() -NoNewline
Write-Host "Wrote $line to $engineIni"

if ($SetReadOnly) {
    $item = Get-Item $engineIni
    $item.IsReadOnly = $true
    Write-Host "Set Engine.ini to Read Only."
}
Write-Host "Done. Restart the game if it was running."
