pipeline {
    agent any
    
    environment {
        HTML_FILE = 'webPage/index.html'
        VM_USER = 'user'
        VM_PASS = 'password'
        VM_GROUP = ['VM-ip', 'VM-ip']  
        DEST_PATH = '/var/www/html' 
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Deploy HTML') {
            steps {
                script {
                    for (instance in env.VM_GROUP) {
                        echo "Copying HTML file to $instance..."
                        scpToRemote(remote: instance, user: env.VM_USER, password: env.VM_PASS, source: env.HTML_FILE, destination: "${instance}:${env.DEST_PATH}/index.html")
                    }
                }
            }
        }
    }
}
