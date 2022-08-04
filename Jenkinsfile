def project_folder = "/var/lib/jenkins/workspace/RecruitmentApp/app/build/outputs/apk/debug"
def JOB_NAME = 'RecruitmentApp'
def backup_folder = '/var/lib/jenkins/workspace/apkbackups'
def Version_Number = "0.0.1.$BUILD_NUMBER"
//def Console_Output_URL = "${JOB_URL}${BUILD_NUMBER}/console"
def finalfile ="${backup_folder}/${JOB_NAME}_${currentBuild.number}.apk"

pipeline {

    agent any 

   environment {
    PATH = "/opt/gradle/gradle-7.4.2:$PATH"
    def timestamp = sh (script: "echo `date +%d%m%Y%H%M`", returnStdout: true).trim()
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
					currentBuild.setDisplayName("AndroidApp-#${currentBuild.number} [" + GIT_BRANCH + "]")
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
     
        stage('End 2 End Tests') {
            steps {
                echo "Running Tests if Any"
            }
        } 

       stage ('Backup apk'){
          steps {
            script {
            // Copy the generated apk file to a backup folder
              echo "Copying apk as a backup"
              sh "cp -r ${project_folder}/*.apk ${backup_folder}"
            // Renaming apk file with app and build number    
              echo "Renaming apk file with App and Build Number"
              sh "mv ${project_folder}/*.apk ${backup_folder}/${JOB_NAME}_${currentBuild.number}.apk"
              echo "Build number is ${currentBuild.number}"
              echo "Job name is ${JOB_NAME}"
          }
        }

       }

       stage ('Deploy to Server') {
        steps {
          // Moving the generated apk file to our Deployment Server which runs on WINDOWS
          echo "Copying apk to WINDOWS Server"
          // 
           withCredentials([string(credentialsId: 'windows_password', variable: 'windowspassword')]){
              sh "echo y | pscp -pw '${windowspassword}' $timestamp_${finalfile} Administrator@3.133.89.186:/Users/Administrator/Downloads/RecruitmentApp/Version1"
              echo "My password is '${windowspassword}'!"
          }
          // -pw 'KSVoTE%3n3kiN=Jn36;ZHEdHm(JG*ptV'
        //  need to bind this password KSVoTE%3n3kiN=Jn36;ZHEdHm(JG*ptV
        //  sh "mount -t cifs -o username=Administrator //172.31.46.59/Users/Administrator/Downloads/RecruitmentApp/Version1 /var/lib/jenkins/workspace/apkbackups/"
          echo "$timestamp"
        }
       }

	 }
     post {
	        success {
	          script {
	            echo 'Build Completed'
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

