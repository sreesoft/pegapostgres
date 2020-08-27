# Dockerfile

# base postgres image
FROM postgres:11.8

# install packages & Java for tomcat
RUN apt-get update && \
	apt-get install sudo

RUN apt-get update && \
    apt-get install -y curl \
    wget \
    openjdk-8-jdk
	
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

RUN apt-get install -y vim


### prepare postgres config for Pega
RUN ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/libjvm.so /lib/libjvm.so
COPY ./pljava.so /usr/lib/postgresql/11/lib
COPY ./pljava.jar /usr/lib/postgresql/11/lib


#change default data folder to different location.
#This is required to not loose changes due to different volume postgres create.
RUN mkdir -p /var/lib/postgresql-static/data
RUN chown -R postgres:postgres /var/lib/postgresql-static
ENV PGDATA /var/lib/postgresql-static/data

#COPY ./pg_hba.conf /var/lib/postgresql-static/data
#COPY ./postgresql.conf /var/lib/postgresql-static/data
