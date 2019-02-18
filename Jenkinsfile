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
                sh 'cd /var/lib/jenkins/workspace/demo-build/target/'
                sh 'docker image build .. -t demo-build:${BUILD_NUMBER}'
                sh 'docker tag demo-build:${BUILD_NUMBER} jenkins-demo:latest'
                sh 'docker images'
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