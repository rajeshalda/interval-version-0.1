Import-Module MSAL.PS

$vaultName = "key-vault-app1"
$clientId = "6ec2907b-3c90-4bd5-8b01-269a2c4f00d5"
$tenantId = "common"
$scope = @("https://vault.azure.net/.default")

$authResult = Get-MsalToken -ClientId $clientId -TenantId $tenantId -Scopes $scope

if ($authResult -eq $null) {
    Write-Error "Authentication failed. Please make sure you provided valid credentials."
    exit
}

$accessToken = $authResult.AccessToken
Write-Output "Authentication successful. Access token acquired."

$secretName = "myfirstkey"

if ([string]::IsNullOrEmpty($secretName) -or $secretName.Trim().Length -eq 0) {
    Write-Error "Secret name is missing or invalid. Please provide a valid secret name."
    exit
}
else {
    Write-Output "Secret name to retrieve: '$secretName'"
}

$apiVersion = "7.4"
$keyVaultUrl = "https://$vaultName.vault.azure.net/secrets/$($secretName.Trim())?api-version=$apiVersion"
Write-Output "Constructed Key Vault URL: $keyVaultUrl"

$headers = @{
    "Authorization" = "Bearer $accessToken"
}

try {
    Write-Output "Making request to retrieve secret value from Key Vault: $keyVaultUrl"
    $response = Invoke-RestMethod -Uri $keyVaultUrl -Method Get -Headers $headers
    
    $secretValue = $response.value
    Write-Output "Secret value retrieved successfully: $secretValue"
}
catch {
    Write-Error "Failed to retrieve secret value from Key Vault. Error: $($_.Exception.Message)"
    exit
}
