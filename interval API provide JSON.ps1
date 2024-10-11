$intervalsApiKey = "57w7p45pmlj"
$endpoint = "https://api.myintervals.com/task"

# Set the username and password for Basic Authentication
$username = $intervalsApiKey
$password = "X"  # Placeholder for password

# Encode the credentials into Base64 format for Basic Authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${username}:${password}"))

# Set the headers to request JSON data
$headers = @{
    "Authorization" = "Basic $base64AuthInfo";
    "Content-Type"  = "application/json";
    "Accept"        = "application/json"  # Request JSON format in the response
}

# Make the request to the API
try {
    $response = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers
    Write-Output "Successfully connected to Intervals API."
    Write-Output $response  # This should now be in JSON format
} catch {
    Write-Error "Error connecting to Intervals API: $_"
}