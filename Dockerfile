#Reference URL: https://runnable.com/docker/java/dockerize-your-java-application
#Reference URL: https://www.howtoforge.com/tutorial/how-to-create-docker-images-with-dockerfile/
#Reference URL: https://hub.docker.com/r/mcpayment/ubuntu1404-java8/~/dockerfile/
#Reference Command: docker search ubuntu/java

#Download base image ubuntu 16.04
FROM ubuntu

MAINTAINER  Ankush Goyal <ankush.goyal@prontoitlabs.com>
 
# Update Software repository
RUN apt-get update

#Update the package repository
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get -y update

#Install Oracle Java 8
ENV JAVA_VER 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-get update && \
    echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VER}-installer oracle-java${JAVA_VER}-set-default && \
    apt-get clean && \
    rm -rf /var/cache/oracle-jdk${JAVA_VER}-installer

#Set Oracle Java as the default Java
RUN update-java-alternatives -s java-8-oracle

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc

#Clean Up APT when finished
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#CMD ["/sbin/my_init"]

EXPOSE 80 443

