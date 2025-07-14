resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name= "vpc-terra"
    }
  
}

resource "aws_subnet" "sub-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    tags={
        Name ="sub-terra-1"
    }
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "sub-2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      Name ="sub-terra-2"
    }
    availability_zone = "ap-south-1b"
  
}
resource "aws_internet_gateway" "my-ig" {
    vpc_id = aws_vpc.myvpc.id
    tags={
        Name="ig-terra"
    }
  
}
resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-ig.id
    }
    tags = {
      Name= "rt-terra"
    }

    }
    
   
resource "aws_route_table_association" "rt-asso" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.sub-1.id
    
}