#resource "aws_instance" "ec2" {
    #ami="ami-05ffe3c48a9991133"

    #instance_type = "t2.micro"

    #tags={
     #   Name="Seema"
   # }
  
#}
resource "aws_s3_bucket" "myuniquebuck" {
    bucket = "terraformevstorage"
  
}