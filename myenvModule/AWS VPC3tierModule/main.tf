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
  #access_key = "xxxxxxxxxxxxxxxxxx"  need access key here
  #secret_key = "xxxxxxxxxxxxxxxxxxxxxx" need secret key here
}
resource "aws_vpc" "awsVPClabel101" {
    cidr_block = "10.60.0.0/16"
    tags = {
      "key" = "myVPC101"
    }
}
resource "aws_subnet" "awswebsubnetlabel101" {
  vpc_id = aws_vpc.awsVPClabel101.id
  cidr_block = "10.60.1.0/24"
}
resource "aws_subnet" "awsappsubnetlabel101" {
  vpc_id = aws_vpc.awsVPClabel101.id
  cidr_block = "10.60.2.0/24"
}
resource "aws_subnet" "awsdbsubnetlabel101" {
  vpc_id = aws_vpc.awsVPClabel101.id
  cidr_block = "10.60.3.0/24"
}