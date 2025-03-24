# Start from a base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the necessary files into the container
COPY . ./

# Install the required packages
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENV PORT 1234
EXPOSE 8080

CMD exec uvicorn main:app --host 0.0.0.0 --port ${PORT}