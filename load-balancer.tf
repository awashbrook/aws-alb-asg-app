resource "aws_lb" "my-alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id # TODO Make Private
  security_groups    = [aws_security_group.lb-securitygroup.id]
  tags = {
    Name = "my-alb"
  }
}
resource "aws_lb_listener" "my-lb-listener" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-lb-tg.arn
  }
  #  listener {
  #   instance_port     = 80
  #   instance_protocol = "http"
  #   lb_port           = 80
  #   lb_protocol       = "http"
  # } 
}
resource "aws_lb_target_group" "my-lb-tg" {
  name     = "App-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    # target              = "HTTP:80/"
    protocol = "HTTP"
    port     = 80
    interval = 30
    // TODO
    # path = "/index.html"
    # matcher = "200,202"
  }

  # cross_zone_load_balancing   = true
  # connection_draining         = true
  # connection_draining_timeout = 400

}