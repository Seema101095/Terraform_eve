resource "aws_instance" "name" {
ami= var.ami
instance_type= var.instance_type

tags = {
    Name ="seema1234"
}
 
  
}

resource "aws_s3_bucket" "namemybucket" {
    bucket= "seemanewbucket"
  
}