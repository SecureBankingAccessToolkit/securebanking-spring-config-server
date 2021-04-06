FROM adoptopenjdk/openjdk14:jre-14.0.2_12

RUN mkdir /app
RUN groupadd -r spring-config && useradd -r -s /bin/false -g spring-config spring-config

WORKDIR /app
COPY securebanking-spring-config-server.jar /app
RUN chown -R spring-config:spring-config /app
USER spring-config

CMD ["java", "-jar", "securebanking-spring-config-server.jar"]