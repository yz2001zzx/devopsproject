module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "devopsALB"

  load_balancer_type = "application"

  vpc_id             = modules.module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_groups    = [module.public_sg.security_group_id]

  access_logs = {
    bucket = "bucketforalbjacky"
  }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-04b59ab7ba5dd4d30" // Jenkins EC2
          port = 8080
        }
        my_other_target = {
          target_id = "i-0581fb6e273aef42d" // Application EC2
          port = 8080
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]


    https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 5000

      actions = [{
        type        = "forward"
        path        = "/jenkins*"
        protocol    = "HTTPS"
        target_group_index = 0
      }]

   },

    {
      https_listener_index = 0
      priority             = 5000

      actions = [{
        type        = "forward"
        path        = "/"
        protocol    = "HTTPS"
        target_group_index = 1
      }]

   },
    
  ] 


}
