FROM amazoncorretto:23-alpine3.20

EXPOSE 8080

WORKDIR /usr/src/app

COPY . .

RUN sed -i 's/\r$//' mvnw
RUN ./mvnw package

CMD ["java", "-jar", "./target/docker-example-1.1.3.jar"]

