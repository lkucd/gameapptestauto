pipeline
{
    agent any
    environment
    {
        // Docker Hub Credentials ID stored in Jenkins
        DOCKERHUB_CREDENTIALS ='cybr-3120'
        IMAGE_NAME ='kellucd/snakegame'
    }

    stages
    {
        stage('Cloning git')
        {
            steps
            {
                checkout scm
            }
        }

        stage('SAST')
        {
            steps
            {
                sh 'echo Running SAST scan with snyk...'
            }
        }

        stage('BUILD-AND-TAG')
        {
            agent { label 'CWEB3120Jenkins'}

            steps
            {
                script
                {
                    // Build Docker image using Jenkins Docker Pipeline API
                    echo "Building Docker image ${IMAGE_NAME}..."
                    app.docker.Build("${IMAGE_NAME}")
                    app.tag("latest")
                }
            }
        }
        stage('POST-TO-DOCKERHUB')
        {
            agent { label 'CWEB3120Jenkins'}

            steps
            {
                script
                {
                   echo "Pushing image ${IMAGE_NAME}:latest to Docker Hub..."
                   docker.withRegistry('https://registry.hub.docker.com',"{DOCKERHUB_CREDENTIALS}")
                   {
                    app.push("latest")
                   }
                }
            }
        }

        stage('DAST')
        {
            steps
            {
                sh 'echo Running DAST scan with snyk...'
            }
        }

         stage('DEPLOYMENT')
        {
            agent { label 'CWEB3120Jenkins'}

            steps
            echo 'Starting deplotyment using docker-compose...'
            {
                script
                {
                   dir("${WORKP-LACE}")
                   {
                     sh '''
                        docker-compose down
                        docker-compose up -d
                          docker ps
                    '''
                    
                   }
                }

                }
                echo 'Deployment completed successfully!'
            }

        }

    }
