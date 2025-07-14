resource "aws_instance" "ec2" {
    ami= var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.key-terra.key_name
    security_groups = [aws_security_group.sg-terra.id]
    associate_public_ip_address = "true"
    subnet_id = aws_subnet.sub-terra.id
    tags={
        Name="Seema"
    }
    availability_zone = ""
  
}

resource "aws_vpc" "vpc-terra" {
    cidr_block = "10.0.0.0/24"
    tags = {
      Name="vpc-terra"
    }
    
}

resource "aws_subnet" "sub-terra" {
    vpc_id = aws_vpc.vpc-terra.id
    cidr_block = "10.0.0.0/26"
    availability_zone = "us-east-1a"
  
}
resource "aws_internet_gateway" "ig-terra" {
    vpc_id = aws_vpc.vpc-terra.id
  
}
 resource "aws_route_table" "rt-terra" {
    vpc_id = aws_vpc.vpc-terra.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig-terra.id
    }
   
 }

 resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.rt-terra.id
    subnet_id = aws_subnet.sub-terra.id
   
 }

 resource "aws_security_group" "sg-terra" {
    vpc_id = aws_vpc.vpc-terra.id
    ingress {
        to_port = 22
        from_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
 }

 resource "tls_private_key" "ec2-pvtkey" {
    algorithm = "RSA"
 }

 resource "aws_key_pair" "key-terra" {
    key_name = "terraform-newkey"
    public_key = tls_private_key.ec2-pvtkey.public_key_openssh
   
 }
 resource "local_file" "private-key" {
    content = tls_private_key.ec2-pvtkey.private_key_openssh
    filename = "${path.module}/terraform-newec2.pem"
    file_permission = "0600"
   
 }