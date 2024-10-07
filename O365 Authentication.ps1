#Install the MSAL.PS module (run this once to install it)
#Install-Module -Name MSAL.PS -Scope CurrentUser

# Import the module
Import-Module MSAL.PS

# Define the parameters for the authentication
$clientId = "6ec2907b-3c90-4bd5-8b01-269a2c4f00d5"   # Replace with your registered application client ID
$tenantId = "common"    # Use 'common' for multi-tenant or unknown tenant ID
$scope = @("offline_access")

# Authentication - Interactive login
$authResult = Get-MsalToken -ClientId $clientId -TenantId $tenantId -Scopes $scope

# Check if authentication was successful
if ($authResult -eq $null) {
    Write-Error "Authentication failed. Please make sure you provided valid credentials."
    exit
}

# Authentication successful message
Write-Output "Authentication successful. User authenticated successfully."

# Note:
# - Replace "YOUR_CLIENT_ID" with your actual client ID from Azure App Registration.
# - You don't need to use a client secret in this case because it's using interactive login.
# - The tenant ID can be set to "common" for common endpoint, which works across all Azure AD tenants.