# justdoit-cc installer for Windows
# Installs the justdoit slash command for Claude Code

$CommandDir = "$env:USERPROFILE\.claude\commands"
$CommandFile = "$CommandDir\justdoit.md"
$RawUrl = "https://raw.githubusercontent.com/aasm3535/justdoit-cc/main/commands/justdoit.md"

if (-not (Test-Path $CommandDir)) {
    New-Item -ItemType Directory -Path $CommandDir -Force | Out-Null
}

if (Test-Path $CommandFile) {
    $overwrite = Read-Host "justdoit already installed. Overwrite? [y/N]"
    if ($overwrite -ne 'y' -and $overwrite -ne 'Y') {
        Write-Host "Cancelled."
        exit 0
    }
}

try {
    Invoke-WebRequest -Uri $RawUrl -OutFile $CommandFile -UseBasicParsing
    Write-Host "Installed! Use /justdoit in Claude Code."
} catch {
    Write-Host "Error: Failed to download. $_"
    exit 1
}
