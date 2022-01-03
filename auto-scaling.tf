resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix                 = "example-launchconfig"
  associate_public_ip_address = true # TODO Only for troubleshooting
  image_id                    = data.aws_ami.amazon_linux_2.image_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.mykeypair.key_name
  security_groups             = [aws_security_group.myinstance.id]
  user_data                   = filebase64("scripts/init_webserver.sh")
  # user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id] # TODO Make Private
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 2
  max_size                  = 2
  force_delete              = true
  health_check_type         = "EC2"
  health_check_grace_period = 300
  target_group_arns         = [aws_lb_target_group.my-lb-tg.arn]
  # load_balancers            = [aws_lb.my-alb.name]

  tag {
    key                 = "Name"
    value               = "example-autoscaling"
    propagate_at_launch = true
  }
}

