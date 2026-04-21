$source = Join-Path $env:APPDATA "RaidKaderHelper"
$target = "E:\GitHub Repo\raidkader-data"

$files = @(
    "raiders.json",
    "raids.json",
    "items.json",
    "bis_profiles.json",
    "sync_state.json"
)

Write-Host "==== RAIDKADER SYNC START ====" -ForegroundColor Cyan

if (-not (Test-Path $target)) {
    Write-Host "Zielordner existiert nicht: $target" -ForegroundColor Red
    Read-Host "Enter zum Beenden"
    exit 1
}

foreach ($file in $files) {
    $src = Join-Path $source $file
    $dst = Join-Path $target $file

    if (Test-Path $src) {
        Copy-Item $src $dst -Force
        Write-Host "Kopiert: $file" -ForegroundColor Green
    }
    else {
        Write-Host "Fehlt: $src" -ForegroundColor Yellow
    }
}

Set-Location $target

git add .
git commit -m "Auto Sync $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push

Write-Host ""
Write-Host "Sync + Push fertig!" -ForegroundColor Cyan
Read-Host "Enter zum Beenden"