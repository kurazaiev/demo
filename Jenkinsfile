pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/kurazaiev/demo.git"
            }
        }

        stage ('Dockerhub configuration') {
            steps {
                withDockerRegistry (
                    url: "https://cloud.docker.com",
                    credentialsId: "dockerhub_user"
                )
            }
        }

        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: "mvn",
                    pom: 'pom.xml',
                    goals: 'clean package',
                )
            }
        }

        stage ('Docker build image') {
            agent any
            steps {
                sh 'mv /var/lib/jenkins/workspace/demo-build/target/demo-0.0.1-SNAPSHOT.jar /var/lib/docker/tmp/'
                sh 'docker build -t demo-build:${BUILD_NUMBER} .'
                sh 'docker tag demo-build:${BUILD_NUMBER} jenkins-demo:latest'
                sh 'docker images'
            }
        }

        stage ('Push to repo') {
            steps {
                sh 'docker push jenkins-demo:latest'
                sh 'docker push demo-build:${BUILD_NUMBER}'
            }
        }
    }
}