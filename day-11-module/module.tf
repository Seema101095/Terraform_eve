module "myownmodule" {
    source = "github.com/Seema101095/Terraform_eve/day-11"
    ami_id = "ami-0150ccaf51ab55a51"
    instance_type = "t3.micro"
    buck_name="qwertyui"
}