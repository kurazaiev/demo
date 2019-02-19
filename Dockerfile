FROM java
RUN mkdir -p /demo
WORKDIR /demo
COPY /var/lib/jenkins/workspace/demo-build/target/demo-0.0.1-SNAPSHOT.jar /demo
CMD java -jar demo-0.0.1-SNAPSHOT.jar

