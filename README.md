**Demo High Level Summary:**
1. I've used my laptop used as base machine on which Windows Sub-System for Linux(Ubuntu), terraform and visual studio code is installed. 
2. This Demo has two fully automated parts. 
    Automated Jenkins Server Installation and Setup using Terraform from my local machine. 
    A Jenkins Pipeline for EKS Provisioning and Deployment using Terraform Code.
    Following are pipelines stages. 
        Checkout Code from GITHUB Repo
        Initialize Terraform Code
        Check for Formatting Errors in Terraform Code
        Validating Terraform Code
        Previewing the infra by generating Terraform Plan
        Creating/destroying the EKS Cluster
        Deploying nginx application using k8s YAML manifest files. 
3. S3 Bucket is configured to be used for storing terraform state as remote backend.
4. Leveraged Terraform existing modules for writing code in Visual Studio Code IDE. 
5. All the code is stored in GITHUB Repo using local git commands and from local git repository. 
6. Pipeline is configured to poll SCM for identifying any changes to the GITHUB repo and kickstart the pipeline automatically once a merge to the master occurred.
7. Pipeline code is written in Groovy and it is a parameterized pipeline so we can use the same pipeline for Provisioning and De-provisioning the AWS EKS infrastructure by toggling between apply and destroy parameter values.    

**FAQ:** 

1. Tools and Technologies Used: AWS Cloud, AWS CLI, Jenkins, GITHUB, Terraform, Visual Studio Code, Shell Commands, Kubernetes, EKS, Docker Containers.
2. AWS Resources Used(Primarily): EC2, S3 Bucket, VPC, Subnets, Elastic IP, Availability Zones, ALB, Security Groups, EKS, Node Groups, Routing Tables, IAM, Access Keys, NAT & Internet Gateways
3. Is there any scope for improvement? - YES, Definitely! As the requirements pops-up, the features can be added accordingly. Below are some basic thoughts but not limited to. 
Terraform - Usage of Terraform Work Spaces, Count, foreach, maintain state at each make it more reusable code and in organized manner. 
K8s - Usage of Namespaces, RBAC, HPA, Taints, Tolerances, Deamon sets, Persistent Volumes, 
etc..

Challenges: Data usage limit of 1 GB per region in Free AWS Tier is already consumed and further usage may incur costs.  
