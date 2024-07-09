FROM python:3.11-slim AS base

RUN apt-get update && 
    apt-get install -y --no-install-recommends curl && 
    rm -rf /var/lib/apt/lists/*
# --no-install-recommends flag is used to prevent the installation of recommended packages to reduce image size
# rm -rf /var/lib/apt/lists/* is used to clear cache to reduce image size.

WORKDIR /usr/local/app/
# Set the application directory

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt
#--no-cache-dir it prevents caching of downloaded packages
# Install our requirements.txt

# Define a stage specifically for development, where it'll watch for
# filesystem changes
FROM base AS dev
RUN pip install watchdog
ENV FLASK_ENV=development
#development Flask provides additional features like auto-reloading when code changes
CMD ["python", "app.py"]

#Define the final stage that will bundle the application for production
FROM base AS final

COPY . .
#Copy our code from the current folder to the working directory inside the container

EXPOSE 80

#Define our command to be run when launching the container
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
