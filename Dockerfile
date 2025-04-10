# Use a Maven image to build the app
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use a smaller JDK image to run the app
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/HandToHandsNotes-0.0.1-SNAPSHOT.jar app.jar

# Expose the port (Render uses PORT env)
EXPOSE 8080
ENV PORT 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
