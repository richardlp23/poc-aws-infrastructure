variable "profile_name" {
  description = "AWS profile name"
  type        = string
  default     = "default"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-085ad6ae776d8f09c"
}
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"

}
variable "ec2_name_prefix" {
  description = "Prefix for the EC2 instance name"
  type        = string
  default     = "web-server"
}
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}
variable "environment" {
  description = "Environment for the EC2 instance"
  type        = string
  default     = "development"
}
variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = "server-key"
}
variable alb_name {
  description = "Name of the ALB"
  type        = string
  default     = "web-alb"
}
variable load_balancer_type {
  description = "Type of the load balancer"
  type        = string
  default     = "application"
}
variable internal {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}
variable listener_port {
  description = "Port for the ALB listener"
  type        = number
  default     = 80
}
variable listener_protocol {
  description = "Protocol for the ALB listener"
  type        = string
  default     = "HTTP"
}
variable default_action_type {
  description = "Type of the default action for the ALB listener"
  type        = string
  default     = "forward"
}
variable web_listener_name {
  description = "Name of the web listener"
  type        = string
  default     = "web-listener"
}
variable web_tg_name {
  description = "Name of the web target group"
  type        = string
  default     = "web-tg"
}
variable web_tg_port {
  description = "Port for the web target group"
  type        = number
  default     = 80
}
variable web_tg_protocol {
  description = "Protocol for the web target group"
  type        = string
  default     = "HTTP"
}
variable target_type {
  description = "Type of the target for the target group"
  type        = string
  default     = "instance"
}
variable health_check_path {
  description = "Path for the health check"
  type        = string
  default     = "/"
}
variable health_check_protocol {
  description = "Protocol for the health check"
  type        = string
  default     = "HTTP"
}
variable health_check_port {
  description = "Port for the health check"
  type        = string
  default     = "80"
}
variable health_check_healthy_threshold {
  description = "Healthy threshold for the health check"
  type        = number
  default     = 2
}
variable health_check_unhealthy_threshold {
  description = "Unhealthy threshold for the health check"
  type        = number
  default     = 2
}
variable health_check_timeout {
  description = "Timeout for the health check"
  type        = number
  default     = 4
}
variable health_check_interval {
  description = "Interval for the health check"
  type        = number
  default     = 30
}
variable vpc_name {
  description = "Name of the VPC"
  type        = string
  default     = "MyVPC"
}
variable vpc_cidr {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16" 
} 
variable subnet_public_a_name {
  description = "Name of the public subnet A"
  type        = string
  default     = "subnet-public1-us-east-1a"
}
variable subnet_public_a_cidr {
  description = "CIDR block for the public subnet A"
  type        = string
  default     = "10.0.0.0/20"
}
variable subnet_public_b_name {
  description = "Name of the public subnet B"
  type        = string
  default     = "subnet-public2-us-east-1b"
}
variable subnet_public_b_cidr {
  description = "CIDR block for the public subnet B"
  type        = string
  default     = "10.0.16.0/20" 
}
variable availability_zone_a {
  description = "Availability zone A"
  type        = string
  default     = "us-east-1a"
}
variable availability_zone_b {
  description = "Availability zone B"
  type        = string
  default     = "us-east-1b"
} 
variable map_public_ip_on_launch {
  description = "Map public IP on launch"
  type        = bool
  default     = true
} 
variable internet_gateway_name {
  description = "Name of the internet gateway"
  type        = string
  default     = "internet-gateway"
}
variable route_table_name {
  description = "Name of the route table"
  type        = string
  default     = "public-route-table"
}
variable route_cidr_block {
  description = "CIDR block for the route"
  type        = string
  default     = "0.0.0.0/0"
}
variable security_groups {
  description = "List of security groups to associate with the EC2 instance"
  type        = list(string)
  default     = []
}
variable security_group_name {
  description = "Name of the security group"
  type        = string
  default     = "web-server-sg"
}
