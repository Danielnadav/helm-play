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
                      helm ls
            """
        }
    }
    
    stages {
        stage('Helm List') {
            steps {
                container('helm') {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        // Run helm ls command and capture output
                        script {
                            def helmOutput = sh(returnStdout: true, script: "helm ls").trim()
                            echo helmOutput
                        }
                    }
                }
            }
        }
    }
}
