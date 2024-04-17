$currentDC = Read-Host "Enter the hostname of the current DC with FSMO roles"

$targetDC = Read-Host "Enter the hostname of the target DC to transfer the roles to"

if (-not (Test-Connection -ComputerName $currentDC -Count 1 -Quiet)) {
    Write-Host "Error: Unable to reach the current DC. Please ensure the hostname is correct and the DC is reachable." -ForegroundColor Red
    exit
}

if (-not (Test-Connection -ComputerName $targetDC -Count 1 -Quiet)) {
    Write-Host "Error: Unable to reach the target DC. Please ensure the hostname is correct and the DC is reachable." -ForegroundColor Red
    exit
}

$roleNames = "PDCEmulator", "RIDMaster", "InfrastructureMaster", "SchemaMaster", "DomainNamingMaster"

foreach ($roleName in $roleNames) {
    try {
        # Transfer each FSMO role one by one
        Write-Host "Transferring $roleName role from $currentDC to $targetDC"
        Move-ADDirectoryServerOperationMasterRole -Identity $targetDC -OperationMasterRole $roleName -Confirm:$false -Force:$true
    } catch {
        Write-Host "Error transferring $roleName role: $_" -ForegroundColor Red
    }
}

Write-Host "FSMO roles have been successfully transferred to $targetDC" -ForegroundColor Green
