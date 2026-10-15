#Requires -Version 7
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Windows port of scripts/link-skills.sh.
#
# Links every skill in this repo into ~/.claude/skills. Each entry is a
# symlink into this repo, so a `git pull` keeps installed skills up to date.
# `deprecated/` and `misc/` are skipped.
#
# Symlinks need Developer Mode or an elevated shell on Windows. Without
# either, each skill falls back to a directory junction, which works the same
# for local folders and needs no special rights.

$Repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Dests = @(Join-Path $HOME '.claude' 'skills')

$skipDirs = @('node_modules', 'deprecated', 'misc')
$skills = Get-ChildItem -Path (Join-Path $Repo 'skills') -Recurse -File -Filter 'SKILL.md' |
  Where-Object {
    $segments = [IO.Path]::GetRelativePath($Repo, $_.DirectoryName) -split '[\\/]'
    -not ($segments | Where-Object { $skipDirs -contains $_ })
  } |
  ForEach-Object { [pscustomobject]@{ Name = $_.Directory.Name; Src = $_.DirectoryName } }

function Test-InRepo([string]$Path) {
  $full = [IO.Path]::GetFullPath($Path).TrimEnd('\', '/')
  $full -eq $Repo -or $full.StartsWith($Repo + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)
}

foreach ($Dest in $Dests) {
  # If $Dest is itself a link into this repo, we'd write the per-skill links
  # back into the repo's own skills/ tree. Bail out instead.
  $destItem = Get-Item -LiteralPath $Dest -Force -ErrorAction SilentlyContinue
  if ($destItem -and $destItem.LinkType) {
    $resolved = $destItem.ResolveLinkTarget($true).FullName
    if (Test-InRepo $resolved) {
      Write-Error "$Dest is a link into this repo ($resolved).`nRemove it (Remove-Item `"$Dest`") and re-run; the script will recreate it as a real dir."
    }
  }

  New-Item -ItemType Directory -Path $Dest -Force | Out-Null

  foreach ($skill in $skills) {
    $target = Join-Path $Dest $skill.Name

    # Never clobber a real (non-link) skill someone installed by hand.
    $existing = Get-Item -LiteralPath $target -Force -ErrorAction SilentlyContinue
    if ($existing -and -not $existing.LinkType) {
      Write-Warning "skip $($skill.Name): $target exists and is not a link"
      continue
    }

    # Deletes only the link itself, never the folder it points to.
    if ($existing) { [IO.Directory]::Delete($target) }

    try {
      New-Item -ItemType SymbolicLink -Path $target -Target $skill.Src | Out-Null
      $kind = 'symlink'
    } catch {
      New-Item -ItemType Junction -Path $target -Target $skill.Src | Out-Null
      $kind = 'junction'
    }
    Write-Host "linked $($skill.Name) -> $($skill.Src) ($Dest, $kind)"
  }
}
