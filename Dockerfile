# -------- Stage 1: Build WAR --------
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app
COPY . .

# Run build + dist test (you can change to `verify` if using integration tests)
RUN mvn clean package -DskipTests

# -------- Stage 2: Deploy WAR to External Tomcat --------
FROM tomcat:9.0-jdk21

# Set custom port 818 (Tomcat default port change)
ENV CATALINA_HOME /usr/local/tomcat
ENV CATALINA_OPTS "-Dserver.port=818"

# Remove default webapps
RUN rm -rf $CATALINA_HOME/webapps/*

# Copy WAR from builder stage to ROOT.war
COPY --from=build /app/target/TradingApplication-0.0.1-SNAPSHOT.war $CATALINA_HOME/webapps/ROOT.war

# Update Tomcat config to use 818 instead of 8080
RUN sed -i 's/port="8080"/port="818"/' $CATALINA_HOME/conf/server.xml

EXPOSE 818
CMD ["catalina.sh", "run"]
