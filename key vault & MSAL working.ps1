Import-Module MSAL.PS
Import-Module Az.KeyVault  # Import Key Vault module

# Set parameters for Key Vault and Key Names
$vaultName = "key-vault-app1"     # Replace with your Azure Key Vault name
$clientIdSecretName = "myfirstkey" # Name of the secret in Key Vault for Client ID

# Authenticate with Azure to access Key Vault
Connect-AzAccount -DeviceCode  # Using -DeviceCode for non-interactive login if necessary

# Retrieve secrets from Key Vault in plain text
$clientId = Get-AzKeyVaultSecret -VaultName $vaultName -Name $clientIdSecretName -AsPlainText
$tenantId = "common"

# Check if ClientId was retrieved successfully
if ([string]::IsNullOrEmpty($clientId)) {
    Write-Error "Client ID secret is empty or invalid."
    exit
} else {
    Write-Host "Client ID retrieved successfully: $clientId"
}

# Define the parameters for the authentication (remove offline_access as MSAL includes it automatically)
$scope = @()  # Empty array as we don't need to pass openid, profile, or offline_access

# Authentication - Interactive login
$authResult = Get-MsalToken -ClientId $clientId -TenantId $tenantId -Scopes $scope

# Check if authentication was successful
if ($authResult -eq $null) {
    Write-Error "Authentication failed. Please make sure you provided valid credentials."
    exit
}

# Authentication successful message
Write-Output "Authentication successful. User authenticated successfully."
