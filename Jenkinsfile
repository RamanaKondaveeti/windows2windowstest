def windowspath = "C:/Users/Administrator/Downloads/RecruitmentApp/Version1"

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
                   git branch: 'master', url: 'https://github.com/RamanaKondaveeti/windows2windowstest.git'
                }
        }

        stage('Prep') {
            steps {
                script {
                    GIT_BRANCH=sh(returnStdout: true, script: 'git symbolic-ref --short HEAD').trim()
                    currentBuild.setDisplayName("WindowsMultiDeploy-#${currentBuild.number} [" + GIT_BRANCH + "]")
                    sh "export GIT_BRANCH=$GIT_BRANCH"
                }
            }
        }
        stage('End 2 End Tests') {
            steps {
                echo "Running Tests if Any"
            }
        }
      stage ('Copy from windows2windows') {
        steps {
          // Moving the generated apk file to our Deployment Server which runs on WINDOWS
          echo "Copying file from windows server to WINDOWS Server"
           script {
           withCredentials([
	            usernamePassword(credentialsId: 'windowspassword', passwordVariable: 'windowspass', usernameVariable: 'Administrator'),
	            usernamePassword(credentialsId: 'windowstest1', passwordVariable: 'windowstest1', usernameVariable: 'wondowstest1'),
	            usernamePassword(credentialsId: 'windowstest2', passwordVariable: 'windowstest2', usernameVariable: 'wondowstest2')
            ]){
              sh "sshpass -p '${windowspass}' ssh Administrator@3.133.89.186 'powershell.exe cd ${windowspath}; ./backupsscript.ps1; ./powershellscript.ps1'"

              echo "$timestamp"
           }
        }
       }
      }
// Right click on the folders and give full control to folder sharing--> Advanced sharing --> permissions --full control
            
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
