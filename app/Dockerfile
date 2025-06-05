# Use Alpine for minimal size
# Use Python 3.11 Alpine image for a lightweight container
FROM python:3.11-alpine

# Set environment variables for cleaner image with no cache and unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy only the application code (not .git, tests, etc.). The files to ignore should be specified in .dockerignore.
COPY . .

# Create a non-root user for running the app
RUN adduser -D -g '' appuser && chown -R appuser /app

# Switch to non-root user
USER appuser

# Expose only the necessary port
EXPOSE 5000

# Use Gunicorn for production, reading API key from environment variable
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:5000", "main:app"]

# Local healthcheck inside the container for running the docker container locally
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --spider -q http://localhost:5000/health || exit 1
