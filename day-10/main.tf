resource "aws_vpc" "mydbvpc" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name="mydbvpc"
    }
    enable_dns_support = true
    enable_dns_hostnames = true
  
}
resource "aws_subnet" "sub-1" {
    vpc_id = aws_vpc.mydbvpc.id
    cidr_block = "10.0.0.0/25"
    availability_zone = "us-east-1a"
    depends_on = [ aws_vpc.mydbvpc ]
  
}

resource "aws_subnet" "sub-2" {
    vpc_id = aws_vpc.mydbvpc.id
    cidr_block = "10.0.0.128/25"
    availability_zone = "us-east-1b"
    depends_on = [ aws_vpc.mydbvpc ]
  
}
resource "aws_db_subnet_group" "mysqldbgroup" {
    name="mysqldbgroup"
    subnet_ids = [ aws_subnet.sub-1.id, aws_subnet.sub-2.id ]
    depends_on = [ aws_subnet.sub-1, aws_subnet.sub-2 ]
}

resource "aws_security_group" "dbsg" {
  name="dbsg"
  vpc_id = aws_vpc.mydbvpc.id
  ingress  {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
resource "aws_db_instance" "db1" {
    engine="mysql"
    engine_version = "8.0.40"
    username="admin"
    password="mysecurepwd123"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    publicly_accessible = true
    db_subnet_group_name = aws_db_subnet_group.mysqldbgroup.id
    vpc_security_group_ids = [ aws_security_group.dbsg.id ]
  
}

resource "aws_internet_gateway" "dbig" {
    vpc_id = aws_vpc.mydbvpc.id
  
}
resource "aws_route_table" "dbrt" {
    vpc_id = aws_vpc.mydbvpc.id
    route  {
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.dbig.id
    }
  
}
resource "aws_route_table_association" "mysubassn1" {
  subnet_id = aws_subnet.sub-1.id
  route_table_id = aws_route_table.dbrt.id
}
resource "aws_route_table_association" "mysubassn2" {
  subnet_id = aws_subnet.sub-2.id
  route_table_id = aws_route_table.dbrt.id
}
