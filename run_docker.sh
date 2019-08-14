#!/usr/bin/env bash

# Build image and add a descriptive tag
docker build --tag=tirganbooks .

# Run flask app
docker run -p 8080:8080 -idt tirganbooks
