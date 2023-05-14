provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "web_server"
  }

  # Set up security group to allow HTTP and SSH access
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Set up IAM role for instance to access S3 bucket
  iam_instance_profile = aws_iam_instance_profile.instance_profile.id

  # Use user data to install Apache and copy website files from S3 bucket
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              service httpd start
              chkconfig httpd on
              aws s3 cp s3://${var.website_bucket_name} /var/www/html --recursive
              EOF
}

# Create security group for web server
resource "aws_security_group" "web_sg" {
  name_prefix = "web_sg_"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create IAM role for instance to access S3 bucket
resource "aws_iam_role" "instance_role" {
  name = "instance_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach S3 access policy to IAM role
resource "aws_iam_role_policy_attachment" "instance_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.instance_role.name
}

# Create IAM instance profile to associate with instance
resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"

  role = aws_iam_role.instance_role.name
}

# Create S3 bucket to store website files
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.website_bucket_name

  tags = {
    Name = "website_bucket"
  }
}

# Define variables for website bucket name and region
variable "website_bucket_name" {
  default = "my-website-bucket"
}

variable "region" {
  default = "us-west-2"
}

