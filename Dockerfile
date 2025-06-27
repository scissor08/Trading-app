FROM tomcat:9.0-jdk21

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR into the ROOT context
COPY target/TradingApplication-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
