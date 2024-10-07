# Install the MSAL.PS module (run this once to install it)
# Install-Module -Name MSAL.PS -Scope CurrentUser

# Import the module
Import-Module MSAL.PS

# Define the parameters for the authentication
$clientId = "6ec2907b-3c90-4bd5-8b01-269a2c4f00d5"   # Replace with your registered application client ID
$tenantId = "common"    # Use 'common' for multi-tenant or unknown tenant ID
$scope = @("offline_access", "Calendars.Read")

# Authentication - Interactive login
$authResult = Get-MsalToken -ClientId $clientId -TenantId $tenantId -Scopes $scope

# Check if authentication was successful
if ($authResult -eq $null) {
    Write-Error "Authentication failed. Please make sure you provided valid credentials."
    exit
}

# Extract the access token
$accessToken = $authResult.AccessToken

# Define the Graph API endpoint for fetching calendar events
$graphApiEndpoint = "https://graph.microsoft.com/v1.0/me/events"

# Make the API call to get calendar events
$response = Invoke-RestMethod -Uri $graphApiEndpoint -Headers @{Authorization = "Bearer $accessToken"} -Method Get

# Check if the response contains value
if ($response.value -eq $null) {
    Write-Error "Failed to retrieve calendar events. Please check your permissions."
    exit
}

# Output the events (you can modify this part to fit your needs)
$events = $response.value
foreach ($event in $events) {
    Write-Output "Subject: $($event.subject)"
    Write-Output "Start: $($event.start.dateTime)"
    Write-Output "End: $($event.end.dateTime)"
    Write-Output "-----"
}

# Note:
# - Replace "YOUR_CLIENT_ID" with your actual client ID from Azure App Registration.
# - You don't need to use a client secret in this case because it's using interactive login.
# - The tenant ID can be set to "common" for common endpoint, which works across all Azure AD tenants.