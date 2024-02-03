# vpc - Refer documentation here - https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.15.0
# as we're using terraform vpc module, route tables, subnets, internet gateways will be automatically created. 
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets

  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
  public_subnet_tags = {
    Name = "jenkins-subnet"
  }
}

# security group - Refer documentation here - https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
# Allow incoming traffic on Jenkins port and ssh port and allow any outgoing traffic on any port.  
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group for Jenkins Server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "jenkins port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh port"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "allow all outgoing traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name = "jenkins-sg"
  }
}

# EC2 instance - Refer documentation here - https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
# use script to install jenkins, git, terraform, kubectl


module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-Server"

  instance_type               = var.instance_type
  key_name                    = "jenkins-keypair"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data         = file("jenkins-install.sh")
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name        = "Jenkins-Server"
    Terraform   = "true"
    Environment = "dev"
  }
}