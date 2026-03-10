$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$AppsValueName = "AppsUseLightTheme"
$SystemValueName = "SystemUsesLightTheme"

function Get-ThemeMode {
    try {
        $props = Get-ItemProperty -Path $RegistryPath -ErrorAction Stop
        return $props.$AppsValueName
    } catch {
        return $null
    }
}

$currentMode = Get-ThemeMode

if ($null -eq $currentMode) {
    Write-Host "Error: Could not determine current theme mode." -ForegroundColor Red
    exit 1
}

# Toggle: If 1 (Light), change to 0 (Dark). If 0 (Dark), change to 1 (Light).
$newMode = if ($currentMode -eq 1) { 0 } else { 1 }

if ($newMode -eq 0) {
    Write-Host "Switching to Dark Mode..." -ForegroundColor Gray
} else {
    Write-Host "Switching to Light Mode..." -ForegroundColor White
}

try {
    Set-ItemProperty -Path $RegistryPath -Name $AppsValueName -Value $newMode -ErrorAction Stop
    Set-ItemProperty -Path $RegistryPath -Name $SystemValueName -Value $newMode -ErrorAction Stop
    Write-Host "Successfully toggled Windows Dark Mode!" -ForegroundColor Green
} catch {
    Write-Host "Error: Failed to update registry. $($_.Exception.Message)" -ForegroundColor Red
}

# Keep the window open if run by clicking
if ($host.Name -eq "ConsoleHost") {
    Write-Host "`nPress any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
