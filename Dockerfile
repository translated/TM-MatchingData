FROM php

# install java 11
RUN apt-get update
RUN mkdir -p /usr/share/man/man1
RUN apt -qy install openjdk-11-jre-headless

# install mailutils to send email
RUN apt update
RUN apt -qy install mailutils


# Create app directory
WORKDIR /server

# Copy needed files
COPY CMD.httpserver_start.sh /server
COPY DO_clustering.sh /server
RUN mkdir -p /server/WWW/save/sys /server/WWW/save/trace /server/WWW/save/upload
RUN mkdir -p /server/sw
COPY WWW/. /server/WWW/
COPY sw/. /server/sw/
RUN find /server/WWW


# define the port number the container should expose
EXPOSE 8082

# run the command
CMD ["bash", "CMD.httpserver_start.sh"]

