variable "ec2_full_stack_project" {
  type = string
}


resource "aws_instance" "cyf_backend" {
  ami             = "ami-0905a3c97561e0b69"                   # Use an appropriate Ubuntu AMI ID
  instance_type   = "t2.micro"                                # Choose an instance type
  key_name        = "VideoStorage"                            # Create an SSH key pair in AWS and specify the name
  security_groups = ["ec2_full_stack_project-security-group"] # Create a security group in AWS and specify
  tags = {
    Name = "terraform-VideoStorage-app"
  }
  user_data = <<-EOF
              sudo apt update
              sudo apt  install docker.io -y
              sudo systemctl start docker
              sudo systemctl enable docker
              EOF
}

resource "aws_security_group" "cyf_backend_sg" {
  name        = "ec2_full_stack_project-security-group" # Choose a unique name
  description = "Security group for ec2_full_stack_project-security-group backend"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  # Add more ingress rules for your application as needed
}

# Key Pair creation

resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}