# PowerShell Script to Calculate Hashes and Validate MD5 Hash on VirusTotal

$filePath = Read-Host "Enter the file path"

try {
    # Resolve the full path (in case a relative path is given)
    $resolvedPath = Resolve-Path $filePath

    # Calculate SHA256 and MD5 hashes
    $sha256 = Get-FileHash -Path $resolvedPath -Algorithm SHA256 -ErrorAction Stop
    $md5 = Get-FileHash -Path $resolvedPath -Algorithm MD5 -ErrorAction Stop

    Write-Host "SHA-256 hash: $($sha256.Hash)"
    Write-Host "MD5 hash: $($md5.Hash)"

    # VirusTotal API Details
    $apiKey = " " # Replace with your VirusTotal API key
    $uri = "https://www.virustotal.com/api/v3/files/$($md5.Hash)"

    $headers = @{
        "x-apikey" = $apiKey
    }

    $vtResponse = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers

    Write-Host "VirusTotal Response:"
    Write-Host ($vtResponse | ConvertTo-Json -Depth 10)
}
catch {
    # Error handling
    Write-Host "Error: $($_.Exception.Message)"
}
