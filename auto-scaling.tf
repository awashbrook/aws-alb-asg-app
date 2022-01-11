resource "aws_launch_template" "example-launchtemplate" {
  name          = "example-launchtemplate"
  image_id      = data.aws_ami.amazon_linux_2.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.mykeypair.key_name

  user_data = filebase64("scripts/init_webserver.sh")

  network_interfaces {
    associate_public_ip_address = true # TODO Only for troubleshooting
    security_groups             = [aws_security_group.myinstance.id]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                = "example-autoscaling"
  vpc_zone_identifier = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id] # TODO Make Private
  launch_template {
    id      = aws_launch_template.example-launchtemplate.id
    version = "$Latest"
  }
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

