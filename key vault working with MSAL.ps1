# Import the MSAL.PS module
Import-Module MSAL.PS

# Set parameters for Key Vault and Client
$vaultName = "key-vault-app1"           # Replace with your Azure Key Vault name
$clientId = "6ec2907b-3c90-4bd5-8b01-269a2c4f00d5"  # Replace with your registered application client ID
$tenantId = "common"                     # Use 'common' for multi-tenant or specific tenant ID
$scope = @("https://vault.azure.net/.default")  # Scope for accessing Azure Key Vault

# Authenticate with Azure AD to get the access token using MSAL
$authResult = Get-MsalToken -ClientId $clientId -TenantId $tenantId -Scopes $scope

# Check if authentication was successful
if ($authResult -eq $null) {
    Write-Error "Authentication failed. Please make sure you provided valid credentials."
    exit
}

# Store the access token
$accessToken = $authResult.AccessToken
Write-Output "Authentication successful. Access token acquired."

# Define Key Vault REST API URL to retrieve the value of a specific secret
$secretName = "myfirstkey"  # Replace with the secret name you want to retrieve

# Check if the secret name is valid and doesn't contain spaces or invalid characters
if ([string]::IsNullOrEmpty($secretName) -or $secretName.Trim().Length -eq 0) {
    Write-Error "Secret name is missing or invalid. Please provide a valid secret name."
    exit
}
else {
    Write-Output "Secret name to retrieve: '$secretName'"  # Debugging: Output the secret name
}

# Construct the Key Vault URL properly
$apiVersion = "7.4"  # Use the latest Key Vault API version
$keyVaultUrl = "https://$vaultName.vault.azure.net/secrets/$($secretName.Trim())?api-version=$apiVersion"
Write-Output "Constructed Key Vault URL: $keyVaultUrl"  # Debugging: Output the constructed URL

# Set headers for the REST API request
$headers = @{
    "Authorization" = "Bearer $accessToken"
}

# Make the REST API call to Azure Key Vault to retrieve the secret value
try {
    Write-Output "Making request to retrieve secret value from Key Vault: $keyVaultUrl"
    $response = Invoke-RestMethod -Uri $keyVaultUrl -Method Get -Headers $headers
    
    # Extract and output the secret value
    $secretValue = $response.value
    Write-Output "Secret value retrieved successfully: $secretValue"
}
catch {
    Write-Error "Failed to retrieve secret value from Key Vault. Error: $($_.Exception.Message)"
    exit
}
