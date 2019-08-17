#!/usr/bin/env bash

# Build image and add a descriptive tag
docker build -t tirganbooks -f ../python/ .

# Run flask app
docker run -p 8080:8080 -idt tirganbooks
