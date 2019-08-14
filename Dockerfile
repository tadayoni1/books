FROM python:3.7.3-stretch

# Create a working directory
WORKDIR /app

# Copy source code to working directory
COPY . * /app/

# Install packages from requirements.txt
RUN pip install --upgrade pip==19.2.1 &&\
    pip install --trusted-host pypi.python.org -r requirements.txt

# Expose port 8080
EXPOSE 8080/tcp

## Step 5:
# Run app.py at container launch
CMD ["python", "run_app.py"]
