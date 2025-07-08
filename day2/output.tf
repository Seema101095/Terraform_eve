output "ip" {
    value = aws_instance.name.private_ip
  
}

output "bucketname" {
    value =aws_s3_bucket.namemybucket.bucket
  
}