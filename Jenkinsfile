def project_folder = "/var/lib/jenkins/workspace/RecruitmentApp/app/build/outputs/apk/debug"
def JOB_NAME = 'RecruitmentApp'
def backup_folder = '/var/lib/jenkins/workspace/apkbackups'
def Version_Number = "0.0.1.$BUILD_NUMBER"
def backup_file_name = "$Job_Name.$Version_Number" //final file name 

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
					currentBuild.setDisplayName("AndroidApp- #${currentBuild.number} [" + GIT_BRANCH + "]")
					sh "export GIT_BRANCH=$GIT_BRANCH"
				}
			}
		}
       stage('Dependencies') {
              steps {  
		      sh "pwd"
		      sh 'ls /root/android-sdk'
                sh 'ls /root/android-sdk/cmdline-tools'
		            sh 'export ANDROID_HOME=/root/android-sdk/cmdline-tools'
                sh 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin'
                sh 'export PATH=$PATH:$ANDROID_HOME/platform-tools'
                sh 'echo $ANDROID_HOME'
		        }  
          }
        stage('Build') {
            steps {
                sh "chmod +x gradlew"
                sh './gradlew build'
            }
         }
     
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

       stage ('Backup apk'){
        steps {
          script {
            echo "Copying apk as a backup"
                sh "cp ${project_folder}/*.apk ${backup_folder}"
            // sh 'cd /var/lib/jenkins/workspace/apkbackups'
                sh "mv ${backup_folder}.apk ${JOB_NAME}.${currentBuild.number}.apk"
            echo "Build number is ${currentBuild.number}"
            echo "Job name is ${JOB_NAME}"
          }
        }

       }

	 }
     post {
	        success {
	          script {
	            echo 'Build completed'
              // We can add SMTP server details where we can send the email notifications once build is success
	            echo 'Sending email Notification...'
	         
	 
	          }
	        }
	         failure {
	          script {
	            echo 'Build failed!!'
	            echo 'Sending email Notification...'
	          
	 
	        }
	    }
	}
}

