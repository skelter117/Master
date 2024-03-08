$Username = Read-host "Enter the new local username: "
$Password = Read-host "Enter the new password you want to use for the new account: " | ConvertTo-SecureString  -AsPlainText -Force
$FullName = Read-host "Enter your Full name: "
$Description = "New Local User Account"
$GroupMembership = "Users" 
if (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue) {
    Write-Host "User account '$Username' already exists."
}
else {
    $UserParams = @{
        "Name" = $Username
        "Password" = $Password
        "FullName" = $FullName
        "Description" = $Description
    }
    $NewUser = New-LocalUser @UserParams

    foreach ($Group in $GroupMembership) {
        Add-LocalGroupMember -Group $Group -Member $Username
    }

    if ($NewUser) {
        Write-Host "User account '$Username' created successfully."
    }
    else {
        Write-Host "Failed to create user account '$Username'."
    }
}
