# SystemInfo.ps1 - Menu script
Import-Module "$PSScriptRoot\os_information_jayyang.psm1" -Force

do {
    Clear-Host
    Write-Host "===== ITWorks System Information Menu =====" -ForegroundColor Green
    Write-Host "1. Operating System"
    Write-Host "2. Windows Remote Service Status"
    Write-Host "3. Manufacturer and Model"
    Write-Host "4. Computer Name"
    Write-Host "5. Domain Name"
    Write-Host "6. Trusted Hosts"
    Write-Host "7. OS Architecture"
    Write-Host "8. Get ALL information"
    Write-Host "9. Quit"
    Write-Host "===========================================" -ForegroundColor Green

    $choice = Read-Host "`nSelect (1-9)"

    switch ($choice) {
        "1" { Write-Host "`nOS: $(Get-OperatingSystem)" -ForegroundColor Yellow }
        "2" { Write-Host "`n$(Get-RemoteServiceStatus)" -ForegroundColor Yellow }
        "3" { Write-Host "`n$(Get-ManufacturerModel)" -ForegroundColor Yellow }
        "4" { Write-Host "`nName: $(Get-ComputerNameInfo)" -ForegroundColor Yellow }
        "5" { Write-Host "`nDomain: $(Get-DomainName)" -ForegroundColor Yellow }
        "6" { Write-Host "`nTrusted Hosts: $(Get-TrustedHosts)" -ForegroundColor Yellow }
        "7" { Write-Host "`nArchitecture: $(Get-OSArchitecture)" -ForegroundColor Yellow }
        "8" { Get-AllInfo }
        "9" { Write-Host "`nGoodbye!" -ForegroundColor Green }
        default { Write-Host "`nInvalid. Enter 1-9." -ForegroundColor Red }
    }

    if ($choice -ne "9") { Read-Host "`nPress Enter to continue" }
} while ($choice -ne "9")