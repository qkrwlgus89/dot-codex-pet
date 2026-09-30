param([string]$Repository = '', [string]$Ref = 'main')
$ErrorActionPreference = 'Stop'
$temporary = Join-Path ([IO.Path]::GetTempPath()) ('dot-pet-' + [guid]::NewGuid())
try {
  if ($Repository) {
    if ($Repository -notmatch '^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$') { throw 'Expected GitHub OWNER/REPO' }
    if ($Ref -notmatch '^[A-Za-z0-9._-]+$') { throw 'Use a simple branch, tag, or commit SHA' }
    New-Item -ItemType Directory -Path $temporary | Out-Null
    $source = $temporary
    foreach ($file in @('pet.json', 'spritesheet.webp', 'SHA256SUMS')) {
      Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/$Repository/$Ref/pets/dot-pet/$file" -OutFile (Join-Path $source $file)
    }
  } else { $source = Join-Path $PSScriptRoot 'pets/dot-pet' }
  $expectedFiles = @('pet.json', 'spritesheet.webp')
  $checks = @(Get-Content (Join-Path $source 'SHA256SUMS'))
  if ($checks.Count -ne 2) { throw 'Invalid checksum manifest' }
  foreach ($line in $checks) {
    if ($line -notmatch '^([a-fA-F0-9]{64})  (pet\.json|spritesheet\.webp)$') { throw 'Invalid checksum line' }
    $expected = $Matches[1]; $file = $Matches[2]
    if ($file -notin $expectedFiles) { throw 'Duplicate checksum entry' }
    $expectedFiles = @($expectedFiles | Where-Object { $_ -ne $file })
    if ((Get-FileHash -Algorithm SHA256 (Join-Path $source $file)).Hash -ne $expected) { throw "Checksum failed: $file" }
  }
  $manifest = Get-Content -Raw (Join-Path $source 'pet.json') | ConvertFrom-Json
  if ($manifest.id -ne 'dot-pet' -or $manifest.spriteVersionNumber -ne 2 -or $manifest.spritesheetPath -ne 'spritesheet.webp') { throw 'Invalid Dot Pet manifest' }
  $codexRoot = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
  $pets = Join-Path $codexRoot 'pets'
  New-Item -ItemType Directory -Force -Path $pets | Out-Null
  $destination = Join-Path $pets 'dot-pet'
  $stage = Join-Path $pets ('.dot-pet-stage-' + [guid]::NewGuid())
  New-Item -ItemType Directory -Path $stage | Out-Null
  Copy-Item (Join-Path $source 'pet.json'), (Join-Path $source 'spritesheet.webp') -Destination $stage
  if (Test-Path $destination) {
    $backup = $destination + '.backup.' + [guid]::NewGuid()
    Move-Item $destination $backup
    Write-Output "Previous installation backed up: $backup"
  }
  Move-Item $stage $destination
  Write-Output "Dot Pet installed: $destination"
  Write-Output 'Restart Codex and select Dot Pet in the pet picker.'
} finally { if (Test-Path $temporary) { Remove-Item -Recurse -Force $temporary } }
