$intervalsApiKey = "57w7p45pmlj"  # Replace with your actual Intervals API Key

# Define endpoints
$taskEndpoint = "https://api.myintervals.com/task"
$worktypeEndpoint = "https://api.myintervals.com/worktype"

try {
    # Encode the authorization key properly
    $encodedAuth = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("${intervalsApiKey}:"))
    $headers = @{
        Authorization = "Basic $encodedAuth"
        "Content-Type" = "application/json"
    }

    # Make GET request to fetch task data
    $taskResponse = Invoke-RestMethod -Uri $taskEndpoint -Headers $headers -Method Get
    if ($taskResponse -ne $null) {
        Write-Output "Successfully connected to Intervals API. Fetching task details..."

        # Treat the response as XML
        [xml]$taskXmlResponse = $taskResponse

        # Save the XML response to a file for further inspection
        $taskXmlResponse.Save("C:\Users\Rajesh.alda\Pictures\Script Test\IntervalsTaskDetails.xml")
        Write-Output "Task details saved to IntervalsTaskDetails.xml"
    } else {
        Write-Error "Failed to receive a response from Task API."
    }

    # Make GET request to fetch worktype data
    $worktypeResponse = Invoke-RestMethod -Uri $worktypeEndpoint -Headers $headers -Method Get
    if ($worktypeResponse -ne $null) {
        Write-Output "Successfully connected to Intervals API. Fetching worktype details..."

        # Treat the response as XML
        [xml]$worktypeXmlResponse = $worktypeResponse

        # Save the XML response to a file for further inspection
        $worktypeXmlResponse.Save("C:\Users\Rajesh.alda\Pictures\Script Test\IntervalsWorkTypeDetails.xml")
        Write-Output "Worktype details saved to IntervalsWorkTypeDetails.xml"
    } else {
        Write-Error "Failed to receive a response from Worktype API."
    }

    # Extract relevant data from both XML files
    $taskData = Get-Content -Path "C:\Users\Rajesh.alda\Pictures\Script Test\IntervalsTaskDetails.xml"
    $worktypeData = Get-Content -Path "C:\Users\Rajesh.alda\Pictures\Script Test\IntervalsWorkTypeDetails.xml"

    [xml]$taskXml = $taskData
    [xml]$worktypeXml = $worktypeData

    # Prepare output text file
    $outputFilePath = "C:\Users\Rajesh.alda\Pictures\Script Test\IntervalsSummaryDetails.txt"
    if (Test-Path $outputFilePath) {
        Remove-Item $outputFilePath
    }

    # Extracting details from Task XML and saving them in the text file
    foreach ($task in $taskXml.intervals.task.item) {
        Add-Content -Path $outputFilePath -Value "Person ID: $($task.assigneeid)"
        Add-Content -Path $outputFilePath -Value "Client: $($task.client)"
        Add-Content -Path $outputFilePath -Value "Project: $($task.project)"
        Add-Content -Path $outputFilePath -Value "Module: $($task.module)"
        Add-Content -Path $outputFilePath -Value "Billable: $($task.billable)"
        Add-Content -Path $outputFilePath -Value "-----"
    }

    # Extracting details from Worktype XML and saving them in the text file
    foreach ($worktype in $worktypeXml.intervals.worktype.item) {
        Add-Content -Path $outputFilePath -Value "Work Type ID: $($worktype.id)"
        Add-Content -Path $outputFilePath -Value "Work Type Name: $($worktype.name)"
        Add-Content -Path $outputFilePath -Value "Active: $($worktype.active)"
        Add-Content -Path $outputFilePath -Value "-----"
    }

    # Notify user of completion
    Write-Output "Details successfully saved in text format at $outputFilePath"

} catch {
    Write-Error "An error occurred while connecting to Intervals API or processing data. Error: $_"
}
