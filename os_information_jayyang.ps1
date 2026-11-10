# ============================================
# ITWorks Client System Information Script
# Displays a menu and gathers OS / computer info
# ============================================
function Get-OperatingSystem {
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        return $os.Caption
    }
    catch {
        return "Error: $($_.Exception.Message)"
    }
}

function Get-RemoteServiceStatus {
    try {
        $service = Get-Service -Name TermService -ErrorAction Stop
        return "$($service.DisplayName) is $($service.Status)"
    }
    catch {
        return "Error: $($_.Exception.Message)"
    }
}

function Get-ManufacturerModel {
    try {
        $cs = Get-CimInstance Win32_ComputerSystem
        return "Manufacturer: $($cs.Manufacturer), Model: $($cs.Model)"
    }
    catch {
        return "Error: $($_.Exception.Message)"
    }
}

function Get-ComputerNameInfo {
    try {
        return $env:COMPUTERNAME
    }
    catch {
        return "Error: $($_.Exception.Message)"
    }
}

function Get-DomainName {
    try {
        $cs = Get-CimInstance Win32_ComputerSystem
        return $cs.Domain
    }
    catch {
        return "Error: $($_.Exception.Message)"
    }
}

function Get-TrustedHosts {
    try {
        $trusted = (Get-Item WSMan:\localhost\Client\TrustedHosts -ErrorAction Stop).Value
        if ([string]::IsNullOrEmpty($trusted)) { return "No trusted hosts configured" }
        return $trusted
    }
    catch {
        return "Error: $($_.Exception.Message)"
    }
}

function Get-OSArchitecture {
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        return $os.OSArchitecture
    }
    catch {
        return "Error: $($_.Exception.Message)"
    }
}

function Get-AllInfo {
    try {
        Write-Host "`n========== ALL SYSTEM INFORMATION ==========" -ForegroundColor Cyan
        Write-Host "1. Operating System     : $(Get-OperatingSystem)"
        Write-Host "2. Remote Service       : $(Get-RemoteServiceStatus)"
        Write-Host "3. Manufacturer/Model   : $(Get-ManufacturerModel)"
        Write-Host "4. Computer Name        : $(Get-ComputerNameInfo)"
        Write-Host "5. Domain Name          : $(Get-DomainName)"
        Write-Host "6. Trusted Hosts        : $(Get-TrustedHosts)"
        Write-Host "7. OS Architecture      : $(Get-OSArchitecture)"
        Write-Host "============================================`n" -ForegroundColor Cyan
    }
    catch {
        Write-Host "Error gathering all information: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Main menu loop
do {
    Clear-Host
    Write-Host "===== ITWorks System Information Menu =====" -ForegroundColor Green
    Write-Host "1. Operating System currently being used"
    Write-Host "2. Windows Remote Service Status"
    Write-Host "3. Computer Manufacturer and Model"
    Write-Host "4. Computer Name"
    Write-Host "5. Computer Domain Name"
    Write-Host "6. Computer's Trusted Hosts"
    Write-Host "7. Operating System Architecture (32/64 bit)"
    Write-Host "8. Get ALL the above information"
    Write-Host "9. Quit"
    Write-Host "===========================================" -ForegroundColor Green

    $choice = Read-Host "`nPlease enter your selection (1-9)"

    switch ($choice) {
        "1" { Write-Host "`nOperating System: $(Get-OperatingSystem)" -ForegroundColor Yellow }
        "2" { Write-Host "`nRemote Service: $(Get-RemoteServiceStatus)" -ForegroundColor Yellow }
        "3" { Write-Host "`n$(Get-ManufacturerModel)" -ForegroundColor Yellow }
        "4" { Write-Host "`nComputer Name: $(Get-ComputerNameInfo)" -ForegroundColor Yellow }
        "5" { Write-Host "`nDomain Name: $(Get-DomainName)" -ForegroundColor Yellow }
        "6" { Write-Host "`nTrusted Hosts: $(Get-TrustedHosts)" -ForegroundColor Yellow }
        "7" { Write-Host "`nOS Architecture: $(Get-OSArchitecture)" -ForegroundColor Yellow }
        "8" { Get-AllInfo }
        "9" { Write-Host "`nExiting script. Goodbye!" -ForegroundColor Green }
        default { Write-Host "`nInvalid selection. Please enter a number between 1 and 9." -ForegroundColor Red }
    }

    # Reliable pause so results stay on screen
    if ($choice -ne "9") {
        Write-Host "`nPress Enter to return to the menu..." -ForegroundColor Gray
        Read-Host
    }

} while ($choice -ne "9")
