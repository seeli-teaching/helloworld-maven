# First stage: Maven builder
FROM maven:3.6.3-jdk-11-slim AS build

WORKDIR /app
COPY . .

RUN mvn clean package

# Second stage: Java runner
FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=build /app/target/jb-hello-world-maven-0.2.0.jar app.jar

CMD ["java", "-jar", "app.jar"]