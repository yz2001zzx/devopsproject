module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bastion"

  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.medium"
  key_name               = "myOwnAWS"
  monitoring             = true
  vpc_security_group_ids = [module.public_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  

  tags = {
    Terraform   = "true"
  }
}