import os
import requests

API_KEY = os.environ.get('OW_API_KEY')  # Read the API key from environment variable

def fetch_weather(city):
    """
    Fetch the temperature for the given city from OpenWeatherMap API.
    Returns (temperature, source, error) where:
    - temperature: float or None if error
    - source: 'api' or 'cache'
    - error: None or error message
    """
    url = f'https://api.openweathermap.org/data/2.5/weather?q={city}&units=metric&appid={API_KEY}'
    
    try:
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        data = response.json()

        if 'main' not in data or 'temp' not in data['main']:
            return None, "Unexpected API response."

        #temperature = data['main']['temp']
        return data['main']['temp'], None

    except requests.exceptions.HTTPError as e:
        if response.status_code == 404:
            return None, "City not found."
        else:
            return None, "Weather API error."
    except requests.exceptions.RequestException:
        return None, "Weather API unreachable."
    except Exception as e:
        return None, f"Internal server error: {e}"