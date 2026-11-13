# SystemInfo.psm1 - ITWorks system information functions

function Get-OperatingSystem {
    try { (Get-CimInstance Win32_OperatingSystem).Caption }
    catch { "Error: $($_.Exception.Message)" }
}

function Get-RemoteServiceStatus {
    try { $s = Get-Service TermService -ErrorAction Stop; "$($s.DisplayName) is $($s.Status)" }
    catch { "Error: $($_.Exception.Message)" }
}

function Get-ManufacturerModel {
    try { $c = Get-CimInstance Win32_ComputerSystem; "Manufacturer: $($c.Manufacturer), Model: $($c.Model)" }
    catch { "Error: $($_.Exception.Message)" }
}

function Get-ComputerNameInfo {
    try { $env:COMPUTERNAME }
    catch { "Error: $($_.Exception.Message)" }
}

function Get-DomainName {
    try { (Get-CimInstance Win32_ComputerSystem).Domain }
    catch { "Error: $($_.Exception.Message)" }
}

function Get-TrustedHosts {
    try {
        $t = (Get-Item WSMan:\localhost\Client\TrustedHosts -ErrorAction Stop).Value
        if ([string]::IsNullOrEmpty($t)) { "No trusted hosts configured" } else { $t }
    }
    catch { "Error: $($_.Exception.Message)" }
}

function Get-OSArchitecture {
    try { (Get-CimInstance Win32_OperatingSystem).OSArchitecture }
    catch { "Error: $($_.Exception.Message)" }
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
    catch { Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red }
}

Export-ModuleMember -Function *