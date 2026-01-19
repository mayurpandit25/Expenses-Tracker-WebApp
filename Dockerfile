#1st stage to build the artifact
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests=true

#2nd stage to copy the artifacts
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

ENTRYPOINT ["java","-jar","/app/target/expenseapp.jar"]
