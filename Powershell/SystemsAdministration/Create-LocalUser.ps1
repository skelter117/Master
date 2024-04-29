$name = Read-Host "Enter username"

New-LocalUser -Name $name

$add_sudo = Read-Host "Add user to Administrators group? (yes/no)"
if ($add_sudo -eq "yes") {
    Add-LocalGroupMember -Group "Administrators" -Member $name
}

# Create user directory if it doesn't exist
if (-not (Test-Path "C:\Users\$name")) {
    New-Item -Path "C:\Users\$name" -ItemType Directory | Out-Null
    $folder = Get-Item "C:\Users\$name"
    $acl = $folder.GetAccessControl()
    $owner = New-Object System.Security.Principal.NTAccount($name)
    $acl.SetOwner($owner)
    $folder.SetAccessControl($acl)
}

try {
    $openSSHInstalled = Get-WindowsCapability -Online | Where-Object { $_.Name -like '*OpenSSH.Client*' }
} catch {
    $openSSHInstalled = $null
}

if ($openSSHInstalled -eq $null) {
    try {
        Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
        Write-Host "OpenSSH Client installed."
    } catch {
        Write-Host "Failed to install OpenSSH Client."
    }
} else {
    Write-Host "OpenSSH Client is installed."
}

$generate_ssh = Read-Host "Generate SSH key? (yes/no)"
if ($generate_ssh -eq "yes") {
    ssh-keygen
    Write-Host "SSH keys generated."
}

# Prompt to upload public key to a server
$upload_key = Read-Host "Would you like to upload the public key to a server? (yes/no)"
if ($upload_key -eq "yes") {
    $server_ip = Read-Host "Enter the IP address of the server"
    $server_user = Read-Host "Enter the username on the server"
    $server_path = Read-Host "Enter the path to copy the public key on the server"
    # Copy public key to server
    ssh-copy-id -i "$ssh_key_path.pub" "$server_user@$server_ip"
    Write-Host "Public key uploaded to server."
} else {
    Write-Host "Exiting script."
}
