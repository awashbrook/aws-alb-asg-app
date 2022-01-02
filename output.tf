output "load_balancer_dns" {
  value = aws_elb.my-elb.dns_name
}

