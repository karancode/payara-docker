FROM java:8-jdk
LABEL maintainer="karan.thanvi@rakuten.com"

# ENV for payara download
ENV PAYARA_PKG https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/Payara+4.1.1.171.1/payara-4.1.1.171.1.zip
ENV PAYARA_FILE_NAME payara-server-4.1.1.171.1.zip
ENV PAYARA_HOME /opt/payara41

# update & install unzip
RUN apt-get update
RUN apt-get install -y unzip

# create payara home
RUN mkdir -p $PAYARA_HOME/deployments && \
    mkdir -p /opt/scripts && \
    mkdir -p /opt/deployments

# download & unpack payara
RUN wget -O /opt/$PAYARA_FILE_NAME $PAYARA_PKG && \
    unzip /opt/$PAYARA_FILE_NAME -d /opt

# setup payara 
COPY ["./env_payarabase.sh","./setup_payarabase.sh", "/opt/scripts/"]
COPY ./showcase-5.3.war /opt/deployments
COPY ./mysql-connector-java-5.1.39.jar $PAYARA_HOME/glassfish/domains/domain1/lib/ext

# permission for scripts
RUN chmod +x /opt/scripts/*
RUN chmod +x /opt/deployments/*


# envs for payara-asadamin
ENV ADMIN_PASSWORD admin
ENV AS_ADMIN_PORT 4848
ENV AS_ADMIN_PASSWORDFILE /opt/.aspasswd
ENV AS_ADMIN_HOST localhost
ENV PATH=$PATH:$PAYARA_HOME/bin

# asadmin password configs
RUN echo 'AS_ADMIN_PASSWORD=\n\
AS_ADMIN_NEWPASSWORD='${ADMIN_PASSWORD}'\n\
EOF\n'\
>> /opt/tmpfile

RUN echo 'AS_ADMIN_PASSWORD='${ADMIN_PASSWORD}'\n\
EOF\n'\
>> /opt/.aspasswd

# setup payara instance
RUN /opt/scripts/setup_payarabase.sh

# expose port required
#EXPOSE 4848 8080 8009 8007

# cleanup
RUN rm /opt/$PAYARA_FILE_NAME
#RUN rm /opt/tmpfile

# start domain at the end
#ENTRYPOINT ["asadmin", "start-domain", "-v"]

# dockerfile end
