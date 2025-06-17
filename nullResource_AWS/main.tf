terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
  access_key = "AKIAxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
resource "aws_instance" "provinAWSins" {
  ami = "ami-021a584b49225376d"
  instance_type = "t2.micro"
  key_name = "AWSec2provin2"
  security_groups = ["launch-wizard-2"]
}
resource "null_resource" "nullProvin" {
  triggers = {
    id = aws_instance.provinAWSins.id
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
    ]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/Downloads/AWSec2provin2.pem")
      host = aws_instance.provinAWSins.public_ip
    }
  }
}