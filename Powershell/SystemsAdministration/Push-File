$target = Read-Host "Enter the IP address or hostname of the target device"

# Prompt the user to enter the file location on the local machine
$sourceFile = Read-Host "Enter the path of the file to transfer"

# Specify destination to transfer the file to
$destinationPath = "\\$target\c$\Users\Public\Desktop\"

# Check if the source file exists
if (Test-Path $sourceFile -PathType Leaf) {
    # Copy the file to the target device
    Copy-Item -Path $sourceFile -Destination $destinationPath -Force
    Write-Host "File copied successfully to $destinationPath on $target"
} else {
    Write-Host "Source file does not exist or is not accessible."
}
