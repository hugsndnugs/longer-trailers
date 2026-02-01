# Build LongerTrailers_P.pak from mod/ folder.
# Requires repak: cargo install repak_cli (or download from https://github.com/trumank/repak/releases)
# Run from repo root: .\scripts\pack.ps1

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$ModDir = Join-Path $RepoRoot "mod"
$OutPak = Join-Path $RepoRoot "LongerTrailers_P.pak"

if (-not (Test-Path $ModDir)) {
    Write-Error "mod/ folder not found: $ModDir"
}

$repak = $null
foreach ($dir in @("$env:USERPROFILE\.cargo\bin", $env:PATH -split ';')) {
    $exe = Join-Path $dir "repak.exe"
    if ($dir -and (Test-Path $exe)) { $repak = $exe; break }
}
if (-not $repak) { $repak = "repak" }

Set-Location $RepoRoot
& $repak pack $ModDir $OutPak -v --mount-point "../../../"
Write-Host "Built: $OutPak"
