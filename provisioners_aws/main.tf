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
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "provinAWSins" {
  ami = "ami-021a584b49225376d"
  instance_type = "t2.micro"
  key_name = "AWSec2provin2"
  security_groups = ["launch-wizard-2"]
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/Downloads/AWSec2provin2.pem")
    host = aws_instance.provinAWSins.public_ip
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo apt-get update",
      "sudo apt install software-properties-common -y",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "ansible --version",
      "ansible-playbook --version"
     ]
  }
}