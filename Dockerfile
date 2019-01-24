FROM tomcat:8.0-jre8-alpine

MAINTAINER SUMIT SAMSON

LABEL created_by="sumit"
LABEL version="1.0"
LABEL date_of_creation="18-Jan-2019"

RUN apk update
RUN apk upgrade
RUN apk add openjdk8

RUN apk update
RUN apk add --no-cache musl-dev libffi-dev openssl-dev make gcc python py2-pip python-dev
RUN pip install cffi
RUN pip install --upgrade pip
RUN pip install ansible
RUN apk update
RUN apk add --no-cache openssh
RUN apk add sshpass


ENV TOMCAT_HOME /usr/local/tomcat
#ENV REPOSITORY_URL http://localhost:9081/artifactory/generic-local


#ARG WAR_URL=$REPOSITORY_URL/ansiblecore.war

#ADD $WAR_URL $TOMCAT_HOME/webapps/ansiblecore.war

# for accessing tomcat manager ui using tomcat:Automic@1
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml


RUN chmod -R 777 $TOMCAT_HOME


EXPOSE 8080

ENTRYPOINT  ["catalina.sh","run"]
