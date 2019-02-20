pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/kurazaiev/demo.git"
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
            agent any
            steps {
                withDockerRegistry([ credentialsId: "dockerhub_user",
                                     url: "" ]) {
                    sh 'docker tag jenkins-demo kurazaev/demo-repo:latest'
                    sh 'docker tag demo-build:${BUILD_NUMBER} kurazaev/demo-repo::${BUILD_NUMBER}'
                    sh 'docker push kurazaev/demo-repo'
                }
            }
        }
    }
}