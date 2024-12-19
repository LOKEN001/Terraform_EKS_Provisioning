pipeline{
    agent any
    environment {                                                     #set the aws credential in jenkins
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {
        stag ("Git Checkout"){
            steps{
                script{

                }
 
            }
        }

        stag ("Initialization"){
            steps{
                 script{
                   dir("EKS-Provisioning"){
                   sh 'terraform init'
                   }
                }
            }
        }

        stag ("Formation"){
            steps{
                 script{
                   dir("EKS-Provisioning"){
                   sh 'terraform fmt'
                   }
                }
 
            }
        }

        stag ("Validation"){
            steps{
                 script{
                   dir("EKS-Provisioning"){
                   sh 'terraform validate'
                   }
                }
 
            }
        }

        stag ("Planing"){
            steps{
                script{
                   dir("EKS-Provisioning"){
                   sh 'terraform plan'
                   }
                   input(message: "Please check the plan" ok: "proceed")
                }
 
            }
        }

        stag ("Applying or Distroy the cluster"){
            steps{
                script{
                    dir("EKS-Provisioning"){
                        sh 'terraform $action --auto-approve'             # based on condition of parameter
                    }

                }
 
            }
        }

         stag ("Planing"){
            steps{
                script{
                   dir("EKS-Provisioning/configuration"){
                      sh 'aws eks update-kubeconfig --name my-eks-cluster'
                      sh 'kubectl apply -f deployment.yaml'
                      sh 'kubectl apply -f service.yaml'
                   }
                }
 
            }
        }
    }
}