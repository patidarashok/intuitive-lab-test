provider "aws" {
  region = "us-west-2"
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.0.0"

  bucket = "intuitive-bucket"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Security group for the frontend"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for the backend"
  vpc_id      = aws_vpc.main.id
}

resource "aws_instance" "frontend_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  tags = {
    Name = "frontend-instance"
  }
}

resource "aws_instance" "backend_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = {
    Name = "backend-instance"
  }
}

resource "aws_ebs_volume" "frontend_volume" {
  availability_zone = aws_subnet.main.availability_zone
  size              = 10
}

resource "aws_ebs_volume" "backend_volume" {
  availability_zone = aws_subnet.main.availability_zone
  size              = 20
}

resource "aws_volume_attachment" "frontend_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.frontend_volume.id
  instance_id = aws_instance.frontend_instance.id
}

resource "aws_volume_attachment" "backend_attachment" {
  device_name = "/dev/sdg"
  volume_id   = aws_ebs_volume.backend_volume.id
  instance_id = aws_instance.backend_instance.id
}