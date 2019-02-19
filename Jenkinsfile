pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/kurazaiev/demo.git"
            }
        }

        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "art",
                    url: "https://demoak.jfrog.io/demoak",
                    credentialsId: "jfroguser"
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
                sh 'pwd'
                sh  'mv /var/lib/jenkins/workspace/demo-build/target/demo-0.0.1-SNAPSHOT.jar /var/lib/docker/tmp/'
                sh 'pwd'
                sh  'docker build -t demo-build:${BUILD_NUMBER} .'
                sh 'pwd'
                sh  'docker tag demo-build:${BUILD_NUMBER} jenkins-demo:latest'
                sh 'pwd'
                sh  'docker images'
                sh 'pwd'
            }
        }

//           stage ('Publish build info') {
//                    steps {
//                        rtPublishBuildInfo (
//                    serverId: 'art'
//                )
//            }
//        }
    }
}