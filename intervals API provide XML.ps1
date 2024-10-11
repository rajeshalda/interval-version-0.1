$intervalsApiKey = "57w7p45pmlj"
$endpoint = "https://api.myintervals.com/task"

# Set the username and password for Basic Authentication
$username = $intervalsApiKey
$password = "X"  # Placeholder for password

# Encode the credentials into Base64 format for Basic Authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${username}:${password}"))

# Set the headers for Basic Authentication
$headers = @{
    "Authorization" = "Basic $base64AuthInfo";
    "Content-Type"  = "application/xml";  # Request XML format
}

# Make the request to the API
try {
    $response = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers
    Write-Output "Successfully connected to Intervals API."

    # Convert the XML response to a PowerShell object
    $xmlData = [xml]$response
    $xmlData

    # You can now work with the XML data, for example:
    # Write-Output $xmlData.intervals.tasks
} catch {