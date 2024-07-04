FROM adoptopenjdk/openjdk11:alpine-jre

ARG artifact=target/Simp_java_code.jar

WORKDIR opt/app
 #open the folder you need to place

COPY ${artifact} opt/app

ENTRYPOINT ["java","-jar","app.jar"]
