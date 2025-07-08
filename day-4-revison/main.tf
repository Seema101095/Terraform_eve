resource "aws_instance" "ec2seema" {
    ami = var.ami
    instance_type = var.instance_type
    tags={
        Name = "ec2"
    }
    availability_zone = "us-east-2c"

}
