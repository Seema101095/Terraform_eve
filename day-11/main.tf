resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
  
}

resource "aws_s3_bucket" "name" {
    bucket = var.buck_name
  
}