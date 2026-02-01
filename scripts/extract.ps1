# Extract MotorTown-Windows.pak for discovery (trailer length config path).
# Requires repak: cargo install repak_cli (or download from https://github.com/trumank/repak/releases)
# Run from repo root: .\scripts\extract.ps1

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$PakPath = Join-Path $RepoRoot "MotorTown-Windows.pak"
$OutDir = Join-Path $RepoRoot "MotorTown-Windows-extracted"

if (-not (Test-Path $PakPath)) {
    Write-Error "Game pak not found: $PakPath"
}

# Prefer repak from cargo bin
$repak = $null
foreach ($dir in @("$env:USERPROFILE\.cargo\bin", $env:PATH -split ';')) {
    $exe = Join-Path $dir "repak.exe"
    if ($dir -and (Test-Path $exe)) { $repak = $exe; break }
}
if (-not $repak) { $repak = "repak" }

Write-Host "Using repak: $repak"
Write-Host "Pak: $PakPath"
Write-Host ""

Write-Host "=== repak info ==="
& $repak info $PakPath
Write-Host ""

Write-Host "=== repak list (first 100 paths) ==="
& $repak list $PakPath 2>&1 | Select-Object -First 100
Write-Host ""

Write-Host "Searching for trailer/length-related paths..."
& $repak list $PakPath 2>&1 | Select-String -Pattern "trailer|length|config|DefaultGame|\.ini" -CaseSensitive:$false
Write-Host ""

if (-not (Test-Path $OutDir)) {
    Write-Host "Unpacking to: $OutDir"
    & $repak unpack $PakPath --output $OutDir -v
    Write-Host "Done. Search extracted files for 35, 30, trailer, length, max."
} else {
    Write-Host "Output dir already exists: $OutDir (delete it to re-unpack)"
}
