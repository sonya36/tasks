provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "soniya-tfstate-s3-bucket"
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "test_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = { Name = "test-server" }
}
