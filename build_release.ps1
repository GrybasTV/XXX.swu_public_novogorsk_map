# Ukraine vs Russia Warmachine - Release Builder
# PowerShell script to build clean PBO releases

param(
    [string]$Version = "v2.0",
    [string]$OutputDir = "releases"
)

Write-Host "=== Ukraine vs Russia Warmachine Release Builder ===" -ForegroundColor Green
Write-Host "Version: $Version" -ForegroundColor Yellow
Write-Host "Output Directory: $OutputDir" -ForegroundColor Yellow
Write-Host ""

# Check if Arma 3 Tools are available
$arma3ToolsPath = "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools"
if (!(Test-Path $arma3ToolsPath)) {
    Write-Host "ERROR: Arma 3 Tools not found at $arma3ToolsPath" -ForegroundColor Red
    Write-Host "Please install Arma 3 Tools from Steam" -ForegroundColor Red
    exit 1
}

# Create output directory
if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

# Clean build directory (exclude docs/, tests/, Original/)
Write-Host "Cleaning build directory..." -ForegroundColor Cyan

$excludeDirs = @("docs", "tests", ".git")
$excludeFiles = @("*.log", "*.rpt", "*.tmp", ".git*")

Get-ChildItem -Path "." -Directory | Where-Object {
    $excludeDirs -notcontains $_.Name
} | ForEach-Object {
    $destPath = Join-Path $OutputDir $_.Name
    if (Test-Path $destPath) {
        Remove-Item $destPath -Recurse -Force
    }
    Copy-Item $_.FullName $destPath -Recurse -Force
}

Get-ChildItem -Path "." -File | Where-Object {
    $_.Name -notin $excludeFiles -and
    !$excludeDirs.Contains([System.IO.Path]::GetDirectoryName($_.FullName).Split([IO.Path]::DirectorySeparatorChar)[-1])
} | ForEach-Object {
    Copy-Item $_.FullName $OutputDir -Force
}

Write-Host "Build directory prepared" -ForegroundColor Green

# Create version file
$versionFile = Join-Path $OutputDir "version.txt"
"Version: $Version" | Out-File $versionFile -Encoding UTF8
"Built: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File $versionFile -Append -Encoding UTF8
"Commit: $(git rev-parse HEAD)" | Out-File $versionFile -Append -Encoding UTF8

Write-Host "Version file created" -ForegroundColor Green

# Check for PBO build tools
$pboToolPath = Join-Path $arma3ToolsPath "AddonBuilder\AddonBuilder.exe"
if (!(Test-Path $pboToolPath)) {
    Write-Host "ERROR: AddonBuilder not found at $pboToolPath" -ForegroundColor Red
    Write-Host "Please verify Arma 3 Tools installation" -ForegroundColor Red
    exit 1
}

# Build PBO
$pboName = "XXX.swu_public_novogorsk_map_$Version.pbo"
$pboOutputPath = Join-Path $OutputDir $pboName

Write-Host "Building PBO: $pboName" -ForegroundColor Cyan

$addonBuilderArgs = @(
    $OutputDir,
    $pboOutputPath,
    "-packonly",
    "-clear",
    "-projectdrives"
)

& $pboToolPath $addonBuilderArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host "PBO built successfully: $pboOutputPath" -ForegroundColor Green

    # Get file size
    $fileSize = (Get-Item $pboOutputPath).Length / 1MB
    Write-Host ("PBO Size: {0:N2} MB" -f $fileSize) -ForegroundColor Green

    # Create checksum
    $hash = Get-FileHash $pboOutputPath -Algorithm SHA256
    $hashFile = Join-Path $OutputDir "$pboName.sha256"
    "$($hash.Hash) *$pboName" | Out-File $hashFile -Encoding UTF8

    Write-Host "SHA256 checksum created" -ForegroundColor Green

} else {
    Write-Host "ERROR: PBO build failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit 1
}

# Create release notes
$releaseNotes = @"
# Ukraine vs Russia Warmachine $Version

## Installation
1. Download the PBO file
2. Copy to your Arma 3 `mpmissions` folder
3. Launch with required mods

## Requirements
- CBA_A3 (required)
- RHS mods (recommended)

## Changes
See docs/MODIFICATIONS.md for full changelog

## File Info
- Size: $([math]::Round($fileSize, 2)) MB
- SHA256: $($hash.Hash)
- Built: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

---
Built with ❤️ for Arma 3 community
"@

$releaseNotesFile = Join-Path $OutputDir "RELEASE_NOTES.md"
$releaseNotes | Out-File $releaseNotesFile -Encoding UTF8

Write-Host "Release notes created" -ForegroundColor Green

# Cleanup build directory
Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item (Join-Path $OutputDir "*") -Exclude "*.pbo", "*.sha256", "RELEASE_NOTES.md", "version.txt" -Force

Write-Host "" -ForegroundColor White
Write-Host "=== RELEASE BUILD COMPLETE ===" -ForegroundColor Green
Write-Host "PBO: $pboOutputPath" -ForegroundColor White
Write-Host "Size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor White
Write-Host "SHA256: $($hash.Hash)" -ForegroundColor White
Write-Host "" -ForegroundColor White
Write-Host "Ready for GitHub release!" -ForegroundColor Green
