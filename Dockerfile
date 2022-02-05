#Grab the ubuntu 16.04 image
FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

# Install python and pip
RUN apt-get update -y
RUN apt-get install -y python3-pip python3 build-essential
RUN apt-get install -y xvfb chromium-chromedriver firefox xserver-xorg-video-dummy

ENV TZ=Europe/Moscow

ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

RUN python3 dummy.py
# Expose is NOT supported by Heroku
# EXPOSE 5000 		

# Run the image as a non-root user
#RUN adduser -D myuser
#USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:$PORT wsgi 

