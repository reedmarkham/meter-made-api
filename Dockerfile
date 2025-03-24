# Start from a base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the required packages
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the application code into the container
COPY ["model.pkl", "main.py", "./"] .

ENV PORT 8080

CMD exec uvicorn main:app --host 0.0.0.0 --port ${PORT}