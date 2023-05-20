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
        
        stage('Helm Install') {
            steps {
                container('helm') {
                    script {
                        def valueFile
                        if (params.ENVIRONMENT == 'stg') {
                            valueFile = 'values-stg.yaml'
                        } else if (params.ENVIRONMENT == 'prd') {
                            valueFile = 'Values.yaml'
                        } else {
                            error("Invalid environment selected!")
                        }
                        
                        // Run helm install command with the selected value file
                        sh "helm install -f ${valueFile} ./  --generate-name"
                    }
                }
            }
        }
    }
}
