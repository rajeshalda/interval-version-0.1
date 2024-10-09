import requests
from requests.auth import HTTPBasicAuth

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
        print(response.json())
    else:
        print(f"Failed to receive a response from Intervals API. Status Code: {response.status_code}")
        print(f"Error: {response.text}")

except requests.exceptions.RequestException as e:
    print(f"An error occurred while connecting to Intervals API. Error: {e}")
