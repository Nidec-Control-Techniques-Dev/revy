import requests
import asyncio
import pandas as pd

import os

here = os.path.dirname(os.path.abspath(__file__))

GOOGLE_MAPS_API_KEY = ""


async def get_lat_and_lng(address):
    try:
        url = f"https://maps.googleapis.com/maps/api/geocode/json?address={address}&key={GOOGLE_MAPS_API_KEY}"
        response = await asyncio.get_event_loop().run_in_executor(
            None, lambda: requests.get(url)
        )
        data = response.json()
        lat = data["results"][0]["geometry"]["location"]["lat"]
        lng = data["results"][0]["geometry"]["location"]["lng"]

        return {"latitude": lat, "longitude": lng}
    except Exception as e:
        print(
            "################### [ Error in getting coordinates ] ######################"
        )
        print(f"Error : {e}")
        return {"latitude": None, "longitude": None}


async def main():
    # Read the csv file. Get the raw_addresses from the column named "Address"
    filePath = os.path.join(here, "./raw_data/Copy of China - Masterfile.csv")
    df = pd.read_csv(filePath)
    addresses = df["Address"]

    coordinates = []
    for i in range(len(addresses)):
        print(f"Getting coordinates for address {i + 1} of {len(addresses)}")
        print(addresses[i])

        address = addresses[i]
        coordinates.append(
            {"address": address, "coordinates": await get_lat_and_lng(address)}
        )

        print(f"Latitude: {coordinates[-1]['coordinates']['latitude']}")
        print(f"Longitude: {coordinates[-1]['coordinates']['longitude']}\n")

    # Save the coordinates to a csv file.
    import csv

    with open(
        os.path.join(here, "./raw_data/China - coordinates.csv"),
        mode="w",
        newline="",
    ) as file:
        fieldnames = ["Address", "Latitude", "Longitude"]
        writer = csv.DictWriter(file, fieldnames=fieldnames)

        writer.writeheader()
        for item in coordinates:
            writer.writerow(
                {
                    "Address": item["address"],
                    "Latitude": item["coordinates"]["latitude"],
                    "Longitude": item["coordinates"]["longitude"],
                }
            )

    print("Coordinates saved to file.")


asyncio.run(main())
