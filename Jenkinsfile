pipeline {
    agent {
        kubernetes {
            // Configure the Kubernetes pod template
            // Customize the values based on your Kubernetes cluster and requirements
            yaml """
                apiVersion: v1
                kind: Pod
                metadata:
                  labels:
                    jenkins: agent
                spec:
                  containers:
                  - name: helm
                    image: alpine/helm
                    command:
                    - /bin/sh
                    - -c
                    - |
                      while true; do sleep 1; done
            """
        }
    }
    
    parameters {
        choice(
            choices: ['stg', 'prd'],
            description: 'Select the environment',
            name: 'ENVIRONMENT'
        )
    }
    
    stages {
        stage('Helm List') {
            steps {
                container('helm') {
                    // Run helm ls command
                    sh "helm ls"
                }
            }
        }
        
        stage('Helm Install or Upgrade') {
            steps {
                container('helm') {
                    script {
                        def valueFile
                        def releaseName
                        def chartPath
                        
                        if (params.ENVIRONMENT == 'stg') {
                            valueFile = 'values-stg.yaml'
                            releaseName = 'my-chart-stg'
                            chartPath = 'https://github.com/Danielnadav/helm-play.git'
                        } else if (params.ENVIRONMENT == 'prd') {
                            valueFile = 'values-prd.yaml'
                            releaseName = 'my-chart-prd'
                            chartPath = 'https://github.com/Danielnadav/helm-play.git'
                        } else {
                            error("Invalid environment selected!")
                        }
                        
                        // Check if the release already exists
                        def releaseCheck = sh(returnStatus: true, script: "helm list -q --namespace my-namespace | grep -q ${releaseName}")
                        
                        if (releaseCheck == 0) {
                            // Release already exists, perform helm upgrade
                            sh "helm upgrade -f ${valueFile} ${releaseName} ${chartPath}"
                        } else {
                            // Release does not exist, perform helm install
                            sh "helm install -f ${valueFile} --generate-name ${chartPath}"
                        }
                    }
                }
            }
        }
    }
}
