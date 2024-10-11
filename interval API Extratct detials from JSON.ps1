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

    # Extract the tasks from the response
    $tasks = $response.task

    # Loop through the tasks and extract important details
    foreach ($task in $tasks) {
        Write-Output "========================================="
        Write-Output "Task ID       : $($task.id)"
        Write-Output "Title         : $($task.title)"
        Write-Output "Status        : $($task.status)"
        Write-Output "Assigned To   : $($task.assigneeid)"
        Write-Output "Project       : $($task.project)"
        Write-Output "Module        : $($task.module)"
        Write-Output "Date Open     : $($task.dateopen)"
        Write-Output "Date Due      : $($task.datedue)"
        Write-Output "Date Modified : $($task.datemodified)"
        Write-Output "Priority      : $($task.priority)"
        Write-Output "Billable      : $($task.billable)"
        Write-Output "-----------------------------------------"
    }
    
} catch {
    Write-Error "Error connecting to Intervals API: $_"
}
