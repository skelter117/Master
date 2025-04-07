$GroupName = Read-host "Enter the AD security group name you wish to get membership details for"
$Group = Get-ADGroup -Identity $GroupName
$Members = Get-ADGroupMember -Identity $Group
$Members | Select-Object Name, SamAccountName, objectClass
