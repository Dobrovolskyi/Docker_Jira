FROM openjdk:11.0.8-slim

RUN apt update && apt -y install wget

RUN mkdir /opt/jira/ && useradd -m -s /bin/bash jira
RUN wget -O- https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-8.13.0.tar.gz | tar xz -C /opt/jira
RUN chown jira:jira /opt/jira && chmod 0777 /opt && chmod 0775 /opt/jira &&\
    mv /opt/jira/atlassian-jira-software-8.13.0-standalone/* /opt/jira/ &&\
    sed "s%jira.home = %jira.home = /home/jira%g" /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties

ENV JIRA_HOME=/home/jira

WORKDIR /opt/jira/
EXPOSE 8080
USER jira

ENTRYPOINT ./bin/start-jira.sh -fg