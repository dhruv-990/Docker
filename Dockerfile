# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables to prevent prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Python and pip
RUN apt update && apt install -y python3 python3-pip python3-venv && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Create a virtual environment
RUN python3 -m venv venv

# Activate the virtual environment and install dependencies
RUN . /app/venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

# Expose the port FastAPI runs on
EXPOSE 8000

# Run the application inside the virtual environment
CMD ["/app/venv/bin/python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]