resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      name= "myvpc"
    }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    tags ={
        name="subnet1"
    }
    depends_on = [ aws_vpc.myvpc ]

  
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      name="subnet2"
    }
    depends_on = [ aws_vpc.myvpc ]
}

resource "aws_subnet" "subnet3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.3.0/24"
    tags = {
      name="subnet3"
    }
    depends_on = [ aws_vpc.myvpc ]
}