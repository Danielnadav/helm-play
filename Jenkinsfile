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
                    // Run helm install command
                    sh "helm install nginxprd . -f Values.yaml"
                }
            }
        }
    }
}
