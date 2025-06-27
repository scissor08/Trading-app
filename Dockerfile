# -------- Stage 1: Build JAR --------
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# -------- Stage 2: Run JAR --------
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/target/TradingApplication-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]
