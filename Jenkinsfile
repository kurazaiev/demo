pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/kurazaiev/demo.git"
            }
        }

       /* stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "art",
                    url: "https://demoak.jfrog.io/demoak",
                    credentialsId: "jfroguser"
                )
            }
        }*/

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
                                     url: "https://cloud.docker.com/repository/docker/kurazaev/demo-repo" ]) {
                    sh 'docker push jenkins-demo:latest'
                    sh 'docker push demo-build:${BUILD_NUMBER}'
                }
            }
        }
    }
}