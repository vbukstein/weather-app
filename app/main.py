from flask import Flask, render_template, request, jsonify
from cache import get_cached_temperature, set_cache
from weather import fetch_weather

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    temperature = None
    error = None
    source = None
    city = None
    if request.method == 'POST':
        city = request.form.get('city', '').strip()
        if city:
            # Try cache first
            temperature = get_cached_temperature(city)
            if temperature is not None:
                source = "cache"
            else:
                temperature, error = fetch_weather(city)
                if temperature is not None:
                    source = "api"
                    set_cache(city, temperature)
        else:
            error = "Please enter a city name."
    return render_template('index.html', temperature=temperature, error=error, source=source, city=city)

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint."""
    return jsonify({"response": 200}), 200

if __name__ == '__main__':
    app.run(debug=True)
