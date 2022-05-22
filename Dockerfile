FROM ubuntu:20.04 
MAINTAINER "surya@evoke.com"
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.78/bin/apache-tomcat-8.5.78.tar.gz /root
COPY gamutkart.war /root/apache-tomcat-8.5.78/webapps
ENTRYPOINT /root/apache-tomcat-8.5.78/bin/startup.sh && bash
EXPOSE 8080/tcp
