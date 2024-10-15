# Create a Dockerfile for a new image that starts from ubuntu:22.04
FROM ubuntu:22.04

# add instructions to install curl into that image
RUN apt-get update
RUN apt-get install -y curl

# Add instructions to copy the script file into that image
COPY script.sh .

# Set it to run on container start 
CMD ./script.sh