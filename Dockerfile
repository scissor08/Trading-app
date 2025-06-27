# Start from an OpenJDK base image
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the executable JAR file into the container
COPY target/*.jar app.jar

# Run the JAR file
CMD ["java", "-jar", "app.jar"]
