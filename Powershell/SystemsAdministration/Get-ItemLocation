$searchQuery = Read-Host "Enter the file or folder name, or file extension to search all drives"
$drives = Get-PSDrive -PSProvider FileSystem
foreach ($drive in $drives) {
    if ($drive.Free -ne $null) {
        $results = Get-ChildItem -Path $drive.Root -Filter $searchQuery -Recurse -ErrorAction SilentlyContinue
        if ($results) {
            Write-Output "Found items matching '$searchQuery' on drive $($drive.Root):"
            $results | ForEach-Object { $_.FullName }
        }
    }
}
