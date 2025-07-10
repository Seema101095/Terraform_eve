terraform {
  backend "s3" {
    bucket = "terraformevstorage"
    key= "terrafom.tfstate"
    region= "us-east-1"
    dynamodb_table = "terraform-locks"
    
  }
}