import os
from supabase import create_client, Client
import time
import asyncio


def main():
    print("2 [INFO] Running main function in currencies_seeder.py")

    url: str = os.environ.get("PUBLIC_SUPABASE_URL")
    key: str = os.environ.get("PUBLIC_SUPABASE_ANON_KEY")

    # print(f"URL: {url}")
    # print(f"KEY: {key}")

    supabase: Client = create_client(url, key)

    print("3 [INFO] Signing in a user to get access to the database.")
    # * SIGN-IN A USER IN ORDER TO GET ACCESS TO THE DATABASE.
    data = supabase.auth.sign_in_with_password(
        {
            "email": "mpvviernes@gmail.com",
            "password": "Qwerty1234",
        }
    )
    print(data)

    print("4 [INFO] Fetching all currencies from the database.")
    response = supabase.table("currencies").select("*").execute()
    print(response)

    print("5 [INFO] End of main function in currencies_seeder.py")


if __name__ == "__main__":
    print("1 [INFO] Running currencies_seeder.py")
    start_time = time.perf_counter()
    main()
    end_time = time.perf_counter()
    print(f"Time elapsed: {end_time - start_time} seconds.")
    print("6 [INFO] currencies_seeder.py finished running.")

    print("7 [INFO] Terminating currencies_seeder.py.")
    # Terminate the script.
    exit(0)
    print(
        "8 [INFO] currencies_seeder.py terminated. This message should not be printed."
    )
