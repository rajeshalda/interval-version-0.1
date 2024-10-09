import requests
import json
from requests.auth import HTTPBasicAuth
import os

# Replace with your actual Intervals API Key
intervals_api_key = "57w7p45pmlj"
endpoint = "https://api.myintervals.com/task"

# Set the headers
headers = {
    "Content-Type": "application/json"
}

try:
    # Making the GET request
    response = requests.get(endpoint, headers=headers, auth=HTTPBasicAuth(intervals_api_key, 'X'))

    # Check if the response is successful
    if response.status_code == 200:
        print("Successfully connected to Intervals API. Here's the task details:")
        response_data = response.json()
        print(response_data)
        
        # Specify a path for the JSON file (e.g., save to the user's desktop)
        file_path = os.path.expanduser("~/Desktop/IntervalsTaskDetails.json")
        
        # Save the response to a JSON file
        with open(file_path, "w") as json_file:
            json.dump(response_data, json_file, indent=4)
        
        print(f"The response has been saved to '{file_path}'.")

    else:
        print(f"Failed to receive a response from Intervals API. Status Code: {response.status_code}")
        print(f"Error: {response.text}")

except requests.exceptions.RequestException as e:
    print(f"An error occurred while connecting to Intervals API. Error: {e}")
