$Port = Read-Host "Enter the port number to block"

$RuleName = "Block Port $Port"
$RuleAction = "Block"
$RuleDirection = "Inbound"
$RuleProtocol = "TCP"
$RuleLocalPort = $Port

New-NetFirewallRule -DisplayName $RuleName -Action $RuleAction -Direction $RuleDirection -Protocol $RuleProtocol -LocalPort $RuleLocalPort

Write-Host "Traffic on port $Port is now blocked."
