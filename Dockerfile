FROM manelhomri2/monimage-java:1.0
COPY target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]