pipeline {

    agent any 

   environment {
//PATH = "/opt/apache-maven-3.8.6/bin/:$PATH"
//PATH = "/opt/gradle/gradle-7.5-rc-4/bin/:$PATH"
    PATH = "/opt/gradle/gradle-7.4.2:$PATH"
   }

     options {
        timestamps()
    }

    stages {
		
        stage ("Clone Repository") {
                steps {
                   git branch: 'master', url: 'https://github.com/RamanaKondaveeti/RecruitmentAppAndroidGradle.git'
                }
            }  

        stage('Prep') {
			steps {
				script {
					GIT_BRANCH=sh(returnStdout: true, script: 'git symbolic-ref --short HEAD').trim()
					currentBuild.setDisplayName("#${currentBuild.number} [" + GIT_BRANCH + "]")
					sh "export GIT_BRANCH=$GIT_BRANCH"
				}
			}
		}  

        stage('Build') {
            steps {
                sh "chmod +x gradlew"
                sh './gradlew build --no-daemon -stacktrace'
            }
         }

       //  stage('Frontend Static Code Analysis') {
         //   steps {
           //     script {
             //       try {
               //         sh './gradlew tslint --no-daemon'
                 //   } finally { //Make checkstyle results available
                   //     checkstyle canComputeNew: false, defaultEncoding: '', healthy: '', pattern: 'publicapi/frontend/tslint-result.xml', unHealthy: ''
                   // }
              //  }
         //   }
       // }
     //   stage('End 2 End Tests') {
       //     steps {
         //       script {
           //         try {
             //           sh './gradlew e2e --no-daemon'
               //     } finally { //Make selenium/protractor results available and publish the html (containing screenshots)
                 //       junit '**/e2e-results/junit-formatted/*.xml'
                   //     publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'publicapi/frontend/test/e2e-results/html-formatted/', reportFiles: 'htmlReport.html', reportName: 'End 2 End Test Report', reportTitles: ''])
                  //  }
              //  }
           // }
       // } 

        stage ('Declarative Post Options') {
            steps {
                script {
                    echo 'Sending Post Build Notifications'
                }
            }   
            
	        }
	}
}


	






    

    













