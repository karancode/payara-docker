#FROM java:8-jdk
FROM dockt/payarabase:2.0
LABEL maintainer="karan.thanvi@rakuten.com"

# setup payara 
COPY ["./entrypoint.sh","./env.sh","./create_payara_backend.sh", "./common_asadmin_env.sh", "./load_env.sh", "/opt/scripts/"]

# permission for scripts
RUN chmod +x /opt/scripts/*

# setup payara instance
RUN /opt/scripts/create_payara_backend.sh

# expose port required
EXPOSE 4848 8080 8009 8007

# cleanup
RUN rm /opt/tmpfile

# start domain at the end
ENTRYPOINT ["/opt/scripts/entrypoint.sh"]

# dockerfile end
