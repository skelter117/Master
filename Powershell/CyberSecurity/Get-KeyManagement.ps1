$keyGenerationChoice = Read-Host "Do you want to generate a symmetric AES256 key? (yes/no)"

if ($keyGenerationChoice -eq "yes") {
    # Generate a random symmetric key
    $random = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $buffer = New-Object byte[] 32
    $random.GetBytes($buffer)
    $hexKey = [BitConverter]::ToString($buffer).Replace("-", [string]::Empty)

    # Prompt user if they want to convert the symmetric key to base64
    $base64symmetrickey = Read-Host "Do you want to convert this symmetric key to base 64?"

    if ($base64symmetrickey -eq "yes") {
        $base64Key = [Convert]::ToBase64String($buffer)
        Write-Output "Symmetric Key (base64):"
        Write-Output $base64Key
    }
    else {
        Write-Output "Symmetric Key (hex):"
        Write-Output $hexKey
    }

    # Prompt user if they want to encrypt the symmetric key with someone's public key
    $encryptsymmetrickey = Read-Host "Do you want to encrypt the symmetric key with someone's public key?"

    if ($encryptsymmetrickey -eq "yes") {
        $recipientPublicKey = Read-Host "Enter the recipient's RSA public key:"

        # Create an RSA object for the recipient's public key
        $rsaRecipient = New-Object System.Security.Cryptography.RSACryptoServiceProvider
        $rsaRecipient.FromXmlString($recipientPublicKey)

        # Prompt user if they want to generate their own RSA key pair
        $generateKeyPair = Read-Host "Do you want to generate your own RSA key pair? (yes/no)"

        if ($generateKeyPair -eq "yes") {
            # Generate your own RSA key pair
            $rsa = New-Object System.Security.Cryptography.RSACryptoServiceProvider(2048)

            # Get your own public key
            $publicKey = $rsa.ToXmlString($true)
        }
        else {
            Write-Output "You chose not to generate your own RSA key pair."
            $publicKey = ""
        }

        # Convert the symmetric key to bytes
        $symmetricKeyBytes = [System.Text.Encoding]::UTF8.GetBytes($hexKey)

        # Encrypt the symmetric key with recipient's public key
        $encryptedSymmetricKey = $rsaRecipient.Encrypt($symmetricKeyBytes, $false)

        Write-Output "Your Public Key:"
        Write-Output $publicKey

        # Convert the encrypted symmetric key to base64 and display it
        $base64EncryptedSymmetricKey = [Convert]::ToBase64String($encryptedSymmetricKey)
        Write-Output "Encrypted Symmetric Key (Base64):"
        Write-Output $base64EncryptedSymmetricKey
    }
    else {
        # Prompt user if they want to generate their own RSA key pair
        $generateKeyPair = Read-Host "Do you want to generate your own RSA key pair? (yes/no)"

        if ($generateKeyPair -eq "yes") {
            # Generate your own RSA key pair
            $rsa = New-Object System.Security.Cryptography.RSACryptoServiceProvider(2048)

            # Get your own public key
            $publicKey = $rsa.ToXmlString($true)

            Write-Output "Your Public Key:"
            Write-Output $publicKey
        }
        else {
            Write-Output "Symmetric key not encrypted."
        }
    }
}

$closePrompt = Read-Host "Type 'end' to close the PowerShell window when you are done:"
if ($closePrompt -eq "end") {
    exit
}
