provider "aws"{
    region = "us-east-1"
}
resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "soniya-tfstate-s3-bucket"
  versioning {
    enabled = true
  }
}
resource "aws_instance" "jenkins" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"

  tags = {
    Name = "test-server"
  }
}
