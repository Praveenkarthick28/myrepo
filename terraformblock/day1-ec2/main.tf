resource "aws_instance" "tfdemo" {
   ami = "ami-04a81a99f5ec58529"
   instance_type = "t2.nano"
}