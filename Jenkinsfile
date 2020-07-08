pipeline{
        agent any
        stages{
            stage('Pull Repo'){
                steps{
                    sh "git checkout development2"
                    sh "git pull"
                }
            }
            stage('Install docker and docker-compose'){
                steps{
                    sh "sudo apt update"
                    sh "sudo apt install -y curl jq"
                    sh "version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')"
                    sh "docker: curl https://get.docker.com | sudo bash"
                    sh "sudo curl -L 'https://github.com/docker/compose/releases/download/\${version}/docker-compose-\$(uname -s)-\$(uname -m)' -o /usr/local/bin/docker-compose"
                    sh "sudo chmod +x /usr/local/bin/docker-compose"
                }
            }
                stage('Deploy application'){
                        steps{
                                sh "cd dnd-project"
                                sh "docker-compose build"
                                sh "docker-compose push"
                                sh "docker stack deploy --compose-file docker-compose.yaml dnd"
                        }
        }    
}
}
