FROM java
RUN mkdir -p /demo
WORKDIR /demo
COPY ../demo-0.0.1-SNAPSHOT.jar /demo
CMD java -jar demo-0.0.1-SNAPSHOT.jar
EXPOSE 8080

