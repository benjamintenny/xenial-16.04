#Grab the latest alpine image
FROM python:3.8.0
FROM alpine:latest

# Install python and pip
#RUN apk add --no-cache --update python3 py3-pip bash
#RUN apk add --no-cache --update gcc musl-dev python3-dev py3-pip bash
RUN apk add --no-cache --update py3-pip bash
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt


# Install headless selenium
RUN apk add chromium
RUN apk add chromium-chromedriver

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Expose is NOT supported by Heroku
# EXPOSE 5000 		

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:$PORT wsgi 

