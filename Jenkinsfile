pipeline {
    agent none
    stages {
        stage('Git checkout') {
            agent { label 'Build' }
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/surya123789/my_own_project.git'
            }
        }
        stage('Build') {
            agent { label 'Build' }
            steps {
                sh 'mvn install'
            }
        }
        stage('SonarQube analysis') {
            agent { label 'Build' }
            steps {
                withSonarQubeEnv('sonarqubedashboard') {
                    sh 'mvn sonar:sonar'
    }   // submitted SonarQube taskId is automatically attached to the pipeline context
  }
}
  
// No need to occupy a node
        stage("Quality Gate"){
            agent { label 'Build' }
            steps {
               script {
                 timeout(time: 10, unit: 'MINUTES') { // Just in case something goes wrong, pipeline will be killed after a timeout
                    def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                    if (qg.status != 'OK') {
                         error "Pipeline aborted due to quality gate failure: ${qg.status}"
                                           }
                                                    }
                     }
                 }
                             }
        stage('uploading artifacts to JFROG(artifactory repo)') {
            agent { label 'Build' }
            steps {
                rtUpload (
                    serverId: 'artifactory-server',
                    spec: '''{
                        "files": [
                            {
                            "pattern": "target/**.war",
                            "target": "maven/"
                            }
                        ]
                     }''',
 
    // Optional - Associate the uploaded files with the following custom build name and build number,
    // as build artifacts.
    // If not set, the files will be associated with the default build name and build number (i.e the
    // the Jenkins job name and number).
                    buildName: 'my_own_project',
                    buildNumber: '01',
                    // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                    project: 'my_own_project'
)
            }
        }
        stage('Downloading artifactory from JFROG(artifactory repo)') {
            agent { label 'Docker' }
            steps {
                rtDownload (
                    serverId: 'artifactory-server',
                    spec: '''{
                        "files": [
                            {
                            "pattern": "target/**.war",
                            "target": "maven/"
                            }
                        ]
                     }''',
 
    // Optional - Associate the uploaded files with the following custom build name and build number,
    // as build artifacts.
    // If not set, the files will be associated with the default build name and build number (i.e the
    // the Jenkins job name and number).
                    buildName: 'my_own_project',
                    buildNumber: '01',
                    // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                    project: 'my_own_project'
)
            }
        }
        stage('Git-checkout-docker ') {
            agent { label 'Docker' }
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/surya123789/suryatech.git'
            }
        }
        stage('build-Image') {
                // Build the images from dockerfile
              agent { label 'Docker' }
		     	 steps {
			      	sh 'docker build -t="surya123789/my_own_project:latest" .'
		        }
        }
    	stage('Docker-login') {
            agent { label 'Docker' }
		      steps {
		          sh 'docker login -u surya123789 -p aDm1n@123'
			}
	}
	    stage('Dockerpush') {
			  agent { label 'Docker' }
          steps {
				     sh 'docker push surya123789/my_own_project:latest'
		             	}
	}
	   stage('pull image') {
			 agent { label 'Docker' }
            steps {
				      sh 'docker pull surya123789/my_own_project:latest'
			                  }
	    	}
  	stage('create container') {
			agent { label 'Docker' }
           steps {
				     sh 'sudo docker run -it -d --name mydocker1 -p 8080:8080 surya123789/pipeline:latest'
			                  }
	    	}
 }
}
