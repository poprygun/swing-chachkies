FROM adoptopenjdk/maven-openjdk13 as build

WORKDIR /workspace/app

COPY pom.xml .
COPY src src

RUN mvn install -DskipTests

#FROM adoptopenjdk/openjdk13:jre-13.0.2_8-alpine
FROM adoptopenjdk/openjdk13:jre-13.0.2_8-ubuntu
#FROM adoptopenjdk/openjdk13:jre-13.0.2_8_openj9-0.18.0-ubuntu

#
#
#RUN yum -y install libXext.x86_64
#RUN yum -y install libXrender.x86_64
#RUN yum -y install libXtst.x86_64

RUN apt-get update && apt-get install -y libxrender1 libxtst6 libxi6

COPY --from=build /workspace/app/target/*.jar /application.jar

ENTRYPOINT ["java","-jar","/application.jar"]

