$intervalsApiKey = "57w7p45pmlj"
$endpoint = "https://api.myintervals.com/task"

# Set the headers
$headers = @{
    "Content-Type" = "application/json"
}

# Set the basic auth credentials
$username = $intervalsApiKey
$password = "X"

try {
    # Making the GET request using Invoke-RestMethod
    $response = Invoke-RestMethod -Uri $endpoint -Headers $headers -Authentication Basic -Credential (New-Object System.Management.Automation.PSCredential($username, (ConvertTo-SecureString $password -AsPlainText -Force)))
    
    Write-Host "Successfully connected to Intervals API. Here's the task details:"
    Write-Output $response
} catch {
    # Catching and displaying errors
    Write-Host "An error occurred while connecting to Intervals API. Error: $_"
}