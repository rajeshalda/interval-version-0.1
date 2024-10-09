$intervalsApiKey = "57w7p45pmlj"  # Replace with your actual Intervals API Key
$endpoint = "https://api.myintervals.com/task"

try {
    # Encode the authorization key properly
    $encodedAuth = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("${intervalsApiKey}:"))
    $headers = @{
        Authorization = "Basic $encodedAuth"
        "Content-Type" = "application/json"
    }

    # Make the GET request
    $response = Invoke-RestMethod -Uri $endpoint -Headers $headers -Method Get

    # Check if the response contains data
    if ($response -ne $null) {
        Write-Output "Successfully connected to Intervals API. Here's the task details:"

        # Since the response is XML, treat it accordingly
        [xml]$xmlResponse = $response

        # Output the entire XML response
        $xmlResponse.intervals | Format-List

        # Save the XML response to a file for further inspection
        $xmlResponse.Save("C:\Users\Rajesh.alda\Pictures\Script Test\IntervalsTaskDetails.xml")
        Write-Output "Task details saved to C:\IntervalsTaskDetails.xml"
    } else {
        Write-Error "Failed to receive a response from Intervals API."
    }
} catch {
    Write-Error "An error occurred while connecting to Intervals API. Error: $_"
}
