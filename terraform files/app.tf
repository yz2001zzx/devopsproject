module "app" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "app"

  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.medium"
  key_name               = "myOwnAWS"
  monitoring             = true
  vpc_security_group_ids = [module.private_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[1]
  

  tags = {
    Terraform   = "true"
  }
}