#!/bin/bash

if [ ! -f .env ]; then
    echo "Error: .env file not found in the current directory"
    exit 1
fi

PROJECT_NAME=$(grep -E '^PROJECT_NAME=' .env | cut -d '=' -f2)

if [ -z "$PROJECT_NAME" ]; then
    echo "Error: PROJECT_NAME not found or empty in .env file"
    exit 1
fi

echo "Building container for project: $PROJECT_NAME"

docker-compose build

if [ $? -eq 0 ]; then
    echo "Successfully built $PROJECT_NAME"
else
    echo "Error: Failed to build $PROJECT_NAME"
    exit 1
fi