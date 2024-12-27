import requests
import pandas as pd

# Define the URL of the JSON data
url = "https://gbfs.lyft.com/gbfs/2.3/chi/en/station_information.json"  

try:
    # Fetch the data from the URL
    response = requests.get(url)
    response.raise_for_status()  # Check if the request was successful

    # Parse the JSON data
    data = response.json()

    # Extract the stations list
    stations = data.get("data", {}).get("stations", [])

    # Convert the data to a Pandas DataFrame
    df = pd.DataFrame(stations)

    # Select and rename relevant columns (optional)
    df = df[["name", "short_name", "station_id", "lat", "lon", "capacity"]]
    df.columns = ["station_name", "id", "station_id", "latitude", "longitude", "capacity"]

    # Display the table
    print(df)

    # Save to a CSV file (optional)
    df.to_csv("stations_information.csv", index=False)
    print("\nData saved to 'stations_info.csv'")

except requests.exceptions.RequestException as e:
    print(f"Error fetching the data: {e}")
