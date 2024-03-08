$fileName = Read-Host "Enter the file name"
$filePath = Resolve-Path $fileName

try {
    $sha256 = Get-FileHash -Path $filePath -Algorithm SHA256 -ErrorAction Stop
    $md5 = Get-FileHash -Path $filePath -Algorithm MD5 -ErrorAction Stop
    $sha1 = Get-FileHash -Path $filePath -Algorithm SHA1 -ErrorAction Stop

    Write-Host "SHA-256 hash: $($sha256.Hash)"
    Write-Host "MD5 hash: $($md5.Hash)"
    Write-Host "SHA1 hash: $($sha1.Hash)"
}
catch {
    Write-Host "Error: $($_.Exception.Message)"
}
