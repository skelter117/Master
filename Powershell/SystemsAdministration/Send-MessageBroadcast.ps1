$subnets = Read-Host "Enter the subnets in CIDR notation separated by commas (example: 192.168.1.0/24, 10.0.0.0/16)"
$senderName = Read-Host "Enter the name you want to use"
$message = Read-Host "Enter the message to broadcast"
#Example message: "Please restart your computer"

# Split the subnets
$subnetsArray = $subnets -split ','

foreach ($subnet in $subnetsArray) {
    $networkAddress, $subnetMask = $subnet -split '/'

    # Convert subnet mask to CIDR notation
    $subnetPrefixLength = (Convert-IPV4MaskToPrefixLength $subnetMask)

    # Get all IP addresses in the subnet
    $ipAddresses = Get-IPAddressInRange -NetworkAddress $networkAddress -SubnetPrefixLength $subnetPrefixLength

    foreach ($ip in $ipAddresses) {
        $computerName = $ip
        Invoke-Command -ComputerName $computerName -ScriptBlock {
            param($senderName, $message)
            msg.exe * /SERVER:$env:COMPUTERNAME "$senderName says: $message"
        } -ArgumentList $senderName, $message
    }
}
