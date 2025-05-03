# Use official OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy Maven configuration and source code
COPY pom.xml .
COPY src ./src

# Install Maven and build the application
RUN apt-get update && apt-get install -y maven \
    && mvn clean package -DskipTests \
    && mv target/*.jar app.jar \
    && apt-get remove -y maven \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]