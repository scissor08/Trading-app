# -------- Stage 1: Build WAR --------
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app
COPY . .

# Run build + dist test (you can change to `verify` if using integration tests)
RUN mvn clean package -DskipTests

# -------- Stage 2: Deploy WAR to External Tomcat --------
FROM tomcat:9.0-jdk21

RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml
# Set Tomcat Home
ENV CATALINA_HOME /usr/local/tomcat

# Remove default webapps
RUN rm -rf $CATALINA_HOME/webapps/*

# Copy WAR from builder stage to ROOT.war
COPY --from=build /app/target/TradingApplication-0.0.1-SNAPSHOT.war $CATALINA_HOME/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
