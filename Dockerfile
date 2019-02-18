FROM java
RUN mkdir -p /usr/src/demo
WORKDIR /usr/scr/demo
COPY target/demo-0.0.1-SNAPSHOT.jar /usr/src/demo
CMD java -jar demo-0.0.1-SNAPSHOT.jar
EXPOSE 8080