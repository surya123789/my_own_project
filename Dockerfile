FROM ubuntu:20.04 
MAINTAINER "surya@evoke.com"
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y apache2
RUN apt-get install -y nginx
ENV JAVA_HOME /usr
#ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.78/bin/apache-tomcat-8.5.78.tar.gz /root
#COPY gamutkart.war /root/apache-tomcat-8.5.78/webapps
#RUN chmod -R 777 /root/apache-tomcat-8.5.78
ENTRYPOINT service apache2 restart && bash
EXPOSE 80/tcp
