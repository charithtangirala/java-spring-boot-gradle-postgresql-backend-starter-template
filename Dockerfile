# Stage 1: Build the Java 25 Spring Boot JAR file
FROM eclipse-temurin:25-jdk-jammy AS build
WORKDIR /app
COPY . .
RUN ./gradlew build -x test

# Stage 2: Create the slim production runtime image using Java 25 JRE
FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
