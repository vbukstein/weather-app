<body>

<h1>Weather App 🌤️</h1>

<p>
  A simple, secure, and container-ready Flask web application to check the current temperature for any city using the OpenWeatherMap API.<br>
  Includes local in-memory caching for efficiency and supports Docker deployment.
</p>

<h2>Features</h2>
<ul>
  <li>🌎 Search for current temperature by city name</li>
  <li>⚡ Fast local (in-memory) caching to reduce API calls</li>
  <li>🐳 Easy Docker containerization</li>
  <li>🔒 No secrets in code: API key loaded from environment variable</li>
  <li>🩺 Health check endpoint for cloud-native deployments</li>
</ul>

<h2>Quick Start</h2>
<ol>
  <li>
    <strong>Clone the repository</strong>
    <pre><code>
  git clone https://github.com/your-username/weather-app.git
  cd weather-app/app
    </code></pre>
  </li>
  <li>
    <strong>Install dependencies</strong>
    <pre><code>
  python3 -m venv venv
  source venv/bin/activate
  pip install -r requirements.txt
    </code></pre>
  </li>
  <li>
    <h2>Sign up for an account</h2>
      <p>
        Go to <a href="https://home.openweathermap.org/users/sign_up" target="_blank">OpenWeatherMap Sign Up</a> and create a free account using your email address and generate your own API key.
      </p>
    <strong>Set your OpenWeatherMap API key</strong>
    <pre><code>export OW_API_KEY=your_openweathermap_api_key</code></pre>
  </li>
  <li>
    <strong>Run the app</strong>
    <pre><code>python -m main</code></pre>
    Visit <a href="http://localhost:5000" target="_blank">http://localhost:5000</a> in your browser.
  </li>
</ol>

<h2>Docker Usage</h2>
<strong>Build the image</strong>
<pre><code>
  cd weather-app/app
  docker build -t weather-app .
</code></pre>

<strong>Run the container</strong>
<pre><code>
  docker run -p 5000:5000 -e OW_API_KEY=your_openweathermap_api_key weather-app
</code></pre>

<h2>Helm Usage</h2>
<p>Build, tag and push your image to private docker registry.</p>
<p>Configure the appropriate values in values.yaml file.</p>
<p>Install the helm chart to Kubernetes.</p>
<pre><code>
  cd chart
  helm install weather-app . -f values.yaml
</code></pre>
<p>Be sure to deploy your pull secret for private docker registry before installation.</p>

<h2>Health Check Endpoint</h2>
<p>For use with Docker, Kubernetes, or any load balancer:</p>
<pre><code>GET /health</code></pre>
<p>Returns:</p>
<pre><code>{
  "response": 200
}</code></pre>

<h2>Project Structure</h2>
<div class="structure">
<pre><code>weather-app/
    ├── app/
    │   ├── __init__.py
    │   ├── main.py
    │   ├── cache.py
    │   ├── weather.py
    │   ├── templates/
    │   │   └── index.html
    │   ├── requirements.txt
    │   └── Dockerfile
    ├── chart/
    │   ├── .helmignore
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   ├── charts/
    │   ├── templates/
    │   └── tests/
    ├── terraform/
    │   ├── helm/
    │   │    |── nginx_ingress.tf
    │   │    |── providers.tf
    │   │    └── variables.tf
    │   ├── remote_state/
    │   │    |── main.tf
    │   │    |── outputs.tf
    │   │    └── variables.tf
    │   ├── backend.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── variables.tf
    │   └── versions.tf
    ├── tests/
    │   ├── __init__.py
    │   └── test_main.py
    ├── .gitignore
    ├──  pytest.ini
    └──  README.md
</code></pre>
</div>

<h2>Configuration</h2>
<ul>
  <li><strong>API Key:</strong> Set the <code>OW_API_KEY</code> environment variable to your OpenWeatherMap API key.</li>
  <li><strong>Cache Duration:</strong> Default is 1 hour. You can change this in <code>./app/cache.py</code>.</li>
</ul>

<h2>Testing</h2>
<p>To ensure the application works correctly, you can run the automated test suite using <code>pytest</code>.</p>
<p>Install pytest package</p>
<p>
  <pre><code>pip install pytest</code></pre>
</p>
<p>Run tests from project root directory</p>
<p>
  <pre><code>pytest</code></pre>
</p>
<p>
  If you encounter import errors please try releative import or run
  <pre><code>PYTHONPATH=. pytest</code></pre>
</p>

<h2>Continuous integration/Continuous deployment</h2>
<ul>
<li><strong>Install and configure aws cli</strong></li>
  <p>Ensure you have aws cli installed <a href="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html" target="_blank">Install AWS CLI</a>.</p>
  <p>Configure your AWS credentials to interact with AWS API.</p>
  <p>
    Go to <a href="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html" target="_blank">Setting up the AWS CLI</a> and setup your cli
  </p>
<li><strong>Deploy infrastructure to AWS with Terraform</strong></li>
<p>Ensure you have terraform cli installed <a href="https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli" target="_blank">Install terraform CLI</a>.</p>
<p>Deploy backend to manage remote state.</p>
<pre><code>
  cd terraform/remote_state
  terraform init
  terraform plan 
  terraform apply
</code></pre>
<p>Deploy infrastructure to AWS.</p>
<pre><code>
  cd terraform
  terraform init
  terraform plan
  terraform apply
</code></pre>
<li><strong>Install the helm chart to EKS you created.</strong></li>
<pre><code>
  cd chart
  helm install weather-app . -f values.yaml
</code></pre>
</ul>

<h2>Contributing</h2>
<ol>
  <li>Fork the repo</li>
  <li>Create your feature branch (<code>git checkout -b feature/your-feature</code>)</li>
  <li>Commit your changes (<code>git commit -am 'Add new feature'</code>)</li>
  <li>Push to the branch (<code>git push origin feature/your-feature</code>)</li>
  <li>Open a pull request</li>
</ol>

<h2>Credits</h2>
<ul>
  <li><a href="https://flask.palletsprojects.com/">Flask</a></li>
  <li><a href="https://openweathermap.org/api">OpenWeatherMap API</a></li>
  <li><a href="https://developer.hashicorp.com/terraform">Terraform</a></li>
</ul>

<p><strong>Questions or suggestions?</strong><br>
Open an issue or submit a pull request!</p>

</body>
</html>
