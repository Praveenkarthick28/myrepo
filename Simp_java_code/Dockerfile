FROM amazoncorretto:11

ARG artifact=target/MathOperations-0.0.1-SNAPSHOT.jar

WORKDIR /opt/app
 #open the folder you need to place

COPY ${artifact} opt/app

ENTRYPOINT ["java","-jar","app.jar"]
