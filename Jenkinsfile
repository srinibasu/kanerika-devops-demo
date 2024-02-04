pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout files from GITHUB Repo'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'jenkins-pat', url: 'https://github.com/srinibasu/kanerika-devops-demo.git']])
                }
            }
        }
        stage('Initialize Terraform Code'){
            steps{
                script{
                    dir('EKS-Cluster-Setup'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formatting Terraform Code'){
            steps{
                script{
                    dir('EKS-Cluster-Setup'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('EKS-Cluster-Setup'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the infra by generating Terraform Plan'){
            steps{
                script{
                    dir('EKS-Cluster-Setup'){
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed with applying the plan?", ok: "Proceed")
                }
            }
        }
        stage('Creating/destroying the EKS Cluster'){
            steps{
                script{
                    dir('EKS-Cluster-Setup'){
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        stage('Deployinng nginx application'){
            steps{
                script{
                    dir('EKS-Cluster-Setup/k8s-manifests'){
                        sh 'aws eks update-kubeconfig --name my-eks-cluster --region us-east-1'
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'

                        
                    }
                }
            }
        }

    }
}