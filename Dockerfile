FROM adoptopenjdk/maven-openjdk13 as build

WORKDIR /workspace/app

COPY pom.xml .
COPY src src

RUN mvn install -DskipTests

FROM adoptopenjdk/openjdk13:jre-13.0.2_8-ubuntu

RUN apt-get update && apt-get install -y libxrender1 libxtst6 libxi6

COPY --from=build /workspace/app/target/*.jar /application.jar

ENTRYPOINT ["java","-jar","/application.jar"]

