$searchQuery = Read-Host "Enter the file or folder name, or file extension to search all drives"
$targetHost = Read-Host "Enter the hostname or IP address of the target machine"
$credential = Get-Credential -Message "Enter your credentials for $targetHost"

$foundItems = @()

try {
    # Start WinRM service on the remote machine/Change file location of psexec.exe
    Start-Process -FilePath "C:\Program Files\Sysinternals\PsExec.exe" -ArgumentList "\\$targethost", "-s", "powershell.exe", "-Command", "Start-Service WinRM" -NoNewWindow -Wait -PassThru

    # Get list of user folders on the target machine
    $userFolders = Invoke-Command -ComputerName $targetHost -Credential $credential -ScriptBlock {
        Get-ChildItem -Path "C:\Users" -Directory | Select-Object -ExpandProperty Name
    }

    # Construct UNC paths for each user folder
    $uncPaths = @()
    foreach ($userFolder in $userFolders) {
        $uncPaths += "\\$targetHost\C$\Users\$userFolder\Desktop"
        $uncPaths += "\\$targetHost\C$\Users\$userFolder\Downloads"
        $uncPaths += "\\$targetHost\C$\Users\$userFolder\Documents"
    }

    # Search for the specified file or folder in the specified directories and their subdirectories
    foreach ($uncPath in $uncPaths) {
        Write-Output "Searching in $uncPath and its subdirectories..."
        $result = Invoke-Command -ComputerName $targetHost -Credential $credential -ScriptBlock {
            param($searchQuery, $uncPath)
            $results = Get-ChildItem -Path $uncPath -Filter $searchQuery -Recurse -ErrorAction SilentlyContinue
            if ($results) {
                $results | ForEach-Object { $_.FullName }
            }
        } -ArgumentList $searchQuery, $uncPath
        if ($result) {
            $foundItems += $result
        }
    }
} catch {
    Write-Host "Failed to perform the operation on computer '$targetHost'. Error: $_"
}

# Display real-time searching and verbose output
if ($foundItems.Count -gt 0) {
    Write-Host "Real-time searching and verbose output:"
    Write-Host "Successfully found the following items:"
    $foundItems | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "Real-time searching and verbose output:"
    Write-Host "No items matching '$searchQuery' found in any specified directory."
}
