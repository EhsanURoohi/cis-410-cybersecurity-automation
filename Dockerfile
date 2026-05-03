# FIX VIOLATION 1: Use a pinned, stable, and lightweight base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# FIX VIOLATION 2: Optimize Layer Caching
# Copy only the requirements first so Docker can cache the 'pip install' layer
COPY app/requirements.txt ./app/requirements.txt
RUN pip install --no-cache-dir -r app/requirements.txt

# Now copy the rest of the application code
COPY . .

# FIX VIOLATION 3: Remove Root Privileges
# Create a dedicated non-root user and change ownership of the app directory
RUN useradd -m appuser && chown -R appuser:appuser /app

# Switch to the non-root user
USER appuser

EXPOSE 5000

# Run the application
CMD ["python", "app/app.py"]