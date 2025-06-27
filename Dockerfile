# Use official Tomcat base image
FROM tomcat:9-jdk11

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file as ROOT.war
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
