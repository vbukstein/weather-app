import time

CACHE_DURATION = 3600  # Cache save time 1 hour in seconds
CACHE = {} # In-memory cache initiate the cache as an empty dictionary

def get_cached_temperature(city):
    """
    Check if the temperature for the city is cached and still valid.
    Returns the cached temperature if valid, else None.
    """
    city = city.lower()
    entry = CACHE.get(city)
    if entry and (time.time() - entry['timestamp'] < CACHE_DURATION):
        return entry['temperature']
    return None

def set_cache(city, temperature):
    """
    Store the temperature for the city in the cache with the current timestamp.
    """
    CACHE[city.lower()] = {
        'temperature': temperature,
        'timestamp': time.time()
    }