FROM java
COPY /var/lib/jenkins/workspace/demo-build/target/demo-0.0.1-SNAPSHOT.jar /jar
RUN	cd /jar
CMD java -jar demo-0.0.1-SNAPSHOT.jar
EXPOSE 8080