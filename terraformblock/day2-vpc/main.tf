resource "vpc" "myvpc" {
  cidr_block = var.cidr
  }
  
resource "aws_subnet" "mysub1"{
   vpc_id = vpc.myvpc.id
   cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1a"
   map_public_ip_on_launch = true
  }
  
resource "aws_subnet" "mysub2"{
   vpc_id = vpc.myvpc.id
   cidr_block = "10.0.2.0/24"
   availability_zone  = "us-east-1b"
   map_public_ip_on_launch = true
   }

resource "aws_internet_gateway" "igw1" {
   vpc_id = vpc.myvpc.id
  } 
  
resource "aws_route_table" "mytable" {
   vpc_id = vpc.myvpc.id
   route {
    cidr = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }
}
  
resource "aws_route_table_association" "myRT1" {
   subnet= aws_subnet.mysub1.id
   route_table_id= aws_route_table.mytable.id
  }
  
resource "aws_route_table_association" "myRT2" {
   subnet = aws_subnet.mysub2.id
   route_table_id = aws_route_table.mytable.id
  }

resource "aws_security_group" "mysg1"{
   vpc_id= vpc.myvpc.id
   name = "mysg1"
   ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3" "mys3" {
   bucket = "bucketforworldcup2024"
   }

resource "aws_instance" "server1" {
   ami = "ami-04a81a99f5ec58529"
   instance_type = "t2.micro"
   vpc_security_group_id = aws_security_group.mysg1.id
   vpc_id = aws_vpc.myvpc.id
   subnet_id = aws_subnet.mysub1.id
   user_data = base64encode(file("userdata.sh"))
}
resource "aws_instance" "server2" {
   ami = "ami-04a81a99f5ec58529"
   instance_type = "t2.micro"
   vpc_security_group_id = aws_security_group.mysg1.id
   vpc_id = aws_vpc.myvpc.id
   subnet_id = aws_subnet.mysub2.id
   user_data = base64encode(file("userdata1.sh"))
}

resource "aws_lb" "mylb" {
   name = "mylb"
   internal = false
   load_balancer_type = "application"

  security_groups = [aws_security_group.webSg1.id]
  subnets = [aws_subnet.mysub1.id, aws_subnet.mysub2.id]
  
}       

resource "aws_lb_target_group" "tg" {
  name     = "myTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "tga1" {
     target_group_arn = aws_lb_target_group.tg.arn
     target_id = aws_instance.server1.id
     port = 80
  }

resource "aws_lb_target_group_attachment" "tga2" {
     target_group_arn = aws_lb_target_group.tg.arn
     target_id = aws_instance.server2.id
     port = 80
  }
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
}
output "loadbalancerdns" {
  value = aws_lb.mylb.dns_name
}
